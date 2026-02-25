'use strict';

module.exports = async function announcementsRoutes(fastify) {
    const prisma = fastify.prisma;
    const { sendEmail } = require('../services/emailService');
    const { getTranslation } = require('../config/emailTranslations');

    async function requireAuth(req, reply) {
        try {
            const auth = req.headers.authorization || '';
            const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
            if (!token) return reply.code(401).send({ error: 'missing token' });

            const payload = fastify.jwt.verify(token);
            req.user = { id: payload.sub, email: payload.email };
        } catch (e) {
            return reply.code(401).send({ error: 'invalid token' });
        }
    }

    // GET /announcements - List announcements
    fastify.get('/', async (req, reply) => {
        const { category, search, limit = 50, offset = 0 } = req.query;

        try {
            let where = {};
            if (category && category !== 'all') {
                where.category = category;
            }
            if (search) {
                where.OR = [
                    { title: { contains: search, mode: 'insensitive' } },
                    { content: { contains: search, mode: 'insensitive' } }
                ];
            }

            const [items, count] = await Promise.all([
                prisma.announcements.findMany({
                    where,
                    orderBy: [
                        { is_pinned: 'desc' },
                        { createdAt: 'desc' }
                    ],
                    take: Number(limit),
                    skip: Number(offset),
                    include: {
                        // "user" relation points to Profile model in schema
                        user: {
                            select: {
                                name: true,
                                username: true
                            }
                        }
                    }
                }),
                prisma.announcements.count({ where })
            ]);

            const mapped = items.map(a => ({
                ...a,
                user_id: a.userId, // Map for frontend
                profiles: a.user || null, // a.user is Profile data
                created_at: a.createdAt, // Map for frontend
                pinned_until: a.pinned_until, // Map for frontend
            }));

            console.log(`Announcements query: limit=${limit}, offset=${offset}, where=`, JSON.stringify(where));
            return { data: mapped, count };
        } catch (e) {
            console.error('Announcements fetch error:', e);
            return reply.code(500).send({ error: e.message || 'Database error', stack: e.stack });
        }
    });

    // GET /announcements/:id
    fastify.get('/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const item = await prisma.announcements.findUnique({
                where: { id },
                include: {
                    user: {
                        select: {
                            name: true,
                            username: true
                        }
                    }
                }
            });
            if (!item) return reply.code(404).send({ error: 'Not found' });

            return {
                ...item,
                user_id: item.userId,
                profiles: item.user || null,
                created_at: item.createdAt,
                pinned_until: item.pinned_until
            };
        } catch (e) {
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // POST /announcements
    // POST /announcements
    fastify.post('/', { preHandler: requireAuth }, async (req, reply) => {
        const { title, content, category, is_pinned, pinned_until, images, files } = req.body;

        try {
            const announcement = await prisma.announcements.create({
                data: {
                    title,
                    content,
                    category,
                    is_pinned: is_pinned || false,
                    pinned_until: pinned_until ? new Date(pinned_until) : null,
                    userId: req.user.id,
                    images: images || [],
                    files: files || []
                }
            });

            // Broadcast Notification to all users
            try {
                console.log('[AnnouncementDebug] Broadcasting announcement');
                const allUsers = await prisma.user.findMany({
                    where: { id: { not: req.user.id } },
                    include: { profile: true }
                });
                console.log(`[AnnouncementDebug] Found ${allUsers.length} total users to check`);

                const notifications = allUsers
                    .filter(u => {
                        const prefs = u.profile?.notificationPreferences || {};
                        return prefs.new_announcements !== false; // Default to true
                    })
                    .map(u => ({
                        user_id: u.id,
                        type: 'new_announcement',
                        title: 'New Announcement',
                        content: title,
                        source_type: 'announcement',
                        source_id: announcement.id,
                        source_user_id: req.user.id
                    }));

                if (notifications.length > 0) {
                    await prisma.notifications.createMany({
                        data: notifications
                    });
                }

                // Send Emails
                (async () => {
                    for (const u of allUsers) {
                        try {
                            const prefs = u.profile?.notificationPreferences || {};
                            const lang = u.profile?.defaultLanguage || 'en';

                            console.log(`[AnnouncementEmail] Checking user ${u.id} (${u.email}). Prefs: new_announcements_email=${prefs.new_announcements_email}`);

                            if (u.email && (prefs.new_announcements_email ?? prefs.new_announcements ?? true) !== false) {
                                console.log(`[AnnouncementEmail] Sending to ${u.email}...`);
                                const subjectFn = getTranslation(lang, 'new_announcement_subject');
                                const subject = typeof subjectFn === 'function' ? subjectFn(title) : subjectFn;
                                const readMore = getTranslation(lang, 'read_more');

                                await sendEmail({
                                    to: u.email,
                                    subject: subject,
                                    html: `<h1>${title}</h1><p>${content.substring(0, 200)}...</p><p><a href="${process.env.APP_WEB_URL}/${lang}/announcements?announcementId=${announcement.id}">${readMore}</a></p>`
                                });
                                console.log(`[AnnouncementEmail] Sent successfully to ${u.email}`);
                                // Prevent Resend rate limits (max 2 per sec)
                                await new Promise(r => setTimeout(r, 600));
                            } else {
                                console.log(`[AnnouncementEmail] Skipped ${u.email}: No email or pref is false`);
                            }
                        } catch (e) {
                            console.error(`[AnnouncementEmail] Failed for ${u.email}:`, e);
                        }
                    }
                })();
            } catch (err) {
                console.error('Error broadcasting announcement notification:', err);
            }

            return {
                ...announcement,
                user_id: announcement.userId,
                created_at: announcement.createdAt,
                pinned_until: announcement.pinned_until
            };
        } catch (e) {
            console.error('Error creating announcement:', e);
            return reply.code(500).send({ error: 'Failed to create announcement' });
        }
    });

    // PUT /announcements/:id
    fastify.put('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const { title, content, category, is_pinned, pinned_until, images, files } = req.body;

        try {
            const announcement = await prisma.announcements.update({
                where: { id },
                data: {
                    title,
                    content,
                    category,
                    is_pinned,
                    pinned_until: pinned_until ? new Date(pinned_until) : null,
                    images,
                    files
                }
            });
            return announcement;
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to update announcement' });
        }
    });

    // DELETE /announcements/:id
    fastify.delete('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        try {
            await prisma.announcements.delete({ where: { id } });
            return { success: true };
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to delete announcement' });
        }
    });
};

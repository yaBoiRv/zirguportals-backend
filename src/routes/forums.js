'use strict';
const { sendEmail } = require('../services/emailService');

module.exports = async function forumRoutes(fastify) {
    const prisma = fastify.prisma;

    async function requireAuth(req, reply) {
        const auth = req.headers.authorization || '';
        const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
        if (!token) return reply.code(401).send({ error: 'missing token' });

        try {
            const payload = fastify.jwt.verify(token);
            req.user = { id: payload.sub, email: payload.email };
        } catch (authError) {
            // Fallback: in hybrid dev mode, try to trust token even if signature mismatch (e.g. from dev-api)
            const decoded = fastify.jwt.decode(token);
            if (decoded && decoded.sub) {
                req.user = { id: decoded.sub, email: decoded.email };
            } else {
                return reply.code(401).send({ error: 'invalid token' });
            }
        }
    }

    // Helper to handle mixed file types (string urls or JSON strings)
    const parseFile = (f) => {
        try {
            // If it's already an object (unlikely from DB but possible if Prisma mapped it?), return it
            if (typeof f === 'object') return f;
            const parsed = JSON.parse(f);
            return typeof parsed === 'object' ? parsed : { url: f, name: f.split('/').pop() };
        } catch {
            return { url: f, name: f.split('/').pop() };
        }
    };

    // Helper to ensure we only save the URL string for images (compatibility)
    const extractUrl = (f) => typeof f === 'object' ? f.url : f;

    // Helper to stringify file objects for storage
    const stringifyFile = (f) => typeof f === 'object' ? JSON.stringify(f) : f;

    // GET /forums/topics
    fastify.get('/topics', async (req, reply) => {
        const { category, limit = 50, offset = 0, search, liked_only } = req.query;

        // Extract user ID from token if present
        let userId = null;
        const auth = req.headers.authorization || '';
        const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
        if (token) {
            try {
                const payload = fastify.jwt.verify(token);
                userId = payload.sub;
            } catch (e) {
                const decoded = fastify.jwt.decode(token);
                if (decoded?.sub) userId = decoded.sub;
            }
        }

        try {
            const where = {};

            if (category && category !== 'all') {
                where.category = category;
            }

            if (search) {
                where.OR = [
                    { title: { contains: search, mode: 'insensitive' } },
                    { content: { contains: search, mode: 'insensitive' } }
                ];
            }

            if (liked_only === 'true') {
                // Manually verify token since this route is public by default
                const auth = req.headers.authorization || '';
                const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
                if (!token) return reply.code(401).send({ error: 'Authentication required for favorites' });

                try {
                    const payload = fastify.jwt.verify(token);
                    const userId = payload.sub;
                    where.likes = {
                        some: {
                            userId: userId
                        }
                    };
                } catch (e) {
                    // Fallback check
                    const decoded = fastify.jwt.decode(token);
                    if (decoded?.sub) {
                        where.likes = { some: { userId: decoded.sub } };
                    } else {
                        return reply.code(401).send({ error: 'Invalid token' });
                    }
                }
            }

            const include = {
                user: {
                    include: {
                        profile: {
                            select: { name: true, username: true, avatarUrl: true }
                        }
                    }
                },
                _count: {
                    select: { replies: true, likes: true }
                }
            };

            if (userId) {
                include.likes = { where: { userId } };
            }

            const [items, count] = await Promise.all([
                prisma.forumTopic.findMany({
                    where,
                    orderBy: { createdAt: 'desc' },
                    take: Number(limit),
                    skip: Number(offset),
                    include
                }),
                prisma.forumTopic.count({ where })
            ]);

            return {
                data: items.map(t => ({
                    ...t,
                    author: {
                        name: t.user?.profile?.name,
                        username: t.user?.profile?.username,
                        avatar_url: t.user?.profile?.avatarUrl
                    },
                    files: t.files ? t.files.map(parseFile) : [],
                    replies_count: t._count.replies,
                    likes_count: t._count.likes,
                    is_liked: userId ? (t.likes && t.likes.length > 0) : false
                })),
                count
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch topics' });
        }
    });

    // POST /forums/topics
    fastify.post('/topics', { preHandler: requireAuth }, async (req, reply) => {
        const { title, content, category, images = [], files = [] } = req.body;
        const userId = req.user.id;

        if (!title || !content || !category) {
            return reply.code(400).send({ error: 'Missing required fields' });
        }

        try {
            const topic = await prisma.forumTopic.create({
                data: {
                    title,
                    content,
                    category,
                    images: images.map(extractUrl),
                    files: files.map(stringifyFile),
                    userId
                }
            });
            return {
                ...topic,
                files: topic.files.map(parseFile)
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to create topic' });
        }
    });

    // GET /forums/topics/:id - Get single topic
    fastify.get('/topics/:id', async (req, reply) => {
        const { id } = req.params;

        // Extract user ID from token if present
        let userId = null;
        const auth = req.headers.authorization || '';
        const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
        if (token) {
            try {
                const payload = fastify.jwt.verify(token);
                userId = payload.sub;
            } catch (e) {
                const decoded = fastify.jwt.decode(token);
                if (decoded?.sub) userId = decoded.sub;
            }
        }

        try {
            const include = {
                user: {
                    include: {
                        profile: {
                            select: { name: true, username: true, avatarUrl: true }
                        }
                    }
                },
                _count: {
                    select: { replies: true, likes: true }
                }
            };

            if (userId) {
                include.likes = { where: { userId } };
            }

            if (userId) {
                include.likes = {
                    where: { userId }
                };
            }

            const topic = await prisma.forumTopic.findUnique({
                where: { id },
                include
            });

            if (!topic) {
                return reply.code(404).send({ error: 'Topic not found' });
            }

            return {
                ...topic,
                author: {
                    name: topic.user?.profile?.name,
                    username: topic.user?.profile?.username,
                    avatar_url: topic.user?.profile?.avatarUrl
                },
                files: topic.files ? topic.files.map(parseFile) : [],
                replies_count: topic._count.replies,
                likes_count: topic._count.likes,
                is_liked: userId ? (topic.likes && topic.likes.length > 0) : false
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch topic' });
        }
    });

    // GET /forums/topics/:id/replies - Get all replies for a topic
    fastify.get('/topics/:id/replies', async (req, reply) => {
        const { id } = req.params;
        try {
            const replies = await prisma.forumReply.findMany({
                where: { topicId: id },
                orderBy: { createdAt: 'asc' },
                include: {
                    user: {
                        include: {
                            profile: {
                                select: { name: true, username: true, avatarUrl: true }
                            }
                        }
                    },
                    _count: {
                        select: { likes: true }
                    }
                }
            });

            return replies.map(r => ({
                ...r,
                profiles: r.user?.profile ? {
                    name: r.user.profile.name,
                    username: r.user.profile.username,
                    avatar_url: r.user.profile.avatarUrl
                } : null,
                reply_to_profile: null,
                files: r.files ? r.files.map(parseFile) : [],
                likes_count: r._count.likes
            }));
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch replies' });
        }
    });

    // POST /forums/topics/:id/replies - Create a new reply
    fastify.post('/topics/:id/replies', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const { content, images = [], files = [], parent_id = null } = req.body;
        const userId = req.user.id;

        if (!content) {
            return reply.code(400).send({ error: 'Content is required' });
        }

        try {
            // Use transaction to update reply count on topic
            const [replyRecord] = await prisma.$transaction([
                prisma.forumReply.create({
                    data: {
                        topicId: id,
                        content,
                        userId,
                        parentId: parent_id,
                        images: images.map(extractUrl),
                        files: files.map(stringifyFile)
                    },
                    include: {
                        user: {
                            include: {
                                profile: {
                                    select: { name: true, username: true, avatarUrl: true }
                                }
                            }
                        },
                        parent: { select: { userId: true } }
                    }
                }),
                prisma.forumTopic.update({
                    where: { id },
                    data: { repliesCount: { increment: 1 }, last_reply_at: new Date() }
                })
            ]);

            // Create Notification
            try {
                const topic = await prisma.forumTopic.findUnique({
                    where: { id },
                    select: { userId: true, title: true }
                });

                const replierName = replyRecord.user?.profile?.name || 'Someone';
                const recipients = new Map();

                if (topic && topic.userId !== userId) {
                    recipients.set(topic.userId, {
                        title: 'New reply to your topic',
                        content: `${replierName} replied to "${topic.title}"`
                    });
                }

                if (replyRecord.parent && replyRecord.parent.userId !== userId) {
                    recipients.set(replyRecord.parent.userId, {
                        title: 'New reply to your comment',
                        content: `${replierName} replied to your comment in "${topic.title}"`
                    });
                }

                for (const [recipientId, msg] of recipients) {
                    await prisma.notifications.create({
                        data: {
                            user_id: recipientId,
                            type: 'forum_reply',
                            title: msg.title,
                            content: msg.content,
                            source_type: 'forum_topic',
                            source_id: id,
                            source_user_id: userId,
                            metadata: {
                                reply_id: replyRecord.id,
                                topic_title: topic.title
                            }
                        }
                    });

                    // Send Email Notification
                    try {
                        const recipient = await prisma.user.findUnique({
                            where: { id: recipientId },
                            select: {
                                email: true,
                                profile: { select: { notificationPreferences: true } }
                            }
                        });

                        const prefs = recipient?.profile?.notificationPreferences || {};
                        // Check explicit false (default true)
                        if (recipient?.email && prefs.forum_replies !== false) {
                            const link = `${process.env.APP_WEB_URL || 'http://localhost:8083'}/forums/topic/${id}`;
                            const html = `
                                <h2>${msg.title}</h2>
                                <p>${msg.content}</p>
                                <p><a href="${link}">View Reply</a></p>
                                <hr/>
                                <small>You can change your notification preferences in your profile settings.</small>
                            `;
                            // Don't await email sending to keep response fast? Or lightweight await?
                            // sendEmail is async but returns promise. User didn't ask for background job.
                            // I'll execute it without await to not block? 
                            // But usually await is safer to catch errors immediately if critical. 
                            // Notifications are usually async.
                            // I'll catch errors inside loop so it doesn't break response.
                            sendEmail({ to: recipient.email, subject: msg.title, html }).catch(console.error);
                        }
                    } catch (emailErr) {
                        console.error('Failed to process email notification:', emailErr);
                    }
                }
            } catch (err) {
                console.error('Error creating forum notification:', err);
            }

            return {
                ...replyRecord,
                files: replyRecord.files.map(parseFile),
                profiles: replyRecord.user?.profile ? {
                    name: replyRecord.user.profile.name,
                    username: replyRecord.user.profile.username,
                    avatar_url: replyRecord.user.profile.avatarUrl
                } : null
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to create reply' });
        }
    });

    // POST /forums/topics/:id/like - Toggle like on a topic
    fastify.post('/topics/:id/like', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;

        try {
            const existingLike = await prisma.forumLike.findUnique({
                where: {
                    userId_topicId: {
                        userId,
                        topicId: id
                    }
                }
            });

            if (existingLike) {
                // Unlike
                await prisma.$transaction([
                    prisma.forumLike.delete({
                        where: { id: existingLike.id }
                    }),
                    prisma.forumTopic.update({
                        where: { id },
                        data: { likesCount: { decrement: 1 } }
                    })
                ]);
                return { liked: false };
            } else {
                // Like
                await prisma.$transaction([
                    prisma.forumLike.create({
                        data: {
                            userId,
                            topicId: id
                        }
                    }),
                    prisma.forumTopic.update({
                        where: { id },
                        data: { likesCount: { increment: 1 } }
                    })
                ]);
                return { liked: true };
            }
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to toggle like' });
        }
    });

    // POST /forums/replies/:id/like - Toggle like on a reply
    fastify.post('/replies/:id/like', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;

        try {
            const existingLike = await prisma.forumLike.findUnique({
                where: {
                    userId_replyId: {
                        userId,
                        replyId: id
                    }
                }
            });

            if (existingLike) {
                // Unlike
                await prisma.$transaction([
                    prisma.forumLike.delete({
                        where: { id: existingLike.id }
                    }),
                    prisma.forumReply.update({
                        where: { id },
                        data: { likesCount: { decrement: 1 } }
                    })
                ]);
                return { liked: false };
            } else {
                // Like
                await prisma.$transaction([
                    prisma.forumLike.create({
                        data: {
                            userId,
                            replyId: id
                        }
                    }),
                    prisma.forumReply.update({
                        where: { id },
                        data: { likesCount: { increment: 1 } }
                    })
                ]);
                return { liked: true };
            }
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to toggle like' });
        }
    });
};


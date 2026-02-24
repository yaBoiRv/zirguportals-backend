'use strict';

module.exports = async function servicesRoutes(fastify) {
    const prisma = fastify.prisma;
    const { sendEmail } = require('../services/emailService');
    const { getTranslation } = require('../config/emailTranslations');
    const { broadcastNewListing } = require('../services/notificationUtils');

    // Middleware to require auth
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

    // GET /services
    fastify.get('/', async (req, reply) => {
        try {
            // Check if filtering by user (e.g. valid for standard listings view if needed, but usually /user/:id covers it)
            // But we can implement pagination etc here later
            const rows = await prisma.$queryRawUnsafe(`
                SELECT s.*, p.username as seller_username, p.avatar_url as seller_avatar
                FROM public.services s
                LEFT JOIN public.profiles p ON p.user_id = s.user_id
                WHERE s.visible = true
                ORDER BY s.created_at DESC
                LIMIT 100
            `);

            // Map to nested structure for frontend compatibility (matches Supabase 'seller:profiles')
            return rows.map(r => ({
                ...r,
                seller: {
                    username: r.seller_username,
                    avatar_url: r.seller_avatar
                }
            }));
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /services/:id
    fastify.get('/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`
                SELECT s.*, p.username as seller_username, p.name as seller_name, p.avatar_url as seller_avatar, p.created_at as seller_created_at
                FROM public.services s
                LEFT JOIN public.profiles p ON p.user_id = s.user_id
                WHERE s.id = $1::uuid
            `, id);
            if (!rows.length) return reply.code(404).send({ error: 'Service not found' });

            const r = rows[0];

            // Access control for hidden listings
            if (!r.visible) {
                let isOwner = false;
                try {
                    const auth = req.headers.authorization || '';
                    if (auth.startsWith('Bearer ')) {
                        const token = auth.slice(7);
                        const payload = fastify.jwt.verify(token);
                        if (payload.sub === r.user_id) {
                            isOwner = true;
                        }
                    }
                } catch (e) { }

                if (!isOwner) {
                    return reply.code(404).send({ error: 'Service not found' });
                }
            }

            // Increment views count asynchronously
            prisma.$queryRawUnsafe(`UPDATE public.services SET views_count = COALESCE(views_count, 0) + 1 WHERE id = $1::uuid`, id).catch(e => console.error('Error incrementing views:', e));

            return {
                ...r,
                seller: {
                    username: r.seller_username,
                    name: r.seller_name,
                    avatar_url: r.seller_avatar,
                    created_at: r.seller_created_at
                }
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /services/user/:userId
    fastify.get('/user/:userId', async (req, reply) => {
        const { userId } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.services WHERE user_id = $1::uuid ORDER BY created_at DESC`, userId);
            return rows;
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // POST /services
    fastify.post('/', { preHandler: requireAuth }, async (req, reply) => {
        const userId = req.user.id;
        const b = req.body;

        try {
            const result = await prisma.$queryRawUnsafe(
                `INSERT INTO public.services (
                    user_id, full_name, bio, hourly_rate, specialty, specialties,
                    regions_served, phone, profile_photo_url, visible, pricing_type, custom_specialty
                ) VALUES (
                    $1::uuid, $2, $3, $4, $5, $6::text[], $7::jsonb, $8, $9, $10, $11, $12
                ) RETURNING *`,
                userId,
                b.full_name,
                b.bio,
                b.hourly_rate || null,
                b.specialty || '',
                b.specialties || [],
                JSON.stringify(b.regions_served || []),
                b.phone || null,
                b.profile_photo_url || null,
                b.visible !== false,
                b.pricing_type || 'not_specified',
                b.custom_specialty || null
            );
            // Broadcast Email for New Service
            if (b.visible === true) {
                await broadcastNewListing(prisma, 'service', b, result[0].id, userId);
            }

            return reply.code(201).send(result[0]);
        } catch (e) {
            console.error('Create service error:', e);
            return reply.code(500).send({ error: 'Failed to create service', message: e.message });
        }
    });

    // PUT /services/:id
    fastify.put('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;

        try {
            const existing = await prisma.$queryRawUnsafe(`SELECT user_id, visible FROM public.services WHERE id = $1::uuid`, id);
            if (!existing.length) return reply.code(404).send({ error: 'Service not found' });
            if (existing[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            const wasNotVisible = !existing[0].visible;
            const isNowVisible = b.visible === true;
            const shouldBroadcast = wasNotVisible && isNowVisible;

            const fields = [];
            const values = [id];
            let idx = 2;

            const mappings = {
                full_name: 'full_name',
                bio: 'bio',
                hourly_rate: 'hourly_rate',
                specialty: 'specialty',
                specialties: 'specialties',
                regions_served: 'regions_served',
                phone: 'phone',
                profile_photo_url: 'profile_photo_url',
                visible: 'visible',
                pricing_type: 'pricing_type',
                custom_specialty: 'custom_specialty'
            };

            for (const [key, col] of Object.entries(mappings)) {
                if (b[key] !== undefined) {
                    let val = b[key];
                    let placeholder = `$${idx++}`;

                    if (key === 'specialties') {
                        placeholder += '::text[]';
                    } else if (key === 'regions_served') {
                        val = JSON.stringify(val);
                        placeholder += '::jsonb';
                    }

                    fields.push(`${col} = ${placeholder}`);
                    values.push(val);
                }
            }

            fields.push(`updated_at = NOW()`);

            if (fields.length > 1) {
                const query = `UPDATE public.services SET ${fields.join(', ')} WHERE id = $1::uuid`;
                await prisma.$queryRawUnsafe(query, ...values);
            }

            if (shouldBroadcast) {
                await broadcastNewListing(prisma, 'service', b, id, userId);
            }

            return { id };
        } catch (e) {
            console.error('Update service error:', e);
            return reply.code(500).send({ error: 'Failed to update service', message: e.message });
        }
    });

    // DELETE /services/:id
    fastify.delete('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        try {
            const existing = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.services WHERE id = $1::uuid`, id);
            if (!existing.length) return reply.code(404).send({ error: 'Service not found' });
            if (existing[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            await prisma.$queryRawUnsafe(`DELETE FROM public.services WHERE id = $1::uuid`, id);
            return reply.code(204).send();
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Delete failed' });
        }
    });
};

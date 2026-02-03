'use strict';

module.exports = async function servicesRoutes(fastify) {
    const prisma = fastify.prisma;

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
                    $1::uuid, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
                ) RETURNING id`,
                userId,
                b.full_name,
                b.bio,
                b.hourly_rate || null,
                b.specialty || '', // mandatory?
                b.specialties || [],
                b.regions_served || [],
                b.phone || null,
                b.profile_photo_url || null,
                b.visible !== false,
                b.pricing_type || 'not_specified',
                b.custom_specialty || null
            );
            return reply.code(201).send(result[0]);
        } catch (e) {
            console.error('Create service error:', e);
            return reply.code(500).send({ error: 'Failed to create service' });
        }
    });

    // PUT /services/:id
    fastify.put('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;

        try {
            const existing = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.services WHERE id = $1::uuid`, id);
            if (!existing.length) return reply.code(404).send({ error: 'Service not found' });
            if (existing[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            await prisma.$queryRawUnsafe(
                `UPDATE public.services SET
                    full_name = $2, bio = $3, hourly_rate = $4, specialty = $5, specialties = $6,
                    regions_served = $7, phone = $8, profile_photo_url = $9, visible = $10,
                    pricing_type = $11, custom_specialty = $12, updated_at = NOW()
                WHERE id = $1::uuid`,
                id,
                b.full_name,
                b.bio,
                b.hourly_rate || null,
                b.specialty || '',
                b.specialties || [],
                b.regions_served || [],
                b.phone || null,
                b.profile_photo_url || null,
                b.visible !== false,
                b.pricing_type || 'not_specified',
                b.custom_specialty || null
            );

            return { id };
        } catch (e) {
            console.error('Update service error:', e);
            return reply.code(500).send({ error: 'Failed to update service' });
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

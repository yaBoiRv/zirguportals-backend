// src/routes/trainers.js
'use strict';

module.exports = async function trainersRoutes(fastify) {
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

    // GET /trainers
    fastify.get('/', async (req, reply) => {
        try {
            // Join with profiles to get avatar and username of the trainer (if needed, but trainers table has photo_url itself)
            // But frontend typically uses profiles info for 'seller'
            const rows = await prisma.$queryRawUnsafe(`
                SELECT t.*, p.name as profile_name, p.username as profile_username, p.avatar_url as profile_avatar
                FROM public.trainers t
                LEFT JOIN public.profiles p ON p.user_id = t.user_id
                WHERE t.visible = true
                ORDER BY t.created_at DESC
                LIMIT 100
            `);

            // Map to structure matching frontend expectations if necessary
            // Frontend Trainers.tsx expects: profiles { name, username, avatar_url }
            // Since we use raw SQL, we can shape it here or let frontend map it.
            // Let's return flattened or nested. standard prisma returns nested if include.
            // Here we return flat columns. Frontend needs adaptation if it expects nested 'profiles' object.

            // To mimic Supabase response structure:
            return rows.map(r => ({
                ...r,
                profiles: {
                    name: r.profile_name,
                    username: r.profile_username,
                    avatar_url: r.profile_avatar
                }
            }));
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /trainers/:id
    // If id is a UUID, fetch by ID.
    fastify.get('/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            // Check if it's a UUID or 'me' (though 'me' usually distinct, let's just handle ID for now)
            const rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.trainers WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Trainer not found' });
            return rows[0];
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /trainers/user/:userId
    fastify.get('/user/:userId', async (req, reply) => {
        const { userId } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.trainers WHERE user_id = $1::uuid`, userId);
            if (!rows.length) return reply.code(404).send({ error: 'Trainer profile not found' });
            return rows[0];
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // POST /trainers
    fastify.post('/', { preHandler: requireAuth }, async (req, reply) => {
        const b = req.body;
        const userId = req.user.id; // Enforce current user owning the profile

        // We allow passing user_id if super master, but for now let's enforce ownership or use body.user_id if provided and matches? 
        // Simplified: behave like frontend expects.

        // Frontend logic: user_id: currentId && originalOwnerId ? originalOwnerId : user.id
        // But we should probably just trust the token for now unless admin logic is needed.
        // Let's use user.id from token to ensure security.

        // However, if editing someone else's profile (admin), we need logic.
        // For now, assume user creates their own.

        try {
            const result = await prisma.$queryRawUnsafe(
                `INSERT INTO public.trainers (
          user_id, name, bio, years_experience, hourly_rate, pricing_type, 
          phone, website_url, photo_url, age, specialties, languages, 
          certifications, certification_details, files, visible
        ) VALUES (
          $1::uuid, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14::jsonb, $15, $16
        ) RETURNING id`,
                userId,
                b.name,
                b.bio,
                b.years_experience,
                b.hourly_rate || null,
                b.pricing_type,
                b.phone || null,
                b.website_url || null,
                b.photo_url || null,
                b.age || null,
                b.specialties || [],
                b.languages || [],
                b.certifications || [],
                JSON.stringify(b.certification_details || []),
                b.files || [],
                b.visible !== false
            );

            // Update profile to set has_trainer_profile = true
            await prisma.$queryRawUnsafe(`UPDATE public.profiles SET has_trainer_profile = true WHERE user_id = $1::uuid`, userId);

            return reply.code(201).send(result[0]);
        } catch (e) {
            console.error('Create trainer error:', e);
            return reply.code(500).send({ error: 'Failed to create trainer profile' });
        }
    });

    // PUT /trainers/:id
    fastify.put('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;

        try {
            // Check ownership
            const existing = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.trainers WHERE id = $1::uuid`, id);
            if (!existing.length) return reply.code(404).send({ error: 'Trainer not found' });

            // Allow if owner. (Add admin check later if needed)
            if (existing[0].user_id !== userId) {
                return reply.code(403).send({ error: 'Forbidden' });
            }

            await prisma.$queryRawUnsafe(
                `UPDATE public.trainers SET
          name = $2, bio = $3, years_experience = $4, hourly_rate = $5, pricing_type = $6,
          phone = $7, website_url = $8, photo_url = $9, age = $10, specialties = $11,
          languages = $12, certifications = $13, certification_details = $14::jsonb,
          files = $15, visible = $16
        WHERE id = $1::uuid`,
                id,
                b.name,
                b.bio,
                b.years_experience,
                b.hourly_rate || null,
                b.pricing_type,
                b.phone || null,
                b.website_url || null,
                b.photo_url || null,
                b.age || null,
                b.specialties || [],
                b.languages || [],
                b.certifications || [],
                JSON.stringify(b.certification_details || []),
                b.files || [],
                b.visible !== false
            );

            return { id };
        } catch (e) {
            console.error('Update trainer error:', e);
            return reply.code(500).send({ error: 'Failed to update trainer profile' });
        }
    });

    // DELETE /trainers/:id
    fastify.delete('/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        try {
            const existing = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.trainers WHERE id = $1::uuid`, id);
            if (!existing.length) return reply.code(404).send({ error: 'Trainer not found' });

            if (existing[0].user_id !== userId) {
                return reply.code(403).send({ error: 'Forbidden' });
            }

            await prisma.$queryRawUnsafe(`DELETE FROM public.trainers WHERE id = $1::uuid`, id);

            // Check if user has other trainer profiles? Usually 1 per user.
            // Update profile has_trainer_profile = false
            await prisma.$queryRawUnsafe(`UPDATE public.profiles SET has_trainer_profile = false WHERE user_id = $1::uuid`, userId);

            return reply.code(204).send();
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Delete failed' });
        }
    });
};

// src/routes/trainers.js
'use strict';

module.exports = async function trainersRoutes(fastify) {
    const prisma = fastify.prisma;
    const { sendEmail } = require('../services/emailService');
    const { getTranslation } = require('../config/emailTranslations');

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

    // GET /trainers/user/:userId - MUST come before /:id to avoid route conflict
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

    // GET /trainers/:id
    // If id is a UUID, fetch by ID.
    fastify.get('/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`
                SELECT t.*, p.username as profile_username, p.name as profile_name, p.avatar_url as profile_avatar, p.created_at as profile_created_at
                FROM public.trainers t
                LEFT JOIN public.profiles p ON p.user_id = t.user_id
                WHERE t.id = $1::uuid
            `, id);

            if (!rows.length) return reply.code(404).send({ error: 'Trainer not found' });

            // Increment views count asynchronously
            prisma.$queryRawUnsafe(`UPDATE public.trainers SET views_count = COALESCE(views_count, 0) + 1 WHERE id = $1::uuid`, id).catch(e => console.error('Error incrementing views:', e));

            const r = rows[0];
            return {
                ...r,
                profiles: {
                    username: r.profile_username,
                    name: r.profile_name,
                    avatar_url: r.profile_avatar,
                    created_at: r.profile_created_at
                }
            };
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
          $1::uuid, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11::text[], $12::text[], $13::text[], $14::jsonb, $15::text[], $16
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

            // Broadcast Email for New Trainer
            try {
                console.log('[TrainerDebug] Broadcasting email for new TRAINER');
                const allUsers = await prisma.user.findMany({
                    where: { id: { not: userId } },
                    include: { profile: true }
                });
                console.log(`[TrainerDebug] Found ${allUsers.length} potential recipients`);

                const title = b.name || 'New Trainer';
                const trainerId = result[0].id;

                for (const r of allUsers) {
                    const prefs = r.profile?.notificationPreferences || {};
                    if (r.email && prefs.new_listings !== false) {
                        try {
                            await prisma.notifications.create({
                                data: {
                                    user_id: r.id,
                                    type: 'new_trainer',
                                    title: 'New Trainer Profile',
                                    content: title,
                                    source_type: 'trainer',
                                    source_id: trainerId,
                                    source_user_id: userId
                                }
                            });
                        } catch (e) {
                            console.error('Failed to create notification', e);
                        }

                        const lang = r.profile?.defaultLanguage || 'en';
                        const subjectFn = getTranslation(lang, 'new_trainer_subject');
                        const subject = typeof subjectFn === 'function' ? subjectFn(title) : subjectFn;

                        const bodyFn = getTranslation(lang, 'new_trainer_body');
                        const body = typeof bodyFn === 'function' ? bodyFn(title) : bodyFn;

                        const viewProfile = getTranslation(lang, 'view_profile');
                        const trainerUrl = `${process.env.APP_WEB_URL}/${lang}/trainers/${trainerId}`;

                        await sendEmail({
                            to: r.email,
                            subject: subject,
                            html: `<p>${body}</p>
                                    <p>${b.bio ? b.bio.substring(0, 100) + '...' : ''}</p>
                                    <p>${b.hourly_rate ? b.hourly_rate + ' EUR/hr' : ''}</p>
                                    <p><a href="${trainerUrl}">${viewProfile}</a></p>`
                        });
                    }
                }
            } catch (e) {
                console.error('Error sending new trainer emails:', e);
            }

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

            if (existing[0].user_id !== userId) {
                return reply.code(403).send({ error: 'Forbidden' });
            }

            // Dynamically build SET clause
            const fields = [];
            const values = [id]; // $1 is id
            let idx = 2;

            const mappings = {
                name: 'name',
                bio: 'bio',
                years_experience: 'years_experience',
                hourly_rate: 'hourly_rate',
                pricing_type: 'pricing_type',
                phone: 'phone',
                website_url: 'website_url',
                photo_url: 'photo_url',
                age: 'age',
                specialties: 'specialties',
                languages: 'languages',
                certifications: 'certifications',
                certification_details: 'certification_details',
                files: 'files',
                visible: 'visible',
                city: 'city',
                country: 'country'
            };

            for (const [key, col] of Object.entries(mappings)) {
                if (b[key] !== undefined) {
                    let val = b[key];
                    let placeholder = `$${idx++}`;

                    if (['specialties', 'languages', 'certifications', 'files'].includes(key)) {
                        placeholder += '::text[]';
                    } else if (key === 'certification_details') {
                        val = JSON.stringify(val);
                        placeholder += '::jsonb';
                    }

                    fields.push(`${col} = ${placeholder}`);
                    values.push(val);
                }
            }

            // Always update updated_at
            fields.push(`updated_at = NOW()`);

            if (fields.length === 1) { // Only updated_at
                return { id }; // Nothing to update
            }

            const query = `UPDATE public.trainers SET ${fields.join(', ')} WHERE id = $1::uuid`;

            await prisma.$queryRawUnsafe(query, ...values);

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

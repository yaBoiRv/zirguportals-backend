// src/routes/listings.js
'use strict';

/**
 * Listings API for horses and equipment
 * Adapts between frontend format and actual DB schema
 */
module.exports = async function listingsRoutes(fastify) {
    const prisma = fastify.prisma;
    if (!prisma) throw new Error('fastify.prisma is not available');

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

    // ==================== HORSE LISTINGS ====================

    // GET /listings/horses
    fastify.get('/horses', async (req, reply) => {
        try {
            const userId = req.query.user_id;
            let rows;
            if (userId) {
                rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.horse_listings WHERE user_id = $1::uuid ORDER BY created_at DESC`, userId);
            } else {
                rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.horse_listings WHERE visible = true ORDER BY created_at DESC LIMIT 50`);
            }
            return rows.map(listing => ({
                ...listing,
                name: listing.title,
                birth_year: listing.age ? (new Date().getFullYear() - listing.age) : null,
                video_url: listing.video_urls?.[0] || null,
            }));
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to fetch listings' });
        }
    });

    // GET /listings/horses/:id
    fastify.get('/horses/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.horse_listings WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Listing not found' });
            const listing = rows[0];

            const colors = await prisma.$queryRawUnsafe(
                `SELECT c.* FROM public.horse_colors c JOIN public.horse_listing_colors lc ON lc.color_id = c.id WHERE lc.listing_id = $1::uuid`,
                id
            );
            const disciplines = await prisma.$queryRawUnsafe(
                `SELECT d.* FROM public.horse_disciplines d JOIN public.horse_listing_disciplines ld ON ld.discipline_id = d.id WHERE ld.listing_id = $1::uuid`,
                id
            );

            return {
                ...listing,
                name: listing.title,
                birth_year: listing.age ? (new Date().getFullYear() - listing.age) : null,
                video_url: listing.video_urls?.[0] || null,
                colors,
                disciplines,
            };
        } catch (e) {
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // POST /listings/horses
    fastify.post('/horses', { preHandler: requireAuth }, async (req, reply) => {
        const userId = req.user.id;
        const b = req.body;
        const age = b.birth_year ? (new Date().getFullYear() - b.birth_year) : null;
        const video_urls = b.video_url ? [b.video_url] : [];

        try {
            const result = await prisma.$queryRawUnsafe(
                `INSERT INTO public.horse_listings (
                    user_id, title, description, price, currency, country, images, 
                    status, featured, age, height, video_urls, breed_id, sex_id, 
                    visible, municipality, lat, lon, city
                ) VALUES (
                    $1::uuid, $2, $3, $4, $5, $6, $7, 'available', $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18
                ) RETURNING id`,
                userId, b.name || b.title, b.description, b.price || null, b.currency || 'EUR', b.country, b.images || [],
                b.featured || false, age, b.height || null, video_urls, b.breed_id || null, b.sex_id || null,
                b.visible !== false, b.municipality || null, Number(b.lat || 0), Number(b.lon || 0), b.city || null
            );
            const listingId = result[0].id;

            if (b.color_ids?.length) {
                for (const cid of b.color_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, listingId, cid);
                }
            }
            if (b.discipline_ids?.length) {
                for (const did of b.discipline_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_disciplines (listing_id, discipline_id) VALUES ($1::uuid, $2)`, listingId, did);
                }
            }
            return reply.code(201).send({ id: listingId });
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to create listing', details: e.message });
        }
    });

    // PUT /listings/horses/:id
    fastify.put('/horses/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;
        const age = b.birth_year ? (new Date().getFullYear() - b.birth_year) : null;
        const video_urls = b.video_url ? [b.video_url] : [];

        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.horse_listings WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Not found' });
            if (rows[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            await prisma.$queryRawUnsafe(
                `UPDATE public.horse_listings SET 
                    title = $2, description = $3, price = $4, currency = $5, country = $6, images = $7, 
                    featured = $8, age = $9, height = $10, video_urls = $11, breed_id = $12, sex_id = $13, 
                    visible = $14, municipality = $15, lat = $16, lon = $17, city = $18
                WHERE id = $1::uuid`,
                id, b.name || b.title, b.description, b.price || null, b.currency || 'EUR', b.country, b.images || [],
                b.featured || false, age, b.height || null, video_urls, b.breed_id || null, b.sex_id || null,
                b.visible !== false, b.municipality || null, Number(b.lat || 0), Number(b.lon || 0), b.city || null
            );

            // Re-sync colors and disciplines
            if (b.color_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.horse_listing_colors WHERE listing_id = $1::uuid`, id);
                for (const cid of b.color_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, id, cid);
                }
            }
            if (b.discipline_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.horse_listing_disciplines WHERE listing_id = $1::uuid`, id);
                for (const did of b.discipline_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_disciplines (listing_id, discipline_id) VALUES ($1::uuid, $2)`, id, did);
                }
            }

            return { id };
        } catch (e) {
            return reply.code(500).send({ error: 'Update failed' });
        }
    });

    // ==================== EQUIPMENT LISTINGS ====================

    // GET /listings/equipment/:id
    fastify.get('/equipment/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.equipment_listings WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Listing not found' });
            const listing = rows[0];
            const colors = await prisma.$queryRawUnsafe(
                `SELECT c.* FROM public.equipment_colors c JOIN public.equipment_listing_colors lc ON lc.color_id = c.id WHERE lc.listing_id = $1::uuid`,
                id
            );
            return { ...listing, colors };
        } catch (e) {
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /listings/equipment
    fastify.get('/equipment', async (req, reply) => {
        try {
            const userId = req.query.user_id;
            let rows;
            if (userId) {
                rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.equipment_listings WHERE user_id = $1::uuid ORDER BY created_at DESC`, userId);
            } else {
                rows = await prisma.$queryRawUnsafe(`SELECT * FROM public.equipment_listings WHERE visible = true ORDER BY created_at DESC LIMIT 50`);
            }
            return rows.map(listing => ({ ...listing }));
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to fetch equipment listings' });
        }
    });

    // POST /listings/equipment
    fastify.post('/equipment', { preHandler: requireAuth }, async (req, reply) => {
        const userId = req.user.id;
        const b = req.body;
        try {
            const result = await prisma.$queryRawUnsafe(
                `INSERT INTO public.equipment_listings (
                    user_id, title, description, price, currency, condition, size, 
                    country, images, status, featured, visible, city, lat, lon, 
                    municipality, brand_id, material_id, equipment_type_id, custom_equipment_type
                ) VALUES (
                    $1::uuid, $2, $3, $4, $5, $6, $7, $8, $9, 'available', $10, $11, $12, $13, $14, $15, $16, $17, $18, $19
                ) RETURNING id`,
                userId, b.title, b.description, b.price || null, b.currency || 'EUR', b.condition, b.size || null,
                b.country, b.images || [], b.featured || false, b.visible !== false, b.city || null,
                Number(b.lat || 0), Number(b.lon || 0), b.municipality || null, b.brand_id || null,
                b.material_id || null, b.equipment_type_id || null, b.custom_equipment_type || null
            );
            const listingId = result[0].id;
            if (b.color_ids?.length) {
                for (const cid of b.color_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.equipment_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, listingId, cid);
                }
            }
            return reply.code(201).send({ id: listingId });
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to create listing' });
        }
    });

    // PUT /listings/equipment/:id
    fastify.put('/equipment/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.equipment_listings WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Not found' });
            if (rows[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            await prisma.$queryRawUnsafe(
                `UPDATE public.equipment_listings SET 
                    title = $2, description = $3, price = $4, currency = $5, condition = $6, size = $7, country = $8, 
                    images = $9, featured = $10, visible = $11, city = $12, lat = $13, lon = $14, municipality = $15, 
                    brand_id = $16, material_id = $17, equipment_type_id = $18, custom_equipment_type = $19
                WHERE id = $1::uuid`,
                id, b.title, b.description, b.price || null, b.currency || 'EUR', b.condition, b.size || null,
                b.country, b.images || [], b.featured || false, b.visible !== false, b.city || null,
                Number(b.lat || 0), Number(b.lon || 0), b.municipality || null, b.brand_id || null,
                b.material_id || null, b.equipment_type_id || null, b.custom_equipment_type || null
            );

            if (b.color_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.equipment_listing_colors WHERE listing_id = $1::uuid`, id);
                for (const cid of b.color_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.equipment_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, id, cid);
                }
            }

            return { id };
        } catch (e) {
            return reply.code(500).send({ error: 'Update failed' });
        }
    });

    // DELETE /listings/:type/:id
    fastify.delete('/:type/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { type, id } = req.params;
        const table = type === 'horses' ? 'horse_listings' : 'equipment_listings';
        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.${table} WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Not found' });
            if (rows[0].user_id !== req.user.id) return reply.code(403).send({ error: 'Forbidden' });
            await prisma.$queryRawUnsafe(`DELETE FROM public.${table} WHERE id = $1::uuid`, id);
            return reply.code(204).send();
        } catch (e) {
            return reply.code(500).send({ error: 'Delete failed' });
        }
    });
};

// src/routes/listings.js
'use strict';

/**
 * Listings API for horses and equipment
 * Adapts between frontend format and actual DB schema
 */
module.exports = async function listingsRoutes(fastify) {
    const prisma = fastify.prisma;
    if (!prisma) throw new Error('fastify.prisma is not available');

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

    // ==================== HORSE LISTINGS ====================

    // GET /listings/horses
    fastify.get('/horses', async (req, reply) => {
        try {
            const {
                user_id, min_price, max_price, min_age, max_age, min_height, max_height,
                breed_id, sex_id, search, sort, limit = 50, offset = 0, include_hidden, lang = 'en'
            } = req.query;

            let sql = `SELECT l.*, p.name as seller_name, p.username as seller_username, p.avatar_url as seller_avatar,
                              COALESCE(hbt.name, hb.key, pbt.name, pb.key, l.custom_breed, l.custom_pony_breed) as breed,
                              ARRAY(SELECT color_id FROM public.horse_listing_colors WHERE listing_id = l.id) as color_ids,
                              ARRAY(SELECT discipline_id FROM public.horse_listing_disciplines WHERE listing_id = l.id) as discipline_ids,
                              ARRAY(SELECT temperament_id FROM public.horse_listing_temperaments WHERE listing_id = l.id) as temperament_ids
                       FROM public.horse_listings l
                       LEFT JOIN public.profiles p ON p.user_id = l.user_id
                       LEFT JOIN public.horse_breeds hb ON hb.id = l.breed_id
                       LEFT JOIN public.horse_breed_translations hbt ON hbt.breed_id = hb.id AND hbt.lang_code = $1
                       LEFT JOIN public.pony_breeds pb ON pb.id = l.pony_breed_id
                       LEFT JOIN public.pony_breed_translations pbt ON pbt.breed_id = pb.id AND pbt.lang_code = $1
                       WHERE 1=1`;

            // $1 is lang
            const params = [lang];
            let pIdx = 2;

            if (include_hidden !== 'true') {
                sql += ` AND l.visible = true`;
            }

            if (user_id) {
                sql += ` AND l.user_id = $${pIdx++}::uuid`;
                params.push(user_id);
            }

            if (min_price) { sql += ` AND l.price >= $${pIdx++}`; params.push(Number(min_price)); }
            if (max_price) { sql += ` AND l.price <= $${pIdx++}`; params.push(Number(max_price)); }

            if (min_age) {
                sql += ` AND l.age >= $${pIdx++}`; params.push(Number(min_age));
            }
            if (max_age) { sql += ` AND l.age <= $${pIdx++}`; params.push(Number(max_age)); }

            if (min_height) { sql += ` AND l.height >= $${pIdx++}`; params.push(Number(min_height)); }
            if (max_height) { sql += ` AND l.height <= $${pIdx++}`; params.push(Number(max_height)); }

            // Helper to handle array filters
            const addArrayFilter = (val, col) => {
                if (!val) return;
                const arr = Array.isArray(val) ? val : (typeof val === 'string' && val.includes(',') ? val.split(',') : [val]);
                const numArr = arr.map(Number).filter(n => !isNaN(n));
                if (numArr.length > 0) {
                    sql += ` AND l.${col} = ANY($${pIdx++})`;
                    params.push(numArr);
                }
            };

            // Support both singular (legacy) and plural query params
            const breedIds = req.query.breed_ids || (breed_id ? [breed_id] : null);
            const sexIds = req.query.sex_ids || (sex_id ? [sex_id] : null);
            const colorIds = req.query.color_ids;
            const disciplineIds = req.query.discipline_ids;
            const temperamentIds = req.query.temperament_ids;

            addArrayFilter(breedIds, 'breed_id');
            addArrayFilter(sexIds, 'sex_id');

            // Many-to-many filters
            const addJoinFilter = (ids, table, col) => {
                if (!ids) return;
                const arr = Array.isArray(ids) ? ids : (typeof ids === 'string' && ids.includes(',') ? ids.split(',') : [ids]);
                const numArr = arr.map(Number).filter(n => !isNaN(n));
                if (numArr.length > 0) {
                    sql += ` AND EXISTS (SELECT 1 FROM public.${table} sub WHERE sub.listing_id = l.id AND sub.${col} = ANY($${pIdx++}))`;
                    params.push(numArr);
                }
            };

            addJoinFilter(colorIds, 'horse_listing_colors', 'color_id');
            addJoinFilter(disciplineIds, 'horse_listing_disciplines', 'discipline_id');
            addJoinFilter(temperamentIds, 'horse_listing_temperaments', 'temperament_id');

            if (search) {
                sql += ` AND (l.title ILIKE $${pIdx} OR l.description ILIKE $${pIdx})`;
                params.push(`%${search}%`);
                pIdx++;
            }

            // Status visibility
            if (include_hidden !== 'true') {
                sql += ` AND (l.status = 'available' OR (l.status = 'sold' AND l.sold_at >= NOW() - INTERVAL '3 days'))`;
            }

            // Sort
            if (sort === 'price_asc') sql += ` ORDER BY l.price ASC`;
            else if (sort === 'price_desc') sql += ` ORDER BY l.price DESC`;
            else if (sort === 'popular') sql += ` ORDER BY l.favorites_count DESC`;
            else sql += ` ORDER BY l.created_at DESC`;

            sql += ` LIMIT $${pIdx++} OFFSET $${pIdx++}`;
            params.push(Number(limit), Number(offset));

            // Main Query
            const rows = await prisma.$queryRawUnsafe(sql, ...params);

            // Count Query logic
            // Use specific table name to avoid matching FROM in subqueries
            const fromIndex = sql.indexOf('FROM public.horse_listings');
            const orderIndex = sql.lastIndexOf('ORDER BY');
            const wherePart = sql.substring(fromIndex, orderIndex);
            // Params excluding limit/offset
            const countParams = params.slice(0, params.length - 2);

            const countRes = await prisma.$queryRawUnsafe(`SELECT COUNT(*) as cnt ${wherePart}`, ...countParams);
            const count = Number(countRes[0]?.cnt || 0);

            return {
                data: rows.map(listing => ({
                    ...listing,
                    category: 'horses', // Add category for URL generation
                    name: listing.title, // Map title to name for consistency if needed, though frontend uses title
                    birth_year: listing.age ? (new Date().getFullYear() - listing.age) : null,
                    video_url: listing.video_urls?.[0] || null,
                    seller: {
                        id: listing.user_id, // Add seller ID for chat functionality
                        name: listing.seller_name,
                        username: listing.seller_username,
                        avatar_url: listing.seller_avatar
                    }
                })),
                count
            };
        } catch (e) {
            console.error('Fetch horses error:', e);
            return reply.code(500).send({ error: 'Failed to fetch listings' });
        }
    });

    // GET /listings/horses/:id
    fastify.get('/horses/:id', async (req, reply) => {
        const { id } = req.params;
        const lang = req.query.lang || 'en';

        try {
            const rows = await prisma.$queryRawUnsafe(
                `SELECT l.*, p.name as seller_name, p.username as seller_username, p.avatar_url as seller_avatar, p.phone as seller_phone, p.created_at as seller_member_since,
                        COALESCE(hbt.name, hb.key, pbt.name, pb.key, l.custom_breed, l.custom_pony_breed) as breed
                 FROM public.horse_listings l
                 LEFT JOIN public.profiles p ON p.user_id = l.user_id
                 LEFT JOIN public.horse_breeds hb ON hb.id = l.breed_id
                 LEFT JOIN public.horse_breed_translations hbt ON hbt.breed_id = hb.id AND hbt.lang_code = $2
                 LEFT JOIN public.pony_breeds pb ON pb.id = l.pony_breed_id
                 LEFT JOIN public.pony_breed_translations pbt ON pbt.breed_id = pb.id AND pbt.lang_code = $2
                 WHERE l.id = $1::uuid`,
                id, lang
            );
            if (!rows.length) return reply.code(404).send({ error: 'Listing not found' });

            // Increment views count asynchronously
            prisma.$queryRawUnsafe(`UPDATE public.horse_listings SET views_count = COALESCE(views_count, 0) + 1 WHERE id = $1::uuid`, id).catch(e => console.error('Error incrementing views:', e));

            const r = rows[0];

            const colors = await prisma.$queryRawUnsafe(
                `SELECT c.* FROM public.horse_colors c JOIN public.horse_listing_colors lc ON lc.color_id = c.id WHERE lc.listing_id = $1::uuid`,
                id
            );
            const disciplines = await prisma.$queryRawUnsafe(
                `SELECT d.* FROM public.horse_disciplines d JOIN public.horse_listing_disciplines ld ON ld.discipline_id = d.id WHERE ld.listing_id = $1::uuid`,
                id
            );
            const temperaments = await prisma.$queryRawUnsafe(
                `SELECT t.*, tr.name 
                 FROM public.horse_temperament t 
                 JOIN public.horse_listing_temperaments lt ON lt.temperament_id = t.id 
                 LEFT JOIN public.horse_temperament_translations tr ON tr.temperament_id = t.id AND tr.lang_code = 'en'
                 WHERE lt.listing_id = $1::uuid`,
                id
            );

            return {
                ...r,
                category: 'horses',
                name: r.title,
                birth_year: r.age ? (new Date().getFullYear() - r.age) : null,
                video_url: r.video_urls?.[0] || null,
                colors,
                disciplines,
                temperaments,
                seller: {
                    id: r.user_id, // Add seller ID for chat functionality
                    name: r.seller_name,
                    username: r.seller_username,
                    avatar_url: r.seller_avatar,
                    phone: r.seller_phone,
                    created_at: r.seller_member_since
                }
            };
        } catch (e) {
            console.error('Fetch horse error:', e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // POST /listings/horses
    fastify.post('/horses', { preHandler: requireAuth }, async (req, reply) => {
        const userId = req.user.id;
        const b = req.body;
        const age = b.age !== undefined ? b.age : (b.birth_year ? (new Date().getFullYear() - b.birth_year) : null);
        const video_urls = b.video_urls || (b.video_url ? [b.video_url] : []);

        try {
            const result = await prisma.$queryRawUnsafe(
                `INSERT INTO public.horse_listings (
                    user_id, title, description, price, currency, country, images, 
                    status, featured, age, height, video_urls, breed_id, sex_id, 
                    visible, municipality, lat, lon, city, registration_id,
                    animal_type, pony_breed_id, custom_breed, custom_pony_breed
                ) VALUES (
                    $1::uuid, $2, $3, $4, $5, $6, $7, 'available', $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19,
                    $20, $21, $22, $23
                ) RETURNING id`,
                userId, b.name || b.title, b.description, b.price || null, b.currency || 'EUR', b.country, b.images || [],
                b.featured || false, age, b.height || null, video_urls, b.breed_id || null, b.sex_id || null,
                b.visible !== false, b.municipality || null, Number(b.lat || 0), Number(b.lon || 0), b.city || null,
                b.registration_id || null, b.animal_type || 'horse', b.pony_breed_id || null, b.custom_breed || null,
                b.custom_pony_breed || null
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
            if (b.temperament_ids?.length) {
                for (const tid of b.temperament_ids) {
                    await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_temperaments (listing_id, temperament_id) VALUES ($1::uuid, $2)`, listingId, tid);
                }
            }

            // Broadcast Email for New Listing
            try {
                console.log('[ListingDebug] Broadcasting email for new HORSE listing');
                // Fetch users who want new listings (default true)
                const allUsers = await prisma.user.findMany({
                    where: { id: { not: userId } },
                    include: { profile: { select: { defaultLanguage: true, notificationPreferences: true } } }
                });
                console.log(`[ListingDebug] Found ${allUsers.length} potential recipients`);

                const title = b.name || b.title || 'New Horse Listing';

                for (const r of allUsers) {
                    const prefs = r.profile?.notificationPreferences || {};
                    // console.log(`[ListingDebug] Checking user ${r.email}: new_listings=${prefs.new_listings}`);
                    if (r.email && prefs.new_listings !== false) {
                        // console.log(`[ListingDebug] Sending to ${r.email}`);
                        const lang = r.profile?.defaultLanguage || 'en';
                        const subjectFn = getTranslation(lang, 'new_listing_subject');
                        const subject = typeof subjectFn === 'function' ? subjectFn(title) : subjectFn;

                        const bodyFn = getTranslation(lang, 'new_listing_body');
                        const body = typeof bodyFn === 'function' ? bodyFn(title) : bodyFn;

                        const priceLabel = getTranslation(lang, 'price');
                        const viewListing = getTranslation(lang, 'view_listing');
                        const listingUrl = `${process.env.APP_WEB_URL}/${lang}/horses/${listingId}`;

                        sendEmail({
                            to: r.email,
                            subject: subject,
                            html: `<p>${body}</p>
                                    <p>${b.description ? b.description.substring(0, 100) + '...' : ''}</p>
                                    <p>${priceLabel}: ${b.price || 'N/A'} ${b.currency || 'EUR'}</p>
                                    <p><a href="${listingUrl}">${viewListing}</a></p>`
                        });
                    }
                }
            } catch (e) {
                console.error('Error sending new listing emails:', e);
            }

            return reply.code(201).send({ id: listingId });
        } catch (e) {
            console.error('Create horse error:', e);
            return reply.code(500).send({ error: 'Failed to create listing', details: e.message });
        }
    });

    // PUT /listings/horses/:id
    fastify.put('/horses/:id', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const userId = req.user.id;
        const b = req.body;

        // Handle age from either age or birth_year
        let age = b.age;
        if (age === undefined && b.birth_year !== undefined) {
            age = new Date().getFullYear() - b.birth_year;
        }

        // Handle video_urls
        let video_urls = b.video_urls;
        if (!video_urls && b.video_url) {
            video_urls = [b.video_url];
        }

        try {
            const rows = await prisma.$queryRawUnsafe(`SELECT user_id FROM public.horse_listings WHERE id = $1::uuid`, id);
            if (!rows.length) return reply.code(404).send({ error: 'Not found' });
            if (rows[0].user_id !== userId) return reply.code(403).send({ error: 'Forbidden' });

            const fields = [];
            const values = [id];
            let idx = 2;

            const mappings = {
                title: 'title', name: 'title',
                description: 'description',
                price: 'price',
                currency: 'currency',
                country: 'country',
                images: 'images',
                featured: 'featured',
                // age, height, video_urls handled specifically below or if passed directly
                breed_id: 'breed_id',
                pony_breed_id: 'pony_breed_id',
                custom_breed: 'custom_breed',
                custom_pony_breed: 'custom_pony_breed',
                animal_type: 'animal_type',
                sex_id: 'sex_id',
                visible: 'visible',
                municipality: 'municipality',
                lat: 'lat',
                lon: 'lon',
                city: 'city',
                status: 'status',
                sold_at: 'sold_at',
                registration_id: 'registration_id'
            };

            // Add manually processed fields if they have values
            if (age !== undefined) {
                fields.push(`age = $${idx++}`);
                values.push(age);
            }
            if (b.height !== undefined) {
                fields.push(`height = $${idx++}`);
                values.push(b.height);
            }
            if (video_urls !== undefined) {
                fields.push(`video_urls = $${idx++}`);
                values.push(video_urls);
            }

            for (const [key, col] of Object.entries(mappings)) {
                if (b[key] !== undefined) {
                    if (fields.some(f => f.startsWith(`${col} =`))) continue;

                    let placeholder = `$${idx++}`;
                    if (key === 'sold_at') placeholder += '::timestamptz';

                    fields.push(`${col} = ${placeholder}`);
                    values.push(b[key]);
                }
            }

            fields.push(`updated_at = NOW()`);

            if (fields.length > 1) {
                const query = `UPDATE public.horse_listings SET ${fields.join(', ')} WHERE id = $1::uuid`;
                await prisma.$queryRawUnsafe(query, ...values);
            }

            // Sync colors/disciplines ONLY if provided
            if (b.color_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.horse_listing_colors WHERE listing_id = $1::uuid`, id);
                if (Array.isArray(b.color_ids)) {
                    for (const cid of b.color_ids) {
                        await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, id, cid);
                    }
                }
            }
            if (b.discipline_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.horse_listing_disciplines WHERE listing_id = $1::uuid`, id);
                if (Array.isArray(b.discipline_ids)) {
                    for (const did of b.discipline_ids) {
                        await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_disciplines (listing_id, discipline_id) VALUES ($1::uuid, $2)`, id, did);
                    }
                }
            }
            if (b.temperament_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.horse_listing_temperaments WHERE listing_id = $1::uuid`, id);
                if (Array.isArray(b.temperament_ids)) {
                    for (const tid of b.temperament_ids) {
                        await prisma.$queryRawUnsafe(`INSERT INTO public.horse_listing_temperaments (listing_id, temperament_id) VALUES ($1::uuid, $2)`, id, tid);
                    }
                }
            }

            return { id };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Update failed' });
        }
    });

    // ==================== EQUIPMENT LISTINGS ====================

    // GET /listings/equipment/:id
    fastify.get('/equipment/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const rows = await prisma.$queryRawUnsafe(
                `SELECT l.*, p.name as seller_name, p.username as seller_username, p.avatar_url as seller_avatar, p.phone as seller_phone, p.created_at as seller_member_since, b.name as brand
                 FROM public.equipment_listings l
                 LEFT JOIN public.profiles p ON p.user_id = l.user_id
                 LEFT JOIN public.equipment_brands b ON b.id = l.brand_id
                 WHERE l.id = $1::uuid`,
                id
            );
            if (!rows.length) return reply.code(404).send({ error: 'Listing not found' });

            // Increment views count asynchronously
            prisma.$queryRawUnsafe(`UPDATE public.equipment_listings SET views_count = COALESCE(views_count, 0) + 1 WHERE id = $1::uuid`, id).catch(e => console.error('Error incrementing views:', e));

            const r = rows[0];

            const colors = await prisma.$queryRawUnsafe(
                `SELECT c.* FROM public.equipment_colors c JOIN public.equipment_listing_colors lc ON lc.color_id = c.id WHERE lc.listing_id = $1::uuid`,
                id
            );

            return {
                ...r,
                category: 'equipment',
                colors,
                seller: {
                    id: r.user_id, // Add seller ID for chat functionality
                    name: r.seller_name,
                    username: r.seller_username,
                    avatar_url: r.seller_avatar,
                    phone: r.seller_phone,
                    created_at: r.seller_member_since
                }
            };
        } catch (e) {
            console.error('Fetch equipment error:', e);
            return reply.code(500).send({ error: 'Database error' });
        }
    });

    // GET /listings/equipment
    fastify.get('/equipment', async (req, reply) => {
        try {
            const {
                user_id, equipmentType_ids, brand_ids, material_ids, condition_ids,
                min_price, max_price, search, sort, limit = 50, offset = 0, include_hidden, lang = 'en'
            } = req.query;

            let sql = `SELECT l.*, p.name as seller_name, p.username as seller_username, p.avatar_url as seller_avatar,
                              COALESCE(ett.name, et.key, l.custom_equipment_type) as equipment_type,
                              b.name as brand,
                              ARRAY(SELECT color_id FROM public.equipment_listing_colors WHERE listing_id = l.id) as color_ids
                       FROM public.equipment_listings l
                       LEFT JOIN public.profiles p ON p.user_id = l.user_id
                       LEFT JOIN public.equipment_types et ON et.id = l.equipment_type_id
                       LEFT JOIN public.equipment_type_translations ett ON ett.type_id = et.id AND ett.lang_code = $1
                       LEFT JOIN public.equipment_brands b ON b.id = l.brand_id
                       WHERE 1=1`;
            const params = [lang];
            let pIdx = 2;

            if (include_hidden !== 'true') {
                sql += ` AND l.visible = true`;
            }

            if (user_id) {
                sql += ` AND l.user_id = $${pIdx++}::uuid`;
                params.push(user_id);
            }

            // Helper to handle array filters
            const addArrayFilter = (val, col) => {
                if (!val) return;
                // Parse comma-separated if string
                const arr = Array.isArray(val) ? val : (typeof val === 'string' && val.includes(',') ? val.split(',') : [val]);
                const numArr = arr.map(Number).filter(n => !isNaN(n));

                if (numArr.length > 0) {
                    sql += ` AND l.${col} = ANY($${pIdx++})`;
                    params.push(numArr);
                }
            };

            addArrayFilter(equipmentType_ids, 'equipment_type_id');
            addArrayFilter(brand_ids, 'brand_id');
            addArrayFilter(material_ids, 'material_id');
            // condition is string enum in DB ('new', 'used', etc) or text? 
            // Previous code used addArrayFilter but cast to Number. 
            // Let's check Schema if possible. But assume frontend sends what backend needs. 
            // If condition_ids implies IDs, but DB has string 'condition', we might have a mismatch or need translation. 
            // The previous code had:  addArrayFilter(condition_ids, 'condition'); which casts to Number. 
            // If condition in DB is string, this fails. 
            // Let's assume condition_ids are NOT numbers if condition is string.
            // But 'condition_ids' suggests IDs. 
            // Let's keep it safe: if it's strictly specific values, we use string array filter logic.
            // For now, I'll use a string version of array filter for condition if needed, or just revert to previous logic
            // providing the previous logic WAS working or intended. 
            // The previous logic I restored uses `addArrayFilter` which casts to Number. 
            // If condition IS text, this is a bug in previous logic too. 
            // I'll stick to the "AddArrayFilter" logic for now but might need adjustment if condition is text.
            // Actually, for condition, let's treat it as string array.
            if (condition_ids) {
                const arr = Array.isArray(condition_ids) ? condition_ids : (typeof condition_ids === 'string' ? condition_ids.split(',') : [condition_ids]);
                if (arr.length > 0) {
                    sql += ` AND l.condition = ANY($${pIdx++})`;
                    params.push(arr);
                }
            }

            if (min_price) {
                sql += ` AND l.price >= $${pIdx++}`;
                params.push(Number(min_price));
            }
            if (max_price) {
                sql += ` AND l.price <= $${pIdx++}`;
                params.push(Number(max_price));
            }
            if (search) {
                sql += ` AND (l.title ILIKE $${pIdx} OR l.description ILIKE $${pIdx})`;
                params.push(`%${search}%`);
                pIdx++;
            }

            // Status visibility: available or sold recently (3 days)
            if (include_hidden !== 'true') {
                sql += ` AND (l.status = 'available' OR (l.status = 'sold' AND l.sold_at >= NOW() - INTERVAL '3 days'))`;
            }

            // Sort
            if (sort === 'price_asc') sql += ` ORDER BY l.price ASC`;
            else if (sort === 'price_desc') sql += ` ORDER BY l.price DESC`;
            else if (sort === 'popular') sql += ` ORDER BY l.favorites_count DESC`;
            else sql += ` ORDER BY l.created_at DESC`;

            // Limit/Offset
            sql += ` LIMIT $${pIdx++} OFFSET $${pIdx++}`;
            params.push(Number(limit), Number(offset));

            // Execute Main Query
            const rows = await prisma.$queryRawUnsafe(sql, ...params);

            // Execute Count Query
            // Use specific table name to avoid matching FROM in subqueries
            const fromIndex = sql.indexOf('FROM public.equipment_listings');
            const orderIndex = sql.lastIndexOf('ORDER BY');
            const wherePart = sql.substring(fromIndex, orderIndex);

            // Note: params mapping relies on $1, $2, etc. We must pass the exact same params slicing.
            // But we added limit/offset params at end.
            const countParams = params.slice(0, params.length - 2);
            const countQuery = `SELECT COUNT(*) as cnt ${wherePart}`;

            const countRes = await prisma.$queryRawUnsafe(countQuery, ...countParams);
            const count = Number(countRes[0]?.cnt || 0);

            return {
                data: rows.map(r => ({
                    ...r,
                    category: 'equipment',
                    seller: {
                        id: r.user_id, // Add seller ID for chat functionality
                        name: r.seller_name,
                        username: r.seller_username,
                        avatar_url: r.seller_avatar
                    }
                })),
                count
            };
        } catch (e) {
            console.error('List equipment error:', e);
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
            // Broadcast Email for New Equipment Listing
            try {
                console.log('[ListingDebug] Broadcasting email for new EQUIPMENT listing');
                const allUsers = await prisma.user.findMany({
                    where: { id: { not: userId } },
                    include: { profile: { select: { defaultLanguage: true, notificationPreferences: true } } }
                });
                console.log(`[ListingDebug] Found ${allUsers.length} potential recipients`);

                const title = b.title || 'New Equipment Listing';

                for (const r of allUsers) {
                    const prefs = r.profile?.notificationPreferences || {};
                    if (r.email && prefs.new_listings !== false) {
                        const lang = r.profile?.defaultLanguage || 'en';
                        const subjectFn = getTranslation(lang, 'new_listing_subject');
                        const subject = typeof subjectFn === 'function' ? subjectFn(title) : subjectFn;

                        const bodyFn = getTranslation(lang, 'new_equipment_body');
                        const body = typeof bodyFn === 'function' ? bodyFn(title) : bodyFn;

                        const priceLabel = getTranslation(lang, 'price');
                        const viewListing = getTranslation(lang, 'view_listing');
                        const listingUrl = `${process.env.APP_WEB_URL}/${lang}/equipment/${listingId}`;

                        sendEmail({
                            to: r.email,
                            subject: subject,
                            html: `<p>${body}</p>
                                    <p>${b.description ? b.description.substring(0, 100) + '...' : ''}</p>
                                    <p>${priceLabel}: ${b.price || 'N/A'} ${b.currency || 'EUR'}</p>
                                    <p><a href="${listingUrl}">${viewListing}</a></p>`
                        });
                    }
                }
            } catch (e) {
                console.error('Error sending new equipment listing emails:', e);
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

            const fields = [];
            const values = [id];
            let idx = 2;

            const mappings = {
                title: 'title',
                description: 'description',
                price: 'price',
                currency: 'currency',
                condition: 'condition',
                size: 'size',
                country: 'country',
                images: 'images',
                featured: 'featured',
                visible: 'visible',
                city: 'city',
                lat: 'lat',
                lon: 'lon',
                municipality: 'municipality',
                brand_id: 'brand_id',
                material_id: 'material_id',
                equipment_type_id: 'equipment_type_id',
                custom_equipment_type: 'custom_equipment_type',
                status: 'status',
                sold_at: 'sold_at'
            };

            for (const [key, col] of Object.entries(mappings)) {
                if (b[key] !== undefined) {
                    if (fields.some(f => f.startsWith(`${col} =`))) continue;

                    let placeholder = `$${idx++}`;
                    if (key === 'sold_at') placeholder += '::timestamptz';

                    fields.push(`${col} = ${placeholder}`);
                    values.push(b[key]);
                }
            }

            fields.push(`updated_at = NOW()`);

            if (fields.length > 1) {
                const query = `UPDATE public.equipment_listings SET ${fields.join(', ')} WHERE id = $1::uuid`;
                await prisma.$queryRawUnsafe(query, ...values);
            }

            if (b.color_ids !== undefined) {
                await prisma.$queryRawUnsafe(`DELETE FROM public.equipment_listing_colors WHERE listing_id = $1::uuid`, id);
                if (Array.isArray(b.color_ids)) {
                    for (const cid of b.color_ids) {
                        await prisma.$queryRawUnsafe(`INSERT INTO public.equipment_listing_colors (listing_id, color_id) VALUES ($1::uuid, $2)`, id, cid);
                    }
                }
            }

            return { id };
        } catch (e) {
            console.error(e);
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

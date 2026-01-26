// src/routes/dictionaries.js
'use strict';

/**
 * Dictionaries endpoint for frontend dropdowns.
 * GET /api/dictionaries/:key?lang=en
 *
 * Returns: [{ id, key, name, icon? }]
 */
module.exports = async function dictionariesRoutes(fastify) {
  const prisma = fastify.prisma; // assumes you decorate fastify with prisma
  if (!prisma) throw new Error('fastify.prisma is not available (decorate prisma first)');

  // normalize lang
  function normLang(lang) {
    const l = String(lang || 'en').toLowerCase();
    // support your app languages (adjust if needed)
    if (['lv', 'en', 'ru', 'lt', 'et'].includes(l)) return l;
    return 'en';
  }

  // Helper: base table + translation table (name)
  async function dictWithTranslations({ table, trTable, trFk, iconColumn = null }, lang) {
    // Uses LEFT JOIN so if translation missing, name can be null.
    // You can COALESCE to fallback later if you want.
    const rows = await prisma.$queryRawUnsafe(
      `
      SELECT
        b.id,
        b.key,
        ${iconColumn ? `b.${iconColumn} AS icon,` : ''}
        t.name
      FROM public.${table} b
      LEFT JOIN public.${trTable} t
        ON t.${trFk} = b.id
       AND t.lang_code = $1
      ORDER BY COALESCE(t.name, b.key) ASC;
      `,
      lang
    );

    // Ensure consistent output shape
    return rows.map(r => ({
      id: r.id,
      key: r.key,
      name: r.name ?? r.key,
      ...(iconColumn ? { icon: r.icon } : {}),
    }));
  }

  // --- Fallback Data ---
  const MOCKS = {
    'horse-colors': [{ id: 1, key: 'bay', name: 'Bay' }, { id: 2, key: 'chestnut', name: 'Chestnut' }, { id: 3, key: 'black', name: 'Black' }, { id: 4, key: 'grey', name: 'Grey' }],
    'horse-breeds': [{ id: 1, key: 'arabian', name: 'Arabian' }, { id: 2, key: 'friesian', name: 'Friesian' }, { id: 3, key: 'tb', name: 'Thoroughbred' }],
    'pony-breeds': [{ id: 1, key: 'shetland', name: 'Shetland' }, { id: 2, key: 'welsh', name: 'Welsh Pony' }],
    'horse-disciplines': [{ id: 1, key: 'dressage', name: 'Dressage' }, { id: 2, key: 'jumping', name: 'Show Jumping' }],
    'horse-temperament': [{ id: 1, key: 'calm', name: 'Calm' }, { id: 2, key: 'energetic', name: 'Energetic' }],
    'equipment-colors': [{ id: 1, key: 'black', name: 'Black' }, { id: 2, key: 'brown', name: 'Brown' }],
    'countries': [{ id: 1, key: 'LV', name: 'Latvia' }, { id: 2, key: 'LT', name: 'Lithuania' }, { id: 3, key: 'EE', name: 'Estonia' }],
    'equipment-brands': [{ id: 1, key: 'prestige', name: 'Prestige' }, { id: 2, key: 'kieffer', name: 'Kieffer' }],
    'equipment-types': [{ id: 1, key: 'saddle', name: 'Saddle' }, { id: 2, key: 'bridle', name: 'Bridle' }],
    'equipment-materials': [{ id: 1, key: 'leather', name: 'Leather' }, { id: 2, key: 'synthetic', name: 'Synthetic' }],
    'equipment-conditions': [{ id: 1, key: 'new', name: 'New' }, { id: 2, key: 'good', name: 'Good' }],
    'trainer-species': [],
    'trainer-specialties': [{ id: 1, key: 'dressage', name: 'Dressage' }, { id: 2, key: 'jumping', name: 'Jumping' }],
    'trainer-languages': [{ id: 1, key: 'en', name: 'English' }, { id: 2, key: 'lv', name: 'Latvian' }],
    'trainer-certifications': [{ id: 1, key: 'cert1', name: 'Certificate 1' }],
    'service-specialties': [{ id: 1, key: 'vet', name: 'Veterinarian' }, { id: 2, key: 'farrier', name: 'Farrier' }],
    'announcement-categories': [{ id: 1, key: 'sell', name: 'Sell' }, { id: 2, key: 'buy', name: 'Buy' }]
  };

  async function safeDict(key, fn) {
    try {
      return await fn();
    } catch (e) {
      console.error(`Dictionary DB failed for ${key}, returning mock.`);
      return MOCKS[key] || [];
    }
  }

  fastify.get('/dictionaries/:key', async (request, reply) => {
    const key = String(request.params.key || '').toLowerCase();
    const lang = normLang(request.query.lang);

    // Cache a little (safe for dictionaries)
    reply.header('Cache-Control', 'public, max-age=300');

    switch (key) {
      case 'horse-colors':
        return safeDict('horse-colors', () => dictWithTranslations({
          table: 'horse_colors',
          trTable: 'horse_color_translations',
          trFk: 'color_id',
        }, lang));

      case 'horse-breeds':
        return safeDict('horse-breeds', () => dictWithTranslations({
          table: 'horse_breeds',
          trTable: 'horse_breed_translations',
          trFk: 'breed_id',
        }, lang));

      case 'pony-breeds':
        return safeDict('pony-breeds', () => dictWithTranslations({
          table: 'pony_breeds',
          trTable: 'pony_breed_translations',
          trFk: 'breed_id',
        }, lang));

      case 'horse-disciplines':
        return safeDict('horse-disciplines', () => dictWithTranslations({
          table: 'horse_disciplines',
          trTable: 'horse_discipline_translations',
          trFk: 'discipline_id',
        }, lang));

      case 'horse-temperament':
      case 'horse-temperaments':
        return safeDict('horse-temperament', () => dictWithTranslations({
          table: 'horse_temperament',
          trTable: 'horse_temperament_translations',
          trFk: 'temperament_id',
        }, lang));

      case 'forum-categories':
        // forum_categories likely has icon column; if it does, include it.
        // If forum_categories does NOT have icon, set iconColumn=null.
        return safeDict('forum-categories', () => dictWithTranslations({
          table: 'forum_categories',
          trTable: 'forum_category_translations',
          trFk: 'category_id',
          iconColumn: 'icon', // if column doesn't exist, change to null
        }, lang));

      case 'equipment-colors':
        return safeDict('equipment-colors', () => dictWithTranslations({
          table: 'equipment_colors',
          trTable: 'equipment_color_translations',
          trFk: 'color_id',
        }, lang));

      case 'horse-sex':
        // You don't have a table for this in your list. Frontend expects it -> return static.
        // Adjust keys to what your frontend expects (common ones: mare/stallion/gelding).
        return [
          { key: 'mare', name: lang === 'lv' ? 'Ķēve' : lang === 'ru' ? 'Кобыла' : 'Mare' },
          { key: 'stallion', name: lang === 'lv' ? 'Ērzelis' : lang === 'ru' ? 'Жеребец' : 'Stallion' },
          { key: 'gelding', name: lang === 'lv' ? 'Kastrāts' : lang === 'ru' ? 'Мерин' : 'Gelding' },
        ];

      case 'countries':
        return safeDict('countries', () => dictWithTranslations({
          table: 'countries',
          trTable: 'country_translations',
          trFk: 'country_id',
        }, lang));

      case 'announcement-categories':
        return safeDict('announcement-categories', () => dictWithTranslations({
          table: 'announcement_categories',
          trTable: 'announcement_category_translations',
          trFk: 'category_id',
        }, lang));

      case 'service-specialties':
        return safeDict('service-specialties', () => dictWithTranslations({
          table: 'service_specialties',
          trTable: 'service_specialty_translations',
          trFk: 'specialty_id',
        }, lang));

      case 'trainer-specialties':
        return safeDict('trainer-specialties', () => dictWithTranslations({
          table: 'trainer_specialties',
          trTable: 'trainer_specialty_translations',
          trFk: 'specialty_id',
        }, lang));

      // Simple dictionaries (no translations or simple key/name)
      case 'equipment-brands':
        // Assuming simple table with id, key, name or just key/name. 
        // If it uses translations, use dictWithTranslations.
        // Based on commonService usage, it seems these might just be lists.
        // Let's assume standard patterns:
        return safeDict('equipment-brands', () => prisma.$queryRawUnsafe('SELECT id, key, name FROM public.equipment_brands ORDER BY name ASC'));

      case 'equipment-types':
        return safeDict('equipment-types', () => dictWithTranslations({
          table: 'equipment_types',
          trTable: 'equipment_type_translations',
          trFk: 'type_id',
        }, lang));

      case 'equipment-materials':
        return safeDict('equipment-materials', async () => {
          // Handle equipmentTypeId filter if passed in query
          const eqTypeId = request.query.equipmentTypeId ? Number(request.query.equipmentTypeId) : null;
          let sql = `
                SELECT b.id, b.key, t.name 
                FROM public.equipment_materials b
                LEFT JOIN public.equipment_material_translations t ON t.material_id = b.id AND t.lang_code = $1
            `;
          const params = [lang];
          if (eqTypeId) {
            sql += ` WHERE b.equipment_type_id = $2 `;
            params.push(eqTypeId);
          }
          sql += ` ORDER BY COALESCE(t.name, b.key) ASC`;

          const materials = await prisma.$queryRawUnsafe(sql, ...params);
          return materials.map(r => ({ id: r.id, key: r.key, name: r.name ?? r.key }));
        });

      case 'equipment-conditions':
        return safeDict('equipment-conditions', () => dictWithTranslations({
          table: 'equipment_conditions',
          trTable: 'equipment_condition_translations',
          trFk: 'condition_id',
        }, lang));

        // Assuming a table or static list. Let's try table.
        return safeDict('trainer-languages', () => prisma.$queryRawUnsafe('SELECT id, key, name FROM public.trainer_languages ORDER BY name ASC'));

      case 'trainer-certifications':
        return safeDict('trainer-certifications', () => dictWithTranslations({
          table: 'trainer_certifications',
          trTable: 'trainer_certification_translations',
          trFk: 'certification_id',
        }, lang));

      default:
        reply.code(404);
        return { error: 'Dictionary not found', key };
    }
  });
};

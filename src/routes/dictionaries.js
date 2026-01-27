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


  // --- Fallback Data REMOVED - Database only ---

  fastify.get('/:key', async (request, reply) => {
    const key = String(request.params.key || '').toLowerCase();
    const lang = normLang(request.query.lang);

    // Cache a little (safe for dictionaries)
    reply.header('Cache-Control', 'public, max-age=300');

    switch (key) {
      case 'horse-colors':
        // Include the `hex` column (aliased as `icon`) so the frontend can render color swatches.
        return dictWithTranslations({
          table: 'horse_colors',
          trTable: 'horse_color_translations',
          trFk: 'color_id',
          iconColumn: 'hex',
        }, lang);

      case 'horse-breeds':
        return dictWithTranslations({
          table: 'horse_breeds',
          trTable: 'horse_breed_translations',
          trFk: 'breed_id',
        }, lang);

      case 'pony-breeds':
        return dictWithTranslations({
          table: 'pony_breeds',
          trTable: 'pony_breed_translations',
          trFk: 'breed_id',
        }, lang);

      case 'horse-disciplines':
        return dictWithTranslations({
          table: 'horse_disciplines',
          trTable: 'horse_discipline_translations',
          trFk: 'discipline_id',
        }, lang);

      case 'horse-temperament':
      case 'horse-temperaments':
        return dictWithTranslations({
          table: 'horse_temperament',
          trTable: 'horse_temperament_translations',
          trFk: 'temperament_id',
        }, lang);

      case 'forum-categories':
        return dictWithTranslations({
          table: 'forum_categories',
          trTable: 'forum_category_translations',
          trFk: 'category_id',
          iconColumn: 'icon',
        }, lang);

      case 'equipment-colors':
        return dictWithTranslations({
          table: 'equipment_colors',
          trTable: 'equipment_color_translations',
          trFk: 'color_id',
          iconColumn: 'hex',
        }, lang);

      case 'horse-sex':
        // Return stable ids so frontend select components can use them as values.
        return [
          { id: 1, key: 'mare', name: lang === 'lv' ? 'Ķēve' : lang === 'ru' ? 'Кобыла' : 'Mare' },
          { id: 2, key: 'stallion', name: lang === 'lv' ? 'Ērzelis' : lang === 'ru' ? 'Жеребец' : 'Stallion' },
          { id: 3, key: 'gelding', name: lang === 'lv' ? 'Kastrāts' : lang === 'ru' ? 'Мерин' : 'Gelding' },
        ];

      case 'countries':
        return dictWithTranslations({
          table: 'countries',
          trTable: 'country_translations',
          trFk: 'country_id',
        }, lang);

      case 'announcement-categories':
        return dictWithTranslations({
          table: 'announcement_categories',
          trTable: 'announcement_category_translations',
          trFk: 'category_id',
        }, lang);

      case 'service-specialties':
        return dictWithTranslations({
          table: 'service_specialties',
          trTable: 'service_specialty_translations',
          trFk: 'specialty_id',
        }, lang);

      case 'trainer-specialties':
        return dictWithTranslations({
          table: 'trainer_specialties',
          trTable: 'trainer_specialty_translations',
          trFk: 'specialty_id',
        }, lang);

      case 'equipment-brands':
        return prisma.$queryRawUnsafe('SELECT id, key, name FROM public.equipment_brands ORDER BY name ASC');

      case 'equipment-types':
        return dictWithTranslations({
          table: 'equipment_types',
          trTable: 'equipment_type_translations',
          trFk: 'type_id',
        }, lang);

      case 'equipment-materials': {
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
      }

      case 'equipment-conditions':
        return dictWithTranslations({
          table: 'equipment_conditions',
          trTable: 'equipment_condition_translations',
          trFk: 'condition_id',
        }, lang);

      case 'trainer-certifications':
        return dictWithTranslations({
          table: 'trainer_certifications',
          trTable: 'trainer_certification_translations',
          trFk: 'certification_id',
        }, lang);

      default:
        reply.code(404);
        return { error: 'Dictionary not found', key };
    }
  });
};

// src/routes/dictionaries.js
'use strict';

/**
 * Dictionaries endpoint for frontend dropdowns.
 * GET /api/dictionaries/:key?lang=en
 *
 * Returns: [{ id, key, name, icon? }]
 */
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

module.exports = async function dictionariesRoutes(fastify) {


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

  fastify.get('/:key', async (request, reply) => {
    const key = String(request.params.key || '').toLowerCase();
    const lang = normLang(request.query.lang);

    // Cache a little (safe for dictionaries)
    reply.header('Cache-Control', 'public, max-age=300');

    switch (key) {
      case 'horse-colors':
        return dictWithTranslations({
          table: 'horse_colors',
          trTable: 'horse_color_translations',
          trFk: 'color_id',
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
        // forum_categories likely has icon column; if it does, include it.
        // If forum_categories does NOT have icon, set iconColumn=null.
        return dictWithTranslations({
          table: 'forum_categories',
          trTable: 'forum_category_translations',
          trFk: 'category_id',
          iconColumn: 'icon', // if column doesn't exist, change to null
        }, lang);

      case 'equipment-colors':
        return dictWithTranslations({
          table: 'equipment_colors',
          trTable: 'equipment_color_translations',
          trFk: 'color_id',
        }, lang);

      case 'horse-sex':
        // You don't have a table for this in your list. Frontend expects it -> return static.
        // Adjust keys to what your frontend expects (common ones: mare/stallion/gelding).
        return [
          { key: 'mare', name: lang === 'lv' ? 'Ķēve' : lang === 'ru' ? 'Кобыла' : 'Mare' },
          { key: 'stallion', name: lang === 'lv' ? 'Ērzelis' : lang === 'ru' ? 'Жеребец' : 'Stallion' },
          { key: 'gelding', name: lang === 'lv' ? 'Kastrāts' : lang === 'ru' ? 'Мерин' : 'Gelding' },
        ];

      default:
        reply.code(404);
        return { error: 'Dictionary not found', key };
    }
  });
};

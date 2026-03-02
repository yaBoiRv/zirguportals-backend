'use strict';

/**
 * viewsService.js
 * ────────────────────────────────────────────────────────────────────────────
 * Buffered, deduplicated view tracking for all entity types.
 *
 * Logic:
 *  1. Bot/crawler detection – if the User-Agent looks like a bot we skip counting.
 *  2. Uniqueness window – 1 view per (user_id OR ip+user_agent) per entity per 24 h.
 *  3. Buffered aggregate – we only increment the `views_count` column on the main
 *     table when the view is actually unique, so the read path stays a fast
 *     single-column lookup instead of a COUNT(*) scan.
 *
 * Supported entity types and their config:
 *   horse      → horse_listing_views_log  / horse_listings
 *   equipment  → equipment_listing_views_log / equipment_listings
 *   forum      → forum_topic_views_log    / forum_topics  (field: views_count)
 *   service    → service_views_log        / services
 *   trainer    → trainer_views_log        / trainers
 */

// Known bot/crawler patterns (case-insensitive).
const BOT_PATTERNS = [
    'bot', 'crawler', 'spider', 'slurp', 'wget', 'curl', 'python-requests',
    'go-http-client', 'java/', 'httpclient', 'okhttp', 'libwww', 'facebookexternalhit',
    'twitterbot', 'linkedinbot', 'whatsapp', 'telegrambot', 'applebot',
    'googlebot', 'bingbot', 'yandexbot', 'baiduspider', 'duckduckbot',
    'sogou', 'exabot', 'ia_archiver', 'semrushbot', 'ahrefsbot', 'mj12bot',
    'dotbot', 'rogerbot', 'pingdom', 'uptimerobot', 'dataprovider',
];

/**
 * Returns true if the given User-Agent string belongs to a known bot/crawler.
 * @param {string|null|undefined} ua
 * @returns {boolean}
 */
function isBot(ua) {
    if (!ua) return false;
    const lower = ua.toLowerCase();
    return BOT_PATTERNS.some(p => lower.includes(p));
}

/**
 * Config per entity type.
 *
 * logTable          – Prisma camelCase model name for the view-log table
 * idField           – column name that holds the entity ID inside the log table
 * mainTable         – SQL table name (public schema) where views_count lives
 * mainIdCol         – primary-key column in the main table (usually "id")
 * mainViewsCol      – column name for the counter (usually "views_count")
 */
const ENTITY_CONFIG = {
    horse: {
        logModel: 'horse_listing_views_log',
        idField: 'listing_id',
        mainTable: 'public.horse_listings',
        mainIdCol: 'id',
        mainViewsCol: 'views_count',
    },
    equipment: {
        logModel: 'equipment_listing_views_log',
        idField: 'listing_id',
        mainTable: 'public.equipment_listings',
        mainIdCol: 'id',
        mainViewsCol: 'views_count',
    },
    forum: {
        logModel: 'forum_topic_views_log',
        idField: 'topic_id',
        mainTable: 'public.forum_topics',
        mainIdCol: 'id',
        mainViewsCol: 'views_count',
    },
    service: {
        logModel: 'service_views_log',
        idField: 'service_id',
        mainTable: 'public.services',
        mainIdCol: 'id',
        mainViewsCol: 'views_count',
    },
    trainer: {
        logModel: 'trainer_views_log',
        idField: 'trainer_id',
        mainTable: 'public.trainers',
        mainIdCol: 'id',
        mainViewsCol: 'views_count',
    },
};

/**
 * Record a view attempt for an entity.
 *
 * This is intentionally fire-and-forget safe – the caller should NOT await it
 * (or wrap in .catch()) so that view tracking never blocks or crashes the main
 * response.
 *
 * @param {object} prisma     – Prisma client instance
 * @param {'horse'|'equipment'|'forum'|'service'|'trainer'} entityType
 * @param {string} entityId   – UUID of the entity being viewed
 * @param {object} opts
 * @param {string|null} opts.userId      – authenticated user ID (null for guests)
 * @param {string}      opts.ip          – raw IP from request (may include port)
 * @param {string|null} opts.userAgent   – User-Agent header value
 */
async function recordView(prisma, entityType, entityId, { userId = null, ip, userAgent = null }) {
    try {
        const cfg = ENTITY_CONFIG[entityType];
        if (!cfg) {
            console.warn(`[viewsService] Unknown entity type: ${entityType}`);
            return;
        }

        // ── 1. Bot filter ──────────────────────────────────────────────────
        if (isBot(userAgent)) return;

        // ── 2. Normalize IP (strip IPv6 prefix, strip port) ────────────────
        let cleanIp = (ip || '127.0.0.1').replace(/^::ffff:/, '');
        // Strip port if present (e.g. "1.2.3.4:56789")
        if (cleanIp.includes(':') && !cleanIp.startsWith('[')) {
            // IPv4 with port
            cleanIp = cleanIp.split(':')[0];
        }
        // Truncate to column limit just in case
        cleanIp = cleanIp.slice(0, 64);

        const truncatedUa = (userAgent || '').slice(0, 512);
        const cutoff = new Date(Date.now() - 24 * 60 * 60 * 1000);

        // ── 3. Check for existing view within 24 h ─────────────────────────
        let existingView;

        if (userId) {
            // Logged-in: deduplicate by user_id (device-agnostic)
            existingView = await prisma.$queryRawUnsafe(
                `SELECT id FROM public.${cfg.logModel}
                 WHERE ${cfg.idField} = $1::uuid
                   AND user_id = $2::uuid
                   AND viewed_at >= $3
                 LIMIT 1`,
                entityId, userId, cutoff
            );
        } else {
            // Guest: deduplicate by ip + user_agent
            existingView = await prisma.$queryRawUnsafe(
                `SELECT id FROM public.${cfg.logModel}
                 WHERE ${cfg.idField} = $1::uuid
                   AND ip = $2
                   AND user_agent = $3
                   AND viewed_at >= $4
                 LIMIT 1`,
                entityId, cleanIp, truncatedUa, cutoff
            );
        }

        if (existingView && existingView.length > 0) {
            // Not unique within 24 h – skip
            return;
        }

        // ── 4. Unique view: insert log row + increment counter ──────────────
        await prisma.$queryRawUnsafe(
            `INSERT INTO public.${cfg.logModel}
             (${cfg.idField}, ip, user_id, user_agent)
             VALUES ($1::uuid, $2, $3, $4)`,
            entityId,
            cleanIp,
            userId || null,
            truncatedUa || null
        );

        await prisma.$queryRawUnsafe(
            `UPDATE ${cfg.mainTable}
             SET ${cfg.mainViewsCol} = COALESCE(${cfg.mainViewsCol}, 0) + 1
             WHERE ${cfg.mainIdCol} = $1::uuid`,
            entityId
        );
    } catch (err) {
        // Never let view tracking crash the request
        console.error('[viewsService] Error recording view:', err.message);
    }
}

module.exports = { recordView, isBot };

'use strict';

const path = require('path');
const fs = require('fs');
const crypto = require('crypto');
const { marked } = require('marked');

/**
 * Blog management routes
 * Reads/writes markdown files to the content/blog directory
 */
module.exports = async function blogRoutes(fastify) {

    // Always save blogs to the backend's internal content/blog folder
    const BLOG_DIR = path.join(process.cwd(), 'content', 'blog');

    const SUPPORTED_LANGS = ['lv', 'lt', 'ee', 'en', 'ru'];

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

    async function requireAdmin(req, reply) {
        await requireAuth(req, reply);
        if (reply.sent) return;
        const user = await fastify.prisma.user.findUnique({
            where: { id: req.user.id },
            include: { user_roles: true }
        });
        const roles = user?.user_roles?.map(r => r.role) || [];
        if (!roles.some(r => ['admin', 'super_admin', 'super_master'].includes(r))) {
            return reply.code(403).send({ error: 'Forbidde' });
        }
    }

    // Helper: slugify a title
    function slugify(str) {
        return str
            .toLowerCase()
            .replace(/[^\w\s-]/g, '')
            .replace(/[\s_-]+/g, '-')
            .replace(/^-+|-+$/g, '')
            .substring(0, 80);
    }

    // Helper: escape frontmatter strings
    function escapeFm(str) {
        return String(str || '').replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, ' ');
    }

    // Helper: convert HTML to Markdown-compatible (for body, we just wrap in raw HTML)
    function buildMarkdownFile({ title, metaTitle, description, date, image, category, language, content, slug, published }) {
        return `---
title: "${escapeFm(title)}"
metaTitle: "${escapeFm(metaTitle || title)}"
date: ${date || new Date().toISOString().split('T')[0]}
description: "${escapeFm(description || '')}"
image: ${image ? `"${escapeFm(image)}"` : ''}
category: ${category ? `"${escapeFm(category)}"` : '""'}
language: ${language}
published: ${published !== false ? 'true' : 'false'}
---

${content || ''}
`;
    }

    // Helper: parse frontmatter from file
    function parseFrontmatter(raw) {
        const match = raw.match(/^---\n([\s\S]*?)\n---\n?([\s\S]*)$/);
        if (!match) return null;
        const fm = {};
        const lines = match[1].split('\n');
        for (const line of lines) {
            const colonIdx = line.indexOf(':');
            if (colonIdx === -1) continue;
            const key = line.substring(0, colonIdx).trim();
            let val = line.substring(colonIdx + 1).trim();
            // parse quoted string
            if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
            // parse array
            if (val.startsWith('[') && val.endsWith(']')) {
                val = val.slice(1, -1).split(',').map(s => s.trim().replace(/^"|"$/g, '').replace(/\\"/g, '"')).filter(Boolean);
            }
            // parse boolean
            if (val === 'true') val = true;
            if (val === 'false') val = false;
            fm[key] = val;
        }
        fm.content = match[2].trim();
        return fm;
    }

    // GET /api/blog - list all posts (for admin)
    fastify.get('/', { preHandler: requireAdmin }, async (req, reply) => {
        try {
            const posts = [];
            for (const lang of SUPPORTED_LANGS) {
                const langDir = path.join(BLOG_DIR, lang);
                if (!fs.existsSync(langDir)) continue;
                const files = fs.readdirSync(langDir).filter(f => f.endsWith('.md'));
                for (const file of files) {
                    const raw = fs.readFileSync(path.join(langDir, file), 'utf-8');
                    const fm = parseFrontmatter(raw);
                    if (fm) {
                        posts.push({
                            id: `${lang}/${file.replace('.md', '')}`,
                            slug: file.replace('.md', ''),
                            language: lang,
                            title: fm.title || '',
                            metaTitle: fm.metaTitle || '',
                            description: fm.description || '',
                            date: fm.date || '',
                            image: fm.image || '',
                            category: fm.category || (fm.tags && fm.tags[0]) || 'News',
                            published: fm.published !== false,
                            preview: (fm.content || '').substring(0, 200),
                        });
                    }
                }
            }
            // sort by date desc
            posts.sort((a, b) => new Date(b.date) - new Date(a.date));
            return { data: posts };
        } catch (e) {
            fastify.log.error(e);
            return reply.code(500).send({ error: 'Failed to list posts', details: e.message });
        }
    });

    // GET /api/blog/public - list all published posts for public frontend
    fastify.get('/public', async (req, reply) => {
        try {
            const posts = [];
            for (const lang of SUPPORTED_LANGS) {
                const langDir = path.join(BLOG_DIR, lang);
                if (!fs.existsSync(langDir)) continue;
                const files = fs.readdirSync(langDir).filter(f => f.endsWith('.md'));
                for (const file of files) {
                    const raw = fs.readFileSync(path.join(langDir, file), 'utf-8');
                    const fm = parseFrontmatter(raw);
                    if (fm && fm.published !== false) {
                        posts.push({
                            id: `${lang}/${file.replace('.md', '')}`,
                            slugAsParams: file.replace('.md', ''),
                            slug: file.replace('.md', ''),
                            language: lang,
                            title: fm.title || '',
                            metaTitle: fm.metaTitle || '',
                            description: fm.description || '',
                            date: fm.date || '',
                            image: fm.image || '',
                            category: fm.category || (fm.tags && fm.tags[0]) || 'News',
                            published: true,
                            preview: (fm.content || '').substring(0, 200),
                            tags: fm.tags || [],
                        });
                    }
                }
            }
            posts.sort((a, b) => new Date(b.date) - new Date(a.date));
            return { data: posts };
        } catch (e) {
            fastify.log.error(e);
            return reply.code(500).send({ error: 'Failed to list public posts', details: e.message });
        }
    });

    // GET /api/blog/public/:lang/:slug - get single public post
    fastify.get('/public/:lang/:slug', async (req, reply) => {
        const { lang, slug } = req.params;
        if (!SUPPORTED_LANGS.includes(lang)) return reply.code(400).send({ error: 'Invalid language' });
        const filePath = path.join(BLOG_DIR, lang, `${slug}.md`);
        if (!fs.existsSync(filePath)) return reply.code(404).send({ error: 'Post not found' });
        try {
            const raw = fs.readFileSync(filePath, 'utf-8');
            const fm = parseFrontmatter(raw);
            if (fm.published === false) return reply.code(404).send({ error: 'Post not found' });
            return {
                slugAsParams: slug,
                slug,
                language: lang,
                title: fm.title || '',
                metaTitle: fm.metaTitle || '',
                description: fm.description || '',
                date: fm.date || '',
                image: fm.image || '',
                category: fm.category || (fm.tags && fm.tags[0]) || 'News',
                content: fm.content ? marked(fm.content) : '',
                published: true,
                tags: fm.tags || [],
            };
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to read post' });
        }
    });

    // GET /api/blog/:lang/:slug - get single post for editing
    fastify.get('/:lang/:slug', { preHandler: requireAdmin }, async (req, reply) => {
        const { lang, slug } = req.params;
        if (!SUPPORTED_LANGS.includes(lang)) return reply.code(400).send({ error: 'Invalid language' });
        const filePath = path.join(BLOG_DIR, lang, `${slug}.md`);
        if (!fs.existsSync(filePath)) return reply.code(404).send({ error: 'Post not found' });
        try {
            const raw = fs.readFileSync(filePath, 'utf-8');
            const fm = parseFrontmatter(raw);
            return {
                slug,
                language: lang,
                ...fm,
                published: fm.published !== false,
            };
        } catch (e) {
            return reply.code(500).send({ error: 'Failed to read post' });
        }
    });

    // POST /api/blog - create new post
    fastify.post('/', { preHandler: requireAdmin }, async (req, reply) => {
        const { title, metaTitle, description, content, language, image, category, date, published, customSlug } = req.body || {};
        if (!title || !language) return reply.code(400).send({ error: 'title and language required' });
        if (!SUPPORTED_LANGS.includes(language)) return reply.code(400).send({ error: 'Invalid language' });

        const slug = customSlug ? slugify(customSlug) : slugify(title) || crypto.randomUUID().substring(0, 8);
        const langDir = path.join(BLOG_DIR, language);
        if (!fs.existsSync(langDir)) fs.mkdirSync(langDir, { recursive: true });

        const filePath = path.join(langDir, `${slug}.md`);
        if (fs.existsSync(filePath)) return reply.code(409).send({ error: 'A post with this slug already exists' });

        const fileContent = buildMarkdownFile({ title, metaTitle, description, date: date || new Date().toISOString().split('T')[0], image, category: category || 'News', language, content, slug, published });
        fs.writeFileSync(filePath, fileContent, 'utf-8');

        return reply.code(201).send({ slug, language, id: `${language}/${slug}` });
    });

    // PUT /api/blog/:lang/:slug - update existing post
    fastify.put('/:lang/:slug', { preHandler: requireAdmin }, async (req, reply) => {
        const { lang, slug } = req.params;
        if (!SUPPORTED_LANGS.includes(lang)) return reply.code(400).send({ error: 'Invalid language' });
        const filePath = path.join(BLOG_DIR, lang, `${slug}.md`);
        if (!fs.existsSync(filePath)) return reply.code(404).send({ error: 'Post not found' });

        const { title, metaTitle, description, content, image, category, date, published, customSlug } = req.body || {};

        let targetSlug = slug;
        let targetFilePath = filePath;

        if (customSlug && customSlug !== slug) {
            targetSlug = slugify(customSlug);
            targetFilePath = path.join(BLOG_DIR, lang, `${targetSlug}.md`);
            if (fs.existsSync(targetFilePath)) {
                return reply.code(409).send({ error: 'A post with this slug already exists' });
            }
        }

        // Read existing to merge
        const raw = fs.readFileSync(filePath, 'utf-8');
        const existing = parseFrontmatter(raw) || {};

        const fileContent = buildMarkdownFile({
            title: title ?? existing.title,
            metaTitle: metaTitle ?? existing.metaTitle,
            description: description ?? existing.description,
            date: date ?? existing.date,
            image: image ?? existing.image,
            category: category ?? existing.category ?? (existing.tags && existing.tags[0]) ?? 'News',
            language: lang,
            content: content !== undefined ? content : existing.content,
            slug: targetSlug,
            published: published !== undefined ? published : existing.published,
        });
        
        fs.writeFileSync(targetFilePath, fileContent, 'utf-8');

        if (targetFilePath !== filePath) {
            fs.unlinkSync(filePath);
        }

        return { slug: targetSlug, language: lang };
    });

    // DELETE /api/blog/:lang/:slug - delete post
    fastify.delete('/:lang/:slug', { preHandler: requireAdmin }, async (req, reply) => {
        const { lang, slug } = req.params;
        if (!SUPPORTED_LANGS.includes(lang)) return reply.code(400).send({ error: 'Invalid language' });
        const filePath = path.join(BLOG_DIR, lang, `${slug}.md`);
        if (!fs.existsSync(filePath)) return reply.code(404).send({ error: 'Post not found' });
        fs.unlinkSync(filePath);
        return reply.code(204).send();
    });
};

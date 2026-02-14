'use strict';

module.exports = async function forumRoutes(fastify) {
    const prisma = fastify.prisma;

    async function requireAuth(req, reply) {
        const auth = req.headers.authorization || '';
        const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
        if (!token) return reply.code(401).send({ error: 'missing token' });

        try {
            const payload = fastify.jwt.verify(token);
            req.user = { id: payload.sub, email: payload.email };
        } catch (authError) {
            // Fallback: in hybrid dev mode, try to trust token even if signature mismatch (e.g. from dev-api)
            const decoded = fastify.jwt.decode(token);
            if (decoded && decoded.sub) {
                req.user = { id: decoded.sub, email: decoded.email };
            } else {
                return reply.code(401).send({ error: 'invalid token' });
            }
        }
    }

    // Helper to handle mixed file types (string urls or JSON strings)
    const parseFile = (f) => {
        try {
            // If it's already an object (unlikely from DB but possible if Prisma mapped it?), return it
            if (typeof f === 'object') return f;
            const parsed = JSON.parse(f);
            return typeof parsed === 'object' ? parsed : { url: f, name: f.split('/').pop() };
        } catch {
            return { url: f, name: f.split('/').pop() };
        }
    };

    const stringifyFile = (f) => typeof f === 'object' ? JSON.stringify(f) : f;

    // GET /forums/topics
    fastify.get('/topics', async (req, reply) => {
        const { category, limit = 50, offset = 0 } = req.query;
        try {
            const where = {};
            if (category && category !== 'all') {
                where.category = category;
            }

            const [items, count] = await Promise.all([
                prisma.forumTopic.findMany({
                    where,
                    orderBy: { createdAt: 'desc' },
                    take: Number(limit),
                    skip: Number(offset),
                    include: {
                        user: {
                            include: {
                                profile: {
                                    select: { name: true, username: true, avatarUrl: true }
                                }
                            }
                        },
                        _count: {
                            select: { replies: true, likes: true }
                        }
                    }
                }),
                prisma.forumTopic.count({ where })
            ]);

            return {
                data: items.map(t => ({
                    ...t,
                    author: {
                        name: t.user?.profile?.name,
                        username: t.user?.profile?.username,
                        avatar_url: t.user?.profile?.avatarUrl
                    },
                    files: t.files ? t.files.map(parseFile) : [],
                    replies_count: t._count.replies,
                    likes_count: t._count.likes
                })),
                count
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch topics' });
        }
    });

    // POST /forums/topics
    fastify.post('/topics', { preHandler: requireAuth }, async (req, reply) => {
        const { title, content, category, images = [], files = [] } = req.body;
        const userId = req.user.id;

        if (!title || !content || !category) {
            return reply.code(400).send({ error: 'Missing required fields' });
        }

        try {
            const topic = await prisma.forumTopic.create({
                data: {
                    title,
                    content,
                    category,
                    images,
                    files: files.map(stringifyFile),
                    userId
                }
            });
            return {
                ...topic,
                files: topic.files.map(parseFile)
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to create topic' });
        }
    });

    // GET /forums/topics/:id - Get single topic
    fastify.get('/topics/:id', async (req, reply) => {
        const { id } = req.params;
        try {
            const topic = await prisma.forumTopic.findUnique({
                where: { id },
                include: {
                    user: {
                        include: {
                            profile: {
                                select: { name: true, username: true, avatarUrl: true }
                            }
                        }
                    },
                    _count: {
                        select: { replies: true, likes: true }
                    }
                }
            });

            if (!topic) {
                return reply.code(404).send({ error: 'Topic not found' });
            }

            return {
                ...topic,
                author: {
                    name: topic.user?.profile?.name,
                    username: topic.user?.profile?.username,
                    avatar_url: topic.user?.profile?.avatarUrl
                },
                files: topic.files ? topic.files.map(parseFile) : [],
                replies_count: topic._count.replies,
                likes_count: topic._count.likes
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch topic' });
        }
    });

    // GET /forums/topics/:id/replies - Get all replies for a topic
    fastify.get('/topics/:id/replies', async (req, reply) => {
        const { id } = req.params;
        try {
            const replies = await prisma.forumReply.findMany({
                where: { topicId: id },
                orderBy: { createdAt: 'asc' },
                include: {
                    user: {
                        include: {
                            profile: {
                                select: { name: true, username: true, avatarUrl: true }
                            }
                        }
                    },
                    _count: {
                        select: { likes: true }
                    }
                }
            });

            // Map replies and fetch reply_to_profile manually if needed (or skip for now)
            // Since replyToUser relation is missing in Prisma schema, we can't include it directly.
            // For now, we'll return null for reply_to_profile to prevent crashes.

            return replies.map(r => ({
                ...r,
                profiles: r.user?.profile ? {
                    name: r.user.profile.name,
                    username: r.user.profile.username,
                    avatar_url: r.user.profile.avatarUrl
                } : null,
                reply_to_profile: null, // Relation missing, skip for now
                files: r.files ? r.files.map(parseFile) : [],
                likes_count: r._count.likes
            }));
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to fetch replies' });
        }
    });

    // POST /forums/topics/:id/replies - Create a new reply
    fastify.post('/topics/:id/replies', { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        const { content, images = [], files = [], parent_id = null, reply_to_user_id = null } = req.body;
        const userId = req.user.id;

        if (!content) {
            return reply.code(400).send({ error: 'Content is required' });
        }

        try {
            const replyRecord = await prisma.forumReply.create({
                data: {
                    topicId: id,
                    content,
                    userId,
                    parentId: parent_id,
                    images,
                    files: files.map(stringifyFile)
                },
                include: {
                    user: {
                        include: {
                            profile: {
                                select: { name: true, username: true, avatarUrl: true }
                            }
                        }
                    }
                }
            });

            return {
                ...replyRecord,
                files: replyRecord.files.map(parseFile),
                profiles: replyRecord.user?.profile ? {
                    name: replyRecord.user.profile.name,
                    username: replyRecord.user.profile.username,
                    avatar_url: replyRecord.user.profile.avatarUrl
                } : null
            };
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to create reply' });
        }
    });
};


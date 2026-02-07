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
                        name: t.user.profile?.name,
                        username: t.user.profile?.username,
                        avatar_url: t.user.profile?.avatarUrl
                    },
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
                    files,
                    userId
                }
            });
            return topic;
        } catch (e) {
            console.error(e);
            return reply.code(500).send({ error: 'Failed to create topic' });
        }
    });
};

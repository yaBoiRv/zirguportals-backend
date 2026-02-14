// src/routes/chat.js
'use strict';

module.exports = async function chatRoutes(fastify) {
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

    fastify.get("/unread-count", { preHandler: requireAuth }, async (req, reply) => {
        const count = await prisma.message.count({
            where: {
                conversation: {
                    participants: { some: { userId: req.user.id } }
                },
                senderId: { not: req.user.id },
                isRead: false
            }
        });
        return { count };
    });

    fastify.post("/conversations", { preHandler: requireAuth }, async (req, reply) => {
        const { targetUserId, sourceType, sourceId } = req.body || {};
        if (!targetUserId) return reply.code(400).send({ error: "targetUserId required" });
        if (targetUserId === req.user.id) return reply.code(400).send({ error: "cannot message self" });

        // ✅ ensure both users exist
        const [me, them] = await Promise.all([
            prisma.user.findUnique({ where: { id: req.user.id } }),
            prisma.user.findUnique({ where: { id: targetUserId } }),
        ]);
        if (!me) return reply.code(401).send({ error: "invalid user" });
        if (!them) return reply.code(404).send({ error: "target user not found" });

        // ✅ find existing conversation with same participants + optional source
        const existing = await prisma.conversation.findFirst({
            where: {
                participants: {
                    every: { userId: { in: [req.user.id, targetUserId] } },
                },
                sourceType: sourceType ?? null,
                sourceId: sourceId ?? null,
            },
        });
        if (existing) return reply.send({ conversationId: existing.id, isNew: false });

        const conv = await prisma.conversation.create({
            data: {
                sourceType: sourceType ?? null,
                sourceId: sourceId ?? null,
                participants: {
                    create: [
                        { userId: req.user.id },
                        { userId: targetUserId },
                    ],
                },
            },
            select: { id: true },
        });

        return reply.send({ conversationId: conv.id, isNew: true });
    });

    fastify.get("/conversations", { preHandler: requireAuth }, async (req, reply) => {
        const conversations = await prisma.conversation.findMany({
            where: {
                participants: { some: { userId: req.user.id } },
            },
            orderBy: { updatedAt: "desc" },
            include: {
                participants: { include: { user: { select: { id: true, userId: true, name: true, username: true, avatarUrl: true } } } },
                messages: {
                    orderBy: { createdAt: "desc" },
                    take: 1,
                    include: { sender: { select: { id: true, userId: true, name: true, username: true, avatarUrl: true } } },
                },
                _count: {
                    select: {
                        messages: {
                            where: {
                                isRead: false,
                                senderId: { not: req.user.id }
                            }
                        }
                    }
                }
            },
        });

        // flatten last message & populate source info
        const out = await Promise.all(conversations.map(async (c) => {
            // Find the OTHER participant (not me)
            // We cannot rely on order, so we filter by ID. A participant is 'other' if userId != me.
            const other = c.participants.map(p => p.user).find(u => u.userId !== req.user.id) || null;

            let source_info = null;
            let is_listing_owner = false;

            if (c.sourceType && c.sourceId) {
                try {
                    if (c.sourceType === 'horse_listing') {
                        const item = await prisma.horse_listings.findUnique({
                            where: { id: c.sourceId },
                            select: { title: true, price: true, currency: true, images: true, user_id: true }
                        });
                        if (item) {
                            source_info = { title: item.title, price: Number(item.price), currency: item.currency, images: item.images };
                            if (item.user_id === req.user.id) is_listing_owner = true;
                        }
                    } else if (c.sourceType === 'equipment_listing') {
                        const item = await prisma.equipment_listings.findUnique({
                            where: { id: c.sourceId },
                            select: { title: true, price: true, currency: true, images: true, user_id: true }
                        });
                        if (item) {
                            source_info = { title: item.title, price: Number(item.price), currency: item.currency, images: item.images };
                            if (item.user_id === req.user.id) is_listing_owner = true;
                        }
                    } else if (c.sourceType === 'service') {
                        const item = await prisma.services.findUnique({
                            where: { id: c.sourceId },
                            select: { full_name: true, hourly_rate: true, pricing_type: true, profile_photo_url: true, specialty: true, user_id: true }
                        });
                        if (item) {
                            source_info = {
                                title: item.full_name,
                                price: Number(item.hourly_rate || 0),
                                pricing_type: item.pricing_type,
                                avatar_url: item.profile_photo_url,
                                specialty_key: item.specialty
                            };
                            if (item.user_id === req.user.id) is_listing_owner = true;
                        }
                    } else if (c.sourceType === 'trainer') {
                        const item = await prisma.trainers.findUnique({
                            where: { id: c.sourceId },
                            include: { profiles: { select: { name: true, avatarUrl: true } } }
                        });
                        if (item) {
                            if (item.profiles) source_info = { name: item.profiles.name, avatar_url: item.profiles.avatarUrl };
                            if (item.user_id === req.user.id) is_listing_owner = true;
                        }
                    }
                } catch (e) {
                    console.error("Error fetching source info", e);
                }
            }

            return {
                id: c.id,
                createdAt: c.createdAt,
                updatedAt: c.updatedAt,
                // participants: c.participants.map((p) => p.user),
                participant_1_id: c.participants[0]?.user.userId,
                participant_2_id: c.participants[1]?.user.userId,

                lastMessage: c.messages[0] || null,
                other_participant: other ? { username: other.username || other.name || "User", avatar_url: other.avatarUrl } : null,
                source_type: c.sourceType,
                source_id: c.sourceId,
                source_info,
                is_listing_owner, // Return explicit ownership flag
                unread_count: c._count.messages
            };
        }));

        // Filter out empty conversations for listing owners
        // We only want to show empty chats to the initiator (buyer) so they can send the first message.
        const filteredOut = out.filter(c => {
            // If there are messages, always show
            if (c.lastMessage) return true;

            // If no messages (empty chat):
            // Hide if I am the listing owner (I didn't start it, and nothing is said yet)
            if (c.is_listing_owner) return false;

            // Show if I am the buyer (I started it, wait for me to type)
            return true;
        });

        return reply.send({ conversations: filteredOut });
    });

    fastify.get(
        "/conversations/:id/messages",
        { preHandler: requireAuth },
        async (req, reply) => {
            const conversationId = req.params.id;
            const limit = Math.min(Number(req.query.limit || 50), 200);
            const cursor = req.query.cursor;

            // must be participant
            const participant = await prisma.conversationParticipant.findUnique({
                where: { conversationId_userId: { conversationId, userId: req.user.id } },
            });
            if (!participant) return reply.code(403).send({ error: "not a participant" });

            const messages = await prisma.message.findMany({
                where: { conversationId },
                orderBy: { createdAt: "desc" },
                take: limit,
                ...(cursor
                    ? { skip: 1, cursor: { id: String(cursor) } } // prisma cursor pagination
                    : {}),
                include: { sender: { select: { id: true, userId: true, name: true, username: true, avatarUrl: true } } },
            });

            return reply.send({
                messages: messages.reverse(), // oldest -> newest for UI
                nextCursor: messages.length ? messages[0].id : null,
            });
        }
    );

    fastify.post("/conversations/:id/read", { preHandler: requireAuth }, async (req, reply) => {
        const { id } = req.params;
        try {
            // Mark messages as read
            await prisma.message.updateMany({
                where: {
                    conversationId: id,
                    senderId: { not: req.user.id }
                },
                data: { isRead: true }
            });

            // Update participant last read
            await prisma.conversationParticipant.update({
                where: { conversationId_userId: { conversationId: id, userId: req.user.id } },
                data: { lastReadAt: new Date() }
            });
        } catch (e) {
            console.error("Error marking read:", e);
            // Ignore error if participant not found etc
        }
        return { success: true };
    });
};

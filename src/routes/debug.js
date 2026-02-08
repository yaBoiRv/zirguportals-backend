const crypto = require('crypto');

module.exports = async function debugRoutes(fastify) {
    const prisma = fastify.prisma;

    fastify.get('/debug-create', async (req, reply) => {
        try {
            // 1. Get a valid user
            const user = await prisma.profile.findFirst();
            if (!user) {
                return reply.code(400).send({ error: 'No user found in database to test with' });
            }

            const logs = [];
            const id = crypto.randomUUID();
            logs.push(`Testing with User ID: ${user.id}`);

            // 2. Attempt Minimal Insert using executeRaw
            // We explicitly cast params to ensure types, just in case.
            // But first, try standard parameterization.
            try {
                logs.push('Attempting Minimal Insert (id, title, content, user_id)...');
                await prisma.$executeRaw`
          INSERT INTO "public"."announcements" ("id", "title", "content", "user_id") 
          VALUES (${id}::uuid, 'Debug Title', 'Debug Content', ${user.userId}::uuid)
        `;
                logs.push('Success: Minimal Insert');

                // Clean up
                await prisma.$executeRaw`DELETE FROM "public"."announcements" WHERE id = ${id}::uuid`;
                logs.push('Cleaned up test record');

            } catch (e) {
                logs.push(`Failed Minimal Insert: ${e.message}`);
                // Return early with logs if minimal fails, as it's the baseline.
                return { success: false, logs, error: e };
            }

            // 3. Attempt Insert with Arrays (images empty)
            // This tests if providing an empty array literal works.
            const id2 = uuidv4();
            try {
                logs.push('Attempting Insert with Empty Array Literal (images)...');
                await prisma.$executeRaw`
          INSERT INTO "public"."announcements" ("id", "title", "content", "user_id", "images") 
          VALUES (${id2}::uuid, 'Debug Array', 'Content', ${user.userId}::uuid, ARRAY[]::text[])
        `;
                logs.push('Success: Array Insert');
                await prisma.$executeRaw`DELETE FROM "public"."announcements" WHERE id = ${id2}::uuid`;
            } catch (e) {
                logs.push(`Failed Array Insert: ${e.message}`);
                // This is expected if 'images' column doesn't exist or syntax is bad.
            }

            return { success: true, logs };

        } catch (err) {
            return reply.code(500).send({ error: err.message, stack: err.stack });
        }
    });
};

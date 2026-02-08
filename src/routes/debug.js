const crypto = require('crypto');

module.exports = async function debugRoutes(fastify) {
    const prisma = fastify.prisma;

    fastify.get('/debug-create', async (req, reply) => {
        try {
            const logs = [];

            // 1. Inspect Triggers
            try {
                logs.push('Inspecting Triggers on "announcements"...');
                const triggers = await prisma.$queryRaw`
          SELECT trigger_name, event_manipulation, action_timing 
          FROM information_schema.triggers 
          WHERE event_object_table = 'announcements'
        `;
                logs.push({ triggers });

                // Also check pg_trigger for internal details if possible
                // This might fail if permissions issues, so catch it.
                try {
                    const pgTriggers = await prisma.$queryRaw`
                SELECT tgname, pg_get_triggerdef(oid) as def
                FROM pg_trigger
                WHERE tgrelid = 'public.announcements'::regclass
             `;
                    logs.push({ pgTriggers });
                } catch (e) {
                    logs.push('Could not query pg_trigger directly: ' + e.message);
                }

            } catch (e) {
                logs.push(`Failed to inspect triggers: ${e.message}`);
            }

            // 2. Inspect Columns (sanity check types)
            try {
                logs.push('Inspecting Columns...');
                const columns = await prisma.$queryRaw`
          SELECT column_name, data_type, is_nullable, column_default
          FROM information_schema.columns 
          WHERE table_name = 'announcements'
        `;
                logs.push({ columns });
            } catch (e) {
                logs.push(`Failed to inspect columns: ${e.message}`);
            }

            // 3a. Save function definition before dropping (for backup)
            try {
                const funcDef = await prisma.$queryRaw`SELECT pg_get_functiondef('notify_new_announcement'::regproc) as def`;
                logs.push({ saved_function_def: funcDef });
            } catch (e) {
                logs.push('Could not save function def: ' + e.message);
            }

            // 3b. Drop the offending trigger
            try {
                logs.push('Dropping broken trigger "trigger_notify_new_announcement"...');
                await prisma.$executeRaw`DROP TRIGGER IF EXISTS trigger_notify_new_announcement ON public.announcements`;
                logs.push('Trigger dropped successfully.');
            } catch (e) {
                logs.push('Failed to drop trigger: ' + e.message);
            }

            // 4. Retry Minimal Insert
            const user = await prisma.profile.findFirst();
            if (user) {
                const id = crypto.randomUUID();
                try {
                    await prisma.$executeRaw`
              INSERT INTO public.announcements (id, title, content, user_id) 
              VALUES (${id}::uuid, 'Debug Title After Drop', 'Debug Content', ${user.userId}::uuid)
            `;
                    logs.push('Minimal Insert Success AFTER DROP!');
                    await prisma.$executeRaw`DELETE FROM public.announcements WHERE id = ${id}::uuid`;
                } catch (e) {
                    logs.push('Minimal Insert Failed after drop: ' + e.message);
                }
            }

            return { success: true, logs };

        } catch (err) {
            return reply.code(500).send({ error: err.message, stack: err.stack });
        }
    });
};

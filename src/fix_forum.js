const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    console.log('Fixing NULLs in forum_topics...');
    try {
        const resCreated = await prisma.$executeRawUnsafe(`UPDATE public.forum_topics SET created_at = NOW() WHERE created_at IS NULL`);
        const resUpdated = await prisma.$executeRawUnsafe(`UPDATE public.forum_topics SET updated_at = NOW() WHERE updated_at IS NULL`);
        console.log(`Updated created_at: ${resCreated}, updated_at: ${resUpdated}`);
    } catch (e) {
        console.error('Error:', e);
    } finally {
        await prisma.$disconnect();
    }
}

main();

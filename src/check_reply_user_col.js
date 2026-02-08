const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function checkColumn() {
    try {
        const result = await prisma.$queryRaw`
            SELECT column_name, data_type 
            FROM information_schema.columns 
            WHERE table_name = 'forum_replies' AND column_name = 'reply_to_user_id';
        `;
        console.log('Column check:', JSON.stringify(result, null, 2));
    } catch (e) {
        console.error('Error:', e);
    } finally {
        await prisma.$disconnect();
    }
}

checkColumn();

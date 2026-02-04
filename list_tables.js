const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function listTables() {
    try {
        const result = await prisma.$queryRaw`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            ORDER BY table_name;
        `;
        console.log("--- Tables in 'public' schema ---");
        result.forEach(row => console.log(row.table_name));
        console.log("---------------------------------");
    } catch (e) {
        console.error("Error fetching tables:", e);
    } finally {
        await prisma.$disconnect();
    }
}

listTables();

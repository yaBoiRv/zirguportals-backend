const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const path = require('path');

const prisma = new PrismaClient();

async function importSpecialties() {
    try {
        console.log('Importing specialties...');

        const sql = fs.readFileSync(path.join(__dirname, 'insert_specialties.sql'), 'utf8');

        // Split by semicolon and execute each statement
        const statements = sql
            .split(';')
            .map(s => s.trim())
            .filter(s => s.length > 0 && !s.startsWith('--'));

        for (const statement of statements) {
            if (statement.trim()) {
                console.log('Executing:', statement.substring(0, 50) + '...');
                await prisma.$executeRawUnsafe(statement);
            }
        }

        console.log('✅ Specialties imported successfully!');

        // Verify the data
        const serviceCount = await prisma.$queryRaw`SELECT COUNT(*) FROM service_specialties`;
        const trainerCount = await prisma.$queryRaw`SELECT COUNT(*) FROM trainer_specialties`;

        console.log(`Service specialties: ${serviceCount[0].count}`);
        console.log(`Trainer specialties: ${trainerCount[0].count}`);

    } catch (error) {
        console.error('Error importing specialties:', error);
    } finally {
        await prisma.$disconnect();
    }
}

importSpecialties();

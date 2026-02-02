const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function testQuery() {
    try {
        console.log('Testing service_specialties query...');
        const rows = await prisma.$queryRawUnsafe(
            `SELECT b.id, b.specialty_key as key, t.name
       FROM public.service_specialties b
       LEFT JOIN public.service_specialty_translations t
         ON t.specialty_id = b.id AND t.lang_code = $1
       ORDER BY COALESCE(t.name, b.specialty_key) ASC`,
            'en'
        );
        console.log('Service specialties result:', rows);

        console.log('\nTesting trainer_specialties query...');
        const rows2 = await prisma.$queryRawUnsafe(
            `SELECT b.id, b.key, t.name
       FROM public.trainer_specialties b
       LEFT JOIN public.trainer_specialty_translations t
         ON t.specialty_id = b.id AND t.lang_code = $1
       ORDER BY COALESCE(t.name, b.key) ASC`,
            'en'
        );
        console.log('Trainer specialties result:', rows2);

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await prisma.$disconnect();
    }
}

testQuery();

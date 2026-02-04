const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function check() {
    try {
        const horses = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.horse_listings');
        const equipment = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.equipment_listings');
        const visibleHorses = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.horse_listings WHERE visible = true');
        const visibleEquipment = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.equipment_listings WHERE visible = true');

        console.log('--- DATABASE STATS ---');
        console.log('Horses:', horses);
        console.log('Visible Horses:', visibleHorses);
        console.log('Equipment:', equipment);
        console.log('Visible Equipment:', visibleEquipment);
        console.log('----------------------');
    } catch (err) {
        console.error('Error checking DB:', err.message);
    } finally {
        await prisma.$disconnect();
    }
}

check();

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    console.log('Seeding dictionaries...');

    // --- Horse Sex ---
    const horseSexes = [
        { key: 'mare', name_en: 'Mare', name_lv: 'Ķēve', name_ru: 'Кобыла' },
        { key: 'stallion', name_en: 'Stallion', name_lv: 'Ērzelis', name_ru: 'Жеребец' },
        { key: 'gelding', name_en: 'Gelding', name_lv: 'Kastrāts', name_ru: 'Мерин' },
    ];

    for (const item of horseSexes) {
        const record = await prisma.horseSex.upsert({
            where: { key: item.key },
            update: {},
            create: { key: item.key },
        });

        await prisma.horseSexTranslation.createMany({
            data: [
                { sexId: record.id, langCode: 'en', name: item.name_en },
                { sexId: record.id, langCode: 'lv', name: item.name_lv },
                { sexId: record.id, langCode: 'ru', name: item.name_ru },
            ],
            skipDuplicates: true,
        });
    }

    // --- Forum Categories ---
    const forumCats = [
        { key: 'general', icon: '💬', name_en: 'General Discussion', name_lv: 'Vispārīga diskusija' },
        { key: 'health', icon: '🏥', name_en: 'Health & Vet', name_lv: 'Veselība un veterinārija' },
        { key: 'competitions', icon: '🏆', name_en: 'Competitions', name_lv: 'Sacensības' },
        { key: 'marketplace', icon: '🛒', name_en: 'Marketplace', name_lv: 'Tirgus' },
    ];

    for (const item of forumCats) {
        const record = await prisma.forumCategory.upsert({
            where: { key: item.key },
            update: { icon: item.icon },
            create: { key: item.key, icon: item.icon },
        });

        await prisma.forumCategoryTranslation.createMany({
            data: [
                { categoryId: record.id, langCode: 'en', name: item.name_en },
                { categoryId: record.id, langCode: 'lv', name: item.name_lv },
            ],
            skipDuplicates: true,
        });
    }

    // --- Service Specialties ---
    const serviceSpecs = [
        { key: 'transport', name_en: 'Transportation', name_lv: 'Transportēšana' },
        { key: 'stable', name_en: 'Stabling', name_lv: 'Staļļa īre' },
        { key: 'training', name_en: 'Training', name_lv: 'Trenēšana' },
        { key: 'shoeing', name_en: 'Farrier', name_lv: 'Kalšana' },
        { key: 'vet', name_en: 'Veterinarian', name_lv: 'Veterinārs' },
        { key: 'photography', name_en: 'Photography', name_lv: 'Fotogrāfija' },
    ];

    for (const item of serviceSpecs) {
        const record = await prisma.serviceSpecialty.upsert({
            where: { key: item.key },
            update: {},
            create: { key: item.key },
        });

        await prisma.serviceSpecialtyTranslation.createMany({
            data: [
                { specialtyId: record.id, langCode: 'en', name: item.name_en },
                { specialtyId: record.id, langCode: 'lv', name: item.name_lv },
            ],
            skipDuplicates: true,
        });
    }

    // --- Trainer Specialties ---
    const trainerSpecs = [
        { key: 'jumping', name_en: 'Show Jumping', name_lv: 'Konkūrs' },
        { key: 'dressage', name_en: 'Dressage', name_lv: 'Iejāde' },
        { key: 'eventing', name_en: 'Eventing', name_lv: 'Trīscīņa' },
        { key: 'western', name_en: 'Western', name_lv: 'Western' },
    ];

    for (const item of trainerSpecs) {
        const record = await prisma.trainerSpecialty.upsert({
            where: { key: item.key },
            update: {},
            create: { key: item.key },
        });

        await prisma.trainerSpecialtyTranslation.createMany({
            data: [
                { specialtyId: record.id, langCode: 'en', name: item.name_en },
                { specialtyId: record.id, langCode: 'lv', name: item.name_lv },
            ],
            skipDuplicates: true,
        });
    }

    // --- Trainer Languages ---
    const languages = [
        { key: 'en', name: 'English' },
        { key: 'lv', name: 'Latvian' },
        { key: 'ru', name: 'Russian' },
    ];

    for (const item of languages) {
        await prisma.trainerLanguage.upsert({
            where: { key: item.key },
            update: { name: item.name },
            create: { key: item.key, name: item.name },
        });
    }

    // --- Equipment Brands ---
    const brands = ['Prestige', 'Stubben', 'Kieffer', 'Passier', 'Wintec', 'Bates', 'Fairfax', 'Kent & Masters', 'Albion', 'Devoucoux', 'CWD', 'Antares', 'Butet', 'Equipe', 'Amerigo', 'Sommer', 'Harry Dabbs', 'Black Country', 'Frank Baines', 'Ideal', 'Barnsby', 'Jeffries', 'GFS', 'Pessoa', 'Eurohunters', 'Tekna', 'Status', 'Saddlecraft'];
    for (const brand of brands) {
        const key = brand.toLowerCase().replace(/[^a-z0-9]/g, '-');
        await prisma.equipmentBrand.upsert({
            where: { key },
            update: { name: brand },
            create: { key, name: brand },
        });
    }

    // --- Equipment Colors ---
    const eqColors = [
        { key: 'black', hex: '#000000', name_en: 'Black', name_lv: 'Melns' },
        { key: 'brown', hex: '#5b3a29', name_en: 'Brown', name_lv: 'Brūns' },
        { key: 'tobacco', hex: '#6d4c41', name_en: 'Tobacco', name_lv: 'Tabaka' },
        { key: 'cognac', hex: '#8d6e63', name_en: 'Cognac', name_lv: 'Konjaks' },
        { key: 'london', hex: '#a1887f', name_en: 'London', name_lv: 'Londona' },
    ];
    for (const item of eqColors) {
        const record = await prisma.equipmentColor.upsert({
            where: { key: item.key },
            update: { hex: item.hex },
            create: { key: item.key, hex: item.hex },
        });

        await prisma.equipmentColorTranslation.createMany({
            data: [
                { colorId: record.id, langCode: 'en', name: item.name_en },
                { colorId: record.id, langCode: 'lv', name: item.name_lv },
            ],
            skipDuplicates: true,
        });
    }

    console.log('Seeding completed.');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });

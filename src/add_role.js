const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function addRoleColumn() {
    try {
        console.log('Adding role column...');
        await prisma.$executeRawUnsafe(`ALTER TABLE auth.users ADD COLUMN IF NOT EXISTS role TEXT DEFAULT 'user';`);
        console.log('Column added.');

        console.log('Updating user role...');
        const updated = await prisma.$executeRawUnsafe(`UPDATE auth.users SET role = 'super_admin' WHERE email = 'raimunds.vanags@gmail.com';`);
        console.log('User role updated:', updated);

    } catch (e) {
        console.error('Error:', e);
    } finally {
        await prisma.$disconnect();
    }
}

addRoleColumn();

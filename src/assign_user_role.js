const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function assignRole() {
    const email = 'raimunds.vanags@gmail.com';
    const role = 'super_admin'; // matching enum value in app_role

    console.log(`Looking up user ${email}...`);
    // Schema shows email is not unique (likely due to instance_id), so use findFirst
    const user = await prisma.user.findFirst({ where: { email } });

    if (!user) {
        console.log('User not found!');
        return;
    }
    console.log('User found:', user.id);

    console.log(`Checking if role ${role} exists...`);
    // model user_roles
    const existing = await prisma.user_roles.findFirst({
        where: {
            user_id: user.id,
            role: role
        }
    });

    if (existing) {
        console.log('Role already assigned:', existing);
    } else {
        console.log('Assigning role...');
        const result = await prisma.user_roles.create({
            data: {
                user_id: user.id,
                role: role
            }
        });
        console.log('Role assigned!', result);
    }
}

assignRole()
    .catch((e) => {
        console.error('Error:', e);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });

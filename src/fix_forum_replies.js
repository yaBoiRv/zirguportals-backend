const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('Fixing NULLs in forum_replies...');

  try {
    const resCreated = await prisma.$executeRawUnsafe(`
      UPDATE public.forum_replies
      SET created_at = NOW()
      WHERE created_at IS NULL
    `);

    const resUpdated = await prisma.$executeRawUnsafe(`
      UPDATE public.forum_replies
      SET updated_at = NOW()
      WHERE updated_at IS NULL
    `);

    // Optional but recommended if you ever inserted NULL arrays:
    const resImages = await prisma.$executeRawUnsafe(`
      UPDATE public.forum_replies
      SET images = '{}'::text[]
      WHERE images IS NULL
    `);

    const resFiles = await prisma.$executeRawUnsafe(`
      UPDATE public.forum_replies
      SET files = '{}'::text[]
      WHERE files IS NULL
    `);

    console.log({ resCreated, resUpdated, resImages, resFiles });
  } catch (e) {
    console.error('Error:', e);
  } finally {
    await prisma.$disconnect();
  }
}

main();

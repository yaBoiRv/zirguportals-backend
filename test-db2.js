require('dotenv').config();
const { PrismaClient } = require('@prisma/client');
const p = new PrismaClient();

async function main() {
  const cols = await p.$queryRawUnsafe(
    `SELECT column_name FROM information_schema.columns WHERE table_name = 'horse_listings' AND table_schema = 'public'`
  );
  console.log('horse_listings columns:', cols.map(c => c.column_name).join(', '));
}

main().finally(() => p.$disconnect());

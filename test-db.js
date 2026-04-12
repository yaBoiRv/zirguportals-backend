const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
async function main() {
  const data = await prisma.$queryRawUnsafe("SELECT column_name FROM information_schema.columns WHERE table_name = 'equipment_listings'");
  console.log("COLUMNS:", data.map(d => d.column_name).join(', '));
  
  const listing = await prisma.$queryRawUnsafe("SELECT * FROM equipment_listings WHERE id = 'b928b408-ed12-4a61-9533-f60925ee25b2'");
  console.log("LISTING:", listing);
}
main().finally(() => prisma.$disconnect());

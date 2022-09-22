import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient({
    log:['error', 'info' ,'query', 'warn']
})

async function main() {
  const user = await prisma.user.create({
    data: {
      userName: 'Alice',
      email: 'alice@prisma.io',
    },
  })
  console.log(user)
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })
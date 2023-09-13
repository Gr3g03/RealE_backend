import { faker } from '@faker-js/faker/locale/en';
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient({
  log: ['error', 'info', 'query', 'warn']
})

async function main() {

  for(let i = 0 ; i <=3 ; i++){

  const apartment = await prisma.apartment.create({
    data: {
      bathrooms: faker.number.int(5),
      kitchens: faker.number.int(5),
      bedrooms: faker.number.int(1),
      sqm: faker.number.int(5),
      location: faker.location.city(),
      email: faker.internet.email(),
      phone: faker.phone.number(),
      price: faker.number.int(5),
      image: faker.image.urlPicsumPhotos(),
      cityName  : faker.location.city(),
      title     : faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      userId: 1,
    }
  })

  // const city = await prisma.city.create({
  //   data: {
  //     name :faker.internet.userName(),
  //   }
  // })


  // const res =await prisma.apartmentInCity.create({
  //   data:{
  //     apartmentId: 1,
  //     cityId     : 1,
  //     total      : 0,
  //   }
  // })
}

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
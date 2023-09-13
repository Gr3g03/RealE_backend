import { PrismaClient } from '@prisma/client'
import bodyParser from 'body-parser'
import cors from 'cors'
import express from 'express'
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import 'dotenv/config';
const prisma = new PrismaClient({
    log:['error', 'info' ,'query', 'warn']
})


const app = express()
app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:false}))
app.use(express.json())
app.use(express.static('public'))

//  async function getTotalApartmentsInAllCities() {
//   const cities = await prisma.city.findMany({
//     include: {
//       apartmentInCity: {
//         select: {
//           apartmentId: true
//         }
//       }
//     }
//   });

//   let totalApartments = 0;

//   for (const city of cities) {
//     totalApartments += city.apartmentInCity.length;
//   }

//   console.log(`Total apartments in all cities: ${totalApartments}`);
//   return totalApartments;
// }

// getTotalApartmentsInAllCities();   
const path =  'http://localhost:4000'
const port = 4000
app.get('/', async(req, res)=>{
    res.send(`server up and running : ${[path]}`)
})

const createToken = (id:number) => {
//@ts-ignore
const token = jwt.sign({id: id}, process.env.MY_SECRET , {
    expiresIn: '3days'
});
return token
}

const getUserFromToken = async (token: string) => {
//@ts-ignore
    const data = jwt.verify(token, process.env.MY_SECRET)
    const user = await prisma.user.findUnique({
        where: ({id :data.id})
    })
    return user
}

app.get('/validate', async (req, res) => {
const token = String(req.query.token)
try{
    const user = await getUserFromToken(token)
    res.send(user) 
}
catch(error){
    //@ts-ignore
res.status(400).send({error: error.message})
}
})

app.get('/user', async (req, res) => {
    try{
        const user = await prisma.user.findMany()
        res.send(user)
    }
    catch(error){
        //@ts-ignore
            res.status(400).send({error: error.message})
    }
})

app.post('/register' ,async (req, res) => {
    const { email, password, userName, firstName, lastName, address,  phone, avatar } = req.body;    
    try{
        const hash = bcrypt.hashSync(password)
        const user = await prisma.user.create({
            data:{
                email: email,
                password: hash,
                userName: userName,
                firstName: firstName,
                lastName: lastName,
                address: address,
                phone: phone,
                avatar: avatar,
            }
        })
        res.send({user , token: createToken(user.id)})
    }
    catch(error){
    //@ts-ignore
    res.status(400).send({error: error.message})
    }
})

app.post('/login' , async (req, res) =>{
    const {email , password} = req.body
    try{
const user = await prisma.user.findFirst({
    where: {email: email}
})
if(user){
    const passMatch = bcrypt.compareSync(password, user.password)
     if (user && passMatch){
        res.send({user, token: createToken(user.id)})
     }
}
else{
    throw new Error("user not found");
}
    }
    catch(error){
        //@ts-ignore
    res.status(400).send({error: error.message})
    }
})

app.get('/apartaments', async (req, res) => {
    try{
        const apartment = await prisma.apartment.findMany()
        res.send(apartment)
    }
    catch(error){
        //@ts-ignore
            res.status(400).send({error: error.message})
    }
})

app.post('/apartament', async (req ,res)=> {
const {
    bathrooms,
    kitchens,
    bedrooms,
    sqm,
    email, 
    phone, 
    price,
    location,
    image,
    userId,
    cityName ,
    title ,
    description,
} = req.body

try{
    const resp = await prisma.apartment.create({
        data:{
            bathrooms : bathrooms,
            kitchens :kitchens,
            bedrooms : bedrooms,
            sqm :sqm,
            email: email, 
            phone:phone, 
            price: price,
            location: location,
            image:image,
            userId: userId,
            cityName: cityName ,
            title : title ,
            description:description,
        }
    })
    res.status(200).send(resp)

}catch(error){
    //@ts-ignore
    res.status(400).send({error: error.message})
}

})
app.post('/apartament/:id' , async(req, res)=> {
    const {id} = req.params
    try{
        const apartament =  await prisma.apartment.findUnique({
            where : {
                id : Number(id) 
            }
        })
        res.send(apartament)
    }catch(error){
        //@ts-ignore 
        res.status(400).send({error: error.message})
    }
})

app.listen(port, ()=>{
    console.log(path)
})
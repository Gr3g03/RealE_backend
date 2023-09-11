-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL DEFAULT '',
    "firstName" TEXT NOT NULL DEFAULT '',
    "lastName" TEXT NOT NULL DEFAULT '',
    "address" TEXT NOT NULL DEFAULT '',
    "phone" TEXT NOT NULL DEFAULT '',
    "avatar" TEXT NOT NULL DEFAULT ''
);

-- CreateTable
CREATE TABLE "Apartment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bathrooms" INTEGER NOT NULL,
    "kitchens" INTEGER NOT NULL,
    "bedrooms" INTEGER NOT NULL,
    "sqm" INTEGER NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "location" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Apartment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userName_key" ON "User"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Apartment_email_key" ON "Apartment"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Apartment_phone_key" ON "Apartment"("phone");

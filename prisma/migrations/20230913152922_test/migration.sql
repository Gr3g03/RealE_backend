/*
  Warnings:

  - Added the required column `cityId` to the `Apartment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cityName` to the `Apartment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Apartment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `Apartment` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "ApartmentInCity" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "apartmentId" INTEGER NOT NULL,
    "cityId" INTEGER NOT NULL,
    "total" INTEGER NOT NULL,
    CONSTRAINT "ApartmentInCity_apartmentId_fkey" FOREIGN KEY ("apartmentId") REFERENCES "Apartment" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ApartmentInCity_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "City" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Apartment" (
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
    "cityName" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "cityId" INTEGER NOT NULL,
    CONSTRAINT "Apartment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Apartment_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Apartment" ("bathrooms", "bedrooms", "email", "id", "image", "kitchens", "location", "phone", "price", "sqm", "userId") SELECT "bathrooms", "bedrooms", "email", "id", "image", "kitchens", "location", "phone", "price", "sqm", "userId" FROM "Apartment";
DROP TABLE "Apartment";
ALTER TABLE "new_Apartment" RENAME TO "Apartment";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

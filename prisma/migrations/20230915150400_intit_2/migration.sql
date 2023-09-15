/*
  Warnings:

  - You are about to drop the column `total` on the `ApartmentInCity` table. All the data in the column will be lost.
  - Added the required column `image` to the `City` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_City" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL
);
INSERT INTO "new_City" ("id", "name") SELECT "id", "name" FROM "City";
DROP TABLE "City";
ALTER TABLE "new_City" RENAME TO "City";
CREATE TABLE "new_ApartmentInCity" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "apartmentId" INTEGER NOT NULL,
    "cityId" INTEGER NOT NULL,
    CONSTRAINT "ApartmentInCity_apartmentId_fkey" FOREIGN KEY ("apartmentId") REFERENCES "Apartment" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ApartmentInCity_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ApartmentInCity" ("apartmentId", "cityId", "id") SELECT "apartmentId", "cityId", "id" FROM "ApartmentInCity";
DROP TABLE "ApartmentInCity";
ALTER TABLE "new_ApartmentInCity" RENAME TO "ApartmentInCity";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

/*
  Warnings:

  - You are about to drop the column `email` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the column `password_hash` on the `usuarios` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "usuarios_email_key";

-- AlterTable
ALTER TABLE "usuarios" DROP COLUMN "email",
DROP COLUMN "password_hash";

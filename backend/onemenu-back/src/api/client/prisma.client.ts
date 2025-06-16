// Provide the prisma client to api services
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
export default prisma;
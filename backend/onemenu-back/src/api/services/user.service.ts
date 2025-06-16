import prisma from "../client/prisma.client";
import { user } from "@prisma/client";

export class UserService {
  // Get all
  async getAll(): Promise<user[]> {
    return await prisma.user.findMany();
  }

  // Get by ID
  async getByID(id: string): Promise<user | null> {
    return await prisma.user.findUnique({
      where: { userID: id },
    });
  }

  // Get by email (unique)
  async getByEmail(email: string): Promise<user | null> {
    return await prisma.user.findUnique({
      where: { email },
    });
  }

  // Create
  async create(data: user): Promise<user> {
    return await prisma.user.create({ data });
  }

  // Update
  async update(id: string, data: user): Promise<user | null> {
    return await prisma.user.update({
      where: { userID: id },
      data,
    });
  }

  // Delete
  async delete(id: string): Promise<user> {
    return await prisma.user.delete({
      where: { userID: id },
    });
  }
}
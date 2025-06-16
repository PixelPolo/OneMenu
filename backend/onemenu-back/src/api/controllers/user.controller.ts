import { user } from "../../generated/prisma";
import { UserService } from "../services/user.service";
import { Request, Response } from "express";

export class UserController {
  private userService: UserService;

  constructor() {
    this.userService = new UserService();
  }

  // GET /user
  async getAllUsers(_req: Request, res: Response): Promise<any> {
    try {
      const users: user[] = await this.userService.getAll();
      console.log(users);
      res.status(200).json(users);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // GET /user/:id
  async getUserByID(req: Request, res: Response): Promise<any> {
    try {
      const user: user | null = await this.userService.getByID(req.params.id);
      console.log(user);
      res.status(200).json(user);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // GET /user/:name
  async getUserByName(req: Request, res: Response): Promise<any> {
    try {
      const user: user | null = await this.userService.getByName(
        req.params.name
      );
      console.log(user);
      res.status(200).json(user);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // GET /user/:email
  async getUserByEmail(req: Request, res: Response): Promise<any> {
    try {
      const user: user | null = await this.userService.getByEmail(
        req.params.email
      );
      console.log(user);
      res.status(200).json(user);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // POST /user
  async createUser(req: Request, res: Response): Promise<any> {
    try {
      const newUser: user = await this.userService.create(req.body);
      console.log(newUser);
      res.status(201).json(newUser);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // PATCH /user
  async updateUser(req: Request, res: Response): Promise<any> {
    try {
      const updatedUser: user | null = await this.userService.update(
        req.params.id,
        req.body
      );
      console.log(updatedUser);
      res.status(200).json(updatedUser);
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }

  // DELETE /user/:id
  async deleteUser(req: Request, res: Response): Promise<any> {
    try {
      await this.userService.delete(req.params.id);
      res.status(204).send();
    } catch (error: unknown) {
      console.error(error);
      res.status(400).json({ error: (error as Error).message });
    }
  }
}
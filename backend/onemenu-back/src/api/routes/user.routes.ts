import { Router } from "express";
import { UserController } from "../controllers/user.controller";

const router = Router();
const controller = new UserController();

router.get("/", (req, res) => controller.getAllUsers(req, res));
router.get("/:id", (req, res) => controller.getUserByID(req, res));
router.get("/email/:email", (req, res) => controller.getUserByEmail(req, res));
router.post("/", (req, res) => controller.createUser(req, res));
router.put("/:id", (req, res) => controller.updateUser(req, res));
router.delete("/:id", (req, res) => controller.deleteUser(req, res));

export default router;
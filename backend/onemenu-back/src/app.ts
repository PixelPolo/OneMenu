import dotenv from "dotenv";
import express from "express";
import cookieParser from "cookie-parser";
import { Request, Response } from "express";
import corsMiddleware from "./middlewares/cors.middleware";
import { checkJwt } from "./middlewares/checkjwt.middleware";
import userRoutes from "./api/routes/user.routes";

// Express app
const app = express();

// Environment vars
dotenv.config();
const port = process.env.PORT || 8080;

// Middleware to parse JSON
app.use(express.json());

// Middleware for CORS
app.use(corsMiddleware);

// Secure all routes with Auth0
app.use(checkJwt)

// CookieParser for JWT
app.use(cookieParser());

// Hello World
app.get("/", (req: Request, res: Response) => {
  res.send("Hello World!");
});

// Routes
app.use("/user", userRoutes)

// Export the app for test suite
export default app;

// Start only if this file is executed
if (require.main === module) {
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
    console.log(process.env.PORT);
  });
}

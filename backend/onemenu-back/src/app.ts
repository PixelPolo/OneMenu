import express from "express";
import { Request, Response } from "express";
import corsMiddleware from "./middlewares/cors.middleware";
import cookieParser from "cookie-parser";

const app = express();
const port = process.env.PORT || 8080;

// Middleware to parse JSON
app.use(express.json());

// Middleware for CORS
app.use(corsMiddleware);

// CookieParser for JWT
app.use(cookieParser());

// Hello World
app.get("/", (req: Request, res: Response) => {
  res.send("Hello World!");
});

// Routes
// TODO

// Export the app for test suite
export default app;

// Start only if this file is executed
if (require.main === module) {
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });
}
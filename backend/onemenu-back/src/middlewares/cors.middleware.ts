// https://www.npmjs.com/package/cors#configuring-cors
import cors from "cors";

const localhost = "http://localhost:8080";
const whitelist: string[] = [localhost];

const corsOptions = {
  origin: (
    origin: string | undefined,
    callback: (error: Error | null, allow?: boolean) => void
  ) => {
    console.log("CORS request from:", origin);
    if (origin == undefined) callback(null, true); // Dev only
    else if (origin && whitelist.includes(origin)) callback(null, true);
    else callback(new Error("Not allowed by CORS"));
  },
  credentials: true,
};

export default cors(corsOptions);

import { auth } from "express-oauth2-jwt-bearer";

// https://auth0.com/docs/quickstart/backend/nodejs/interactive
// https://medium.com/@kulkarniaditya1997/securing-your-nodejs-server-with-auth0-b5a4b73d99c4
export const checkJwt = auth({
  audience: process.env.AUDIENCE,
  issuerBaseURL: process.env.ISSUER_BASE_URL,
});
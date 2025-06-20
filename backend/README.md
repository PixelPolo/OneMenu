# Backend

## Project creation

```bash
npm init # entry point: app.ts
npm i express
npm i --save-dev @types/express
npm i --save-dev typescript
npm i --save-dev ts-node-dev @types/node
npm i --save-dev rimraf
npx tsc --init
```

```json
// tsconfig.json
{
  "compilerOptions": {
    "rootDir": "./src",
    "outDir": "./dist"
  }
}
```

```json
// package.json
"scripts": {
    "dev": "ts-node-dev --respawn --transpile-only src/app.ts",
    "build": "rimraf dist && tsc",
    "start": "node dist/app.js"
}
```

## Build and Run

### Local development (with live reload)

```bash
npm run dev
```

### Build and Run compiled app

```bash
npm run build
npm start
```

## Docker

### Build the image and run the container

```bash
# Build only with DATABASE_URL (used by Prisma)
docker build \
  --build-arg DATABASE_URL="$DATABASE_URL" \
  -t onemenu-back .

# Run with all env vars passed (used by Prisma and Auth0 jwt)
docker run --rm --name onemenu-back-container -p 8080:8080 \
  -e DATABASE_URL="$DATABASE_URL" \
  -e AUDIENCE="$AUDIENCE" \
  -e ISSUER_BASE_URL="$ISSUER_BASE_URL" \
  onemenu-back

# Delete the container (optional)
docker rm -f onemenu-back-container
```

### Dockerfile

```Dockerfile
# ---------- STAGE 1: Build the TypeScript app ----------
# Use Node.js ... LTS
FROM node:20 AS builder

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the full source code
COPY . .

# To run in local, pass the args in docker run...
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

# Generate the Prisma client
RUN npx prisma generate

# Build the TypeScript code
RUN npm run build

# ---------- STAGE 2: Run the built app in production ----------
FROM node:20

# Set the working directory
WORKDIR /app

# Copy the compiled code and minimal required files from the builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# To run in local, pass the args in docker run...
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

# Generate the Prisma client
RUN npx prisma generate

# Set the port environment variable (required by Render)
ENV PORT=8080

# Expose the application port
EXPOSE 8080

# Start the compiled app
CMD ["node", "dist/app.js"]
```

## Prisma ORM

<https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project/relational-databases-typescript-postgresql>

```bash
npm install prisma --save-dev
npx prisma init # generate `prisma/schema.prisma` and `.env`
npx prisma db pull # database introspection
npx prisma migrate diff --from-empty --to-schema-datamodel prisma/schema.prisma --script > prisma/migrations/0_init/migration.sql
npx prisma migrate resolve --applied 0_init

npm install @prisma/client
npx prisma generate # todo after each db modif
```

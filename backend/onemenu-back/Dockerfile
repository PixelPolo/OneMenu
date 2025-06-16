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

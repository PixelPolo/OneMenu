# ---------- STAGE 1: Build the Angular app ----------
# Use Node.js LTS version
FROM node:20 AS builder

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./

# Install Angular dependencies
RUN npm install

# Copy the full source code
COPY . .

# Build the Angular app in production mode
RUN npm run build --prod

# ---------- STAGE 2: Serve the built app with Nginx ----------
# Use a minimal Nginx image to serve static files
FROM nginx:alpine

# Copy the built Angular app from the builder stage
COPY --from=builder /app/dist/onemenu-front/browser /usr/share/nginx/html

# Copy the nginx.config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port for Angular app
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
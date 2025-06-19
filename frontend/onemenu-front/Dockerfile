# ---------- STAGE 1: Build the Angular app ----------
FROM node:20 AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy full source code
COPY . .

# Build Angular app in production mode
RUN npm run build --prod

# ---------- STAGE 2: Serve the built app with NGINX ----------
FROM nginx:alpine

# Copy Angular build to NGINX HTML folder
COPY --from=builder /app/dist/onemenu-front/browser /usr/share/nginx/html

# Copy NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy env.template.js and entrypoint script
COPY public/env.template.js /usr/share/nginx/html/public/env.template.js
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose HTTP port
EXPOSE 80

# Inject env vars and run NGINX
ENTRYPOINT ["/entrypoint.sh"]

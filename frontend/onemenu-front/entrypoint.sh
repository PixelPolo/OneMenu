#!/bin/sh

# Replace placeholders with actual environment variable values
# Generate env.js from env.template.js using envsubst
envsubst < /usr/share/nginx/html/public/env.template.js > /usr/share/nginx/html/public/env.js

# Start NGINX
nginx -g 'daemon off;'

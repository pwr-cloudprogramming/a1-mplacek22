#!/bin/sh

# Substitute the PUBLIC_IP in index.js
envsubst '${PUBLIC_IP}' < /usr/share/nginx/html/index.js > /usr/share/nginx/html/index.js.tmp
mv /usr/share/nginx/html/index.js.tmp /usr/share/nginx/html/index.js

# Start nginx
exec nginx -g 'daemon off;'

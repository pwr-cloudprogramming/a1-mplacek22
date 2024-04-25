# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Install gettext for envsubst
RUN apk add --no-cache gettext

# Remove the default Nginx configuration and static files
RUN rm /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/*

# Copy the static content from the 'src' directory into the container
COPY src/* /usr/share/nginx/html/

# Create a custom Nginx configuration file directly in the Dockerfile
RUN echo 'server { listen 3000; server_name localhost; location / { root /usr/share/nginx/html; index index.html; try_files $uri $uri/ =404; } }' > /etc/nginx/conf.d/default.conf

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port 3000 for the container
EXPOSE 3000

# Use the custom entrypoint script to start Nginx
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

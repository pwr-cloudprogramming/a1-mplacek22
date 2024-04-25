#!/bin/bash

sudo systemctl start docker

# Check if Docker Compose is installed, install if it's not
if ! [ -x "$(command -v docker-compose)" ]; then
    echo 'Error: docker-compose is not installed.' >&2
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Retrieve the public IPv4 address of the EC2 instance
API_URL="http://169.254.169.254/latest/api"
TOKEN=$(curl -X PUT "$API_URL/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
TOKEN_HEADER="X-aws-ec2-metadata-token: $TOKEN"
METADATA_URL="http://169.254.169.254/latest/meta-data"
IP_V4=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/public-ipv4)

# Set environment variable for public IP
export PUBLIC_IP=$IP_V4

# Navigate to the directory containing index.js
cd  /home/ec2-user/a1-mplacek22/frontend/src

# # Replace the placeholder <PUBLIC-IP> with the actual public IP in index.js
# sed -i "s|http://<PUBLIC-IP>:8080|http://$IP_V4:8080|g" index.js


#build docker images
sudo docker rm -f $(sudo docker ps -a -q)
cd /home/ec2-user/a1-mplacek22/backend/
sudo docker build -t tictactoe_back:v1 -t tictactoe_back:latest .
cd /home/ec2-user/a1-mplacek22/frontend/
sudo docker build -t tictactoe_front:v1 -t tictactoe_front:latest .

# Navigate to the directory containing Docker Compose file
cd /home/ec2-user/a1-mplacek22

# Start the containers
docker-compose up -d
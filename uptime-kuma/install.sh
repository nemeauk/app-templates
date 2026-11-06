#!/bin/bash
set -e

# 1. Check and install Docker if not present
if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed"
    docker --version
else
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sh /tmp/get-docker.sh
    systemctl enable --now docker
    docker --version
fi

# 2. Create a persistent volume for Uptime Kuma data
echo "Setting up Uptime Kuma volume..."
docker volume create uptime-kuma || true

# 3. Run the Uptime Kuma container
echo "Starting Uptime Kuma..."
docker run -d \
  --restart=always \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  --name uptime-kuma \
  louislam/uptime-kuma:1

echo "----------------------------------------"
echo "Uptime Kuma is successfully running!"
echo "Access your dashboard at: http://<your-server-ip>:3001"
echo "----------------------------------------"
set -e
if command -v docker >/dev/null 2>&1; then echo "Docker is already installed"; docker --version; exit 0; fi
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh
systemctl enable --now docker
docker --version
#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Remove old Docker versions
echo "Removing old Docker packages..."
sudo apt remove -y \
    containerd \
    docker-compose \
    docker-doc \
    docker.io \
    podman-docker \
    runc

# Add Docker's official GPG key:
echo "Adding Docker's GPG key..."
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "Adding repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  bookworm stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Start Docker on boot
echo "Configuring Docker to start on boot..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Verify installation was successful
echo "Verifying installation..."
sudo docker run hello-world

# Configure logging driver
echo "Configuring logging driver..."
daemon_json="/etc/docker/daemon.json"
sudo touch "${daemon_json}"
sudo bash -c "cat > ${daemon_json}" <<EOL
{
  "log-driver": "local"
}
EOL
echo "Saved ${daemon_json} contents:"
sudo cat "${daemon_json}"
echo "Validating ${daemon_json}..."
dockerd --validate --config-file="${daemon_json}"
echo "Docker logging driver: $(docker info --format '{{.LoggingDriver}}')"

# Create Docker Unix group
echo "Creating Docker Unix group..."
sudo groupadd docker
sudo usermod -aG docker "${USER}"
newgrp docker


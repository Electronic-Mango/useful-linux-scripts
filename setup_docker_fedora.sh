#!/usr/bin/env bash

# Update package list
echo "Updating package list..."
sudo dnf update

# Remove old Docker versions
echo "Removing old Docker packages..."
sudo apt remove -y \
    docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine

# Set up the repository
echo "Setting up Docker repository..."
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine:
echo "Installing latest Docker Engine..."
echo "Prompted GPG key should be:"
echo "060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35"
echo "060A61C51B558A7F742B77AAC52FEB6B621E9F35"
sudo dnf install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Start Docker Engine
echo "Starting Docker Engine..."
sudo systemctl enable --now docker

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

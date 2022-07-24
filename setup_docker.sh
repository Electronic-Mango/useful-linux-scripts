#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Remove old Docker versions
echo "Removing old Docker versions..."
sudo apt remove -y docker
sudo apt remove -y docker-engine
sudo apt remove -y docker.io
sudo apt remove -y containerd
sudo apt remove -y runc

# Add Docker GPG key
echo "Adding Docker GPG key..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Start Docker on boot
echo "Configuring Docker to start on boot..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Verify installation was successful
echo "Verifying installation..."
sudo docker run hello-world

# Create Docker Unix group
echo "Creating Docker Unix group..."
sudo groupadd docker
sudo usermod -aG docker "${USER}"
newgrp docker


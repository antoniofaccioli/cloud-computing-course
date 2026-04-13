#!/bin/bash
# Install Docker CE with Compose plugin (v2)
curl -fsSL https://get.docker.com | sh
systemctl start docker
systemctl enable docker

# Create working directory
mkdir -p /root/lab

echo "Setup complete"

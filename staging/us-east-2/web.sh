#!/bin/bash

# Log the output to /var/log/user-data.log for debugging
exec > >(tee -a /var/log/user-data.log) 2>&1
echo "Starting user-data script..."

# Wait for network to be up before starting installation
echo "Waiting for network to be available..."
while ! ping -c 1 google.com; do
  sleep 5
done
echo "Network is up!"

# Uninstall Unofficial versions of Docker (if any)
echo "Uninstalling unofficial Docker versions..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt remove $pkg -y
done

################################## Set up Docker's Apt repository. ###########################

# Add Docker's official GPG key:
echo "Setting up Docker repository..."
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg 

# Add the repository to Apt sources:
echo "Adding Docker repository..."
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# Install the Docker packages
echo "Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Verify Docker installation and status
echo "Verifying Docker installation..."
docker --version
sudo systemctl status docker || echo "Docker failed to start"

# Start and Enable Docker using systemctl
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Add user 'cyber' to the Docker group and update Docker socket permissions
echo "Adding user 'cyber' to Docker group..."
sudo usermod -a -G docker cyber
sudo chmod 666 /var/run/docker.sock

# Run the OWASP Juice Shop container
echo "Pulling OWASP Juice Shop container..."
docker pull bkimminich/juice-shop
echo "Running OWASP Juice Shop container..."
docker run -d -p 80:3000 bkimminich/juice-shop

echo "User data script completed."

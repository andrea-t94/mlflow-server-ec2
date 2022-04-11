#!/bin/bash

# installing docker
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user # Add the ec2-user to the docker group so you can execute Docker commands without using sudo

# Configure Docker to start on boot
sudo systemctl enable docker.service # https://docs.docker.com/engine/install/linux-postinstall/#configure-docker-to-start-on-boot

# Prepare Docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Make ec2-user to docker group to run command without sudo
sudo usermod -a -G docker ec2-user
#!/bin/bash

# Detecting running OS
os=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'// | tr '[:upper:]' '[:lower:]')

# Uninstall previous/old installed versions
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

# Installing dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Adding docker PGP key
curl -fsSL "https://download.docker.com/linux/${os}/gpg" | sudo apt-key add -

# Adding docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/${os} $(lsb_release -cs) stable"

sudo apt-get update

# Actually installing docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose and make it executable
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

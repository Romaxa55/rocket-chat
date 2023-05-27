#!/bin/bash

# Обновляем и улучшаем систему
sudo apt-get update && sudo apt-get upgrade -y

# Устанавливаем Git
sudo apt-get install git -y

# Устанавливаем Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $(whoami)
sudo rm get-docker.sh

# Устанавливаем Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

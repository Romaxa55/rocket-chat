#!/bin/bash

set -x
# Проверка, что скрипт запущен от пользователя с правами суперпользователя
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт должен быть запущен от пользователя с правами суперпользователя (root)."
   exit 1
fi

# Обновляем и улучшаем систему
apt-get update && apt-get upgrade -y

# Устанавливаем Git
apt-get install git curl sudo -y

# Устанавливаем Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $(whoami)
rm get-docker.sh
git clone https://github.com/Romaxa55/rocket-chat.git
docker --version

# Устанавливаем Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

docker-compose --version

docker-compose -f rocket-chat/traefik.yml up -d
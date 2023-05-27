#!/bin/bash

# Проверка, что скрипт запущен от пользователя с правами суперпользователя
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт должен быть запущен от пользователя с правами суперпользователя (root)."
   exit 1
fi

# Обновляем и улучшаем систему
apt-get update && apt-get upgrade -y

# Устанавливаем Git
apt-get install git -y

# Устанавливаем Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $(whoami)
rm get-docker.sh

# Устанавливаем Docker Compose
curl -L "https://github.com/docker/compose/releases/download/2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

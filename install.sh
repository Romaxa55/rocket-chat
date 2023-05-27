#!/bin/bash

set -x
# Проверка, что скрипт запущен от пользователя с правами суперпользователя
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт должен быть запущен от пользователя с правами суперпользователя (root)."
   exit 1
fi

# Проверка на установку Docker
if ! command -v docker &> /dev/null; then
    # Устанавливаем Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    usermod -aG docker $(whoami)
    rm get-docker.sh
fi

# Проверка на установку Docker Compose
if ! command -v docker-compose &> /dev/null; then
    # Устанавливаем Docker Compose
    curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Проверка на установку Git, curl и sudo
packages=("git" "curl" "sudo")
for package in "${packages[@]}"; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
        apt-get update
        apt-get install "$package" -y
    fi
done

# Клонирование репозитория Rocket.Chat
if [ ! -d "rocket-chat" ]; then
    git clone https://github.com/Romaxa55/rocket-chat.git
fi

docker --version
docker-compose --version

docker-compose -f rocket-chat/traefik.yml up -d

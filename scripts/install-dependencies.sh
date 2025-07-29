#!/bin/bash

# Скрипт установки зависимостей для n8n TikTok конвейера

echo "🚀 Установка зависимостей для n8n TikTok конвейера..."

# Обновление пакетов
echo "📦 Обновление пакетов..."
sudo apt update

# Установка Node.js и npm
echo "📦 Установка Node.js..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "✅ Node.js уже установлен"
fi

# Установка FFmpeg
echo "🎬 Установка FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
    sudo apt install -y ffmpeg
else
    echo "✅ FFmpeg уже установлен"
fi

# Установка yt-dlp
echo "📥 Установка yt-dlp..."
if ! command -v yt-dlp &> /dev/null; then
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
else
    echo "✅ yt-dlp уже установлен"
fi

# Установка Python зависимостей
echo "🐍 Установка Python зависимостей..."
sudo apt install -y python3-pip
pip3 install --user yt-dlp

# Создание необходимых директорий
echo "📁 Создание директорий..."
mkdir -p data/{cache,analytics,downloads,processed}
mkdir -p logs
mkdir -p assets

# Установка npm зависимостей
echo "📦 Установка npm зависимостей..."
npm install

# Создание .env файла если не существует
if [ ! -f .env ]; then
    echo "⚙️ Создание .env файла..."
    cp env.example .env
    echo "⚠️ Пожалуйста, отредактируйте .env файл с вашими API ключами"
fi

# Установка прав доступа
echo "🔐 Настройка прав доступа..."
chmod +x scripts/*.sh

echo "✅ Установка завершена!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Отредактируйте .env файл с вашими API ключами"
echo "2. Запустите: npm run dev"
echo "3. Откройте n8n в браузере: http://localhost:5678"
echo ""
echo "🎯 Готово к работе!" 
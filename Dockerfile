# Используем официальный Node.js образ
FROM node:20-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем системные зависимости
RUN apk add --no-cache \
    ffmpeg \
    python3 \
    make \
    g++ \
    && rm -rf /var/cache/apk/*

# Копируем файлы package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci --only=production && npm cache clean --force

# Копируем исходный код
COPY . .

# Создаем необходимые директории
RUN mkdir -p data/cache data/downloads data/analytics logs

# Устанавливаем права на папки
RUN chown -R node:node /app

# Переключаемся на пользователя node
USER node

# Открываем порт
EXPOSE 5678

# Устанавливаем переменные окружения
ENV NODE_ENV=production
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0

# Запускаем приложение
CMD ["npm", "start"] 
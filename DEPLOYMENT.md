# Руководство по развертыванию

Этот документ содержит инструкции по развертыванию n8n TikTok Pipeline в различных средах.

## Локальное развертывание

### Предварительные требования

- Node.js 18+ 
- npm или yarn
- FFmpeg
- Git

### Установка

1. **Клонируйте репозиторий**:
```bash
git clone <your-repo-url>
cd n8n_tiktok
```

2. **Установите зависимости**:
```bash
npm install
```

3. **Настройте переменные окружения**:
```bash
cp env.example .env
# Отредактируйте .env файл
```

4. **Запустите проект**:
```bash
npm run dev
```

## Docker развертывание

### Создание Docker образа

```bash
# Сборка образа
docker build -t n8n-tiktok-pipeline .

# Запуск контейнера
docker run -d \
  --name n8n-tiktok \
  -p 5678:5678 \
  -v $(pwd)/data:/app/data \
  -v $(pwd)/logs:/app/logs \
  --env-file .env \
  n8n-tiktok-pipeline
```

### Docker Compose

Создайте файл `docker-compose.yml`:

```yaml
version: '3.8'

services:
  n8n-tiktok:
    build: .
    ports:
      - "5678:5678"
    volumes:
      - ./data:/app/data
      - ./logs:/app/logs
      - ./workflows:/app/workflows
    environment:
      - NODE_ENV=production
    env_file:
      - .env
    restart: unless-stopped
    depends_on:
      - postgres

  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: n8n
      POSTGRES_USER: n8n
      POSTGRES_PASSWORD: n8n_password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

Запуск:
```bash
docker-compose up -d
```

## Облачное развертывание

### Heroku

1. **Создайте приложение на Heroku**:
```bash
heroku create your-app-name
```

2. **Настройте переменные окружения**:
```bash
heroku config:set NODE_ENV=production
heroku config:set TIKTOK_ACCESS_TOKEN=your_token
# Добавьте остальные переменные
```

3. **Разверните**:
```bash
git push heroku main
```

### AWS EC2

1. **Подключитесь к EC2 инстансу**:
```bash
ssh -i your-key.pem ubuntu@your-ec2-ip
```

2. **Установите зависимости**:
```bash
sudo apt update
sudo apt install nodejs npm git ffmpeg
```

3. **Клонируйте и запустите**:
```bash
git clone <your-repo>
cd n8n_tiktok
npm install
npm run start
```

### Google Cloud Platform

1. **Создайте инстанс**:
```bash
gcloud compute instances create n8n-tiktok \
  --zone=us-central1-a \
  --machine-type=e2-medium \
  --image-family=debian-11 \
  --image-project=debian-cloud
```

2. **Установите и запустите**:
```bash
# Подключитесь к инстансу
gcloud compute ssh n8n-tiktok

# Установите зависимости
sudo apt update
sudo apt install nodejs npm git ffmpeg

# Клонируйте и запустите проект
git clone <your-repo>
cd n8n_tiktok
npm install
npm run start
```

## Мониторинг и логирование

### Логирование

Логи сохраняются в папке `./logs/`:
- `app.log` - основные логи приложения
- `error.log` - логи ошибок
- `access.log` - логи доступа

### Мониторинг

Для мониторинга используйте:
- **PM2** для управления процессами
- **Prometheus** для метрик
- **Grafana** для визуализации

### PM2 настройка

```bash
# Установка PM2
npm install -g pm2

# Запуск с PM2
pm2 start ecosystem.config.js

# Мониторинг
pm2 monit
```

## Безопасность

### SSL/TLS

Для продакшена обязательно используйте HTTPS:

```bash
# С Let's Encrypt
sudo certbot --nginx -d your-domain.com
```

### Firewall

Настройте firewall:
```bash
# UFW (Ubuntu)
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
```

### Переменные окружения

Никогда не коммитьте `.env` файл:
```bash
# Добавьте в .gitignore
.env
.env.local
.env.production
```

## Резервное копирование

### Автоматические бэкапы

Создайте скрипт для бэкапов:

```bash
#!/bin/bash
# backup.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"

# Бэкап данных
tar -czf $BACKUP_DIR/data_$DATE.tar.gz ./data

# Бэкап логов
tar -czf $BACKUP_DIR/logs_$DATE.tar.gz ./logs

# Удаление старых бэкапов (старше 30 дней)
find $BACKUP_DIR -name "*.tar.gz" -mtime +30 -delete
```

### Cron job

```bash
# Добавьте в crontab
0 2 * * * /path/to/backup.sh
```

## Обновления

### Автоматические обновления

Настройте GitHub Actions для автоматического развертывания:

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to server
        run: |
          # Ваши команды развертывания
```

## Устранение неполадок

### Частые проблемы

1. **Порт занят**:
```bash
# Найдите процесс
lsof -i :5678
# Убейте процесс
kill -9 <PID>
```

2. **Недостаточно памяти**:
```bash
# Увеличьте swap
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

3. **Проблемы с правами**:
```bash
# Исправьте права на папки
sudo chown -R $USER:$USER ./data
sudo chown -R $USER:$USER ./logs
```

### Логи для диагностики

```bash
# Просмотр логов в реальном времени
tail -f logs/app.log

# Поиск ошибок
grep "ERROR" logs/app.log

# Статистика логов
wc -l logs/*.log
``` 
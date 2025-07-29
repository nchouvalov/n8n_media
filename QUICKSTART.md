# 🚀 Быстрый старт n8n TikTok Конвейера

## ⚡ Установка за 5 минут

### 1. Клонирование и установка

```bash
# Клонируйте репозиторий
git clone <your-repo-url>
cd n8n_tiktok

# Запустите автоматическую установку
./scripts/install-dependencies.sh
```

### 2. Настройка API ключей

```bash
# Скопируйте пример конфигурации
cp env.example .env

# Отредактируйте файл .env
nano .env
```

**Минимальные настройки для начала:**

```env
# TikTok API (обязательно)
TIKTOK_ACCESS_TOKEN=your_tiktok_token

# YouTube API (опционально)
YOUTUBE_API_KEY=your_youtube_key

# Instagram API (опционально)
INSTAGRAM_ACCESS_TOKEN=your_instagram_token

# Пути для файлов
STORAGE_PATH=./data
DOWNLOADS_PATH=./data/downloads
```

### 3. Запуск n8n

```bash
# Запуск в режиме разработки
npm run dev

# Или в продакшене
npm start
```

Откройте браузер: **http://localhost:5678**

## 📋 Импорт Workflow'ов

### 1. TikTok Monitor
- Импортируйте: `workflows/tiktok-monitor.json`
- Настройте аккаунты для мониторинга
- Активируйте workflow

### 2. Video Downloader
- Импортируйте: `workflows/video-downloader.json`
- Настройте пути сохранения
- Активируйте workflow

### 3. Video Processor
- Импортируйте: `workflows/video-processor.json`
- Настройте параметры обработки
- Активируйте workflow

### 4. Multi-Platform Publisher
- Импортируйте: `workflows/multi-platform-publisher.json`
- Настройте API ключи для платформ
- Активируйте workflow

## 🎯 Первый тест

### Тестирование загрузки

```bash
# Отправьте тестовый webhook
curl -X POST http://localhost:5678/webhook/video-download \
  -H "Content-Type: application/json" \
  -d '{
    "videos": [{
      "video_id": "test123",
      "title": "Test Video",
      "share_url": "https://www.tiktok.com/@user/video/1234567890",
      "platform": "tiktok"
    }]
  }'
```

### Проверка логов

```bash
# Просмотр логов в реальном времени
tail -f logs/error.log
```

## 🔧 Основные команды

```bash
# Установка зависимостей
npm install

# Запуск в режиме разработки
npm run dev

# Запуск в продакшене
npm start

# Сборка проекта
npm run build

# Запуск тестов
npm test

# Очистка кэша
npm run cleanup
```

## 📊 Мониторинг

### Проверка статуса

```bash
# Статус n8n
curl http://localhost:5678/healthz

# Статистика обработки
ls -la data/analytics/
```

### Логи и отладка

```bash
# Все логи
tail -f logs/*.log

# Только ошибки
tail -f logs/error.log

# Логи загрузки
tail -f logs/download.log
```

## 🆘 Решение проблем

### Частые ошибки

1. **"FFmpeg not found"**
   ```bash
   sudo apt install ffmpeg
   ```

2. **"yt-dlp not found"**
   ```bash
   sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
   sudo chmod a+rx /usr/local/bin/yt-dlp
   ```

3. **"Permission denied"**
   ```bash
   chmod +x scripts/*.sh
   chmod -R 755 data/
   ```

4. **"API key invalid"**
   - Проверьте правильность ключей в `.env`
   - Убедитесь в актуальности токенов
   - Проверьте права доступа API

### Получение API ключей

#### TikTok API
1. Зарегистрируйтесь на [TikTok for Developers](https://developers.tiktok.com/)
2. Создайте приложение
3. Получите Access Token

#### YouTube API
1. Перейдите в [Google Cloud Console](https://console.cloud.google.com/)
2. Создайте проект
3. Включите YouTube Data API v3
4. Создайте API ключ

#### Instagram API
1. Создайте Facebook App
2. Добавьте Instagram Basic Display
3. Получите Access Token

## 📈 Следующие шаги

1. **Настройте мониторинг** - добавьте Telegram уведомления
2. **Оптимизируйте производительность** - настройте параллельную обработку
3. **Добавьте новые платформы** - создайте кастомные ноды
4. **Настройте аналитику** - подключите базу данных
5. **Автоматизируйте развертывание** - настройте CI/CD

## 🤝 Поддержка

- 📖 [Полная документация](docs/usage-guide.md)
- 🐛 [Сообщить об ошибке](https://github.com/your-repo/issues)
- 💬 [Discord сообщество](https://discord.gg/n8n)
- 📧 [Email поддержка](mailto:support@your-domain.com)

---

**🎉 Поздравляем! Ваш TikTok конвейер готов к работе!** 
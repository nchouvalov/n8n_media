# n8n TikTok Автоматический Конвейер

Автоматический конвейер для обработки TikTok и других видео форматов с использованием n8n.

## 🚀 Возможности

- **Мониторинг источников**: Автоматическое отслеживание новых видео из TikTok, YouTube, Instagram
- **Загрузка контента**: Скачивание видео и метаданных
- **Обработка видео**: Конвертация, обрезка, добавление водяных знаков
- **Анализ контента**: Извлечение ключевых слов, тегов, описаний
- **Публикация**: Автоматическая загрузка на различные платформы
- **Аналитика**: Отслеживание статистики и производительности

## 📋 Требования

- Node.js 18+
- FFmpeg
- n8n
- Доступ к API TikTok, YouTube, Instagram

## 🛠️ Установка

### Быстрый старт

1. **Клонируйте репозиторий**:
```bash
git clone <your-repo>
cd n8n_tiktok
```

2. **Установите зависимости**:
```bash
npm install
```

3. **Настройте переменные окружения**:
```bash
cp .env.example .env
# Отредактируйте .env файл с вашими API ключами
```

4. **Запустите n8n**:
```bash
npm run dev
```

### Docker развертывание

```bash
# Запуск с Docker Compose
docker-compose up -d

# Или сборка образа
docker build -t n8n-tiktok-pipeline .
docker run -d -p 5678:5678 --env-file .env n8n-tiktok-pipeline
```

## 📁 Структура проекта

```
n8n_tiktok/
├── workflows/          # n8n workflow файлы
├── custom-nodes/       # Пользовательские ноды
├── scripts/           # Вспомогательные скрипты
├── config/            # Конфигурационные файлы
├── data/              # Данные и кэш
└── docs/              # Документация
```

## 🔧 Конфигурация

### API Ключи

Создайте файл `.env` со следующими переменными:

```env
# TikTok API
TIKTOK_ACCESS_TOKEN=your_tiktok_token
TIKTOK_CLIENT_KEY=your_client_key
TIKTOK_CLIENT_SECRET=your_client_secret

# YouTube API
YOUTUBE_API_KEY=your_youtube_api_key

# Instagram API
INSTAGRAM_ACCESS_TOKEN=your_instagram_token

# FFmpeg
FFMPEG_PATH=/usr/bin/ffmpeg

# Storage
STORAGE_PATH=./data
```

## 🎯 Workflow'ы

### 1. TikTok Monitor
Отслеживает новые видео от определенных аккаунтов

### 2. Video Downloader
Скачивает видео с различных платформ

### 3. Video Processor
Обрабатывает видео (конвертация, обрезка, водяные знаки)

### 4. Content Analyzer
Анализирует контент и извлекает метаданные

### 5. Multi-Platform Publisher
Публикует контент на различные платформы

## 📊 Мониторинг

- Логи сохраняются в `./logs/`
- Статистика в `./data/analytics/`
- Кэш видео в `./data/cache/`

## 🤝 Вклад в проект

1. Fork репозитория
2. Создайте feature branch
3. Commit изменения
4. Push в branch
5. Создайте Pull Request

## 📄 Лицензия

MIT License

## 🔗 Полезные ссылки

- [📖 Подробная документация](docs/usage-guide.md)
- [🚀 Руководство по развертыванию](DEPLOYMENT.md)
- [🔧 Руководство по вкладу в проект](CONTRIBUTING.md)
- [🔐 Политика безопасности](SECURITY.md)
- [📋 Настройка GitHub](GITHUB_SETUP.md)
- [📝 История изменений](CHANGELOG.md) 
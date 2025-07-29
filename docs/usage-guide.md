# Руководство по использованию n8n TikTok Конвейера

## 🚀 Быстрый старт

### 1. Установка зависимостей

```bash
# Запустите скрипт установки
./scripts/install-dependencies.sh

# Или установите вручную
npm install
```

### 2. Настройка API ключей

Отредактируйте файл `.env`:

```env
# TikTok API
TIKTOK_ACCESS_TOKEN=your_tiktok_access_token
TIKTOK_CLIENT_KEY=your_client_key
TIKTOK_CLIENT_SECRET=your_client_secret

# YouTube API
YOUTUBE_API_KEY=your_youtube_api_key

# Instagram API
INSTAGRAM_ACCESS_TOKEN=your_instagram_token
```

### 3. Запуск n8n

```bash
npm run dev
```

Откройте браузер: http://localhost:5678

## 📋 Workflow'ы

### 1. TikTok Monitor

**Назначение**: Отслеживает новые видео от определенных TikTok аккаунтов

**Настройка**:
- Добавьте TikTok аккаунты для мониторинга
- Настройте интервал проверки (по умолчанию 15 минут)
- Укажите количество видео для получения

**Импорт**: `workflows/tiktok-monitor.json`

### 2. Video Downloader

**Назначение**: Скачивает видео с различных платформ

**Поддерживаемые платформы**:
- TikTok
- YouTube
- Instagram
- Twitter
- Facebook

**Настройка**:
- Укажите пути для сохранения
- Настройте качество видео
- Добавьте обработку ошибок

**Импорт**: `workflows/video-downloader.json`

### 3. Video Processor

**Назначение**: Обрабатывает скачанные видео

**Возможности**:
- Изменение размера видео
- Добавление водяных знаков
- Конвертация форматов
- Обрезка видео
- Оптимизация качества

**Настройка**:
- Укажите целевые размеры
- Добавьте водяной знак
- Настройте качество

**Импорт**: `workflows/video-processor.json`

## 🔧 Пользовательские ноды

### TikTok Node

Специальная нода для работы с TikTok API:

```javascript
// Получение информации о пользователе
{
  "operation": "getUserInfo",
  "userId": "user_id_here"
}

// Получение списка видео
{
  "operation": "getVideos",
  "userId": "user_id_here",
  "maxCount": 10
}

// Поиск видео
{
  "operation": "searchVideos",
  "query": "search_term",
  "maxCount": 20
}
```

## 📊 Мониторинг и аналитика

### Логи

Логи сохраняются в директории `./logs/`:
- `download.log` - логи загрузки
- `process.log` - логи обработки
- `error.log` - ошибки

### Аналитика

Статистика сохраняется в `./data/analytics/`:
- Количество обработанных видео
- Время обработки
- Успешность операций
- Использование ресурсов

### Метрики

Включите мониторинг в `.env`:
```env
ENABLE_MONITORING=true
METRICS_PORT=9090
```

## 🔄 Автоматизация

### Cron Jobs

Настройте автоматический запуск:

```bash
# Каждые 15 минут
*/15 * * * * cd /path/to/n8n_tiktok && npm run monitor

# Каждый час
0 * * * * cd /path/to/n8n_tiktok && npm run process

# Ежедневно в 2:00
0 2 * * * cd /path/to/n8n_tiktok && npm run cleanup
```

### Webhook Triggers

Настройте webhook для внешних триггеров:

```bash
curl -X POST http://localhost:5678/webhook/video-download \
  -H "Content-Type: application/json" \
  -d '{"videos": [{"video_id": "123", "url": "https://..."}]}'
```

## 🛠️ Расширение функциональности

### Добавление новых платформ

1. Создайте новую ноду в `custom-nodes/`
2. Добавьте обработку в `video-downloader.json`
3. Обновите документацию

### Кастомная обработка видео

1. Создайте скрипт обработки
2. Добавьте ноду Execute Command
3. Настройте параметры в workflow

### Интеграция с внешними сервисами

```javascript
// Пример интеграции с Telegram
{
  "url": "https://api.telegram.org/bot{{ $env.TELEGRAM_BOT_TOKEN }}/sendMessage",
  "method": "POST",
  "body": {
    "chat_id": "{{ $env.TELEGRAM_CHAT_ID }}",
    "text": "Новое видео обработано: {{ $json.title }}"
  }
}
```

## 🔒 Безопасность

### API ключи

- Храните ключи в `.env` файле
- Не коммитьте `.env` в git
- Используйте разные ключи для разработки и продакшена

### Ограничения

- Настройте rate limiting
- Ограничьте размер файлов
- Настройте таймауты

### Мониторинг

- Отслеживайте использование API
- Логируйте все операции
- Настройте алерты при ошибках

## 🐛 Устранение неполадок

### Частые проблемы

1. **Ошибка загрузки видео**
   - Проверьте URL
   - Убедитесь в наличии прав доступа
   - Проверьте интернет соединение

2. **Ошибка обработки видео**
   - Проверьте установку FFmpeg
   - Убедитесь в наличии места на диске
   - Проверьте права доступа к файлам

3. **Ошибки API**
   - Проверьте валидность токенов
   - Убедитесь в соблюдении лимитов
   - Проверьте формат запросов

### Логи и отладка

```bash
# Просмотр логов в реальном времени
tail -f logs/error.log

# Проверка статуса n8n
curl http://localhost:5678/healthz

# Тестирование webhook
curl -X POST http://localhost:5678/webhook/test
```

## 📈 Оптимизация производительности

### Настройки системы

- Увеличьте лимиты файловых дескрипторов
- Настройте swap память
- Оптимизируйте настройки сети

### Настройки n8n

```javascript
// Увеличьте количество параллельных задач
EXECUTIONS_PROCESS: 'main',
EXECUTIONS_MODE: 'regular',

// Настройте таймауты
EXECUTIONS_TIMEOUT: 3600,
EXECUTIONS_TIMEOUT_MAX: 7200,
```

### Кэширование

- Включите кэширование результатов
- Настройте TTL для кэша
- Используйте Redis для распределенного кэша

## 🤝 Поддержка

### Сообщество

- [n8n Community](https://community.n8n.io/)
- [GitHub Issues](https://github.com/your-repo/issues)
- [Discord](https://discord.gg/n8n)

### Документация

- [n8n Documentation](https://docs.n8n.io/)
- [TikTok API Documentation](https://developers.tiktok.com/)
- [YouTube API Documentation](https://developers.google.com/youtube/v3)

### Контакты

- Email: support@your-domain.com
- Telegram: @your_support_bot
- Discord: your-username#1234 
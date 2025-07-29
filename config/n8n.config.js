module.exports = {
    // Основные настройки
    N8N_BASIC_AUTH_ACTIVE: false,
    N8N_BASIC_AUTH_USER: '',
    N8N_BASIC_AUTH_PASSWORD: '',
    
    // Настройки веб-сервера
    N8N_PORT: 5678,
    N8N_HOST: 'localhost',
    N8N_PROTOCOL: 'http',
    
    // Настройки базы данных
    DB_TYPE: 'sqlite',
    DB_SQLITE_VACUUM_ON_STARTUP: true,
    DB_SQLITE_DATABASE: './data/n8n.db',
    
    // Настройки безопасности
    N8N_ENCRYPTION_KEY: process.env.N8N_ENCRYPTION_KEY || 'your-encryption-key-here',
    WEBHOOK_URL: process.env.WEBHOOK_URL || 'http://localhost:5678',
    
    // Настройки логирования
    N8N_LOG_LEVEL: process.env.LOG_LEVEL || 'info',
    N8N_LOG_OUTPUT: 'console',
    
    // Настройки производительности
    EXECUTIONS_PROCESS: 'main',
    EXECUTIONS_MODE: 'regular',
    EXECUTIONS_TIMEOUT: 3600,
    EXECUTIONS_TIMEOUT_MAX: 7200,
    
    // Настройки кэширования
    CACHE_ENABLED: true,
    CACHE_TTL: 3600,
    
    // Настройки пользовательских нод
    N8N_CUSTOM_EXTENSIONS: './custom-nodes',
    
    // Настройки мониторинга
    METRICS: process.env.ENABLE_MONITORING === 'true',
    METRICS_PORT: process.env.METRICS_PORT || 9090,
    
    // Настройки для TikTok конвейера
    TIKTOK_API_BASE_URL: 'https://api.tiktok.com/v2',
    YOUTUBE_API_BASE_URL: 'https://www.googleapis.com/youtube/v3',
    INSTAGRAM_API_BASE_URL: 'https://graph.instagram.com/v12.0',
    
    // Настройки обработки видео
    VIDEO_PROCESSING: {
        MAX_CONCURRENT_JOBS: 3,
        TEMP_DIR: './data/temp',
        OUTPUT_DIR: './data/processed',
        SUPPORTED_FORMATS: ['mp4', 'avi', 'mov', 'mkv'],
        MAX_FILE_SIZE: 1024 * 1024 * 1024, // 1GB
    },
    
    // Настройки загрузки
    DOWNLOAD: {
        MAX_CONCURRENT_DOWNLOADS: 5,
        TIMEOUT: 300000, // 5 минут
        RETRY_ATTEMPTS: 3,
        RETRY_DELAY: 5000, // 5 секунд
    },
    
    // Настройки уведомлений
    NOTIFICATIONS: {
        ENABLED: true,
        WEBHOOK_URL: process.env.NOTIFICATION_WEBHOOK_URL,
        SLACK_WEBHOOK_URL: process.env.SLACK_WEBHOOK_URL,
        TELEGRAM_BOT_TOKEN: process.env.TELEGRAM_BOT_TOKEN,
        TELEGRAM_CHAT_ID: process.env.TELEGRAM_CHAT_ID,
    },
    
    // Настройки аналитики
    ANALYTICS: {
        ENABLED: true,
        STORAGE_PATH: './data/analytics',
        RETENTION_DAYS: 30,
    },
    
    // Настройки безопасности API
    API: {
        RATE_LIMIT_ENABLED: true,
        RATE_LIMIT_REQUESTS: parseInt(process.env.RATE_LIMIT_REQUESTS) || 100,
        RATE_LIMIT_WINDOW: parseInt(process.env.RATE_LIMIT_WINDOW) || 60000,
    },
    
    // Настройки разработки
    NODE_ENV: process.env.NODE_ENV || 'development',
    N8N_DEV_MODE: process.env.NODE_ENV === 'development',
    
    // Настройки туннеля для разработки
    N8N_TUNNEL: process.env.N8N_TUNNEL === 'true',
    
    // Настройки импорта/экспорта
    IMPORT_EXPORT: {
        ALLOWED_HOSTS: ['localhost', '127.0.0.1'],
        MAX_FILE_SIZE: 10 * 1024 * 1024, // 10MB
    },
}; 
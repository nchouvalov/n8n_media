#!/bin/bash

# Скрипт для инициализации Git репозитория
# Использование: ./scripts/init-git.sh

set -e

echo "🚀 Инициализация Git репозитория для n8n TikTok Pipeline..."

# Проверяем, что мы в корневой папке проекта
if [ ! -f "package.json" ]; then
    echo "❌ Ошибка: package.json не найден. Запустите скрипт из корневой папки проекта."
    exit 1
fi

# Инициализируем Git репозиторий (если еще не инициализирован)
if [ ! -d ".git" ]; then
    echo "📁 Инициализация Git репозитория..."
    git init
else
    echo "✅ Git репозиторий уже инициализирован"
fi

# Добавляем все файлы в staging area
echo "📝 Добавление файлов в Git..."
git add .

# Создаем первый коммит
echo "💾 Создание первого коммита..."
git commit -m "feat: инициализация проекта n8n TikTok Pipeline

- Базовая структура проекта
- Пользовательские ноды для TikTok API
- Workflow'ы для мониторинга и обработки видео
- Система загрузки и обработки видео
- Аналитика контента
- Мультиплатформенная публикация
- Документация и конфигурация"

# Создаем ветку develop
echo "🌿 Создание ветки develop..."
git checkout -b develop

# Создаем ветку main (если она еще не существует)
if ! git show-ref --verify --quiet refs/heads/main; then
    echo "🌿 Создание ветки main..."
    git checkout -b main
else
    echo "✅ Ветка main уже существует"
    git checkout main
fi

# Настраиваем Git hooks
echo "🔧 Настройка Git hooks..."
if [ -f ".husky/pre-commit" ]; then
    chmod +x .husky/pre-commit
    echo "✅ Git hooks настроены"
else
    echo "⚠️  Git hooks не найдены"
fi

echo ""
echo "🎉 Git репозиторий успешно инициализирован!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Создайте приватный репозиторий на GitHub"
echo "2. Добавьте remote origin:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
echo "3. Отправьте код:"
echo "   git push -u origin main"
echo "   git push -u origin develop"
echo ""
echo "🔐 Не забудьте:"
echo "- Настроить переменные окружения в .env файле"
echo "- Добавить API ключи в переменные окружения"
echo "- Настроить GitHub Actions secrets"
echo ""
echo "📚 Дополнительная документация:"
echo "- README.md - основная документация"
echo "- DEPLOYMENT.md - руководство по развертыванию"
echo "- CONTRIBUTING.md - руководство по вкладу в проект" 
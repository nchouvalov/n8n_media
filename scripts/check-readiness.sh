#!/bin/bash

# Скрипт для проверки готовности проекта к загрузке на GitHub
# Использование: ./scripts/check-readiness.sh

set -e

echo "🔍 Проверка готовности проекта к загрузке на GitHub..."
echo ""

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функция для проверки
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅${NC} $1"
        return 0
    else
        echo -e "${RED}❌${NC} $1 - НЕ НАЙДЕН"
        return 1
    fi
}

# Функция для проверки содержимого
check_content() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✅${NC} $1 содержит '$2'"
        return 0
    else
        echo -e "${RED}❌${NC} $1 НЕ содержит '$2'"
        return 1
    fi
}

# Счетчики
total_checks=0
passed_checks=0

echo "📁 Проверка структуры проекта..."
echo ""

# Проверка основных файлов
check_file "package.json" && ((passed_checks++)) || true
((total_checks++))

check_file "README.md" && ((passed_checks++)) || true
((total_checks++))

check_file ".gitignore" && ((passed_checks++)) || true
((total_checks++))

check_file "env.example" && ((passed_checks++)) || true
((total_checks++))

check_file "LICENSE" && ((passed_checks++)) || true
((total_checks++))

check_file "Dockerfile" && ((passed_checks++)) || true
((total_checks++))

check_file "docker-compose.yml" && ((passed_checks++)) || true
((total_checks++))

echo ""
echo "🔧 Проверка конфигурации..."
echo ""

# Проверка конфигурационных файлов
check_file ".eslintrc.js" && ((passed_checks++)) || true
((total_checks++))

check_file ".prettierrc" && ((passed_checks++)) || true
((total_checks++))

check_file ".lintstagedrc.js" && ((passed_checks++)) || true
((total_checks++))

check_file ".dockerignore" && ((passed_checks++)) || true
((total_checks++))

echo ""
echo "📚 Проверка документации..."
echo ""

# Проверка документации
check_file "CONTRIBUTING.md" && ((passed_checks++)) || true
((total_checks++))

check_file "SECURITY.md" && ((passed_checks++)) || true
((total_checks++))

check_file "CHANGELOG.md" && ((passed_checks++)) || true
((total_checks++))

check_file "DEPLOYMENT.md" && ((passed_checks++)) || true
((total_checks++))

check_file "GITHUB_SETUP.md" && ((passed_checks++)) || true
((total_checks++))

echo ""
echo "🔐 Проверка безопасности..."
echo ""

# Проверка безопасности
check_content ".gitignore" "\.env" && ((passed_checks++)) || true
((total_checks++))

check_content ".gitignore" "node_modules" && ((passed_checks++)) || true
((total_checks++))

check_content ".gitignore" "logs" && ((passed_checks++)) || true
((total_checks++))

# Проверка, что .env не отслеживается
if [ -f ".env" ]; then
    echo -e "${YELLOW}⚠️${NC} .env файл существует (это нормально для локальной разработки)"
else
    echo -e "${GREEN}✅${NC} .env файл не существует (будет создан из env.example)"
fi

echo ""
echo "📂 Проверка папок..."
echo ""

# Проверка папок
if [ -d "data" ]; then
    echo -e "${GREEN}✅${NC} Папка data существует"
    check_file "data/cache/.gitkeep" && ((passed_checks++)) || true
    ((total_checks++))
    check_file "data/downloads/.gitkeep" && ((passed_checks++)) || true
    ((total_checks++))
    check_file "data/analytics/.gitkeep" && ((passed_checks++)) || true
    ((total_checks++))
else
    echo -e "${RED}❌${NC} Папка data не существует"
fi

if [ -d "logs" ]; then
    echo -e "${GREEN}✅${NC} Папка logs существует"
    check_file "logs/.gitkeep" && ((passed_checks++)) || true
    ((total_checks++))
else
    echo -e "${RED}❌${NC} Папка logs не существует"
fi

echo ""
echo "🚀 Проверка CI/CD..."
echo ""

# Проверка GitHub Actions
if [ -d ".github/workflows" ]; then
    echo -e "${GREEN}✅${NC} GitHub Actions настроены"
    check_file ".github/workflows/ci.yml" && ((passed_checks++)) || true
    ((total_checks++))
else
    echo -e "${YELLOW}⚠️${NC} GitHub Actions не настроены"
fi

# Проверка шаблонов
if [ -d ".github/ISSUE_TEMPLATE" ]; then
    echo -e "${GREEN}✅${NC} Шаблоны Issues настроены"
    check_file ".github/ISSUE_TEMPLATE/bug_report.md" && ((passed_checks++)) || true
    ((total_checks++))
    check_file ".github/ISSUE_TEMPLATE/feature_request.md" && ((passed_checks++)) || true
    ((total_checks++))
else
    echo -e "${YELLOW}⚠️${NC} Шаблоны Issues не настроены"
fi

check_file ".github/PULL_REQUEST_TEMPLATE.md" && ((passed_checks++)) || true
((total_checks++))

echo ""
echo "📊 Результаты проверки..."
echo ""

# Вывод результатов
echo "Пройдено проверок: $passed_checks из $total_checks"

if [ $passed_checks -eq $total_checks ]; then
    echo -e "${GREEN}🎉 Проект готов к загрузке на GitHub!${NC}"
    echo ""
    echo "📋 Следующие шаги:"
    echo "1. Запустите: ./scripts/init-git.sh"
    echo "2. Создайте приватный репозиторий на GitHub"
    echo "3. Следуйте инструкциям в GITHUB_SETUP.md"
else
    echo -e "${YELLOW}⚠️${NC} Некоторые проверки не пройдены. Исправьте ошибки перед загрузкой."
    echo ""
    echo "🔧 Рекомендации:"
    echo "- Проверьте отсутствующие файлы"
    echo "- Убедитесь, что .gitignore настроен правильно"
    echo "- Проверьте конфигурацию безопасности"
fi

echo ""
echo "📚 Дополнительная информация:"
echo "- README.md - основная документация"
echo "- GITHUB_SETUP.md - инструкции по загрузке"
echo "- DEPLOYMENT.md - руководство по развертыванию" 
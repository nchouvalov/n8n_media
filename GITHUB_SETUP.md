# Инструкции по загрузке на GitHub

Этот документ содержит пошаговые инструкции по загрузке проекта n8n TikTok Pipeline на GitHub как приватный репозиторий.

## 🚀 Быстрый старт

### 1. Подготовка проекта

Убедитесь, что все файлы готовы:
```bash
# Проверьте структуру проекта
ls -la

# Убедитесь, что .gitignore создан
cat .gitignore
```

### 2. Инициализация Git (автоматически)

Запустите скрипт инициализации:
```bash
./scripts/init-git.sh
```

### 3. Создание репозитория на GitHub

1. **Перейдите на GitHub.com** и войдите в свой аккаунт
2. **Нажмите "+" в правом верхнем углу** → "New repository"
3. **Заполните форму**:
   - Repository name: `n8n-tiktok-pipeline`
   - Description: `Автоматический конвейер для обработки TikTok и других видео форматов`
   - **Выберите "Private"** (приватный репозиторий)
   - **НЕ ставьте галочки** на "Add a README file", "Add .gitignore", "Choose a license"
4. **Нажмите "Create repository"**

### 4. Подключение к GitHub

```bash
# Добавьте remote origin (замените YOUR_USERNAME на ваше имя пользователя)
git remote add origin https://github.com/YOUR_USERNAME/n8n-tiktok-pipeline.git

# Проверьте remote
git remote -v
```

### 5. Отправка кода

```bash
# Отправьте ветку main
git push -u origin main

# Отправьте ветку develop
git push -u origin develop
```

## 🔐 Настройка безопасности

### 1. Переменные окружения

**НИКОГДА не коммитьте .env файл!**

Создайте файл `.env` на основе `env.example`:
```bash
cp env.example .env
```

Отредактируйте `.env` файл с вашими API ключами:
```env
# TikTok API
TIKTOK_ACCESS_TOKEN=your_actual_token_here
TIKTOK_CLIENT_KEY=your_actual_client_key_here
TIKTOK_CLIENT_SECRET=your_actual_client_secret_here

# YouTube API
YOUTUBE_API_KEY=your_actual_youtube_api_key_here

# Instagram API
INSTAGRAM_ACCESS_TOKEN=your_actual_instagram_token_here
```

### 2. GitHub Secrets (для CI/CD)

Если планируете использовать GitHub Actions:

1. **Перейдите в Settings** вашего репозитория
2. **Выберите "Secrets and variables"** → "Actions"
3. **Добавьте следующие secrets**:
   - `TIKTOK_ACCESS_TOKEN`
   - `TIKTOK_CLIENT_KEY`
   - `TIKTOK_CLIENT_SECRET`
   - `YOUTUBE_API_KEY`
   - `INSTAGRAM_ACCESS_TOKEN`

## 📋 Проверочный список

Перед отправкой убедитесь, что:

- [ ] `.gitignore` настроен правильно
- [ ] `.env` файл НЕ добавлен в Git
- [ ] Все API ключи удалены из кода
- [ ] Документация обновлена
- [ ] Тесты проходят
- [ ] Линтер не выдает ошибок

## 🔍 Проверка безопасности

### Проверка на утечки секретов

```bash
# Установите truffleHog для поиска секретов
pip install truffleHog

# Проверьте репозиторий
truffleHog --regex --entropy=False .

# Или используйте git-secrets
git secrets --scan
```

### Проверка .gitignore

```bash
# Проверьте, что .env не отслеживается
git status

# Убедитесь, что .env в .gitignore
grep -n "\.env" .gitignore
```

## 🚨 Важные предупреждения

### ❌ НЕ ДЕЛАЙТЕ ЭТОГО:

- Не коммитьте `.env` файлы
- Не хардкодите API ключи в коде
- Не используйте публичные репозитории для приватных проектов
- Не делитесь токенами доступа

### ✅ ДЕЛАЙТЕ ЭТО:

- Используйте переменные окружения
- Регулярно ротируйте API ключи
- Используйте приватные репозитории
- Настройте двухфакторную аутентификацию на GitHub

## 🔄 Обновления и поддержка

### Регулярные обновления

```bash
# Обновление зависимостей
npm update

# Проверка безопасности
npm audit

# Автоматическое исправление
npm audit fix
```

### Мониторинг

- Регулярно проверяйте логи GitHub Actions
- Следите за уведомлениями о безопасности
- Обновляйте зависимости при необходимости

## 📞 Поддержка

Если возникли проблемы:

1. **Проверьте логи**: `git log --oneline`
2. **Проверьте статус**: `git status`
3. **Проверьте remote**: `git remote -v`
4. **Создайте Issue** в репозитории

## 🎯 Следующие шаги

После успешной загрузки:

1. **Настройте GitHub Actions** (если нужно)
2. **Добавьте collaborators** (если работаете в команде)
3. **Настройте branch protection** для main ветки
4. **Создайте Issues** для планирования разработки
5. **Настройте автоматическое развертывание**

---

**Удачи с вашим проектом! 🚀** 
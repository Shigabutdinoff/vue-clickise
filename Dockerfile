# Используем базовый образ Node.js
FROM node:22-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем остальные файлы проекта
COPY . .

# Открываем порт для сервера разработки
EXPOSE 5173

# Команда по умолчанию для запуска Vue Dev Server
CMD ["npm", "run", "dev", "--", "--host"]

# Используем образ дистрибутив линукс Alpine с версией Node -14 Node.js
FROM node:20.12.2

# Указываем нашу рабочую дерикторию
WORKDIR /app

# Копируем package.json и package-lock.json внутрь контейнера
COPY package.json ./

# Устанавливаем зависимости
RUN yarn

# Копируем оставшееся приложение в контейнер
COPY . .

# Устанавливаем Prisma
RUN npm install -g prisma

# Генерируем Prisma client
RUN npx prisma generate
RUN npx prisma db migrate

# Копируем Prisma schema и URL базы данных в контейнер
COPY prisma/schema.prisma ./prisma/

# Открываем порт 3000 в нашем контейнере
EXPOSE 4400

# Запускаем сервер
CMD [ "yarn", "start" ]
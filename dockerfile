# Указываем базовый образ
FROM golang:1.22 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum для кэширования зависимостей

RUN go mod download

# Копируем код приложения
COPY . .

# Собираем приложение
RUN  go build -o myapp .

# Создаем финальный образ
FROM alpine:latest
# Копируем скомпилированное приложение из образа builder
COPY --from=builder /app/myapp .
COPY tracker.db .
# Определяем команду для запуска приложения
CMD ["./myapp"]
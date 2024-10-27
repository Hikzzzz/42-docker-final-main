# Указываем базовый образ
FROM golang:1.22 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum для кэширования зависимостей
COPY go.mod go.sum ./
RUN go mod download

# Копируем код приложения
COPY . .

# Собираем приложение
RUN  go build -o myapp .


# Создаем финальный образ
FROM alpine:latest




# Копируем скомпилированное приложение из образа builder
COPY --from=builder /app/myapp .




# Определяем команду для запуска приложения
CMD ["./myapp"]
# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . /app

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Открываем порт 8000
EXPOSE 8000

# Применяем миграции и создаем суперпользователя (опционально)
RUN python manage.py migrate

# Запускаем сервер
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

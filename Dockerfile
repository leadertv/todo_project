# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем переменные окружения для Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Устанавливаем зависимости системы
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы зависимостей
COPY requirements.txt /app/

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальные файлы проекта
COPY . /app/

# Собираем статические файлы
RUN python manage.py collectstatic --noinput

# Применяем миграции
RUN python manage.py migrate

# Открываем порт 8000
EXPOSE 8000

# Применяем миграции и создаем суперпользователя (опционально)
RUN python manage.py migrate

# Запускаем сервер с использованием Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "todo_project.wsgi:application"]

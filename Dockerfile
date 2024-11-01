# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем переменные окружения для Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Копируем файл зависимостей
COPY requirements.txt /app/

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект
COPY . /app/

# Копируем скрипт entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Устанавливаем точку входа
ENTRYPOINT ["/entrypoint.sh"]

# Открываем порт 8000
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "todo_project.wsgi:application"]

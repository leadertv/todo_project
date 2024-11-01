# Приложение "Список задач" на Django

## Описание

Это простое приложение на Django, предоставляющее REST API для управления списком задач (To-Do List). Вы можете создавать, просматривать, обновлять и удалять задачи через API. Приложение контейнеризовано с помощью Docker для удобства развертывания и запуска.

---

## Содержание

- [Описание](#описание)
- [Технологии](#технологии)
- [Установка и запуск](#установка-и-запуск)
  - [Предварительные требования](#предварительные-требования)
  - [Сборка Docker-образа](#сборка-docker-образа)
  - [Запуск контейнера](#запуск-контейнера)
  - [Применение миграций](#применение-миграций)
- [Использование API](#использование-api)
  - [Базовый URL](#базовый-url)
  - [Эндпоинты](#эндпоинты)
    - [Получить список задач](#получить-список-задач)
    - [Создать новую задачу](#создать-новую-задачу)
    - [Получить задачу по ID](#получить-задачу-по-id)
    - [Обновить задачу](#обновить-задачу)
    - [Удалить задачу](#удалить-задачу)
- [Примеры запросов](#примеры-запросов)
  - [Использование Postman](#использование-postman)
  - [Использование VS Code REST Client](#использование-vs-code-rest-client)
- [Переменные окружения](#переменные-окружения)
- [Структура проекта](#структура-проекта)


---

## Технологии

- Python 3.9
- Django 3.2
- Django REST Framework
- Docker
- Docker Compose
- PostgreSQL

---

## Установка и запуск

### Предварительные требования

- Установленный [Docker](https://www.docker.com/get-started).
- ИЛИ curl https://get.docker.com | sh
- Порт `8000` и `80` должен быть свободен на вашем компьютере.

### Сборка Docker-образа

Клонируйте репозиторий и перейдите в каталог проекта:

```bash
git clone https://github.com/leadertv/todo_project.git
cd todo_project
```

Соберите Docker-образ:

```bash
docker compose up --build
```

### Запуск контейнера через Docker Compose

- Заходим в папку /todo-tasks/
- Отредактируйте файл .env
- Билдим образ `docker compose up --build` если до этого не делали
- Запускаем: `docker compose up -d` если не запущен
- Подтянется NGINX, PostgreSQL  и Само приложение.


### Применение миграций
Миграции делаются автоматически через entrypoint.sh скрипт
Если миграции не были применены автоматически, выполните команду:

```bash
docker exec -it todo-container python3 manage.py migrate
```

---

## Использование API

### Базовый URL

```
http://localhost/api/tasks/
```
Из вне
```
http://IP/api/tasks/
```
Порт указывать не обязательно.

### Эндпоинты

#### Получить список задач

**Запрос:**

```
GET /api/tasks/
```

**Ответ:**

```json
[
  {
    "id": 1,
    "title": "Купить продукты",
    "description": "Молоко, хлеб, яйца",
    "completed": false
  },
  {
    "id": 2,
    "title": "Изучить Docker",
    "description": "Прочитать документацию",
    "completed": false
  }
]
```

#### Создать новую задачу

**Запрос:**

```
POST /api/tasks/
Content-Type: application/json
```

**Тело запроса:**

```json
{
  "title": "Изучить Django",
  "description": "Изучить основы Django и REST Framework",
  "completed": false
}
```

**Ответ:**

```json
{
  "id": 3,
  "title": "Изучить Django",
  "description": "Изучить основы Django и REST Framework",
  "completed": false
}
```

#### Получить задачу по ID

**Запрос:**

```
GET /api/tasks/1/
```

**Ответ:**

```json
{
  "id": 1,
  "title": "Купить продукты",
  "description": "Молоко, хлеб, яйца",
  "completed": false
}
```

#### Обновить задачу

**Запрос:**

```
PUT /api/tasks/1/
Content-Type: application/json
```

**Тело запроса:**

```json
{
  "title": "Купить продукты и фрукты",
  "description": "Молоко, хлеб, яйца, яблоки",
  "completed": false
}
```

**Ответ:**

```json
{
  "id": 1,
  "title": "Купить продукты и фрукты",
  "description": "Молоко, хлеб, яйца, яблоки",
  "completed": false
}
```

#### Удалить задачу

**Запрос:**

```
DELETE /api/tasks/1/
```

**Ответ:**

- HTTP статус `204 No Content`

---

## Примеры запросов

### Использование Postman

Порт указывать не нужно или не обязательно

1. **Получить список задач**

   - **Метод:** GET
   - **URL:** `http://localhost:80/api/tasks/`

2. **Создать новую задачу**

   - **Метод:** POST
   - **URL:** `http://localhost:80/api/tasks/`
   - **Headers:**
     - `Content-Type: application/json`
   - **Body (Raw JSON):**

     ```json
     {
       "title": "Изучить Docker",
       "description": "Прочитать документацию и попробовать примеры",
       "completed": false
     }
     ```

3. **Обновить задачу**

   - **Метод:** PUT
   - **URL:** `http://localhost:80/api/tasks/1/`
   - **Headers:**
     - `Content-Type: application/json`
   - **Body (Raw JSON):**

     ```json
     {
       "title": "Изучить Docker и Kubernetes",
       "description": "Прочитать документацию и попробовать примеры",
       "completed": true
     }
     ```

4. **Удалить задачу**

   - **Метод:** DELETE
   - **URL:** `http://localhost:80/api/tasks/1/`

### Использование VS Code REST Client

Создайте файл `requests.http` и добавьте следующие запросы:

```http
### Получить список задач
GET http://localhost:80/api/tasks/
Accept: application/json

###

### Создать новую задачу
POST http://localhost:80/api/tasks/
Content-Type: application/json

{
  "title": "Изучить Docker",
  "description": "Прочитать документацию и попробовать примеры",
  "completed": false
}

###

### Обновить задачу
PUT http://localhost:80/api/tasks/1/
Content-Type: application/json

{
  "title": "Изучить Docker и Kubernetes",
  "description": "Прочитать документацию и попробовать примеры",
  "completed": true
}

###

### Удалить задачу
DELETE http://localhost:80/api/tasks/1/
```

---

## Переменные окружения .env

Приложение использует переменные окружения для конфигурации:

- `SECRET_KEY` — секретный ключ Django (обязателен).
- `DEBUG` — режим отладки (`True` или `False`).
- `ALLOWED_HOSTS` — список разрешенных хостов, разделенных запятыми (например, `localhost,127.0.0.1`).

## Структура проекта

```
todo_project/
├── tasks/
│   ├── __init__.py
│   ├── admin.py
│   ├── apps.py
│   ├── migrations/
│   │   └── __init__.py
│   ├── models.py
│   ├── serializers.py
│   ├── tests.py
│   ├── views.py
│   └── urls.py
├── todo_project/
│   ├── __init__.py
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── .gitignore
└── README.md
```

---


ARG PYTHON_VERSION=3.11.9
FROM python:${PYTHON_VERSION}-slim as base


WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000


RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && apt-get clean

RUN pip install mysqlclient==2.2.7


CMD ["sh","-c","python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

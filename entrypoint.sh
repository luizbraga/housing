#!/usr/bin/env bash


until python manage.py migrate
do
    echo "Waiting for postgres..."
    sleep 2
done
python manage.py collectstatic --noinput

exec gunicorn housing.wsgi:application \
    --name housing \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --log-level=info

#!/usr/bin/env bash

git pull

docker compose pull

docker compose up -d --remove-orphans

docker compose exec app /app/bin/migrate

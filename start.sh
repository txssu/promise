#!/usr/bin/env bash

git pull

docker compose pull

docker compose up -d --remove-orphans

docker exec promise_app /app/bin/migrate

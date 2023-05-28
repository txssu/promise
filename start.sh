#!/usr/bin/env bash

docker compose up -d --remove-orphans

docker exec promise_app /app/bin/migrate

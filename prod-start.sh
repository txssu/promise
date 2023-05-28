#!/usr/bin/env bash

export MIX_ENV=prod

echo "Update dependencies..."
mix deps.get --only prod > /dev/null

echo "Compile..."
mix compile > /dev/null

echo "Compile assets..."
mix assets.deploy > /dev/null

mix release --overwrite

docker compose up -d --remove-orphans --build

docker exec promise_app /app/bin/migrate

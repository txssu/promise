#!/usr/bin/env bash

export MIX_ENV=prod

echo "Get dependencies..."
mix deps.get --only prod > /dev/null

echo "Compile..."
mix compile > /dev/null

echo "Compile assets..."
mix assets.deploy > /dev/null

mix release

docker compose up -d --remove-orphans --build

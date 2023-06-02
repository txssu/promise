#!/usr/bin/env bash

export MIX_ENV=prod

echo "Update dependencies..."
mix deps.get --only prod > /dev/null

echo "Compile..."
mix compile > /dev/null

echo "Compile assets..."
mix assets.deploy > /dev/null

mix release --overwrite

docker build . -t ghcr.io/waika28/promise:latest

docker push ghcr.io/waika28/promise:latest

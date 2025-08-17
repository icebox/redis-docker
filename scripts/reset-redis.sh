#!/usr/bin/env bash
set -euo pipefail

echo ">>> Stopping containers..."
docker compose down -v

echo ">>> Removing volumes..."
docker volume rm -f redis-docker_redis_data || true
docker volume rm -f redis-docker_redisinsight_data || true

echo ">>> Rebuilding containers..."
docker compose up -d --build

echo ">>> Redis environment reset complete!"

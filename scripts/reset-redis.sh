#!/usr/bin/env bash
set -euo pipefail

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
else
  echo "ERROR: .env file not found!"
  exit 1
fi

echo ">>> Stopping and removing containers + volumes..."
docker compose down -v

echo ">>> Rebuilding and starting fresh..."
docker compose up -d --build

echo ">>> Waiting for Redis to accept connections..."
for i in {1..20}; do
  if docker exec ${REDIS_CONTAINER_NAME} redis-cli -a "${REDIS_PASSWORD}" ping >/dev/null 2>&1; then
    echo ">>> Redis is ready."
    break
  fi
  sleep 1
done

echo ">>> DONE. Connect with:"
echo "    redis-cli -a ${REDIS_PASSWORD} -h localhost -p ${REDIS_PORT}"
echo "Or open RedisInsight at http://localhost:${REDISINSIGHT_PORT}"

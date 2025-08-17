#!/usr/bin/env bash
set -euo pipefail

# Load environment variables
export $(grep -v '^#' .env | xargs)

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="./backups/redis_dump_${TIMESTAMP}.rdb"

echo ">>> Creating Redis backup..."
docker exec -t "${REDIS_CONTAINER_NAME}" \
  sh -c 'redis-cli -a "$REDIS_PASSWORD" SAVE'

echo ">>> Copying dump file..."
docker cp "${REDIS_CONTAINER_NAME}":/data/dump.rdb "$BACKUP_FILE"

echo ">>> Backup saved to $BACKUP_FILE"

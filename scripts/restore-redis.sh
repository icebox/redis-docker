#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: ./scripts/restore-redis.sh <backup_file>"
  exit 1
fi

BACKUP_FILE=$1

# Load environment variables
export $(grep -v '^#' .env | xargs)

if [ ! -f "$BACKUP_FILE" ]; then
  echo ">>> Backup file not found: $BACKUP_FILE"
  exit 1
fi

echo ">>> Stopping Redis container..."
docker stop "${REDIS_CONTAINER_NAME}"

echo ">>> Copying backup file into container..."
docker cp "$BACKUP_FILE" "${REDIS_CONTAINER_NAME}":/data/dump.rdb

echo ">>> Restarting Redis container..."
docker start "${REDIS_CONTAINER_NAME}"

echo ">>> Restore complete!"

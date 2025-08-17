#!/usr/bin/env bash
set -euo pipefail

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
else
  echo "ERROR: .env file not found!"
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "Usage: $0 <backup-file>"
  exit 1
fi

BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
  echo "ERROR: Backup file not found: $BACKUP_FILE"
  exit 1
fi

echo ">>> Stopping Redis container..."
docker compose stop redis

echo ">>> Copying backup into container..."
docker cp "${BACKUP_FILE}" ${REDIS_CONTAINER_NAME}:/data/dump.rdb

echo ">>> Restarting Redis..."
docker compose start redis

echo ">>> Restore complete. Redis is running with backup data."

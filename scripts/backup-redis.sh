#!/usr/bin/env bash
set -euo pipefail

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
else
  echo "ERROR: .env file not found!"
  exit 1
fi

BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/dump-${TIMESTAMP}.rdb"

mkdir -p "${BACKUP_DIR}"

echo ">>> Forcing Redis to persist to disk..."
docker exec ${REDIS_CONTAINER_NAME} redis-cli -a "${REDIS_PASSWORD}" save

echo ">>> Copying dump.rdb from container..."
docker cp ${REDIS_CONTAINER_NAME}:/data/dump.rdb "${BACKUP_FILE}"

echo ">>> Backup complete: ${BACKUP_FILE}"

#!/bin/bash
set -euo pipefail

UCRM_PATH="/home/ucrm"
COMPOSE_FILE="${UCRM_PATH}/docker-compose.yml"

if [[ ! -f "${COMPOSE_FILE}" ]]; then
    echo "Error: ${COMPOSE_FILE} not found. Is UCRM installed?"
    exit 1
fi

echo "Migrating ucrm_version.version column to text..."
docker compose -f "${COMPOSE_FILE}" exec -T postgresql \
    psql -U ucrm -d ucrm -c \
    "ALTER TABLE ucrm_version ALTER COLUMN version TYPE text;"

echo "Done."

#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

# CloudNova Enterprise Cloud - Database Backup
# Required: Docker Compose, MariaDB container, and database credentials in .env

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${PROJECT_DIR:-$SCRIPT_DIR}"
BACKUP_DIR="${BACKUP_DIR:-$PROJECT_DIR/backups}"
LOG_FILE="$BACKUP_DIR/backup.log"
RETENTION_DAYS="${RETENTION_DAYS:-7}"

mkdir -p "$BACKUP_DIR"
touch "$LOG_FILE"

log() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

fail() {
    log "ERROR: $*"
    exit 1
}

# Load environment variables without displaying their values.
if [[ ! -f "$PROJECT_DIR/.env" ]]; then
    fail "Missing .env file in $PROJECT_DIR"
fi

set -a
# shellcheck disable=SC1091
source "$PROJECT_DIR/.env"
set +a

: "${MYSQL_DATABASE:?MYSQL_DATABASE must be set in .env}"
: "${MYSQL_USER:?MYSQL_USER must be set in .env}"
: "${MYSQL_PASSWORD:?MYSQL_PASSWORD must be set in .env}"

cd "$PROJECT_DIR"

if ! docker compose ps --status running --services | grep -qx 'db'; then
    fail "The db service is not running. Start the stack before backing up."
fi

TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
TEMP_FILE="$BACKUP_DIR/nextcloud_db_${TIMESTAMP}.sql.gz.tmp"
FINAL_FILE="$BACKUP_DIR/nextcloud_db_${TIMESTAMP}.sql.gz"

cleanup() {
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

log "Starting database backup."

if ! docker compose exec -T 
    -e MYSQL_PWD="$MYSQL_PASSWORD" db 
    mariadb-dump 
    --user="$MYSQL_USER" 
    --single-transaction 
    --quick 
    "$MYSQL_DATABASE" | gzip > "$TEMP_FILE"; then
    fail "Database dump failed."
fi

if [[ ! -s "$TEMP_FILE" ]] || ! gzip -t "$TEMP_FILE"; then
    fail "Backup file is empty or invalid."
fi

mv "$TEMP_FILE" "$FINAL_FILE"
chmod 600 "$FINAL_FILE"

find "$BACKUP_DIR" -maxdepth 1 -type f 
    -name 'nextcloud_db_*.sql.gz' 
    -mtime "+$RETENTION_DAYS" -delete

log "SUCCESS: Backup created at $FINAL_FILE"
log "Old backups older than $RETENTION_DAYS days were checked for removal."

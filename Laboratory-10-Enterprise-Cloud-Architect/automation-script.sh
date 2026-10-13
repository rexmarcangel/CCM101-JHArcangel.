```bash
#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

# CloudNova Enterprise Cloud - Database Backup
# Requires Docker Compose, MariaDB, and credentials in .env

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

# Check required tools.
command -v docker >/dev/null 2>&1 || fail "Docker is not installed."
command -v gzip >/dev/null 2>&1 || fail "gzip is not installed."

# Validate retention setting.
if ! [[ "$RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
    fail "RETENTION_DAYS must be a non-negative integer."
fi

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

# Ensure the database service is running.
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

# Dump the database and compress it.
if docker compose exec -T \
    -e MYSQL_PWD="$MYSQL_PASSWORD" \
    db mariadb-dump \
    --user="$MYSQL_USER" \
    --single-transaction \
    --quick \
    "$MYSQL_DATABASE" | gzip > "$TEMP_FILE"; then
    :
else
    fail "Database dump or compression failed."
fi

# Verify that the compressed backup is valid and non-empty.
if [[ ! -s "$TEMP_FILE" ]] || ! gzip -t "$TEMP_FILE"; then
    fail "Backup file is empty or invalid."
fi

# Keep the completed backup private.
mv "$TEMP_FILE" "$FINAL_FILE"
chmod 600 "$FINAL_FILE"

log "SUCCESS: Backup created at $FINAL_FILE"

# Remove old completed database backups.
find "$BACKUP_DIR" -maxdepth 1 -type f \
    -name 'nextcloud_db_*.sql.gz' \
    -mtime "+$RETENTION_DAYS" -delete

log "Old backups older than $RETENTION_DAYS days were checked for removal."
log "Database backup process finished."
```

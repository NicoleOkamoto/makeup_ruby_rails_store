#!/bin/bash
set -e

# Restore the database from the backup
echo "Restoring the database..."
if [ -f /rails/db/backups/spree_starter_test_backup.dump ]; then
  echo "Backup file found, restoring..."
  PGPASSWORD=$DB_PASSWORD pg_restore --verbose --clean --no-acl --no-owner -h $DB_HOST -U $DB_USERNAME -d $DB_NAME /rails/db/backups/spree_starter_test_backup.dump
else
  echo "Backup file not found, skipping restore."
fi

# Run database migrations
echo "Running database migrations..."
bundle exec rails db:migrate

# Start the Rails server
exec "$@"

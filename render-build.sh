#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing dependencies..."
bundle install --without development test

echo "Precompiling assets..."
bundle exec rails assets:precompile

echo "Running migrations..."
bundle exec rails db:migrate

echo "Seeding database (if needed)..."
bundle exec rails db:seed || echo "Seeding skipped or failed"

echo "Build completed successfully!"

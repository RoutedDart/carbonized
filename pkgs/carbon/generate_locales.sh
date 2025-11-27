#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting Locale Generation Process..."

# Navigate to php_app directory where docker-compose.yml is located
cd php_app

echo "🧹 Cleaning old JSON files..."
# Run inside docker to ensure path consistency with the container volumes
docker compose run --rm phpapp sh -c "rm -f /workspace/lib/src/core/locales/json/*.json"

echo "📦 Exporting locales from PHP Carbon to JSON..."
docker compose run --rm phpapp php scripts/export_locales_to_json.php

echo "🔨 Generating Dart files from JSON..."
docker compose run --rm phpapp php scripts/generate_dart_from_json.php

# Return to root directory
cd ..

echo "✨ Formatting generated Dart code..."
dart format lib/src/core/locales/generated/
dart fix --apply

echo "🔍 Running Dart Analyze..."
# We allow analyze to fail (it might just have infos) but it's good to show output
dart analyze || true

echo "🧪 Running Dart Tests..."
dart test

echo "✅ Done!"

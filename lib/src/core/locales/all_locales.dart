part of '../../carbon.dart';

// All locales are now generated from PHP Carbon locale files
// See php_app/scripts/export_locales_to_json.php and generate_dart_from_json.php
//
// To regenerate locales:
// 1. cd php_app
// 2. docker compose run --rm phpapp php scripts/export_locales_to_json.php
// 3. docker compose run --rm phpapp php scripts/generate_dart_from_json.php

// Use the generated locales directly (815 locales from PHP Carbon)
final Map<String, CarbonLocaleData> allLocales = generatedLocales;

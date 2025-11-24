# Locale Auto-Generation

This document explains how to auto-generate Dart locale files from PHP Carbon locale files.

## Generator Script

Location: `php_app/scripts/generate_dart_locales.php`

The script:
1. Scans all PHP locale files in `php_app/vendor/nesbot/carbon/src/Carbon/Lang/`
2. Groups regional variants with their base locale (e.g., `ar_EG`, `ar_SA` grouped with `ar`)
3. Generates one Dart file per base locale containing the base + all regional variants
4. Creates `copyWith()` calls for regional variants that only override differing fields
5. Generates an index file (`all_generated.dart`) with imports and the `generatedLocales` map

## Usage

Generate the first 20 locales (for testing):
```bash
cd php_app
docker compose run --rm phpapp php scripts/generate_dart_locales.php
```

The script currently stops after 20 locales. To generate ALL 815 locales, edit the script and remove/increase the limit on line ~260.

## Generated Structure

### Individual Locale Files
Example: `lib/src/core/locales/generated/locale_ar.dart`
```dart
const CarbonLocaleData localeAr = CarbonLocaleData(...);

// Regional variant: ar_EG
final CarbonLocaleData localeArEg = localeAr.copyWith(
  localeCode: 'ar_eg',
  weekdaysShort: [...], // Only overrides that differ
);
```

### Index File
`lib/src/core/locales/generated/all_generated.dart`:
```dart
part 'locale_aa.dart';
part 'locale_af.dart';
...

final Map<String, CarbonLocaleData> generatedLocales = {
  'aa': localeAa,
  'ar': localeAr,
  'ar_eg': localeArEg,
  ...
};
```

## Statistics

- **280 base locales** (languages without regional suffix)
- **535 regional variants** (locale_REGION format)
- **815 total locales** available for generation
- Test run generated **20 base locales + 44 regional variants**

## Integration

To use generated locales in your code, they need to be registered with `CarbonTranslator`. The index file provides a `generatedLocales` map that can be bulk-registered.

## Future Improvements

1. **Function generation**: Auto-convert ordinal/meridiem PHP functions to Dart
2. **Incremental builds**: Only regenerate changed locales
3. **CI/CD integration**: Run generator automatically on PHP Carbon updates
4. **Type safety**: Add stronger typing for locale data validation

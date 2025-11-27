<?php

/**
 * Phase 2: JSON → Dart
 * Generates Dart locale files from normalized JSON
 */

$jsonDir = __DIR__ . '/../../lib/src/core/locales/json';
$outputDir = __DIR__ . '/../../lib/src/core/locales/generated';

// Create output directory
if (!is_dir($outputDir)) {
    mkdir($outputDir, 0755, true);
}

function jsonValueToDart($value, $indent = 2) {
    $indentStr = str_repeat(' ', $indent);
    
    if (is_string($value)) {
        // Double escape backslashes for Dart strings
        $escaped = str_replace('\\', '\\\\', $value);
        // Then escape quotes
        $escaped = str_replace("'", "\\'", $escaped);
        // Escape $ for Dart interpolation
        $escaped = str_replace('$', '\$', $escaped);
        return "'$escaped'";
    }
    
    if (is_int($value) || is_float($value)) {
        return (string)$value;
    }
    
    if (is_bool($value)) {
        return $value ? 'true' : 'false';
    }
    
    if (is_array($value)) {
        if (array_keys($value) === range(0, count($value) - 1)) {
            // List
            $items = array_map(fn($v) => jsonValueToDart($v, $indent), $value);
            if (count($items) > 3) {
                $sep = ",\n$indentStr  ";
                return "[\n$indentStr  " . implode($sep, $items) . ",\n$indentStr]";
            }
            return '[' . implode(', ', $items) . ']';
        } else {
            // Map
            $pairs = [];
            foreach ($value as $k => $v) {
                $key = jsonValueToDart($k, $indent);
                $val = jsonValueToDart($v, $indent + 2);
                $pairs[] = "$key: $val";
            }
            if (count($pairs) > 2) {
                $sep = ",\n$indentStr  ";
                return "{\n$indentStr  " . implode($sep, $pairs) . ",\n$indentStr}";
            }
            return '{' . implode(', ', $pairs) . '}';
        }
    }
    
    return 'null';
}

function generateDartLocaleFromJson($localeCode, $jsonData) {
    // Sanitize locale code for Dart variable name (replace @ with _At or remove it)
    // e.g., "aa_ER@saaho" becomes "aa_ER_saaho" for variable name
    $sanitizedForVarName = str_replace('@', '_', $localeCode);
    $constName = 'locale' . str_replace('_', '', ucwords(strtolower($sanitizedForVarName), '_'));
    
    // Keep original locale code for the localeCode field
    $normalizedCode = strtolower(str_replace('-', '_', $localeCode));
    
    $dart = "const CarbonLocaleData $constName = CarbonLocaleData(\n";
    $dart .= "  localeCode: '$normalizedCode',\n";
    
    // Map JSON keys to Dart field names
    $fieldMap = [
        'translationStrings' => 'translationStrings',
        'formats' => 'formats',
        'months' => 'months',
        'monthsStandalone' => 'monthsStandalone',
        'monthsShort' => 'monthsShort',
        'weekdays' => 'weekdays',
        'weekdaysShort' => 'weekdaysShort',
        'weekdaysMin' => 'weekdaysMin',
        'firstDayOfWeek' => 'firstDayOfWeek',
        'dayOfFirstWeekOfYear' => 'dayOfFirstWeekOfYear',
        'ordinalWords' => 'ordinalWords',
        'calendar' => 'calendar',
        'list' => 'listSeparators',
        'periodRecurrences' => 'periodRecurrences',
        'periodInterval' => 'periodInterval',
        'periodStartDate' => 'periodStartDate',
        'periodEndDate' => 'periodEndDate',
    ];
    
    foreach ($fieldMap as $jsonKey => $dartKey) {
        if (isset($jsonData[$jsonKey])) {
            $value = jsonValueToDart($jsonData[$jsonKey], 2);
            $dart .= "  $dartKey: $value,\n";
        }
    }
    
    // Don't reference functions here - they'll be added to file later
    
    // Add ordinal function if present
    if (isset($jsonData['ordinal_function'])) {
        $dart .= "  ordinal: _ordinal,\n";
    }
    
    // Add meridiem function if present (either from function or array)
    if (isset($jsonData['meridiem_function'])) {
        $dart .= "  meridiem: _meridiem,\n";
    } elseif (isset($jsonData['meridiem']) && is_array($jsonData['meridiem'])) {
        $dart .= "  meridiem: _meridiem,\n";
    }
    
    // Add default calendar formats if not provided (matches PHP Carbon's internal defaults)
    if (!isset($jsonData['calendar']) || empty($jsonData['calendar'])) {
        $dart .= "  calendar: {\n";
        $dart .= "    'sameDay': '[Today at] LT',\n";
        $dart .= "    'nextDay': '[Tomorrow at] LT',\n";
        $dart .= "    'nextWeek': 'dddd [at] LT',\n";
        $dart .= "    'lastDay': '[Yesterday at] LT',\n";
        $dart .= "    'lastWeek': '[Last] dddd [at] LT',\n";
        $dart .= "    'sameElse': 'L',\n";
        $dart .= "  },\n";
    }
    
    $dart .= ");\n";
    
    return $dart;
}

function camelCase($str) {
    return lcfirst(str_replace('_', '', ucwords($str, '_')));
}

// Find all base locales (no underscore) and their regional variants
$baseLocales = [];
$regionalVariants = [];

$files = scandir($jsonDir);
foreach ($files as $file) {
    if ($file === '.' || $file === '..' || !str_ends_with($file, '.json')) {
        continue;
    }
    
    $localeCode = basename($file, '.json');
    
    if (strpos($localeCode, '_') === false) {
        // Base locale
        $baseLocales[] = $localeCode;
    } else {
        // Regional variant
        $parts = explode('_', $localeCode);
        $base = $parts[0];
        if (!isset($regionalVariants[$base])) {
            $regionalVariants[$base] = [];
        }
        $regionalVariants[$base][] = $localeCode;
    }
}

sort($baseLocales);

echo "Found " . count($baseLocales) . " base locales\n";
echo "Found " . array_sum(array_map('count', $regionalVariants)) . " regional variants\n\n";

// Process all base locales
$processedCount = 0;
$indexImports = [];
$indexMap = [];

foreach ($baseLocales as $locale) {
    $jsonFile = "$jsonDir/$locale.json";
    
    if (!file_exists($jsonFile)) {
        continue;
    }
    
    $jsonData = json_decode(file_get_contents($jsonFile), true);
    if (!$jsonData) {
        echo "Skipped $locale (invalid JSON)\n";
        continue;
    }
    
    // Generate file content
    $fileContent = "// AUTO-GENERATED from PHP Carbon locale: $locale\n";
    $fileContent .= "// Do not edit - changes will be overwritten\n\n";
    $fileContent .= "import 'package:carbon/carbon.dart';\n\n";
    
    // Generate base locale
    $fileContent .= generateDartLocaleFromJson($locale, $jsonData);
    $fileContent .= "\n";
    
    // Add to index
    $constName = 'locale' . str_replace('_', '', ucwords(strtolower($locale), '_'));
    $indexImports[] = "locale_$locale.dart";
    $indexMap[$locale] = $constName;
    
    // Generate regional variants if any
    if (isset($regionalVariants[$locale])) {
        foreach ($regionalVariants[$locale] as $regional) {
            $regionalJsonFile = "$jsonDir/$regional.json";
            if (!file_exists($regionalJsonFile)) {
                continue;
            }
            
            $regionalData = json_decode(file_get_contents($regionalJsonFile), true);
            if (!$regionalData) {
                continue;
            }
            
            // Sanitize @ character for Dart variable name
            $sanitizedRegional = str_replace('@', '_', $regional);
            $regionalConst = 'locale' . str_replace('_', '', ucwords(strtolower($sanitizedRegional), '_'));
            
            // Generate copyWith for regional variant
            $fileContent .= "// Regional variant: $regional\n";
            $fileContent .= "final CarbonLocaleData $regionalConst = $constName.copyWith(\n";
            $fileContent .= "  localeCode: '" . strtolower(str_replace('-', '_', $regional)) . "',\n";
            
            // Only include fields that differ from parent
            $diffFields = [];
            $fieldMap = [
                'translationStrings' => 'translationStrings',
                'formats' => 'formats',
                'months' => 'months',
                'monthsStandalone' => 'monthsStandalone',
                'monthsShort' => 'monthsShort',
                'weekdays' => 'weekdays',
                'weekdaysShort' => 'weekdaysShort',
                'weekdaysMin' => 'weekdaysMin',
                'firstDayOfWeek' => 'firstDayOfWeek',
                'dayOfFirstWeekOfYear' => 'dayOfFirstWeekOfYear',
                'ordinalWords' => 'ordinalWords',
                'calendar' => 'calendar',
                'list' => 'listSeparators',
                'periodRecurrences' => 'periodRecurrences',
                'periodInterval' => 'periodInterval',
                'periodStartDate' => 'periodStartDate',
                'periodEndDate' => 'periodEndDate',
            ];
            foreach (['weekdays', 'weekdaysShort', 'weekdaysMin', 'months', 'monthsShort', 'monthsStandalone', 'calendar', 'ordinalWords', 'list', 'periodRecurrences', 'periodInterval', 'periodStartDate', 'periodEndDate'] as $field) {
                if (isset($regionalData[$field]) && (!isset($jsonData[$field]) || $regionalData[$field] !== $jsonData[$field])) {
                    $diffFields[$field] = jsonValueToDart($regionalData[$field], 2);
                }
            }
            
            foreach ($diffFields as $field => $value) {
                $dartKey = $fieldMap[$field] ?? $field;
                $fileContent .= "  $dartKey: $value,\n";
            }
            
            $fileContent .= ");\n\n";
            
            $indexMap[strtolower(str_replace('-', '_', $regional))] = $regionalConst;
        }
    }
    
    // Add function definitions at the end of the file
    if (isset($jsonData['ordinal_function']) && !empty($jsonData['ordinal_function'])) {
        $fileContent .= "\n// Auto-generated ordinal function\n";
        $fileContent .= "String _ordinal(int number, String period) {\n";
        $fileContent .= $jsonData['ordinal_function'];
        $fileContent .= "}\n";
    }
    
    if (isset($jsonData['meridiem_function']) && !empty($jsonData['meridiem_function'])) {
        $fileContent .= "\n// Auto-generated meridiem function\n";
        $fileContent .= "String _meridiem(int hour, dynamic minute, dynamic isLower) {\n";
        $fileContent .= $jsonData['meridiem_function'];
        $fileContent .= "}\n";
    } elseif (isset($jsonData['meridiem']) && is_array($jsonData['meridiem'])) {
        // Generate simple meridiem function from array
        $am = addslashes($jsonData['meridiem'][0] ?? 'AM');
        $pm = addslashes($jsonData['meridiem'][1] ?? 'PM');
        $fileContent .= "\n// Auto-generated meridiem function from array\n";
        $fileContent .= "String _meridiem(int hour, dynamic minute, dynamic isLower) {\n";
        $fileContent .= "  return hour < 12 ? '$am' : '$pm';\n";
        $fileContent .= "}\n";
    }
    
    // Write file
    $filename = "locale_$locale.dart";
    file_put_contents("$outputDir/$filename", $fileContent);
    
    echo "Generated: $filename\n";
    $processedCount++;
}

// Generate index file
$indexContent = "// AUTO-GENERATED - Do not edit\n";
$indexContent .= "// This file imports all generated locales and builds the allLocales map\n\n";
$indexContent .= "import 'package:carbon/carbon.dart';\n\n";

foreach ($indexImports as $import) {
    $indexContent .= "import '$import';\n";
}

$indexContent .= "\n// Map of all generated locales\n";
$indexContent .= "final Map<String, CarbonLocaleData> generatedLocales = {\n";

foreach ($indexMap as $key => $const) {
    $indexContent .= "  '$key': $const,\n";
}

$indexContent .= "};\n";

file_put_contents("$outputDir/all_generated.dart", $indexContent);

echo "\n✓ Generated $processedCount locale files\n";
echo "✓ Generated index file: all_generated.dart\n";

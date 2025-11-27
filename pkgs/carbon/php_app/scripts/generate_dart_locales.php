<?php

/**
 * Locale Generator - Converts PHP Carbon locale files to Dart
 * 
 * This script reads PHP locale files and generates individual Dart files per locale.
 */

require __DIR__ . '/../vendor/autoload.php';

$langDir = __DIR__ . '/../vendor/nesbot/carbon/src/Carbon/Lang';
$outputDir = __DIR__ . '/../../lib/src/core/locales/generated';

// Create output directory if it doesn't exist
if (!is_dir($outputDir)) {
    mkdir($outputDir, 0755, true);
}

function parseLocaleFile($filepath) {
    try {
        $data = require $filepath;
        return is_array($data) ? $data : null;
    } catch (Exception $e) {
        return null;
    }
}

function phpValueToDart($value, $indent = 2) {
    $indentStr = str_repeat(' ', $indent);
    
    if (is_string($value)) {
        $escaped = addslashes($value);
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
            $items = array_map(fn($v) => phpValueToDart($v, $indent), $value);
            if (count($items) > 3) {
                $sep = ",\n$indentStr  ";
                return "[\n$indentStr  " . implode($sep, $items) . ",\n$indentStr]";
            }
            return '[' . implode(', ', $items) . ']';
        } else {
            // Map
            $pairs = [];
            foreach ($value as $k => $v) {
                $key = phpValueToDart($k, $indent);
                $val = phpValueToDart($v, $indent + 2);
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

function generateDartLocaleConst($localeCode, $data, $isRegional = false) {
    $constName = 'locale' . str_replace('_', '', ucwords(strtolower($localeCode), '_'));
    $normalizedCode = strtolower(str_replace('-', '_', $localeCode));
    
    if ($isRegional) {
        return "const CarbonLocaleData $constName = $constName;\n";
    }
    
    $dart = "const CarbonLocaleData $constName = CarbonLocaleData(\n";
    $dart .= "  localeCode: '$normalizedCode',\n";
    
    // Translation strings
    $hasTranslations = false;
    $translationKeys = ['year', 'a_year', 'y', 'month', 'a_month', 'm', 'week', 'a_week', 'w',
                        'day', 'a_day', 'd', 'hour', 'a_hour', 'h', 'minute', 'a_minute', 'min',
                        'second', 'a_second', 's', 'ago', 'from_now', 'after', 'before',
                        'diff_now', 'diff_today', 'diff_yesterday', 'diff_tomorrow',
                        'diff_before_yesterday', 'diff_after_tomorrow'];
    
    $translations = [];
    foreach ($translationKeys as $key) {
        if (isset($data[$key]) && is_string($data[$key])) {
            $translations[$key] = $data[$key];
            $hasTranslations = true;
        }
    }
    
    if ($hasTranslations) {
        $dart .= "  translationStrings: " . phpValueToDart($translations, 2) . ",\n";
    }
    
    // Other fields
    $fields = [
        'formats' => 'formats',
        'months' => 'months',
        'months_short' => 'monthsShort',
        'weekdays' => 'weekdays',
        'weekdays_short' => 'weekdaysShort',
        'weekdays_min' => 'weekdaysMin',
        'first_day_of_week' => 'firstDayOfWeek',
        'day_of_first_week_of_year' => 'dayOfFirstWeekOfYear',
    ];
    
    foreach ($fields as $phpKey => $dartKey) {
        if (isset($data[$phpKey])) {
            // Skip callable fields - they need manual handling
            if (is_callable($data[$phpKey])) {
                continue;
            }
            
            $value = phpValueToDart($data[$phpKey], 2);
            $dart .= "  $dartKey: $value,\n";
        }
    }
    
    $dart .= ");\n";
    
    return $dart;
}

// Find all base locales (no underscore) and their regional variants
$baseLocales = [];
$regionalVariants = [];

$files = scandir($langDir);
foreach ($files as $file) {
    if ($file === '.' || $file === '..' || !str_ends_with($file, '.php')) {
        continue;
    }
    
    $localeCode = basename($file, '.php');
    
    // Skip special characters like @ in locale codes for now
    if (strpos($localeCode, '@') !== false) {
        continue;
    }
    
    if (strpos($localeCode, '_') === false) {
        // Base locale
        $baseLocales[] = $localeCode;
    } else {
        // Regional variant - group by base
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
    $filepath = "$langDir/$locale.php";
    
    if (!file_exists($filepath)) {
        continue;
    }
    
    $data = parseLocaleFile($filepath);
    if ($data === null) {
        echo "Skipped $locale (invalid data)\n";
        continue;
    }
    
    // Generate file content
    $fileContent = "// AUTO-GENERATED from PHP Carbon locale: $locale\n";
    $fileContent .= "// Do not edit - changes will be overwritten\n\n";
    $fileContent .= "import 'package:carbon/carbon.dart';\n\n";
    
    // Generate base locale
    $fileContent .= generateDartLocaleConst($locale, $data);
    $fileContent .= "\n";
    
    // Add to index
    $constName = 'locale' . str_replace('_', '', ucwords(strtolower($locale), '_'));
    $indexImports[] = "locale_$locale.dart";
    $indexMap[$locale] = $constName;
    
    // Generate regional variants if any
    if (isset($regionalVariants[$locale])) {
        foreach ($regionalVariants[$locale] as $regional) {
            $regionalPath = "$langDir/$regional.php";
            $regionalData = parseLocaleFile($regionalPath);
            
            if ($regionalData === null) {
                continue;
            }
            
            $regionalConst = 'locale' . str_replace('_', '', ucwords(strtolower($regional), '_'));
            
            // Check if it's just a reference to parent or has custom data
            // If the data is different, generate a copyWith
            $fileContent .= "// Regional variant: $regional\n";
            $fileContent .= "final CarbonLocaleData $regionalConst = $constName.copyWith(\n";
            $fileContent .= "  localeCode: '" . strtolower(str_replace('-', '_', $regional)) . "',\n";
            
            // Only include fields that differ from parent
            $diffFields = [];
            foreach (['weekdays', 'weekdays_short', 'weekdays_min', 'months', 'months_short'] as $field) {
                if (isset($regionalData[$field]) && (!isset($data[$field]) || $regionalData[$field] !== $data[$field])) {
                    $dartField = str_replace('_short', 'Short', str_replace('_min', 'Min', $field));
                    $dartField = str_replace('_', '', ucwords($dartField, '_'));
                    $dartField = lcfirst($dartField);
                    $diffFields[$dartField] = phpValueToDart($regionalData[$field], 2);
                }
            }
            
            foreach ($diffFields as $field => $value) {
                $fileContent .= "  $field: $value,\n";
            }
            
            $fileContent .= ");\n\n";
            
            $indexMap[strtolower(str_replace('-', '_', $regional))] = $regionalConst;
        }
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

<?php

/**
 * Phase 1: PHP → JSON
 * Executes all PHP locale files and exports to normalized JSON
 */

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

// Load the PHP→Dart converter
require __DIR__ . '/php_to_dart_converter.php';

echo "Starting locale export to JSON...\n\n";

// Create converter instance
$converter = new PhpToDartConverter();

$langDir = __DIR__ . '/../vendor/nesbot/carbon/src/Carbon/Lang';
$outputDir = __DIR__ . '/../../lib/src/core/locales/json';

// Create output directory if it doesn't exist
if (!is_dir($outputDir)) {
    mkdir($outputDir, 0755, true);
}

function extractLocaleData($localeCode, $langDir, $converter) {
    try {
        $localeFilePath = "$langDir/$localeCode.php";
        if (!file_exists($localeFilePath)) {
            return null;
        }
        
        $localeFileData = require $localeFilePath;
        if (!is_array($localeFileData)) {
            return null;
        }
        
        $data = [];
        
        // Get translation strings - extract ALL string keys
        $translations = [];
        foreach ($localeFileData as $key => $value) {
            // Skip non-string keys and special keys
            if (!is_string($key) || in_array($key, ['formats', 'calendar', 'months', 'months_short', 'months_standalone', 'weekdays', 'weekdays_short', 'weekdays_min', 'ordinal', 'meridiem', 'list'])) {
                continue;
            }
            
            // Only include simple string values (skip callables)
            if (is_string($value)) {
                $translations[$key] = $value;
            } elseif (is_callable($value) && in_array($key, ['ago', 'from_now', 'after', 'before'])) {
                try {
                    $translations[$key] = $value(':time');
                } catch (\Throwable $e) {
                    // Ignore if it fails
                }
            }
        }
        
        if (!empty($translations)) {
            $data['translationStrings'] = $translations;
        }
        
        // Get formats
        if (isset($localeFileData['formats']) && is_array($localeFileData['formats'])) {
            $data['formats'] = $localeFileData['formats'];
        }
        
        // Get months
        if (isset($localeFileData['months']) && is_array($localeFileData['months'])) {
            $data['months'] = array_values($localeFileData['months']);
        }
        
        // Get short months with mmm_suffix if present
        if (isset($localeFileData['months_short']) && is_array($localeFileData['months_short'])) {
            $monthsShort = array_values($localeFileData['months_short']);
            $mmmSuffix = isset($localeFileData['mmm_suffix']) && is_string($localeFileData['mmm_suffix']) ? $localeFileData['mmm_suffix'] : null;
            
            // If mmm_suffix exists and is not the translation key itself, append it
            // (The check $mmmSuffix !== 'mmm_suffix' is for cases where the key itself is returned if no translation is found)
            if ($mmmSuffix && $mmmSuffix !== 'mmm_suffix') {
                $monthsShort = array_map(function($month) use ($mmmSuffix) {
                    return $month . $mmmSuffix;
                }, $monthsShort);
            }
            $data['monthsShort'] = $monthsShort;
        }
        
        // Get standalone months
        if (isset($localeFileData['months_standalone']) && is_array($localeFileData['months_standalone'])) {
            $data['monthsStandalone'] = array_values($localeFileData['months_standalone']);
        }
        
        // Get weekdays from locale file directly (handles callables properly)
        if (isset($localeFileData['weekdays'])) {
            $weekdayData = $localeFileData['weekdays'];
            if (is_array($weekdayData)) {
                $data['weekdays'] = array_values($weekdayData);
            } elseif (is_callable($weekdayData)) {
                // For callables (like Ukrainian/Russian), call with nominative case
                $weekdays = [];
                for ($i = 0; $i < 7; $i++) {
                    $value = $weekdayData(Carbon::now()->startOfWeek()->addDays($i), '', $i);
                    $weekdays[] = $value;
                }
                $data['weekdays'] = $weekdays;
            }
        }
        
        // Extract weekdays_short
        if (isset($localeFileData['weekdays_short']) && is_array($localeFileData['weekdays_short'])) {
            $data['weekdaysShort'] = array_values($localeFileData['weekdays_short']);
        }

        // Extract calendar
        if (isset($localeFileData['calendar']) && is_array($localeFileData['calendar'])) {
            $data['calendar'] = array_filter($localeFileData['calendar'], 'is_string');
        }

        // Extract ordinal_words
        if (isset($localeFileData['ordinal_words']) && is_array($localeFileData['ordinal_words'])) {
            $data['ordinalWords'] = $localeFileData['ordinal_words'];
        }

        // Extract list
        if (isset($localeFileData['list']) && is_array($localeFileData['list'])) {
            $data['list'] = array_values($localeFileData['list']);
        }

        // Extract period strings
        foreach (['period_recurrences', 'period_interval', 'period_start_date', 'period_end_date'] as $key) {
            if (isset($localeFileData[$key]) && is_string($localeFileData[$key])) {
                $data[lcfirst(str_replace(' ', '', ucwords(str_replace('_', ' ', $key))))] = $localeFileData[$key];
            }
        }
        
        // Extract weekdays_min
        if (isset($localeFileData['weekdays_min']) && is_array($localeFileData['weekdays_min'])) {
            $data['weekdaysMin'] = array_values($localeFileData['weekdays_min']);
        }
        
        // Get week settings
        if (isset($localeFileData['first_day_of_week'])) {
            $data['firstDayOfWeek'] = $localeFileData['first_day_of_week'];
        }
        
        if (isset($localeFileData['day_of_first_week_of_year'])) {
            $data['dayOfFirstWeekOfYear'] = $localeFileData['day_of_first_week_of_year'];
        }
        
        // Extract function metadata using AST conversion
        // Ordinal function
        if (isset($localeFileData['ordinal']) && is_callable($localeFileData['ordinal'])) {
            try {
                $reflection = new ReflectionFunction($localeFileData['ordinal']);
                $filename = $reflection->getFileName();
                $startLine = $reflection->getStartLine() - 1;
                $endLine = $reflection->getEndLine();
                $length = $endLine - $startLine;
                
                $source = file($filename);
                $body = implode("", array_slice($source, $startLine, $length));
                
                // Strip array key assignment if present (e.g. 'ordinal' => ...)
                $body = preg_replace('/^\s*[\'"]\w+[\'"]\s*=>\s*/', '', $body);
                
                // Determine if it's an Arrow Function (fn) or Closure (function)
                $isArrow = false;
                if (str_contains($body, ' fn ') || str_contains($body, 'static fn') || str_starts_with(trim($body), 'fn')) {
                    $isArrow = true;
                }
                
                if ($isArrow && preg_match('/=>\s*(.+)$/s', $body, $matches)) {
                    // Arrow function
                    $functionBody = trim($matches[1]);
                    // Remove trailing semicolon and comma and whitespace using regex
                    $functionBody = preg_replace('/[;,]\s*$/', '', $functionBody);
                    
                    // Strip 'static' keyword if present in the original body to avoid parser issues
                    // We don't need to strip it from $functionBody because $functionBody is just the expression
                    // But convertFunction wraps it. If we pass the expression, convertFunction wraps it in `function() { return $expr; }`.
                    // So we don't need to strip static from $functionBody.
                    
                    // Try to convert to Dart
                    $dartCode = $converter->convertFunction($functionBody);
                    
                    if ($dartCode) {
                        if (str_contains($dartCode, 'Parse Error')) {
                            echo "Parse Error for $localeCode: $dartCode\nInput Body: $functionBody\nHex Body: " . bin2hex($functionBody) . "\n";
                            // Do NOT save parse error
                        } else {
                            $data['ordinal_function'] = $dartCode;
                        }
                    } else {
                        echo "Failed to convert Arrow Function for $localeCode: $functionBody\n";
                    }
                } elseif (preg_match('/\{(.+)\}/s', $body, $matches)) {
                    // Closure (fallback)
                    $functionBody = trim($matches[1]);
                    
                    // Try to convert to Dart
                    $dartCode = $converter->convertFunction($functionBody);
                    
                    if ($dartCode) {
                        $data['ordinal_function'] = $dartCode;
                    }
                }
            } catch (Exception $e) {
                // Skip if conversion fails
            }
        }
        
        // Meridiem function
        if (isset($localeFileData['meridiem']) && is_callable($localeFileData['meridiem'])) {
            try {
                $reflection = new ReflectionFunction($localeFileData['meridiem']);
                $filename = $reflection->getFileName();
                $startLine = $reflection->getStartLine() - 1;
                $endLine = $reflection->getEndLine();
                $length = $endLine - $startLine;
                
                $source = file($filename);
                $body = implode("", array_slice($source, $startLine, $length));
                
                // Strip array key assignment if present (e.g. 'meridiem' => ...)
                $body = preg_replace('/^\s*[\'\"]\w+[\'\"]\s*=>\s*/', '', $body);
                
                // Determine if it's an Arrow Function (fn) or Closure (function)
                $isArrow = false;
                if (str_contains($body, ' fn ') || str_contains($body, 'static fn') || str_starts_with(trim($body), 'fn')) {
                    $isArrow = true;
                }
                
                if ($isArrow && preg_match('/=>\s*(.+)$/s', $body, $matches)) {
                    // Arrow function
                    $functionBody = trim($matches[1]);
                    // Remove trailing semicolon and comma and whitespace using regex
                    $functionBody = preg_replace('/[;,]\s*$/', '', $functionBody);
                    
                    // Try to convert to Dart
                    $dartCode = $converter->convertFunction($functionBody);
                    
                    if ($dartCode) {
                        if (str_contains($dartCode, 'Parse Error')) {
                            echo "Parse Error for $localeCode (Meridiem): $dartCode\nInput Body: $functionBody\nRaw Body: $body\nMatches: " . print_r($matches, true) . "\n";
                            // Do NOT save parse error
                        } else {
                            $data['meridiem_function'] = $dartCode;
                        }
                    } else {
                         echo "Failed to convert Arrow Function for $localeCode (Meridiem): $functionBody\n";
                    }
                } elseif (preg_match('/\{(.+)\}/s', $body, $matches)) {
                    // Closure (fallback)
                    $functionBody = trim($matches[1]);
                    
                    // Try to convert to Dart
                    $dartCode = $converter->convertFunction($functionBody);
                    
                    if ($dartCode) {
                        $data['meridiem_function'] = $dartCode;
                    }
                }
            } catch (Exception $e) {
                // Skip if conversion fails
            }
        } elseif (isset($localeFileData['meridiem']) && is_array($localeFileData['meridiem'])) {
            // Meridiem array (e.g., [0 => 'AM', 1 => 'PM'] or ['ص', 'م'])
            $data['meridiem'] = $localeFileData['meridiem'];
        }
        
        
        // Ordinal words (static mapping)
        if (isset($localeFileData['ordinal_words']) && is_array($localeFileData['ordinal_words'])) {
            $data['ordinalWords'] = $localeFileData['ordinal_words'];
        }
        
        return $data;
        
    } catch (Exception $e) {
        echo "Error processing $localeCode: " . $e->getMessage() . "\n";
        return null;
    }
}

// Process all locales
$files = scandir($langDir);
$processed = 0;
$skipped = 0;

foreach ($files as $file) {
    if ($file === '.' || $file === '..' || !str_ends_with($file, '.php')) {
        continue;
    }
    
    $localeCode = basename($file, '.php');
    
    echo "Processing: $localeCode\n";
    
    $data = extractLocaleData($localeCode, $langDir, $converter);
    
    // Debug for @ locales
    if (strpos($localeCode, '@') !== false) {
        echo "  [@locale] Data is " . (($data && !empty($data)) ? "NOT empty" : "empty") . "\n";
        if ($data) {
            echo "  [@locale] Keys: " . implode(', ', array_keys($data)) . "\n";
        }
    }
    
    if ($data && !empty($data)) {
        $jsonFile = "$outputDir/$localeCode.json";
        file_put_contents($jsonFile, json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
        $processed++;
    } else {
        echo "  Skipped '$localeCode' (no data)\n";
        $skipped++;
    }
}

echo "\n✓ Processed $processed locales to JSON\n";
echo "✗ Skipped $skipped locales\n";

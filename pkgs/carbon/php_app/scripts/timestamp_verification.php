<?php
/**
 * Verification script to confirm PHP and Dart Carbon represent the same moment in time
 * despite different hour property values
 */

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

echo "=== Timestamp Verification: PHP Carbon ===\n\n";

// Test Case 1: The example with hour difference
echo "Test 1: Standard timezone parsing\n";
echo "Input: '2019-02-01T03:45:27.612584' with timezone 'Europe/Paris'\n";
$dt1 = Carbon::parse('2019-02-01T03:45:27.612584', 'Europe/Paris');
echo "Local hour (Paris): " . $dt1->hour . "\n";
echo "UTC hour: " . $dt1->utc()->hour . "\n";
echo "Unix timestamp: " . $dt1->timestamp . "\n";
echo "Milliseconds since epoch: " . ($dt1->timestamp * 1000 + $dt1->millisecond) . "\n";
echo "ISO 8601: " . $dt1->toIso8601String() . "\n";
echo "\n";

// Test Case 2: Parsing with Z (UTC)
echo "Test 2: UTC parsing\n";
echo "Input: '2019-02-01T03:45:27.612584Z'\n";
$dt2 = Carbon::parse('2019-02-01T03:45:27.612584Z');
echo "Hour: " . $dt2->hour . "\n";
echo "Unix timestamp: " . $dt2->timestamp . "\n";
echo "Milliseconds since epoch: " . ($dt2->timestamp * 1000 + $dt2->millisecond) . "\n";
echo "\n";

// Test Case 3: Explicit UTC vs Paris time
echo "Test 3: Same moment in different timezones\n";
$utc = Carbon::parse('2019-02-01T02:45:27.612584Z', 'UTC');
$paris = Carbon::parse('2019-02-01T03:45:27.612584', 'Europe/Paris');
echo "UTC hour: " . $utc->hour . "\n";
echo "Paris hour: " . $paris->hour . "\n";
echo "UTC timestamp: " . $utc->timestamp . "\n";
echo "Paris timestamp: " . $paris->timestamp . "\n";
echo "Timestamps match: " . ($utc->timestamp === $paris->timestamp ? 'YES' : 'NO') . "\n";
echo "Same instant (eq): " . ($utc->eq($paris) ? 'YES' : 'NO') . "\n";
echo "\n";

// Test Case 4: Show timezone offset
echo "Test 4: Timezone offset information\n";
$dt4 = Carbon::parse('2019-02-01T03:45:27.612584', 'Europe/Paris');
echo "Timezone: " . $dt4->timezoneName . "\n";
echo "Offset in hours: " . ($dt4->offsetHours) . "\n";
echo "Offset in seconds: " . $dt4->offset . "\n";
echo "Local hour: " . $dt4->hour . "\n";
echo "UTC hour: " . $dt4->copy()->utc()->hour . "\n";
echo "Calculation check: " . $dt4->hour . " - " . $dt4->offsetHours . " = " . ($dt4->hour - $dt4->offsetHours) . " (should be UTC hour)\n";
echo "\n";

// Test Case 5: Multiple timezones for same moment
echo "Test 5: Same moment, different representations\n";
$base = Carbon::parse('2019-02-01T12:00:00Z');
echo "Original (UTC): " . $base->toIso8601String() . " | hour=" . $base->hour . "\n";
echo "In New York: " . $base->copy()->setTimezone('America/New_York')->toIso8601String() . " | hour=" . $base->copy()->setTimezone('America/New_York')->hour . "\n";
echo "In Tokyo: " . $base->copy()->setTimezone('Asia/Tokyo')->toIso8601String() . " | hour=" . $base->copy()->setTimezone('Asia/Tokyo')->hour . "\n";
echo "In Paris: " . $base->copy()->setTimezone('Europe/Paris')->toIso8601String() . " | hour=" . $base->copy()->setTimezone('Europe/Paris')->hour . "\n";
echo "All timestamps: " . $base->timestamp . " (all should be same)\n";
echo "\n";

// Summary
echo "=== Key Observations ===\n";
echo "1. PHP Carbon's 'hour' property returns the LOCAL hour in the timezone\n";
echo "2. To get UTC hour, use ->utc()->hour or ->copy()->utc()->hour\n";
echo "3. Timestamps are always the same regardless of timezone representation\n";
echo "4. The same moment in time can have different hour values in different timezones\n";
echo "5. ISO 8601 strings include offset to disambiguate\n";

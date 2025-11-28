<?php
/**
 * Test script to verify PHP Carbon's behavior for microsecond precision with timezones
 * This corresponds to the Dart tests in timezone_microseconds_test.dart
 */

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

echo "=== PHP Carbon Microsecond + Timezone Behavior ===\n\n";

// Test 1: Parse microseconds with named timezone (the original failing case)
echo "Test 1: Parse microseconds with named timezone\n";
echo "Input: '2019-02-01T03:45:27.612584' with timezone 'Europe/Paris'\n";
$result1 = Carbon::parse('2019-02-01T03:45:27.612584', 'Europe/Paris');
echo "Microsecond: " . $result1->microsecond . "\n";
echo "Millisecond: " . $result1->millisecond . "\n";
echo "Timezone: " . $result1->timezoneName . "\n";
echo "ISO String: " . $result1->toIso8601String() . "\n";
echo "Hour: " . $result1->hour . "\n";
echo "Minute: " . $result1->minute . "\n";
echo "Second: " . $result1->second . "\n";
echo "Expected microsecond: 612584\n";
echo "Expected millisecond: 612\n";
echo "\n";

// Test 2: Large microsecond values (999999)
echo "Test 2: Large microsecond values\n";
echo "Input: '2019-02-01T03:45:27.999999' with timezone 'America/New_York'\n";
$result2 = Carbon::parse('2019-02-01T03:45:27.999999', 'America/New_York');
echo "Microsecond: " . $result2->microsecond . "\n";
echo "Millisecond: " . $result2->millisecond . "\n";
echo "Timezone: " . $result2->timezoneName . "\n";
echo "Expected microsecond: 999999\n";
echo "Expected millisecond: 999\n";
echo "\n";

// Test 3: Zero microseconds
echo "Test 3: Zero microseconds with timezone\n";
echo "Input: '2019-02-01T03:45:27.000000' with timezone 'Asia/Tokyo'\n";
$result3 = Carbon::parse('2019-02-01T03:45:27.000000', 'Asia/Tokyo');
echo "Microsecond: " . $result3->microsecond . "\n";
echo "Millisecond: " . $result3->millisecond . "\n";
echo "Timezone: " . $result3->timezoneName . "\n";
echo "Expected microsecond: 0\n";
echo "Expected millisecond: 0\n";
echo "\n";

// Test 4: Partial microsecond precision (1 digit after decimal)
echo "Test 4: Partial microsecond precision\n";
echo "Input: '2019-02-01T03:45:27.5' with timezone 'UTC'\n";
$result4 = Carbon::parse('2019-02-01T03:45:27.5', 'UTC');
echo "Microsecond: " . $result4->microsecond . "\n";
echo "Millisecond: " . $result4->millisecond . "\n";
echo "Expected microsecond: 500000\n";
echo "Expected millisecond: 500\n";
echo "\n";

// Test 5: Timezone conversion preserves microseconds
echo "Test 5: Timezone conversion preserves microseconds\n";
echo "Input: '2019-02-01T03:45:27.123456Z' with timezone 'UTC'\n";
$original = Carbon::parse('2019-02-01T03:45:27.123456Z', 'UTC');
echo "Original microsecond: " . $original->microsecond . "\n";
echo "Original millisecond: " . $original->millisecond . "\n";
$converted = $original->copy()->setTimezone('Europe/London');
echo "Converted timezone: " . $converted->timezoneName . "\n";
echo "Converted microsecond: " . $converted->microsecond . "\n";
echo "Converted millisecond: " . $converted->millisecond . "\n";
echo "Expected: microseconds preserved (123456)\n";
echo "\n";

// Test 6: Fixed offset timezone with microseconds
echo "Test 6: Fixed offset timezone (+05:30)\n";
echo "Input: '2019-02-01T03:45:27.500000' with timezone '+05:30'\n";
$result6 = Carbon::parse('2019-02-01T03:45:27.500000', '+05:30');
echo "Microsecond: " . $result6->microsecond . "\n";
echo "Millisecond: " . $result6->millisecond . "\n";
echo "Timezone: " . $result6->timezoneName . "\n";
echo "Expected microsecond: 500000\n";
echo "Expected millisecond: 500\n";
echo "\n";

// Test 7: Negative fixed offset timezone
echo "Test 7: Negative fixed offset timezone (-04:00)\n";
echo "Input: '2019-02-01T03:45:27.750000' with timezone '-04:00'\n";
$result7 = Carbon::parse('2019-02-01T03:45:27.750000', '-04:00');
echo "Microsecond: " . $result7->microsecond . "\n";
echo "Millisecond: " . $result7->millisecond . "\n";
echo "Timezone: " . $result7->timezoneName . "\n";
echo "Expected microsecond: 750000\n";
echo "Expected millisecond: 750\n";
echo "\n";

// Test 8: createFromFormat with microseconds
echo "Test 8: createFromFormat with microseconds\n";
echo "Format: 'Y-m-d H:i:s.u'\n";
echo "Input: '2019-02-01 03:45:27.123456' with timezone 'Europe/Paris'\n";
$result8 = Carbon::createFromFormat('Y-m-d H:i:s.u', '2019-02-01 03:45:27.123456', 'Europe/Paris');
echo "Microsecond: " . $result8->microsecond . "\n";
echo "Millisecond: " . $result8->millisecond . "\n";
echo "Timezone: " . $result8->timezoneName . "\n";
echo "Expected microsecond: 123456\n";
echo "Expected millisecond: 123\n";
echo "\n";

// Test 9: Edge case - microseconds at millisecond boundary
echo "Test 9: Microseconds at millisecond boundary\n";
echo "Input: '2019-02-01T03:45:27.000999' with timezone 'UTC'\n";
$result9 = Carbon::parse('2019-02-01T03:45:27.000999', 'UTC');
echo "Microsecond: " . $result9->microsecond . "\n";
echo "Millisecond: " . $result9->millisecond . "\n";
echo "Expected microsecond: 999\n";
echo "Expected millisecond: 0\n";
echo "\n";

// Test 10: The docs example case (carbonize)
echo "Test 10: Docs example - carbonize\n";
echo "Input: '2019-02-01T03:45:27.612584' with timezone 'Europe/Paris'\n";
$base = Carbon::parse('2019-02-01T03:45:27.612584', 'Europe/Paris');
echo "Base microsecond: " . $base->microsecond . "\n";
echo "Base timezone: " . $base->timezoneName . "\n";
echo "Base ISO: " . $base->toIso8601String() . "\n";

// Carbonize a date string (should inherit timezone)
$fromString = $base->carbonize('2019-03-21');
echo "Carbonized '2019-03-21':\n";
echo "  Timezone: " . $fromString->timezoneName . "\n";
echo "  ISO: " . $fromString->toIso8601String() . "\n";
echo "\n";

// Summary
echo "=== Summary ===\n";
echo "All tests completed. Compare these values with Dart Carbon implementation.\n";
echo "\nKey observations:\n";
echo "- PHP Carbon's microsecond property returns 0-999999 (total within second)\n";
echo "- PHP Carbon's millisecond property returns 0-999 (total within second)\n";
echo "- Microseconds should be preserved across timezone operations\n";

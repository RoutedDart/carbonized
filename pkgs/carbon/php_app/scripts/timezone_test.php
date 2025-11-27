<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

// Set timezone database
date_default_timezone_set('UTC');

// Get current time in UTC
$now = Carbon::now('UTC');

echo "=== PHP Carbon Timezone Test ===\n";
echo "Current UTC time: " . $now->format('Y-m-d H:i:s') . "\n\n";

$cities = [
    ['name' => 'New York', 'tz' => 'America/New_York'],
    ['name' => 'London', 'tz' => 'Europe/London'],
    ['name' => 'Tokyo', 'tz' => 'Asia/Tokyo'],
    ['name' => 'Sydney', 'tz' => 'Australia/Sydney'],
    ['name' => 'Dubai', 'tz' => 'Asia/Dubai'],
    ['name' => 'Los Angeles', 'tz' => 'America/Los_Angeles'],
];

foreach ($cities as $city) {
    $cityTime = $now->copy()->tz($city['tz']);
    $offset = $cityTime->format('P'); // Timezone offset in +HH:MM format
    $offsetSeconds = $cityTime->getOffset(); // Offset in seconds
    
    echo $city['name'] . ":\n";
    echo "  Time: " . $cityTime->format('H:i:s') . "\n";
    echo "  Date: " . $cityTime->format('M d, Y') . "\n";
    echo "  Timezone: " . $city['tz'] . "\n";
    echo "  Offset (P format): " . $offset . "\n";
    echo "  Offset (seconds): " . $offsetSeconds . "\n";
    echo "  Offset (hours): " . ($offsetSeconds / 3600) . "\n";
    echo "\n";
}

// Test start of day calculations
echo "=== Start of Day Test ===\n";
$startOfDay = $now->copy()->startOfDay();
echo "Now: " . $now->format('Y-m-d H:i:s') . "\n";
echo "Start of day: " . $startOfDay->format('Y-m-d H:i:s') . "\n";
echo "Diff in hours: " . $startOfDay->diffInHours($now) . "\n";
echo "Diff in minutes: " . $startOfDay->diffInMinutes($now) . "\n";
echo "diffForHumans: " . $startOfDay->diffForHumans() . "\n";
echo "\n";

// Test start of week
echo "=== Start of Week Test ===\n";
$startOfWeek = $now->copy()->startOfWeek();
echo "Start of week: " . $startOfWeek->format('Y-m-d H:i:s') . "\n";
echo "Diff in days: " . $startOfWeek->diffInDays($now) . "\n";
echo "diffForHumans: " . $startOfWeek->diffForHumans() . "\n";
echo "\n";

// Test end of day
echo "=== End of Day Test ===\n";
$endOfDay = $now->copy()->endOfDay();
echo "End of day: " . $endOfDay->format('Y-m-d H:i:s') . "\n";
echo "diffForHumans: " . $endOfDay->diffForHumans() . "\n";
echo "\n";

<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;
use Carbon\CarbonPeriod;
use Carbon\CarbonInterval;

date_default_timezone_set('UTC');

// Set locale to English for consistent output
Carbon::setLocale('en');

echo "=== PHP CarbonPeriod toString() Tests ===\n\n";

// Test 1: Basic period with days
echo "Test 1: Basic period with days\n";
$start = Carbon::parse('2024-12-01T00:00:00Z');
$period1 = $start->daysUntil('2024-12-05T00:00:00Z');
echo "Period: " . (string)$period1 . "\n";
echo "Start: " . $period1->getStartDate()->toIso8601String() . "\n";
echo "End: " . $period1->getEndDate()->toIso8601String() . "\n";
echo "Recurrences: " . ($period1->getRecurrences() ?? 'null') . "\n";
echo "\n";

// Test 2: Period with explicit recurrences limit
echo "Test 2: Period with explicit recurrences limit\n";
$period2 = $start->daysUntil('2024-12-10T00:00:00Z')->setRecurrences(3);
echo "Period: " . (string)$period2 . "\n";
echo "Start: " . $period2->getStartDate()->toIso8601String() . "\n";
echo "End: " . $period2->getEndDate()->toIso8601String() . "\n";
echo "Recurrences: " . ($period2->getRecurrences() ?? 'null') . "\n";
echo "\n";

// Test 3: Period with months
echo "Test 3: Period with months\n";
$period3 = $start->monthsUntil('2025-03-01T00:00:00Z');
echo "Period: " . (string)$period3 . "\n";
echo "Start: " . $period3->getStartDate()->toIso8601String() . "\n";
echo "End: " . $period3->getEndDate()->toIso8601String() . "\n";
echo "\n";

// Test 4: Period created with CarbonPeriod::create()
echo "Test 4: Period created with CarbonPeriod::create()\n";
$period4 = CarbonPeriod::create('2024-12-01', '2024-12-05', CarbonInterval::days(1));
echo "Period: " . (string)$period4 . "\n";
echo "Start: " . $period4->getStartDate()->toIso8601String() . "\n";
echo "End: " . $period4->getEndDate()->toIso8601String() . "\n";
echo "\n";

// Test 5: Period with recurrences using CarbonPeriod::create()
echo "Test 5: Period with recurrences using CarbonPeriod::create()\n";
$period5 = CarbonPeriod::create('2024-12-01', 3, CarbonInterval::days(1));
echo "Period: " . (string)$period5 . "\n";
echo "Start: " . $period5->getStartDate()->toIso8601String() . "\n";
$endDate = $period5->getEndDate();
echo "End: " . ($endDate ? $endDate->toIso8601String() : 'null') . "\n";
echo "Recurrences: " . ($period5->getRecurrences() ?? 'null') . "\n";
echo "\n";

// Test 6: Empty period
echo "Test 6: Empty period\n";
$period6 = CarbonPeriod::create($start, $start);
echo "Period: " . (string)$period6 . "\n";
echo "Count: " . count($period6) . "\n";
echo "\n";

// Test 7: Different locale (French)
echo "Test 7: Period with French locale\n";
Carbon::setLocale('fr');
$period7 = Carbon::parse('2024-12-01T00:00:00Z')->daysUntil('2024-12-05T00:00:00Z');
echo "Period: " . (string)$period7 . "\n";
echo "\n";

// Test 8: Period with weeks
echo "Test 8: Period with weeks\n";
Carbon::setLocale('en');
$period8 = $start->weeksUntil('2024-12-15T00:00:00Z');
echo "Period: " . (string)$period8 . "\n";
echo "Start: " . $period8->getStartDate()->toIso8601String() . "\n";
echo "End: " . $period8->getEndDate()->toIso8601String() . "\n";
echo "\n";

echo "=== End of PHP Tests ===\n";

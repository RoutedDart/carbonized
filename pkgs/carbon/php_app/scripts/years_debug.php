<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;
$start = Carbon::parse('2000-02-15 12:00:00', 'UTC');
$end = Carbon::parse('2010-03-24 06:00:00', 'UTC');
$diff = $start->diff($end, false);
$years = (int)$diff->format('%y');
$floor = $start->copy()->addYears($years);
$ceil = $start->copy()->addYears($years + 1);
$daysToFloor = $floor->diffInDays($end);
$daysToCeil = $end->diffInDays($ceil);
$result = $years + $daysToFloor / ($daysToCeil + $daysToFloor);
echo json_encode([
  'years' => $years,
  'floor' => $floor->toIso8601String(),
  'ceil' => $ceil->toIso8601String(),
  'daysToFloor' => $daysToFloor,
  'daysToCeil' => $daysToCeil,
  'result' => $result,
], JSON_PRETTY_PRINT), "\n";

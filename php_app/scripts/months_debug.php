<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;
$start = Carbon::parse('2000-02-15 12:00:00', 'UTC');
$end = Carbon::parse('2010-03-24 06:00:00', 'UTC');
$monthsDiff = ($end->year - $start->year) * 12 + ($end->month - $start->month);
$dayStart = $start->format('dHisu');
$dayEnd = $end->format('dHisu');
if ($monthsDiff > 0) {
    $monthsDiff -= ($dayStart > $dayEnd ? 1 : 0);
} elseif ($monthsDiff < 0) {
    $monthsDiff += ($dayStart < $dayEnd ? 1 : 0);
}
$ascending = $start <= $end;
$sign = $ascending ? 1 : -1;
$absMonths = abs($monthsDiff);
if (!$ascending) {
    [$start, $end] = [$end, $start];
}
$floorEnd = $start->copy()->addMonths($absMonths);
$ceilEnd = $start->copy()->addMonths($absMonths + 1);
$daysToFloor = $floorEnd->diffInDays($end);
$daysToCeil = $end->diffInDays($ceilEnd);
$ratio = $daysToFloor / ($daysToCeil + $daysToFloor);
$monthsValue = $sign * ($absMonths + $ratio);
echo json_encode([
    'monthsDiff' => $monthsDiff,
    'dayStart' => $dayStart,
    'dayEnd' => $dayEnd,
    'floor' => $floorEnd->toIso8601String(),
    'ceil' => $ceilEnd->toIso8601String(),
    'daysToFloor' => $daysToFloor,
    'daysToCeil' => $daysToCeil,
    'ratio' => $ratio,
    'resultMonths' => $monthsValue,
    'resultYears' => $monthsValue / 12,
], JSON_PRETTY_PRINT), "\n";

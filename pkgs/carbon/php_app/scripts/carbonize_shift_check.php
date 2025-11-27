<?php

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;
use Carbon\CarbonImmutable;
use Carbon\CarbonInterval;
use Carbon\CarbonPeriod;

date_default_timezone_set('UTC');

$base = Carbon::parse('2019-02-01 03:45:27.612584', 'Europe/Paris');
$period = CarbonPeriod::create('2019-12-10', '2020-01-05');
$interval = CarbonInterval::days(3);
$duration = CarbonInterval::hours(12);

Carbon::setTestNow(Carbon::parse('2024-06-01 12:34:56', 'Asia/Tokyo'));
$carbonizeNull = $base->carbonize();
Carbon::setTestNow();

$immutableBase = CarbonImmutable::parse('2019-02-01 03:45:27', 'UTC');

$shiftBase = Carbon::parse('2024-11-10 00:00:00', 'UTC');
$shifted = $shiftBase->copy()->shiftTimezone('Asia/Tokyo');
$projected = $shiftBase->copy()->tz('Asia/Tokyo');
$shiftImmutable = CarbonImmutable::parse('2024-01-15 12:00:00', 'UTC')
    ->shiftTimezone('America/New_York');

$results = [
    'carbonize_string' => $base->carbonize('2019-03-21')
        ->format('Y-m-d\TH:i:s.uP'),
    'carbonize_period' => $base->carbonize($period)
        ->format('Y-m-d\TH:i:s.uP'),
    'carbonize_interval' => $base->carbonize($interval)
        ->format('Y-m-d\TH:i:s.uP'),
    'carbonize_duration' => $base->carbonize($duration)
        ->format('Y-m-d\TH:i:s.uP'),
    'carbonize_null' => [
        'iso' => $carbonizeNull->format('Y-m-d\TH:i:s.uP'),
        'tz' => $carbonizeNull->timezoneName,
    ],
    'carbonize_immutable' => $immutableBase->carbonize('2019-03-01')
        ->format('Y-m-d\TH:i:s.uP'),
    'shift_timezone' => [
        'shifted' => $shifted->format('Y-m-d\TH:i:s.uP'),
        'projected' => $projected->format('Y-m-d\TH:i:s.uP'),
        'immutable' => $shiftImmutable->format('Y-m-d\TH:i:s.uP'),
    ],
];

echo json_encode($results, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES), "\n";

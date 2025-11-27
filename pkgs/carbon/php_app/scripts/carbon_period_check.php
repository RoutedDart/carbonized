<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;
use Carbon\CarbonPeriod;
use Carbon\CarbonInterval;

date_default_timezone_set('UTC');

$period = CarbonPeriod::create('2024-12-23', '2025-01-05', CarbonInterval::days(1));
$weekdays = $period->filter(static function (Carbon $date) {
    return !$date->isWeekend();
})->recurrences(5);

foreach ($weekdays as $date) {
    echo $date->toIso8601String(), PHP_EOL;
}

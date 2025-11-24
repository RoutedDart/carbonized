<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;
use Carbon\CarbonInterval;

$tests = [
    'Interval (en)' => fn() => CarbonInterval::days(3)->hours(5)->forHumans(),
    'Interval (fr)' => fn() => CarbonInterval::days(3)->hours(5)->locale('fr')->forHumans(),
    '5 hours ago (en)' => fn() => Carbon::now()->subHours(5)->diffForHumans(),
    '5 hours ago (fr)' => fn() => Carbon::now()->subHours(5)->locale('fr')->diffForHumans(),
    '2 months ago (en)' => fn() => Carbon::now()->subMonths(2)->diffForHumans(),
    '2 months ago (fr)' => fn() => Carbon::now()->subMonths(2)->locale('fr')->diffForHumans(),
    '1 year ago (en)' => fn() => Carbon::now()->subYears(1)->diffForHumans(),
    '1 year ago (fr)' => fn() => Carbon::now()->subYears(1)->locale('fr')->diffForHumans(),
];

foreach ($tests as $name => $test) {
    printf("%-20s -> %s\n", $name, $test());
}

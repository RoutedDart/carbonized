<?php

declare(strict_types=1);

require __DIR__.'/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

$cases = [
    [
        'label' => 'seconds_a',
        'method' => 'floatDiffInSeconds',
        'start' => '06:01:23.252987',
        'end' => '06:02:34.321450',
    ],
    [
        'label' => 'minutes_a',
        'method' => 'floatDiffInMinutes',
        'start' => '06:01:23',
        'end' => '06:02:34',
    ],
    [
        'label' => 'hours_a',
        'method' => 'floatDiffInHours',
        'start' => '06:01:23',
        'end' => '06:02:34',
    ],
    [
        'label' => 'hours_negative',
        'method' => 'floatDiffInHours',
        'start' => '12:01:23',
        'end' => '06:02:34',
        'absolute' => false,
    ],
    [
        'label' => 'days_a',
        'method' => 'floatDiffInDays',
        'start' => '2000-01-01 12:00',
        'end' => '2000-02-11 06:00',
    ],
    [
        'label' => 'weeks_a',
        'method' => 'floatDiffInWeeks',
        'start' => '2000-01-01',
        'end' => '2000-02-11',
    ],
    [
        'label' => 'months_a',
        'method' => 'floatDiffInMonths',
        'start' => '2000-01-15',
        'end' => '2000-02-24',
    ],
    [
        'label' => 'months_b',
        'method' => 'floatDiffInMonths',
        'start' => '2000-02-15 12:00',
        'end' => '2000-03-24 06:00',
    ],
    [
        'label' => 'years_a',
        'method' => 'floatDiffInYears',
        'start' => '2000-02-15 12:00',
        'end' => '2010-03-24 06:00',
    ],
];

foreach ($cases as $case) {
    $start = Carbon::parse($case['start'], 'UTC');
    $end = $case['end'];
    $method = $case['method'];
    $absolute = $case['absolute'] ?? true;
    $value = $start->$method($end, $absolute);
    echo $case['label'], ':', number_format($value, 12, '.', ''), PHP_EOL;
}

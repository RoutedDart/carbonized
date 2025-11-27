<?php

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

$dt = Carbon::parse('2019-06-02 12:23:45', 'UTC');
$patterns = [
    '2019',
    '2018',
    '2019-06',
    '06-02',
    '2019-06-02',
    'Sunday',
    'June',
    '12:23',
    '12:23:45',
    '12:23:00',
    '12h',
    '3pm',
    '3am',
];

$results = [];
foreach ($patterns as $pattern) {
    $results[$pattern] = $dt->is($pattern);
}

echo json_encode($results, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES), "\n";

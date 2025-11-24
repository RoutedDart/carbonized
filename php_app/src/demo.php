<?php

declare(strict_types=1);

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

// Simple demo script mirroring the Dart Carbon samples.
$now = Carbon::now('UTC');

$report = [
    'now_utc' => $now->toIso8601String(),
    'next_week' => $now->copy()->addWeek()->startOfWeek()->toIso8601String(),
    'human_diff' => $now->copy()->subHours(5)->diffForHumans(),
];

fwrite(STDOUT, json_encode($report, JSON_PRETTY_PRINT) . PHP_EOL);

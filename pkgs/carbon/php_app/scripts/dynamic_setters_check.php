<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

$date = Carbon::parse('2024-01-01T12:00:00Z');
$date->set('year', 2003);
$date->set('dayOfYear', 35);
$date->set('timestamp', 169957925);

printf("year -> %s\n", $date->year);
printf("day of year -> %s\n", $date->dayOfYear);
printf("timestamp -> %s\n", $date->timestamp);
printf("iso -> %s\n", $date->toIso8601String());

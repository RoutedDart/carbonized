<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;
$date = Carbon::parse('2024-01-01 00:00:00');
$date->rawAdd(new DateInterval('P1D'));
printf("rawAdd -> %s\n", $date->toIso8601String());
$date->rawSub(new DateInterval('PT3H'));
printf("rawSub -> %s\n", $date->toIso8601String());

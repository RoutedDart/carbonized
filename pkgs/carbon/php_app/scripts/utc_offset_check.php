<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;

date_default_timezone_set('UTC');

$date = Carbon::parse('2024-01-01 00:00:00', 'UTC');
printf("initial offset -> %d\n", $date->utcOffset());
$date->utcOffset(180);
printf("after set -> %d\n", $date->utcOffset());
printf("timezone name -> %s\n", $date->tzName);

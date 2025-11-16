<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;
use Carbon\CarbonInterval;

$interval = CarbonInterval::days(3)->hours(5);
printf("forHumans -> %s\n", $interval->forHumans());

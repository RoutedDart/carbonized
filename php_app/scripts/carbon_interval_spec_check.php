<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\CarbonInterval;

$interval = CarbonInterval::days(2)->hours(5)->minutes(30);
printf("spec -> %s\n", $interval->spec());
printf("cascade -> %s\n", json_encode($interval->cascade()));

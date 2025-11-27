<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

Carbon::setLocale('fr');
$past = Carbon::parse('2024-06-05 12:00:00')->subMinutes(2);
$future = Carbon::parse('2024-06-05 12:00:00')->addDays(3);

printf("fr diff -> %s\n", $past->diffForHumans());
printf("fr future -> %s\n", $future->diffForHumans());

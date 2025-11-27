<?php
require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

$dt = Carbon::parse('2024-05-21T12:00:00Z', 'Europe/Paris');
$state = $dt->jsonSerialize();
$restored = Carbon::__set_state($state);
printf("state iso -> %s\n", $restored->toIso8601String());
printf("state locale -> %s\n", $restored->locale);

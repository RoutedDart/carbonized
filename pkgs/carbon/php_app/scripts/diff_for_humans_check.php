<?php

declare(strict_types=1);

require __DIR__.'/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

$now = Carbon::parse('2024-06-05 12:00:00');
$fiveHoursAgo = $now->copy()->subHours(5);
$nextWeek = $now->copy()->addWeek();

printf("five hours ago -> %s\n", $fiveHoursAgo->diffForHumans($now));
printf("relative to future -> %s\n", $now->diffForHumans($nextWeek));
printf("to future instant -> %s\n", $nextWeek->diffForHumans($now));

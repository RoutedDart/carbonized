<?php

declare(strict_types=1);

require __DIR__.'/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

$base = Carbon::parse('2012-01-15 12:00:00');
$earlier = $base->copy()
    ->subYears(2)
    ->subMonths(1)
    ->subDays(3)
    ->subHours(6);

$signed = $base->diffAsCarbonInterval($earlier, false);
$absolute = $base->diffAsCarbonInterval($earlier, true);

printf("signed_years:%d signed_months:%d signed_days:%d signed_hours:%d signed_invert:%d\n",
    $signed->years,
    $signed->months,
    $signed->days,
    $signed->hours,
    $signed->invert
);
printf("absolute_years:%d absolute_months:%d absolute_days:%d absolute_hours:%d absolute_invert:%d\n",
    $absolute->years,
    $absolute->months,
    $absolute->days,
    $absolute->hours,
    $absolute->invert
);

printf("diff_in_unit_months:%0.12f\n", $base->diffInUnit('months', $earlier));
printf("diff_in_unit_hours_signed:%0.12f\n", $earlier->diffInUnit('hours', $base, false));

<?php

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;
use Carbon\CarbonImmutable;

Carbon::setLocale('en');
$date = Carbon::parse('2024-06-05 00:00:00', 'UTC');

$defaultDays = $date->getDaysFromStartOfWeek();
$withSunday = $date->getDaysFromStartOfWeek(Carbon::SUNDAY);
$monday = $date->copy()->setDaysFromStartOfWeek(0)->format('c');
$tuesday = $date->copy()->setDaysFromStartOfWeek(2, Carbon::SUNDAY)->format('c');
$immutable = CarbonImmutable::parse('2024-06-05', 'UTC')
    ->setDaysFromStartOfWeek(1, Carbon::SUNDAY)->format('c');

$weekDefault = $date->week();
$weekCustom = $date->week(null, Carbon::MONDAY, 6);
$weekSet = $date->copy()->week(5)->format('c');
$isoWeekValue = $date->isoWeek();
$isoWeekSet = $date->copy()->isoWeek(2)->format('c');

echo json_encode([
    'default' => $defaultDays,
    'sunday' => $withSunday,
    'set_default' => $monday,
    'set_sunday' => $tuesday,
    'immutable' => $immutable,
    'week' => [
        'value' => $weekDefault,
        'custom' => $weekCustom,
        'set' => $weekSet,
    ],
    'iso_week' => [
        'value' => $isoWeekValue,
        'set' => $isoWeekSet,
    ],
], JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES), "\n";

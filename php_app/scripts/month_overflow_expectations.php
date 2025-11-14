<?php

declare(strict_types=1);

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

function describe(string $label, Carbon $carbon): array {
    return [
        'label' => $label,
        'iso' => $carbon->toIso8601String(),
        'year' => $carbon->year,
        'month' => $carbon->month,
        'day' => $carbon->day,
    ];
}

$cases = [];

$cases[] = describe('addMonths +1', Carbon::create(1975, 1, 31)->addMonths(1));
$cases[] = describe('addMonths -1', Carbon::create(1975, 1, 31)->addMonths(-1));
$cases[] = describe('addMonth', Carbon::create(1975, 1, 31)->addMonth());
$seed = Carbon::create(2016, 1, 31);
$cases[] = describe('addMonthNoOverflow +1', $seed->copy()->addMonthNoOverflow(1));
$cases[] = describe('addMonthNoOverflow -2', $seed->copy()->addMonthNoOverflow(-2));
$cases[] = describe('addMonthsNoOverflow +2', $seed->copy()->addMonthsNoOverflow(2));
$cases[] = describe('addMonthWithOverflow +1', $seed->copy()->addMonthWithOverflow(1));
$cases[] = describe('addMonthWithOverflow -2', $seed->copy()->addMonthWithOverflow(-2));
$cases[] = describe('addMonthsWithOverflow +2', $seed->copy()->addMonthsWithOverflow(2));

$subSeed = Carbon::create(2016, 3, 31);
$cases[] = describe('subMonths +1', $subSeed->copy()->subMonths(1));
$cases[] = describe('subMonths 0', $subSeed->copy()->subMonths(0));
$cases[] = describe('subMonths -1', $subSeed->copy()->subMonths(-1));
$cases[] = describe('subMonth', $subSeed->copy()->subMonth());
$cases[] = describe('subMonthNoOverflow +1', $subSeed->copy()->subMonthNoOverflow(1));
$cases[] = describe('subMonthsNoOverflow +2', $subSeed->copy()->subMonthsNoOverflow(2));
$cases[] = describe('subMonthWithOverflow +1', $subSeed->copy()->subMonthWithOverflow(1));
$cases[] = describe('subMonthsWithOverflow +2', $subSeed->copy()->subMonthsWithOverflow(2));

fwrite(STDOUT, json_encode($cases, JSON_PRETTY_PRINT) . PHP_EOL);

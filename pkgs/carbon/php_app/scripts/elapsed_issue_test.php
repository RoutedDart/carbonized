<?php

declare(strict_types=1);

require __DIR__.'/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

$capturedNow = Carbon::now('UTC');
$originalIso = $capturedNow->toIso8601String();

$mutatedStartOfDay = $capturedNow->startOfDay();
$diffUsingMutatedNow = $mutatedStartOfDay->diffForHumans($capturedNow, false, false, 2);

echo "Original now timestamp before mutation: {$originalIso}\n";
echo "Now after calling now->startOfDay(): {$capturedNow->toIso8601String()}\n";
echo 'mutatedStartOfDay and now are the same instance: '.($capturedNow === $mutatedStartOfDay ? 'true' : 'false')."\n";
echo "Elapsed using mutated now reference -> {$diffUsingMutatedNow}\n\n";

$safeNow = Carbon::now('UTC');
$safeStartOfDay = $safeNow->copy()->startOfDay();
$diffUsingSafeNow = $safeStartOfDay->diffForHumans($safeNow, false, false, 2);

echo "Safe now (copy + startOfDay) timestamp: {$safeNow->toIso8601String()}\n";
echo "Safe startOfDay timestamp: {$safeStartOfDay->toIso8601String()}\n";
echo "Elapsed using safe now reference -> {$diffUsingSafeNow}\n\n";

$diffUsingFreshInstances = Carbon::now('UTC')
    ->startOfDay()
    ->diffForHumans(Carbon::now('UTC'), false, false, 2);

echo "Elapsed using fresh Carbon::now() calls -> {$diffUsingFreshInstances}\n";

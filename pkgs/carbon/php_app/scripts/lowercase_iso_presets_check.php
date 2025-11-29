<?php

declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

function header_line(string $text): void
{
    echo PHP_EOL . '=== ' . $text . ' ===' . PHP_EOL;
}

function print_preset(string $locale, string $token, Carbon $sample): void
{
    $value = $sample->locale($locale)->isoFormat($token);
    printf("%-8s %-6s %s\n", $locale, $token, $value);
}

$locales = ['es', 'es_MX', 'es_ES', 'es_GT', 'es_CO'];
$tokens = ['LL', 'll', 'LLL', 'lll', 'LLLL', 'llll'];

$samples = [
    'LL' => Carbon::parse('2017-01-01T00:00:00Z'),
    'll' => Carbon::parse('2017-01-01T00:00:00Z'),
    'LLL' => Carbon::parse('2017-01-01T15:30:45Z'),
    'lll' => Carbon::parse('2017-01-01T15:30:45Z'),
    'LLLL' => Carbon::parse('2017-01-01T15:30:45Z'),
    'llll' => Carbon::parse('2017-01-01T15:30:45Z'),
];

header_line('Lowercase vs Uppercase ISO Presets (PHP Carbon)');
echo "locale   token  output\n";
echo "-------------------------------\n";
foreach ($locales as $locale) {
    foreach ($tokens as $token) {
        $sample = $samples[$token];
        print_preset($locale, $token, $sample);
    }
    echo "-------------------------------\n";
}

header_line('Example comparison for Spanish (es)');
$example = Carbon::parse('2017-01-01T15:30:45Z')->locale('es');
echo 'LL  : ' . $example->isoFormat('LL') . PHP_EOL;
echo 'll  : ' . $example->isoFormat('ll') . PHP_EOL;
echo 'LLL : ' . $example->isoFormat('LLL') . PHP_EOL;
echo 'lll : ' . $example->isoFormat('lll') . PHP_EOL;
echo 'LLLL: ' . $example->isoFormat('LLLL') . PHP_EOL;
echo 'llll: ' . $example->isoFormat('llll') . PHP_EOL;

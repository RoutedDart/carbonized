<?php

require __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

// Test Russian ordinal behavior
Carbon::setLocale('ru');
$russian = Carbon::parse('2019-05-15T12:00:00Z');

echo "Testing Russian locale ordinals:\n";
echo "Format 'jS': " . $russian->translatedFormat('jS') . "\n";
echo "Format 't F': " . $russian->translatedFormat('t F') . "\n";
echo "Format 'n F': " . $russian->translatedFormat('n F') . "\n";
echo "Format 'F' alone: " . $russian->translatedFormat('F') . "\n";
echo "Format 'n' alone: " . $russian->translatedFormat('n') . "\n";
echo "\n";

// Also test English for comparison
Carbon::setLocale('en');
$english = Carbon::parse('2019-05-15T12:00:00Z');
echo "\nTesting English locale ordinals:\n";
echo "Format 'jS': " . $english->translatedFormat('jS') . "\n";


<?php
/**
 * Test script to verify PHP Carbon's createFromLocaleFormat behavior
 * This helps us ensure our Dart implementation matches PHP Carbon's behavior
 */

require_once __DIR__ . '/../vendor/autoload.php';

use Carbon\Carbon;

echo "=== PHP Carbon createFromLocaleFormat Test ===\n\n";

// Test 1: Chinese locale with month name
echo "Test 1: Chinese locale parsing\n";
echo "Format: Y M d H,i,s\n";
echo "Input:  2019 四月 4 12,04,21\n";
echo "Locale: zh_CN\n";
try {
    $carbon = Carbon::createFromLocaleFormat('Y M d H,i,s', 'zh_CN', '2019 四月 4 12,04,21', 'UTC');
    echo "Result: " . $carbon->toIso8601String() . "\n";
    echo "Year:   " . $carbon->year . "\n";
    echo "Month:  " . $carbon->month . "\n";
    echo "Day:    " . $carbon->day . "\n";
    echo "Hour:   " . $carbon->hour . "\n";
    echo "✓ SUCCESS\n";
} catch (Exception $e) {
    echo "✗ FAILED: " . $e->getMessage() . "\n";
}
echo "\n";

// Test 2: French locale with month name
echo "Test 2: French locale parsing\n";
echo "Format: Y F d H:i:s\n";
echo "Input:  2019 avril 4 12:04:21\n";
echo "Locale: fr\n";
try {
    $carbon = Carbon::createFromLocaleFormat('Y F d H:i:s', 'fr', '2019 avril 4 12:04:21', 'UTC');
    echo "Result: " . $carbon->toIso8601String() . "\n";
    echo "Month:  " . $carbon->month . " (should be 4 for April)\n";
    echo "✓ SUCCESS\n";
} catch (Exception $e) {
    echo "✗ FAILED: " . $e->getMessage() . "\n";
}
echo "\n";

// Test 3: Spanish locale with month name
echo "Test 3: Spanish locale parsing\n";
echo "Format: d \\d\\e F \\d\\e Y\n";
echo "Input:  05 de diciembre de 2022\n";
echo "Locale: es\n";
try {
    $carbon = Carbon::createFromLocaleFormat('d \\d\\e F \\d\\e Y', 'es', '05 de diciembre de 2022', 'UTC');
    echo "Result: " . $carbon->toIso8601String() . "\n";
    echo "Month:  " . $carbon->month . " (should be 12 for December)\n";
    echo "✓ SUCCESS\n";
} catch (Exception $e) {
    echo "✗ FAILED: " . $e->getMessage() . "\n";
}
echo "\n";

// Test 4: German locale with month name
echo "Test 4: German locale parsing\n";
echo "Format: d. F Y\n";
echo "Input:  23. Oktober 2019\n";
echo "Locale: de\n";
try {
    $carbon = Carbon::createFromLocaleFormat('d. F Y', 'de', '23. Oktober 2019', 'UTC');
    echo "Result: " . $carbon->toIso8601String() . "\n";
    echo "Month:  " . $carbon->month . " (should be 10 for October)\n";
    echo "✓ SUCCESS\n";
} catch (Exception $e) {
    echo "✗ FAILED: " . $e->getMessage() . "\n";
}
echo "\n";

// Test 5: Japanese locale with month name
echo "Test 5: Japanese locale parsing\n";
echo "Format: Y年 M月 d日\n";
echo "Input:  2019年 4月 15日\n";
echo "Locale: ja\n";
try {
    $carbon = Carbon::createFromLocaleFormat('Y年 M月 d日', 'ja', '2019年 4月 15日', 'UTC');
    echo "Result: " . $carbon->toIso8601String() . "\n";
    echo "Month:  " . $carbon->month . " (should be 4 for April)\n";
    echo "✓ SUCCESS\n";
} catch (Exception $e) {
    echo "✗ FAILED: " . $e->getMessage() . "\n";
}
echo "\n";

// Test 6: Multiple locales - verify month names
echo "Test 6: Month name verification across locales\n";
$testCases = [
    ['locale' => 'en', 'month' => 'January', 'num' => 1],
    ['locale' => 'fr', 'month' => 'janvier', 'num' => 1],
    ['locale' => 'es', 'month' => 'enero', 'num' => 1],
    ['locale' => 'de', 'month' => 'Januar', 'num' => 1],
    ['locale' => 'zh_CN', 'month' => '一月', 'num' => 1],
    ['locale' => 'ja', 'month' => '1月', 'num' => 1],
    ['locale' => 'fr', 'month' => 'mars', 'num' => 3],
    ['locale' => 'es', 'month' => 'marzo', 'num' => 3],
    ['locale' => 'zh_CN', 'month' => '四月', 'num' => 4],
];

foreach ($testCases as $test) {
    try {
        $input = "2020 {$test['month']} 15";
        $carbon = Carbon::createFromLocaleFormat('Y F d', $test['locale'], $input, 'UTC');
        $success = $carbon->month === $test['num'];
        echo ($success ? "✓" : "✗") . " {$test['locale']}: '{$test['month']}' -> month {$carbon->month} ";
        echo ($success ? "OK" : "FAILED (expected {$test['num']})") . "\n";
    } catch (Exception $e) {
        echo "✗ {$test['locale']}: EXCEPTION - {$e->getMessage()}\n";
    }
}
echo "\n";

// Test 7: Short month names
echo "Test 7: Short month names (M token)\n";
$shortMonthTests = [
    ['locale' => 'en', 'month' => 'Apr', 'num' => 4],
    ['locale' => 'fr', 'month' => 'avr', 'num' => 4],
    ['locale' => 'es', 'month' => 'abr', 'num' => 4],
    ['locale' => 'de', 'month' => 'Apr', 'num' => 4],
];

foreach ($shortMonthTests as $test) {
    try {
        $input = "2020 {$test['month']} 15";
        $carbon = Carbon::createFromLocaleFormat('Y M d', $test['locale'], $input, 'UTC');
        $success = $carbon->month === $test['num'];
        echo ($success ? "✓" : "✗") . " {$test['locale']}: '{$test['month']}' -> month {$carbon->month} ";
        echo ($success ? "OK" : "FAILED (expected {$test['num']})") . "\n";
    } catch (Exception $e) {
        echo "✗ {$test['locale']}: EXCEPTION - {$e->getMessage()}\n";
    }
}
echo "\n";

// Test 8: Case insensitivity
echo "Test 8: Case insensitivity test\n";
$caseTests = [
    ['input' => '2020 APRIL 15', 'expected' => 4],
    ['input' => '2020 april 15', 'expected' => 4],
    ['input' => '2020 April 15', 'expected' => 4],
    ['input' => '2020 aPrIl 15', 'expected' => 4],
];

foreach ($caseTests as $test) {
    try {
        $carbon = Carbon::createFromLocaleFormat('Y F d', 'en', $test['input'], 'UTC');
        $success = $carbon->month === $test['expected'];
        echo ($success ? "✓" : "✗") . " '{$test['input']}' -> month {$carbon->month} ";
        echo ($success ? "OK" : "FAILED") . "\n";
    } catch (Exception $e) {
        echo "✗ EXCEPTION: {$e->getMessage()}\n";
    }
}
echo "\n";

echo "=== Test Complete ===\n";


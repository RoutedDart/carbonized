<?php

declare(strict_types=1);

require __DIR__.'/../vendor/autoload.php';

use Carbon\Carbon;

date_default_timezone_set('UTC');

echo "=== PHP Carbon ISO Format Token Reference ===\n\n";

// Test dates
$nov5 = Carbon::create(2024, 11, 5, 0, 0, 0);
$nov26 = Carbon::create(2024, 11, 26, 0, 0, 0);
$jan5 = Carbon::create(2024, 1, 5, 0, 0, 0);
$dec31 = Carbon::create(2024, 12, 31, 0, 0, 0);
$monday = Carbon::create(2024, 11, 25, 0, 0, 0); // Monday
$tuesday = Carbon::create(2024, 11, 26, 0, 0, 0); // Tuesday
$jan = Carbon::create(2024, 1, 15, 0, 0, 0);
$nov = Carbon::create(2024, 11, 15, 0, 0, 0);
$dec = Carbon::create(2024, 12, 15, 0, 0, 0);
$morning = Carbon::create(2024, 11, 26, 9, 32, 0);
$afternoon = Carbon::create(2024, 11, 26, 14, 32, 0);

echo "=== Day Tokens ===\n";

// D - day of month without padding
echo "D (day of month without padding):\n";
echo "  Nov 5 -> D: " . $nov5->isoFormat('D') . "\n";
echo "  Nov 26 -> D: " . $nov26->isoFormat('D') . "\n";

// DD - day of month with padding
echo "DD (day of month with padding):\n";
echo "  Nov 5 -> DD: " . $nov5->isoFormat('DD') . "\n";
echo "  Nov 26 -> DD: " . $nov26->isoFormat('DD') . "\n";

// DDD - day of year without padding
echo "DDD (day of year without padding):\n";
echo "  Jan 5 -> DDD: " . $jan5->isoFormat('DDD') . "\n";
echo "  Nov 26 -> DDD: " . $nov26->isoFormat('DDD') . "\n";
echo "  Dec 31 -> DDD: " . $dec31->isoFormat('DDD') . "\n";

// DDDD - day of year with padding
echo "DDDD (day of year with padding):\n";
echo "  Jan 5 -> DDDD: " . $jan5->isoFormat('DDDD') . "\n";
echo "  Nov 26 -> DDDD: " . $nov26->isoFormat('DDDD') . "\n";
echo "  Dec 31 -> DDDD: " . $dec31->isoFormat('DDDD') . "\n";

// d - day of week (0=Sunday, 6=Saturday)
echo "d (day of week number):\n";
echo "  Monday Nov 25 -> d: " . $monday->isoFormat('d') . "\n";
echo "  Tuesday Nov 26 -> d: " . $tuesday->isoFormat('d') . "\n";

// dd - min weekday name
echo "dd (min weekday name):\n";
echo "  Monday Nov 25 -> dd: " . $monday->isoFormat('dd') . "\n";
echo "  Tuesday Nov 26 -> dd: " . $tuesday->isoFormat('dd') . "\n";

// ddd - short weekday name
echo "ddd (short weekday name):\n";
echo "  Monday Nov 25 -> ddd: " . $monday->isoFormat('ddd') . "\n";
echo "  Tuesday Nov 26 -> ddd: " . $tuesday->isoFormat('ddd') . "\n";

// dddd - full weekday name
echo "dddd (full weekday name):\n";
echo "  Monday Nov 25 -> dddd: " . $monday->isoFormat('dddd') . "\n";
echo "  Tuesday Nov 26 -> dddd: " . $tuesday->isoFormat('dddd') . "\n";

// Do - day of month with ordinal
echo "Do (day of month with ordinal):\n";
$first = Carbon::create(2024, 11, 1);
$second = Carbon::create(2024, 11, 2);
$third = Carbon::create(2024, 11, 3);
$twentyFirst = Carbon::create(2024, 11, 21);
echo "  Nov 1 -> Do: " . $first->isoFormat('Do') . "\n";
echo "  Nov 2 -> Do: " . $second->isoFormat('Do') . "\n";
echo "  Nov 3 -> Do: " . $third->isoFormat('Do') . "\n";
echo "  Nov 21 -> Do: " . $twentyFirst->isoFormat('Do') . "\n";

echo "\n=== Month Tokens ===\n";

// M - month without padding
echo "M (month without padding):\n";
echo "  Jan -> M: " . $jan->isoFormat('M') . "\n";
echo "  Nov -> M: " . $nov->isoFormat('M') . "\n";

// MM - month with padding
echo "MM (month with padding):\n";
echo "  Jan -> MM: " . $jan->isoFormat('MM') . "\n";
echo "  Nov -> MM: " . $nov->isoFormat('MM') . "\n";

// MMM - short month name
echo "MMM (short month name):\n";
echo "  Jan -> MMM: " . $jan->isoFormat('MMM') . "\n";
echo "  Nov -> MMM: " . $nov->isoFormat('MMM') . "\n";
echo "  Dec -> MMM: " . $dec->isoFormat('MMM') . "\n";

// MMMM - full month name
echo "MMMM (full month name):\n";
echo "  Jan -> MMMM: " . $jan->isoFormat('MMMM') . "\n";
echo "  Nov -> MMMM: " . $nov->isoFormat('MMMM') . "\n";

// Mo - month with ordinal
echo "Mo (month with ordinal):\n";
echo "  Jan -> Mo: " . $jan->isoFormat('Mo') . "\n";
echo "  Dec -> Mo: " . $dec->isoFormat('Mo') . "\n";

echo "\n=== Year Tokens ===\n";

// YY - 2-digit year
echo "YY (2-digit year):\n";
echo "  2024 -> YY: " . $nov26->isoFormat('YY') . "\n";

// YYYY - 4-digit year
echo "YYYY (4-digit year):\n";
echo "  2024 -> YYYY: " . $nov26->isoFormat('YYYY') . "\n";

// YYYYY - 5-digit year with padding
echo "YYYYY (5-digit year with padding):\n";
echo "  2024 -> YYYYY: " . $nov26->isoFormat('YYYYY') . "\n";

echo "\n=== Time Tokens ===\n";

// H - 24-hour without padding
echo "H (24-hour without padding):\n";
echo "  9:32 -> H: " . $morning->isoFormat('H') . "\n";
echo "  14:32 -> H: " . $afternoon->isoFormat('H') . "\n";

// HH - 24-hour with padding
echo "HH (24-hour with padding):\n";
echo "  9:32 -> HH: " . $morning->isoFormat('HH') . "\n";
echo "  14:32 -> HH: " . $afternoon->isoFormat('HH') . "\n";

// h - 12-hour without padding
echo "h (12-hour without padding):\n";
$midnight = Carbon::create(2024, 11, 26, 0, 0, 0);
$noon = Carbon::create(2024, 11, 26, 12, 0, 0);
echo "  midnight -> h: " . $midnight->isoFormat('h') . "\n";
echo "  9:00 -> h: " . $morning->isoFormat('h') . "\n";
echo "  noon -> h: " . $noon->isoFormat('h') . "\n";
echo "  14:00 -> h: " . $afternoon->isoFormat('h') . "\n";

// hh - 12-hour with padding
echo "hh (12-hour with padding):\n";
echo "  midnight -> hh: " . $midnight->isoFormat('hh') . "\n";
echo "  9:00 -> hh: " . $morning->isoFormat('hh') . "\n";
echo "  noon -> hh: " . $noon->isoFormat('hh') . "\n";
echo "  14:00 -> hh: " . $afternoon->isoFormat('hh') . "\n";

// A - AM/PM uppercase
echo "A (AM/PM uppercase):\n";
echo "  9:00 -> A: " . $morning->isoFormat('A') . "\n";
echo "  14:00 -> A: " . $afternoon->isoFormat('A') . "\n";

// a - am/pm lowercase
echo "a (am/pm lowercase):\n";
echo "  9:00 -> a: " . $morning->isoFormat('a') . "\n";
echo "  14:00 -> a: " . $afternoon->isoFormat('a') . "\n";

// mm - minutes with padding
echo "mm (minutes with padding):\n";
$min5 = Carbon::create(2024, 11, 26, 14, 5, 0);
$min32 = Carbon::create(2024, 11, 26, 14, 32, 0);
echo "  14:05 -> mm: " . $min5->isoFormat('mm') . "\n";
echo "  14:32 -> mm: " . $min32->isoFormat('mm') . "\n";

// ss - seconds with padding
echo "ss (seconds with padding):\n";
$sec5 = Carbon::create(2024, 11, 26, 14, 32, 5);
$sec45 = Carbon::create(2024, 11, 26, 14, 32, 45);
echo "  5 sec -> ss: " . $sec5->isoFormat('ss') . "\n";
echo "  45 sec -> ss: " . $sec45->isoFormat('ss') . "\n";

echo "\n=== Edge Cases ===\n";

// End of month transitions
$jan31 = Carbon::create(2024, 1, 31);
$feb1 = $jan31->copy()->addDay();
echo "End of month:\n";
echo "  Jan 31 -> MMM DD: " . $jan31->isoFormat('MMM DD') . "\n";
echo "  Feb 1 -> MMM DD: " . $feb1->isoFormat('MMM DD') . "\n";

// End of year transitions  
$dec31_2024 = Carbon::create(2024, 12, 31);
$jan1_2025 = $dec31_2024->copy()->addDay();
echo "End of year:\n";
echo "  Dec 31 2024 -> MMM DD: " . $dec31_2024->isoFormat('MMM DD') . "\n";
echo "  Jan 1 2025 -> MMM DD: " . $jan1_2025->isoFormat('MMM DD') . "\n";
echo "  Dec 31 2024 dayOfYear: " . $dec31_2024->dayOfYear . "\n";
echo "  Jan 1 2025 dayOfYear: " . $jan1_2025->dayOfYear . "\n";

// Leap year
$leapDay = Carbon::create(2024, 2, 29);
$dayAfter = $leapDay->copy()->addDay();
echo "Leap year:\n";
echo "  Feb 29 -> MMM DD: " . $leapDay->isoFormat('MMM DD') . "\n";
echo "  Mar 1 -> MMM DD: " . $dayAfter->isoFormat('MMM DD') . "\n";
echo "  Feb 29 dayOfYear: " . $leapDay->dayOfYear . "\n";
echo "  Mar 1 dayOfYear: " . $dayAfter->dayOfYear . "\n";

// Non-leap year
$feb28 = Carbon::create(2023, 2, 28);
$mar1 = $feb28->copy()->addDay();
echo "Non-leap year:\n";
echo "  Feb 28 2023 -> MMM DD: " . $feb28->isoFormat('MMM DD') . "\n";
echo "  Mar 1 2023 -> MMM DD: " . $mar1->isoFormat('MMM DD') . "\n";
echo "  Feb 28 2023 dayOfYear: " . $feb28->dayOfYear . "\n";
echo "  Mar 1 2023 dayOfYear: " . $mar1->dayOfYear . "\n";

echo "\n=== Escaping and Literals ===\n";

echo "Brackets preserve literal text:\n";
echo "  [Today is] MMM DD: " . $nov26->isoFormat('[Today is] MMM DD') . "\n";
echo "  MMM DD [is the date]: " . $nov26->isoFormat('MMM DD [is the date]') . "\n";

echo "Mixed tokens and literals:\n";
$fullDate = Carbon::create(2024, 11, 26, 14, 32, 0);
echo "  YYYY-MM-DD [at] HH:mm: " . $fullDate->isoFormat('YYYY-MM-DD [at] HH:mm') . "\n";

echo "\n=== Complex Patterns ===\n";

echo "Full datetime patterns:\n";
echo "  YYYY-MM-DD HH:mm:ss: " . $fullDate->isoFormat('YYYY-MM-DD HH:mm:ss') . "\n";
echo "  dddd, MMMM Do, YYYY: " . $fullDate->isoFormat('dddd, MMMM Do, YYYY') . "\n";

echo "\n=== Summary of Dart Test Expectations ===\n";
echo "Based on PHP Carbon isoFormat(), here are the correct expected values:\n\n";

echo "Day Tokens:\n";
echo "  D (Nov 5) = '" . $nov5->isoFormat('D') . "'\n";
echo "  DD (Nov 5) = '" . $nov5->isoFormat('DD') . "'\n";
echo "  DDD (Jan 5) = '" . $jan5->isoFormat('DDD') . "'\n";
echo "  DDDD (Jan 5) = '" . $jan5->isoFormat('DDDD') . "'\n";
echo "  ddd (Monday) = '" . $monday->isoFormat('ddd') . "'\n";
echo "  dddd (Monday) = '" . $monday->isoFormat('dddd') . "'\n";
echo "  Do (Nov 1) = '" . $first->isoFormat('Do') . "'\n";

echo "\nMonth Tokens:\n";
echo "  Mo (Jan) = '" . $jan->isoFormat('Mo') . "'\n";

echo "\nYear Tokens:\n";
echo "  YY (2024) = '" . $nov26->isoFormat('YY') . "'\n";
echo "  YYYY (2024) = '" . $nov26->isoFormat('YYYY') . "'\n";
echo "  YYYYY (2024) = '" . $nov26->isoFormat('YYYYY') . "'\n";

echo "\nTime Tokens:\n";
echo "  H (9:00) = '" . $morning->isoFormat('H') . "'\n";
echo "  A (9:00) = '" . $morning->isoFormat('A') . "'\n";

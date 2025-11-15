# StringsTest Parity Shortfalls (PHP vs. Dart)

_Last reviewed: 15 Nov 2025_

This document maps every scenario from PHP Carbon's
`/tmp/php-carbon/tests/Carbon/StringsTest.php`
to the current Dart implementation. Status legend:

- ✅ Implemented and covered by `test/string_methods_test.dart` (or another
  Dart suite).
- ⚠️ Implemented but lacking automated coverage **or** behavior diverges from
  the PHP expectation and needs follow-up.
- ❌ Missing feature, API surface, or parity guarantee.

## Scenario Status Matrix

| # | PHP Scenario | Status | Coverage / Gap Summary |
|---|--------------|--------|------------------------|
| 1 | `testToStringCast` | ✅ | `CarbonBase.toString()` now mirrors PHP's `__toString` by returning `toDateTimeString()`, so straight casts produce the expected `YYYY-MM-DD HH:mm:ss` output. |
| 2 | `testToString` | ✅ | Added `CarbonInterface.toLegacyString()` (with tests) to emit the classic `'Thu Dec 25 1975 … GMT-0500'` format, covering PHP's explicit `toString()` scenario without affecting Dart's casting semantics. |
| 3 | `testToISOString` (+ `toJSON`) | ✅ | Added regression tests (`test/string_wrapper_formats_test.dart`) covering extended years, `keepOffset`, and `toIso8601ZuluString()` plus a `toJSON()` alias that forwards to `toIso8601String()`. |
| 4 | `testSetToStringFormatString` | ✅ | String-based overrides are now covered alongside the closure paths—tests assert both the formatted output and the reset back to the default `toDateTimeString()`. |
| 5 | `testSetToStringFormatClosure` | ✅ | Covered by `test/string_methods_test.dart:70`. |
| 6 | `testSetToStringFormatViaSettings` | ✅ | Implemented `CarbonFactory` + per-instance `withToStringFormat`, mirroring PHP's factory-scoped `toStringFormat`. |
| 7 | `testResetToStringFormat` | ✅ | Added explicit regression test ensuring the default `toDateTimeString()` behavior returns after calling `Carbon.resetToStringFormat()`. |
| 8 | `testExtendedClassToString` | ✅ | Introduced `CarbonTestSubclass` (test-only helper) to verify subclasses inherit the global `toString` overrides. |
| 9 | `testToDateString` | ✅ | `test/string_methods_test.dart:17`. |
|10 | `testToDateTimeLocalString` | ✅ | `test/string_methods_test.dart:24` (includes precision + timezone cases). |
|11 | `testToFormattedDateString` | ✅ | `test/string_methods_test.dart:48`. |
|12 | `testToTimeString` | ✅ | `test/string_methods_test.dart:19`. |
|13 | `testToDateTimeString` | ✅ | `test/string_methods_test.dart:17`. |
|14 | `testToDateTimeStringWithPaddedZeroes` | ✅ | `test/string_methods_test.dart:32`. |
|15 | `testToDayDateTimeString` | ✅ | `test/string_methods_test.dart:39`. |
|16 | `testToDayDateString` | ✅ | `test/string_methods_test.dart:44`. |
|17 | `testToAtomString` | ✅ | Verified via `test/string_wrapper_formats_test.dart` for both UTC and offset instances. |
|18 | `testToCOOKIEString` | ✅ | Cookie output (two-digit year + GMT suffix) now covered alongside offset variations. |
|19 | `testToIso8601String` | ✅ | Tests assert UTC conversion, `keepOffset`, expanded years, and the `toJSON()` alias. |
|20 | `testToIso8601ZuluString` | ✅ | Exercised in the same suite to ensure the explicit `Z` suffix remains stable. |
|21 | `testToRC822String` | ✅ | RFC helpers now have regression coverage for offset instances. |
|22 | `testToRfc850String` | ✅ | Locale-aware weekday/month cases validated in `test/string_wrapper_formats_test.dart`. |
|23 | `testToRfc1036String` | ✅ | Covered alongside the other RFC family helpers. |
|24 | `testToRfc1123String` | ✅ | Same. |
|25 | `testToRfc2822String` | ✅ | Same. |
|26 | `testToRfc3339String` | ✅ | Tests cover both default and `extended: true` precision. |
|27 | `testToRssString` | ✅ | Verified output for fixed-offset instances. |
|28 | `testToW3cString` | ✅ | Shares coverage with RFC3339 assertions. |
|29 | `testToRfc7231String` | ✅ | Suite asserts both UTC and offset inputs return the PHP-compatible GMT string. |
|30 | `testIsoFormat` | ✅ | `_IsoFormatter` now supports `g/G` tokens (plus locale week data) with dedicated tests in `test/string_methods_test.dart`. |
|31 | `testBadIsoFormat` | ✅ | Added `Carbon.registerIsoFormatToken`/`resetIsoFormatTokens`, so tests can override token handlers like PHP's `getIsoUnits`. |
|32 | `testTranslatedFormat` | ✅ | Added genitive month overrides for Russian so `'t F'` now emits `'31 мая'` while `'n F'` stays `'5 май'`. |

## Priority Follow-ups
*(none – StringsTest scenarios are now fully covered in Dart)*

Tracking these items here ensures we do not lose sight of the remaining gaps
after the Task 7 documentation sweep.

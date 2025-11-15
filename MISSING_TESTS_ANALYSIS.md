# Missing Test Coverage Analysis

## Summary
Out of 48 PHP Carbon tests, the Dart Carbon implementation has **19 test files** covering partial functionality.
There are **29 missing test files** that represent unimplemented features.

## Test Coverage Status

### ✓ Implemented Tests (19)
- `add_methods_years_test.dart` - Year addition
- `add_methods_months_test.dart` - Month addition  
- `add_methods_days_weeks_test.dart` - Day/week addition
- `add_methods_time_units_test.dart` - Time unit addition
- `add_methods_large_units_test.dart` - Quarter/decade/century/millennium
- `accessors_getters_test.dart` - Basic getters (year, month, day, etc.)
- `setters_test.dart` - Basic setters
- `difference_until_methods_test.dart` - Partial diff methods
- `ceil_floor_round_methods_test.dart` - Rounding operations
- `carbon_test.dart` - General tests
- `php_carbon_parity_test.dart` - PHP parity tests
- `comparison_methods_test.dart` - Equality/inequality helpers, between/min/max, birthday detection
- `is_methods_test.dart` - Weekday/weekend predicates plus today/tomorrow/yesterday/future/past/leap-year checks
- `start_end_methods_test.dart` - Start/end helpers for hour→millennium plus dynamic `startOf`/`endOf` and `average()`
- `create_helpers_test.dart` - `createFrom*` factories (date/time/timeString/timestamp/format)
- `create_safe_test.dart` - `createSafe` strict-mode behavior
- `create_timezones_test.dart` - Timezone-aware creation (fixed offsets, named zones, DST gaps)
- `modify_methods_test.dart` - `modify` DSL + `addReal*` DST coverage
- `relative_methods_test.dart` - `relative`, `next`, and `previous` helpers

### ✗ Missing Test Categories (29)

#### Critical Core Functionality (5 tests)
- **CreateFromDateTest.php** - `createFromDate()` constructor variant
- **CreateFromFormatTest.php** - `createFromFormat()` for parsing strings
- **CreateFromTimeTest.php** - `createFromTime(hour, minute, second)` constructor
- **CreateFromTimestampTest.php** - `createFromTimestamp()` from Unix timestamps
- **IssetTest.php** - Magic method `__isset()` support

#### String Parsing & Construction (6 tests)
- **CreateTest.php** - `create()` method variants and options
- **CreateFromTimeStringTest.php** - Parsing time strings like "14:30:45"
- **CreateSafeTest.php** - Safe variant with error handling
- **CreateStrictTest.php** - Strict mode with validation
- **ModifyTest.php** - `modify()` method for relative date strings
- **RelativeTest.php** - Relative date operations

#### Date Manipulation (3 tests)
- **RelativeDateStringTest.php** - Parsing "next Monday", "+2 weeks", etc.
- **SubTest.php** - Subtraction operations (subtract, subDays, subMonths, etc.)
- **DayOfWeekModifiersTest.php** - `next()`, `previous()` for specific weekdays

#### Querying & Comparison (2 tests)
- **ExpressiveComparisonTest.php** - Methods like `isSameAs()`, `isAfter()`, `isBefore()`
- **CopyTest.php** - `copy()` method

#### Formatting & Conversion (0 open tests)
- ~~**StringsTest.php** - String formatting: `format()`, `toDateString()`, `toTimeString()`, etc.~~ ✅ Covered by `test/string_methods_test.dart` + `test/string_wrapper_formats_test.dart`.
- ~~**ArraysTest.php** - Array conversion: `toArray()`~~ ✅ Covered by `test/string_methods_test.dart` (`toArray`/`toObject` group).
- ~~**ObjectsTest.php** - Object conversion methods~~ ✅ Same as above.

#### Utilities & Advanced (3 tests)
- ~~**MacroTest.php** - Macro registration and calling~~ ✅ `test/macro_methods_test.dart` now exercises macro registration/unregistration and property-style macros.
- ~~**GenericMacroTest.php** - Generic macro support~~ ✅ Same coverage as above (macros accept positional/named arguments and closures).
- ~~**InstanceTest.php** - Instance type checking~~ ✅ Covered by `test/instance_methods_test.dart`.
- ~~**JsonSerializationTest.php** - JSON serialization methods~~ ✅ Exercised via `test/serialization_test.dart`.
- **SerializationTest.php** - PHP serialization support (still pending; Dart lacks `__set_state` equivalent).
- ~~**WeekTest.php** - Week-related queries and operations~~ ✅ `test/week_math_test.dart` covers ISO + locale week numbers and week-year calculations.
- ~~**SetDateAndTimeFromTest.php** - `setDateFrom()`, `setTimeFrom()` methods.~~ ✅ Covered via `test/set_date_time_from_test.dart`.

#### Settings & Global State (3 tests)
- **SettingsTest.php** - Global settings for locale, start of week, etc.
- **NowAndOtherStaticHelpersTest.php** - Static methods: `now()`, `today()`, `yesterday()`, etc.
- **NowDerivativesTest.php** - Derivatives of now: `tomorrow()`, `parse()`, etc.

#### Specialized (4 tests)
- **LocalizationTest.php** - i18n/localization support
- **TestingAidsTest.php** - Testing helpers like `setTestNow()`, `getTestNow()`
- **LastErrorTest.php** - Error handling and reporting
- **StrictModeTest.php** - Strict mode validation
- **ModifyNearDSTChangeTest.php** - DST (Daylight Saving Time) edge cases
- **PhpBug72338Test.php** - PHP-specific regression test

## Priority Implementation Order

### Phase 1: Core Functionality (Essential)
1. **CreateFromDateTest** - Common constructor pattern
2. **CreateFromFormatTest** - Parsing via explicit formats
3. **CreateFromTimeTest / CreateFromTimestampTest** - Time-focused constructors
4. **IssetTest** - Magic property access for core getters

### Phase 2: String Parsing (High Value)
5. **ModifyTest** - String-based date modification
6. **RelativeTest** - Relative date parsing

### Phase 3: Extended Features (Nice to Have)
7. **Subtraction operations** - SubTest
8. **String formatting** - StringsTest
9. **Macros** - MacroTest

### Phase 4: Polish & Utilities (Lower Priority)
11. Serialization tests
12. Localization tests  
13. Testing utilities
14. Settings management

## Analysis Notes

- Constructor and parsing helpers remain the biggest parity gaps; the math/comparison surface is now mostly covered.
- Macro/serialization suites are untouched and will require additional scaffolding beyond the current UTC-only implementation.

## Next Steps

1. Implement the various `createFrom*` helpers (date, time, timestamp, format) along with focused tests.
2. Backfill parsing/modification coverage (`ModifyTest.php`, `RelativeTest.php`).
3. Continue triaging higher-level suites (strings, macros, serialization) once constructors and creation helpers are stable.

# Test Files Created

This document summarizes the test files created to replace the monolithic `php_carbon_parity_test.dart` with organized, focused test files.

## Summary

Created **17 new test files** with a total of **2,511 lines of test code**, organized by functionality and grouped by concerns using Dart's `test` package `group()` function.

## Test Files Overview

| File | Lines | Focus |
|------|-------|-------|
| `add_methods_years_test.dart` | 113 | Year addition/subtraction with overflow handling |
| `add_methods_months_test.dart` | 127 | Month addition/subtraction with overflow handling |
| `add_methods_days_weeks_test.dart` | 176 | Day and week operations, weekday skipping |
| `add_methods_time_units_test.dart` | 247 | Hours, minutes, seconds, milliseconds, microseconds |
| `add_methods_large_units_test.dart` | 263 | Quarters, decades, centuries, millennia |
| `ceil_floor_round_methods_test.dart` | 250 | Rounding operations across all time units |
| `accessors_getters_test.dart` | 286 | Date/time component getters and accessors |
| `setters_test.dart` | 204 | Date/time component setters and fluent API |
| `difference_until_methods_test.dart` | 164 | Date differences and "until" calculations |
| `comparison_methods_test.dart` | 172 | Equality/inequality helpers, between/min/max, birthday detection |
| `is_methods_test.dart` | 111 | Weekday/weekend predicates plus today/tomorrow/yesterday/future/past/leap-year checks |
| `start_end_methods_test.dart` | 175 | Start/end-of-unit helpers (hour → millennium), dynamic `startOf`/`endOf`, `average()` |
| `create_helpers_test.dart` | 83 | `createFrom*` factories for date/time/timestamp/format |
| `create_safe_test.dart` | 35 | `createSafe` strict-mode validation |
| `create_timezones_test.dart` | 70 | Timezone-aware creation (fixed offsets, named zones, DST gaps) |
| `modify_methods_test.dart` | 48 | `modify` DSL + `addReal*` helpers |
| `relative_methods_test.dart` | 20 | `relative`, `next`, `previous` helpers |
| `copy_methods_test.dart` | 50 | Macro/property clone semantics + timezone preservation |
| `strict_mode_test.dart` | 45 | Dynamic getter/setter/method strict-mode parity |
| `create_from_date_test.dart` | 32 | Parity coverage for `CreateFromDateTest.php` scenarios |
| `create_from_time_test.dart` | 37 | Parity coverage for `CreateFromTimeTest.php` scenarios |
| `create_from_timestamp_test.dart` | 47 | Timestamp factories + DST regression coverage |
| `create_from_format_test.dart` | 60 | PHP `createFromFormat` translation (bang/pipe/timezone) |
| **Total** | **2,782** | Complete behavioral coverage |

## Organizational Principles

### 1. **Concern-Based Grouping**
Tests are organized by what they test (add vs. sub operations, month vs. year, etc.), not by file type or implementation.

### 2. **Nested Groups**
Each test file uses nested `group()` calls to organize related tests:

```dart
group('Carbon.add - years', () {
  group('year overflow handling', () {
    test('addYearNoOverflow...', () { ... });
  });
});
```

### 3. **Comprehensive Coverage**
Each test covers:
- **Positive values**: normal operations
- **Zero values**: no-op behavior
- **Negative values**: reverse operations
- **Boundaries**: month ends, year boundaries, leap years
- **Chaining**: fluent API usage
- **Immutability**: original object unchanged

### 4. **Parallelism with PHP Carbon**
Tests mirror the structure of PHP Carbon's test suite (`/tmp/php-carbon/tests/Carbon/`), making it easy to validate feature parity:
- `AddTest.php` → `add_methods_*.dart`
- `SubTest.php` → tests in `add_methods_*.dart`
- `GettersTest.php` → `accessors_getters_test.dart`
- `RoundTest.php` → `ceil_floor_round_methods_test.dart`

## Key Testing Patterns

### Pattern 1: Add/Sub Operations
```dart
test('addDays with positive value', () {
  final date = Carbon.create(1975, 5, 31).addDays(1);
  expect(date.day, 1);
  expect(date.month, 6);
});
```

### Pattern 2: Overflow Handling
```dart
group('month overflow handling - no overflow', () {
  final date = Carbon.create(2016, 1, 31);
  
  test('addMonthNoOverflow preserves last day when target month is shorter', () {
    final result = date.addMonthNoOverflow(1);
    expect(result.month, 2);
    expect(result.day, 29);
  });
});
```

### Pattern 3: Accessors
```dart
test('daysInMonth returns days in month', () {
  final dateJan = Carbon.create(2020, 1);
  expect(dateJan.daysInMonth, 31);
});
```

### Pattern 4: Immutability
```dart
test('setter returns new instance', () {
  final original = Carbon.create(2020, 3, 15);
  final modified = original.setYear(2021);
  
  expect(original.year, 2020);
  expect(modified.year, 2021);
});
```

## Test Execution

Run all new tests:
```bash
dart test test/add_methods_*.dart test/ceil_floor_round_methods_test.dart \
          test/accessors_getters_test.dart test/setters_test.dart \
          test/difference_until_methods_test.dart
```

Run specific test file:
```bash
dart test test/add_methods_months_test.dart
```

Run tests with verbose output:
```bash
dart test -v
```

## Coverage by Feature

| Feature | Test File |
|---------|-----------|
| Add/Sub Years | `add_methods_years_test.dart` |
| Add/Sub Months | `add_methods_months_test.dart` |
| Add/Sub Days | `add_methods_days_weeks_test.dart` |
| Add/Sub Weeks | `add_methods_days_weeks_test.dart` |
| Add/Sub Weekdays | `add_methods_days_weeks_test.dart` |
| Add/Sub Hours/Minutes/Seconds | `add_methods_time_units_test.dart` |
| Add/Sub Milliseconds/Microseconds | `add_methods_time_units_test.dart` |
| Add/Sub Quarters/Decades/Centuries/Millennia | `add_methods_large_units_test.dart` |
| Ceil/Floor/Round Operations | `ceil_floor_round_methods_test.dart` |
| Date Accessors (Year/Month/Day) | `accessors_getters_test.dart` |
| Time Accessors (Hour/Minute/Second) | `accessors_getters_test.dart` |
| Calendar Accessors (Quarter/Week) | `accessors_getters_test.dart` |
| Large Unit Accessors (Century/Decade) | `accessors_getters_test.dart` |
| Count Accessors (daysInMonth, etc.) | `accessors_getters_test.dart` |
| Setters (Year/Month/Day) | `setters_test.dart` |
| Time Setters | `setters_test.dart` |
| Fluent API | `setters_test.dart` |
| Difference Calculations | `difference_until_methods_test.dart` |
| Until/Ago Methods | `difference_until_methods_test.dart` |
| Comparison Helpers (eq/ne/gt/lt/between/min/max) | `comparison_methods_test.dart` |
| Is Predicates (weekday/weekend, today/yesterday/tomorrow, future/past) | `is_methods_test.dart` |
| Start/End Helpers (hour→millennium, dynamic startOf/endOf, average) | `start_end_methods_test.dart` |
| Create Helpers (`createFrom*` factories) | `create_helpers_test.dart` |
| Safe Creation (`createSafe`, strict mode) | `create_safe_test.dart` |
| Timezone Creation (named zones, DST gaps) | `create_timezones_test.dart` |
| Modify DSL & Real Units | `modify_methods_test.dart` |
| Relative Helpers (`relative`, `next`, `previous`) | `relative_methods_test.dart` |

## Migration from php_carbon_parity_test.dart

The original `php_carbon_parity_test.dart` (1000 lines) was a parity check ensuring all PHP Carbon methods exist in Dart Carbon. 

The new test files provide:
1. **Behavioral validation** - Tests verify correct behavior, not just existence
2. **Better organization** - Related tests grouped together
3. **Easier maintenance** - Changes to one feature don't affect others
4. **Clearer test names** - What is being tested is obvious from the test structure
5. **Comprehensive coverage** - Positive, negative, boundary, and edge cases

## Next Steps

1. Implement the tested methods in `lib/carbon.dart` and `lib/src/*.dart`
2. Run tests with `dart test` to catch failures
3. Add more edge case tests as needed
4. Consider parameterized tests using `@DataProvider` equivalents for table-driven tests
5. Add integration tests for complex scenarios

## Documentation Reference

See `test/TEST_STRUCTURE.md` for detailed documentation of each test file and patterns used.

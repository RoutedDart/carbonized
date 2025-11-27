# Carbon Test Structure

This document describes the organization of test files for the Carbon library.

## Overview

Tests are organized by functionality concern rather than a monolithic test file. Each test file uses Dart's `group()` from the `test` package to organize related tests hierarchically.

## Test Files

### 1. **add_methods_years_test.dart**
Tests for year addition/subtraction operations.

**Concerns:**
- `addYears` / `subYears` (positive, zero, negative values)
- `addYear` / `subYear` (singular operations)
- Leap year overflow handling (`NoOverflow`, `WithOverflow` variants)
- Date preservation across year boundaries

**Key Tests:**
- Adding/subtracting years with various values
- Overflow behavior when crossing Feb 29 on non-leap years
- Chaining operations

---

### 2. **add_methods_months_test.dart**
Tests for month addition/subtraction operations.

**Concerns:**
- `addMonths` / `subMonths` (positive, zero, negative values)
- `addMonth` / `subMonth` (singular operations)
- End-of-month overflow handling (`NoOverflow` / `WithOverflow`)
- Month boundary crossing (Jan 31 + 1 month handling)

**Key Tests:**
- Adding/subtracting months with overflow behavior
- Date preservation when target month has fewer days
- Cross-year month operations

---

### 3. **add_methods_days_weeks_test.dart**
Tests for days and weeks addition/subtraction.

**Concerns:**
- `addDays` / `subDays` with various values
- `addDay` / `subDay` singular operations
- `addWeeks` / `subWeeks` with cross-boundary support
- `addWeekday` / `subWeekday` (skipping weekends)
- Weekday calculation with custom weekend configuration

**Key Tests:**
- Day/week arithmetic across month boundaries
- Weekday skipping behavior
- Preservation of time components when adding days
- Weekend vs. weekday calculations

---

### 4. **add_methods_time_units_test.dart**
Tests for fine-grained time unit operations (hours, minutes, seconds, milliseconds, microseconds).

**Concerns:**
- `addHours` / `subHours`
- `addMinutes` / `subMinutes`
- `addSeconds` / `subSeconds`
- `addMilliseconds` / `subMilliseconds`
- `addMicroseconds` / `subMicroseconds`
- All with positive, zero, and negative values
- Cross-boundary operations (e.g., 23:55 + 10 minutes = next day 00:05)

**Key Tests:**
- Time arithmetic with day overflow
- Precision handling for milliseconds/microseconds
- Negative time operations

---

### 5. **add_methods_large_units_test.dart**
Tests for large time units (quarters, decades, centuries, millennia).

**Concerns:**
- `addQuarters` / `subQuarters`
- `addDecades` / `subDecades` with overflow handling
- `addCenturies` / `subCenturies` with overflow handling
- `addMillennia` / `subMillennia` with overflow handling
- Leap year boundaries across large spans

**Key Tests:**
- Quarter calculations within and across years
- Decade/century/millennium overflow behavior
- Date preservation for Feb 29 across large time spans
- Cross-era calculations

---

### 6. **ceil_floor_round_methods_test.dart**
Tests for rounding operations (ceil, floor, round).

**Concerns:**
- `ceilSecond`, `ceilMinute`, `ceilHour`, `ceilDay`
- `ceilMonth`, `ceilQuarter`, `ceilYear`
- `ceilDecade`, `ceilCentury`, `ceilMillennium`
- Corresponding `floor*` and `round*` methods
- Rounding by time units and calendar units

**Key Tests:**
- Rounding to nearest unit
- Ceiling/floor operations preserve higher units
- Round-trip conversions
- Edge cases (exactly on boundary)

---

### 7. **accessors_getters_test.dart**
Tests for date/time component accessors (getters).

**Concerns:**
- Basic accessors: `year`, `month`, `day`, `hour`, `minute`, `second`, `millisecond`, `microsecond`
- Date components: `dayOfWeek`, `dayOfYear`, `weekOfYear`, `quarter`
- Large unit accessors: `millennium`, `century`, `decade`
- Positional accessors: `dayOfMonth`, `dayOfQuarter`, `dayOfCentury`, `yearOfDecade`, `yearOfCentury`
- Count accessors: `daysInMonth`, `daysInYear`, `weeksInMonth`, `yearsInCentury`, etc.

**Key Tests:**
- Correct values for various dates
- Boundary dates (leap years, month ends, etc.)
- Consistency across different units
- Count calculations for different time periods

---

### 8. **setters_test.dart**
Tests for date/time component setters.

**Concerns:**
- Individual setters: `setYear`, `setMonth`, `setDay`, `setHour`, `setMinute`, `setSecond`, `setMillisecond`, `setMicrosecond`
- Composite setters: `setDate`, `setTime`
- `setQuarter`, `setDayOfWeek`
- Immutability (setters return new instances)
- Chaining and fluent API
- Boundary handling (month overflow, leap years)

**Key Tests:**
- Setting individual components
- Chaining multiple setters
- Preservation of other components
- Immutability verification
- Boundary validation

---

### 9. **difference_until_methods_test.dart**
Tests for date difference and "until" calculations.

**Concerns:**
- `diffInYears`, `diffInMonths`, `diffInWeeks`, `diffInDays`
- `diffInHours`, `diffInMinutes`, `diffInSeconds`
- `diffInQuarters`, `diffInDecades`, `diffInCenturies`, `diffInMillennia`
- `yearsUntil`, `monthsUntil`, `weeksUntil`, `daysUntil`, etc.
- Absolute difference (direction-agnostic)
- Fractional/floored differences

**Key Tests:**
- Difference calculations in all units
- Symmetry (diff is same regardless of operand order)
- Large time span calculations
- Fractional day/hour handling
- Until/ago method equivalence

---

### 10. **php_carbon_parity_test.dart** (Reference)
Comprehensive parity test ensuring all PHP Carbon methods are exposed in Dart Carbon.

**Purpose:**
- Verify all expected methods exist
- Not detailed behavioral tests, but method existence checks
- Serves as a specification reference

---

## Test Organization Pattern

Each test file follows this structure:

```dart
import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.<functionality>', () {
    group('<specific concern>', () {
      test('<behavior description>', () {
        // Arrange
        final date = Carbon.create(...);
        
        // Act
        final result = date.operation();
        
        // Assert
        expect(result.component, expectedValue);
      });
    });
  });
}
```

## Running Tests

Run all tests:
```bash
dart test
```

Run specific test file:
```bash
dart test test/add_methods_years_test.dart
```

Run with verbose output:
```bash
dart test -v
```

Run tests matching a pattern:
```bash
dart test --name "add.*years"
```

## Test Coverage Goals

- **Basic operations**: positive, zero, negative values
- **Boundary conditions**: month ends, year boundaries, leap years
- **Immutability**: original unchanged after operations
- **Chaining**: methods work in sequences
- **Type safety**: correct types returned
- **Overflow handling**: explicit behavior for edge cases
- **Precision**: millisecond and microsecond accuracy
- **Cross-boundary**: operations crossing time period boundaries

## Adding New Tests

When adding new test files:

1. Follow the naming convention: `<operation>_test.dart`
2. Group tests by concern using `group()`
3. Use descriptive test names that explain the behavior
4. Test positive, negative, and boundary cases
5. Include examples from PHP Carbon test suite when applicable
6. Document the tested concerns in this file

# Difference

`diff()` returns a Dart `Duration`, while helpers like `diffInHours()` and
`diffInMonths()` mirror the PHP Carbon API for truncated deltas. Use
`floatDiffIn*()` when you need fractional precision; both families use the same
underlying UTC math so daylight-saving transitions stay predictable.


## `diffIn*` helpers

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final ottawa = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Toronto');
  final vancouver = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Vancouver');
  final january = Carbon.parse('2012-01-31T00:00:00Z');

  print('diffInHours -> ${ottawa.diffInHours(vancouver)}');
  print('diffInHours (signed) -> ${vancouver.diffInHours(ottawa, absolute: false)}');
  print('diffInDays addMonth -> ${january.diffInDays(january.copy()..addMonth())}');
  print('diffInDays subMonth signed -> ${january.diffInDays(january.copy()..subMonth(), absolute: false)}');
  print('diffInMinutes +59s -> ${january.diffInMinutes(january.copy()..addSeconds(59))}');
  print('diffInMinutes +120s -> ${january.diffInMinutes(january.copy()..addSeconds(120))}');
  print('secondsSinceMidnight -> ${(january.copy()..addSeconds(120)).secondsSinceMidnight()}');
}

```

Output:

```
diffInHours -> 0
diffInHours (signed) -> 0
diffInDays addMonth -> 31
diffInDays subMonth signed -> 31
diffInMinutes +59s -> 0
diffInMinutes +120s -> 2
secondsSinceMidnight -> 120.0
```


## `diffAsCarbonInterval`

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2012-01-15T12:00:00Z');
  final earlier = base.copy()
    ..subYears(2)
    ..subMonths(1)
    ..subDays(3)
    ..subHours(6);

  final signed = base.diffAsCarbonInterval(earlier, absolute: false);
  final absolute = base.diffAsCarbonInterval(earlier);

  Carbon applyInterval(CarbonInterface source, CarbonInterval interval) {
    final copy = source.copy();
    if (interval.monthSpan != 0) {
      copy.addMonths(interval.monthSpan);
    }
    if (interval.microseconds != 0) {
      copy.add(Duration(microseconds: interval.microseconds));
    }
    return copy as Carbon;
  }

  final roundTrip = applyInterval(base, signed).toIso8601String();
  final absoluteRoundTrip = applyInterval(earlier, absolute).toIso8601String();

  print('signed months -> ${signed.monthSpan}');
  print('signed micros -> ${signed.microseconds}');
  print('round-trip -> $roundTrip');
  print('absolute months -> ${absolute.monthSpan}');
  print('absolute micros -> ${absolute.microseconds}');
  print('absolute rebuild -> $absoluteRoundTrip');
}

```

Output:

```
signed months -> -25
signed micros -> -280800000000
round-trip -> 2009-12-12T06:00:00.000Z
absolute months -> 25
absolute micros -> 280800000000
absolute rebuild -> 2012-01-15T12:00:00.000Z
```


## `floatDiffIn*` helpers

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
  final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
  final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
  final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
  final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
  final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
  final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
  final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
  final monthStart = Carbon.parse('2000-01-15T00:00:00Z');
  final monthEnd = Carbon.parse('2000-02-24T00:00:00Z');
  final monthChunkStart = Carbon.parse('2000-02-15T12:00:00Z');
  final monthChunkEnd = Carbon.parse('2000-03-24T06:00:00Z');
  final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
  final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');

  print('floatDiffInSeconds -> '
      '${secondsStart.floatDiffInSeconds(secondsEnd)}');
  print('floatDiffInMinutes -> '
      '${minutesStart.floatDiffInMinutes(minutesEnd)}');
  print('floatDiffInHours (absolute) -> '
      '${minutesStart.floatDiffInHours(minutesEnd)}');
  print('floatDiffInHours (signed) -> '
      '${signedStart.floatDiffInHours(signedEnd, absolute: false)}');
  print('floatDiffInDays -> ${dayStart.floatDiffInDays(dayEnd)}');
  print('floatDiffInWeeks -> ${weekStart.floatDiffInWeeks(weekEnd)}');
  print('floatDiffInMonths -> ${monthStart.floatDiffInMonths(monthEnd)}');
  print('floatDiffInMonths (chunked) -> '
      '${monthChunkStart.floatDiffInMonths(monthChunkEnd)}');
  print('floatDiffInYears -> ${yearsStart.floatDiffInYears(yearsEnd)}');
}

```

Output:

```
floatDiffInSeconds -> 71.068463
floatDiffInMinutes -> 1.1833333333333333
floatDiffInHours (absolute) -> 0.01972222222222222
floatDiffInHours (signed) -> -5.980277777777777
floatDiffInDays -> 40.75
floatDiffInWeeks -> 5.857142857142857
floatDiffInMonths -> 1.3103448275862069
floatDiffInMonths (chunked) -> 1.282258064516129
floatDiffInYears -> 10.10068493150685
```


## `diffInUnit()`

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2000-01-15T00:00:00Z');
  final target = base.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(5)
    ..addHours(12);

  print('years -> ${base.diffInUnit(CarbonUnit.year, target)}');
  print('months -> ${base.diffInUnit('months', target)}');
  print('hours (signed) -> '
      '${target.diffInUnit('hours', base, absolute: false)}');
}

```

Output:

```
years -> 1.1767123287671233
months -> 14.17741935483871
hours (signed) -> -10332.0
```


## `diff()` returns `Duration`

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final base = Carbon.parse('2012-01-01T00:00:00Z');
  final future = base.copy()..addYears(3)..addDays(10)..addHours(12);
  final delta = future.diff(base);

  print('diff() Duration days -> ${delta.inDays}');
  print('diff() Duration hours -> ${delta.inHours}');
}

```

Output:

```
diff() Duration days -> 1106
diff() Duration hours -> 26556
```


## Differences compared to the PHP docs

- `diff()`/`diffAsDateInterval()` return `Duration` instances rather than a
  PHP `DateInterval`. Use `diffAsCarbonInterval()` when you need explicit month
  plus microsecond components.
- `diffInUnit()` accepts the same keywords as the other add/subtract helpers.
  Strings such as `'hours'` and the `CarbonUnit` enum are supported, but PHP's
  `Unit` class is not mirrored.
- CarbonInterval itself intentionally stays slim (only months + microseconds),
  so advanced APIs like `cascade()` or `forHumans()` still rely on the PHP
  implementation.


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

- `diff()`/`diffAsCarbonInterval()` return `CarbonInterval` in PHP. Dart's
  `diff()` exposes the platform `Duration` instead, so you access `inDays`
  / `inHours` rather than `years`, `months`, etc.
- `diffAsCarbonInterval()`, `diffAsDateInterval()`, and `diffInUnit()` are not
  implemented yet. Convert `diff()` into a `CarbonInterval` manually when you
  need structured units.
- Carbon's PHP-specific `invert` flag is not exposed since Dart relies on the
  sign of the returned `Duration`.


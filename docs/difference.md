# Difference

`diff()` returns a Dart `Duration`, while helpers like `diffInHours()` and
`diffInMonths()` mirror the PHP Carbon API for integer-based deltas. Signed
results require `absolute: false`, and timezone math stays consistent because
everything is computed in UTC internally.


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
- `diffAsCarbonInterval()`, `diffAsDateInterval()`, `diffInUnit()`, and the
  `floatDiffIn*()` family are not implemented. Use the existing `diffIn*()` int
  helpers or compute fractional durations manually.
- Carbon's PHP-specific `invert` flag is not exposed since Dart relies on the
  sign of the returned `Duration`.


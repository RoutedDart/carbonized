# Modifiers

Start/end helpers (`startOfDay()`, `endOfMonth()`, `startOfQuarter()`),
navigation helpers (`next()`, `previous()`, `average()`), and rounding helpers
(`roundSecond()`, `ceilMinute()`, `floorUnit()`) behave like the PHP docs.
Modifiers always return `CarbonInterface`, so they can be chained fluently.


## Start/end helpers

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  print('startOfMinute -> ${dt.copy().startOfMinute()}');
  print('endOfHour -> ${dt.copy().endOfHour()}');
  print('startOfDay -> ${dt.copy().startOfDay()}');
  print('endOfMonth -> ${dt.copy().endOfMonth()}');
  print('startOfQuarter -> ${dt.copy().startOfQuarter()}');
}

```

Output:

```
startOfMinute -> 2012-01-31 15:32:00
endOfHour -> 2012-01-31 15:59:59
startOfDay -> 2012-01-31 00:00:00
endOfMonth -> 2012-01-31 23:59:59
startOfQuarter -> 2012-01-01 00:00:00
```


## Navigating weeks and averages

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2014-05-30T00:00:00Z');
  print('next Wednesday -> ${dt.copy().next(DateTime.wednesday)}');
  print('previous -> ${dt.copy().previous()}');
  final start = Carbon.parse('2014-01-01T00:00:00Z');
  final end = Carbon.parse('2014-01-30T00:00:00Z');
  print('average -> ${start.average(end)}');
}

```

Output:

```
next Wednesday -> 2014-06-04 00:00:00
previous -> 2014-05-23 00:00:00
average -> 2014-01-15 12:00:00
```


## Rounding helpers

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  print('roundSecond -> ${dt.copy().roundSecond()}');
  print('ceilMinute -> ${dt.copy().ceilMinute()}');
  print('floorHour -> ${dt.copy().floorHour()}');
}

```

Output:

```
roundSecond -> 2012-01-31 15:32:46
ceilMinute -> 2012-01-31 15:33:00
floorHour -> 2012-01-31 15:00:00
```


## Differences compared to the PHP docs

- `Carbon::setMidDayAt()` / `getMidDayAt()` are not available. `midDay()` always
  targets noon (12:00) today.
- `nthOfMonth()`/`firstOfMonth()`/`lastOfQuarter()` exist, but string-based
  weekday parsing only accepts English names (matching the current locale
  dictionary).
- Rounding helpers currently operate on UTC instants. There is no dedicated
  `roundFloor()`/`roundCeil()` that respect custom timezones beyond the instance
  timezone.


# Getters

PHP Carbon exposes dozens of `__get()` aliases (`$date->year`,
`$date->englishDayOfWeek`, etc.). Dart Carbon mirrors the surface area via real
getters on `CarbonInterface`, so you still access values with property syntax
(`carbon.year`, `carbon.dayOfWeek`, `carbon.isoWeek`, …) while keeping the type
system happy.


## Date and time components

Every calendar component from the PHP docs (year/month/day, ISO week numbers,
day-of-year, etc.) maps to a strongly typed getter. The example below mirrors
the PHP snippet and demonstrates the most commonly used ones.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2012-10-05T23:26:11.123789Z');

  print('year: ${dt.year}');
  print('month: ${dt.month}');
  print('day: ${dt.day}');
  print('hour: ${dt.hour}');
  print('minute: ${dt.minute}');
  print('second: ${dt.second}');
  print('microsecond: ${dt.microsecond}');
  print('dayOfWeek: ${dt.dayOfWeek}');
  print('isoWeek: ${dt.isoWeek}');
  print('dayOfYear: ${dt.dayOfYear}');
  print('weekOfMonth: ${dt.weekOfMonth}');
  print('weekOfYear: ${dt.weekOfYear}');
  print('daysInMonth: ${dt.daysInMonth}');
  print('timestamp: ${dt.dateTime.millisecondsSinceEpoch ~/ 1000}');
}

```

Output:

```
year: 2012
month: 10
day: 5
hour: 23
minute: 26
second: 11
microsecond: 123789
dayOfWeek: 5
isoWeek: 40
dayOfYear: 279
weekOfMonth: 1
weekOfYear: 40
daysInMonth: 31
timestamp: 1349479571
```


## Localized names

Instead of magic properties like `$carbon->englishDayOfWeek`, reuse
`locale('<code>')` plus `isoFormat()` to render localized names. This keeps the
API consistent with the rest of the documentation and works for any locale
supported by the bundled CLDR data.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('de');

  final dt = Carbon.parse('2012-10-05T23:26:11Z');
  print('English weekday: ${dt.locale('en').isoFormat('dddd')}');
  print('German weekday: ${dt.locale('de').isoFormat('dddd')}');
  print('German month: ${dt.locale('de').isoFormat('MMMM')}');
}

```

Output:

```
English weekday: Friday
German weekday: Freitag
German month: Oktober
```


## Timezone metadata

Use `toDebugMap()` when you need the same timezone payload that PHP's
`Carbon::__debugInfo()` returns. The `timezone` entry includes the canonical
name, abbreviation, formatted offset, raw seconds, and DST flag. Project into a
new zone via `tz('<zone>')` just like in the PHP docs.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final toronto = Carbon.parse(
    '2022-01-24 10:45',
    timeZone: 'America/Toronto',
  );
  final zoneInfo = toronto.toDebugMap()['timezone'] as Map<String, Object?>;

  print('tz name: ${zoneInfo['name']}');
  print('offset: ${zoneInfo['offset']}');
  print('offsetSeconds: ${zoneInfo['offsetSeconds']}');
  print('UTC iso: ${toronto.toUtc().toIso8601String()}');
}

```

Output:

```
tz name: America/Toronto
offset: -05:00
offsetSeconds: -18000
UTC iso: 2022-01-24T15:45:00.000Z
```


## Differences compared to the PHP docs

- Dart does not use `__get()`, so helpers like `englishDayOfWeek`,
  `shortEnglishMonth`, or `weekNumberInMonth` are not surfaced as dynamic
  properties. Use the typed getters (`dayOfWeek`, `weekOfMonth`, `isoWeek`) or
  `isoFormat()` for localized names.
- There is no `utcOffset()` setter. Call `tz('<zone>')` or `toUtc()`/`toLocal()`
  to project an instance into another timezone; inspect offsets via
  `toDateTimeView().timeZoneOffset`.
- PHP's `timestamp`/`getTimestamp()` helpers correspond to
  `toEpochMilliseconds()` or `dateTime.millisecondsSinceEpoch` in Dart since the
  type always stores UTC internally.


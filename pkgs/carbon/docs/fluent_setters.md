# Fluent Setters

PHP Carbon lets you call `$date->year(1975)->month(5)…` thanks to `__call`
magic. Dart Carbon favors explicit `setYear`/`setMonth` helpers that return the
mutated instance, so you can still chain them fluently while keeping analyzer
support and autocompletion.


## Chaining typed setters

Each `set*` helper (plus aliases like `years()`) returns the mutated `Carbon`
instance, which makes fluent chains behave like the PHP docs. Microseconds and
timezone projections work the same way.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final value = Carbon.parse('2001-01-01T01:01:01.200000Z');
  value
    ..setYear(1975)
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5)
    ..setMicroseconds(123456);

  print(value.toIso8601String());
}

```

Output:

```
1975-05-21T22:32:05.123456Z
```


## Grouped setters (`setDate*` family)

Use `setDate`, `setTime`, and `setTimeFrom()` when you need to update multiple
components at once. The return type is still `CarbonInterface`, so you can keep
chaining additional modifiers.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final base = Carbon.parse('2001-01-01T01:01:01.200000Z');
  final setDateTime = base.copy()
    ..setDate(1975, 5, 21)
    ..setTime(22, 32, 5, 123456);
  final preciseSource = Carbon.parse('1975-05-21T22:32:05.123456Z');
  final viaCopy = base.copy()
    ..setDate(1975, 5, 21)
    ..setTimeFrom(preciseSource);

  print('setDate/setTime -> ${setDateTime.toIso8601String()}');
  print('setTimeFrom -> ${viaCopy.toIso8601String()}');
}

```

Output:

```
setDate/setTime -> 1975-05-21T22:34:08.456Z
setTimeFrom -> 1975-05-21T22:32:05.123456Z
```


## Copying date/time parts from other instances

`setTimeFrom`, `setDateFrom`, and `setDateTimeFrom` mirror the PHP helpers for
copying fields from another `CarbonInterface` or `DateTime`. Locale, timezone,
and settings remain untouched, matching the behavior documented on the PHP
site.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final source = Carbon.parse('2010-05-16T22:40:10.100000Z');
  final target = Carbon.parse('2001-01-01T01:01:01.200000Z');

  final fromTime = target.copy()..setTimeFrom(source);
  final fromDate = target.copy()
    ..setDateFrom(Carbon.fromDateTime(DateTime.utc(2013, 9, 1, 9, 22, 56)));
  final fromBoth = target.copy()..setDateTimeFrom(source);

  print('setTimeFrom -> ${fromTime.toIso8601String()}');
  print('setDateFrom -> ${fromDate.toIso8601String()}');
  print('setDateTimeFrom -> ${fromBoth.toIso8601String()}');
}

```

Output:

```
setTimeFrom -> 2001-01-01T22:40:10.100Z
setDateFrom -> 2013-09-01T01:01:01.200Z
setDateTimeFrom -> 2010-05-16T22:40:10.100Z
```


## Differences compared to the PHP docs

- Dynamic calls such as `$date->year(1975)` are replaced with explicit
  `setYear(1975)` in Dart because there is no `__call` magic. Alias helpers like
  `years()` still exist for parity.
- Assigning to `$date->timestamp` is now available via `setTimestamp()` or
  `set('timestamp', value)`, which replace the instant without needing a copy.
- PHP's `setDateTime()` helper does not exist; combine `setDate` with `setTime`
  or `setTimeFrom()` instead.
- `setDateTimeFrom()` copies date & time components only; timezone, locale, and
  settings remain on the target instance. This matches PHP Carbon but is worth
  calling out when porting code that expects timezone inheritance.


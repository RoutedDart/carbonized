# Comparison

Equality/ordering helpers (`equalTo()`, `greaterThan()`, `isAfter()`, etc.) use
the underlying instant (UTC) so two values with different timezone labels still
compare correctly. Range helpers such as `between()`, `min()`, `max()`,
`closest()`, and `farthest()` behave exactly like the PHP docs describe.


## Equality and ordering respect timezones

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final first = Carbon.parse('2012-09-05T23:26:11Z');
  final second = Carbon.parse(
    '2012-09-05T20:26:11',
    timeZone: 'America/Vancouver',
  );

  print('equalTo -> ${first.equalTo(second)}');
  print('notEqualTo -> ${first.notEqualTo(second)}');
  print('greaterThan -> ${first.greaterThan(second)}');
  print('lessThanOrEqual -> ${first.lessThanOrEqual(second)}');
  print('isAfter -> ${first.isAfter(second)}');
  print('isBefore -> ${first.isBefore(second)}');
}

```

Output:

```
equalTo -> false
notEqualTo -> true
greaterThan -> false
lessThanOrEqual -> true
isAfter -> false
isBefore -> true
```


## Range helpers (`between`, `min`, `closest`, `farthest`)

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final start = Carbon.parse('2012-09-05T01:00:00Z');
  final end = Carbon.parse('2012-09-05T05:00:00Z');
  print('3am between -> ${Carbon.parse('2012-09-05T03:00:00Z').between(start, end)}');
  print('5am between (inclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').betweenIncluded(start, end)}');
  print('5am between (exclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').between(start, end, inclusive: false)}');

  final dt1 = Carbon.parse('2010-04-01T00:00:00Z');
  final dt2 = Carbon.parse('2010-03-28T00:00:00Z');
  final dt3 = Carbon.parse('2010-04-16T00:00:00Z');
  print('min -> ${dt1.min(dt2).toIso8601String()}');
  print('max -> ${dt1.max(dt3).toIso8601String()}');
  print('closest -> ${dt1.closest(dt2, dt3).toIso8601String()}');
  print('farthest -> ${dt1.farthest(dt2, dt3).toIso8601String()}');
}

```

Output:

```
3am between -> true
5am between (inclusive) -> true
5am between (exclusive) -> false
min -> 2010-03-28T00:00:00.000Z
max -> 2010-04-16T00:00:00.000Z
closest -> 2010-03-28T00:00:00.000Z
farthest -> 2010-04-16T00:00:00.000Z
```


## Calendar predicates

Use helpers such as `isFuture()`, `isPast()`, `isSameMonth()`, `isCurrentYear()`,
and `isWeekend()` instead of reimplementing calendar math.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final reference = Carbon.parse('2024-06-05T12:00:00Z');
  final birthday = Carbon.parse('1987-04-23T00:00:00Z');

  print('isFuture -> ${reference.isFuture()}');
  print('isPast -> ${birthday.isPast()}');
  print('isSameMonth -> ${reference.isSameMonth(reference.copy().addDays(10))}');
  print('isCurrentYear -> ${reference.isCurrentYear()}');
  print('isWeekend -> ${reference.isWeekend()}');
}

```

Output:

```
isFuture -> false
isPast -> true
isSameMonth -> true
isCurrentYear -> false
isWeekend -> false
```


## Differences compared to the PHP docs

- `isSameAs('<format>', other)` and the string-based `is('Sunday')`/
  `is('June')` helpers are not implemented. Compose predicates using the typed
  helpers (`isSameDay`, `isSameMonth`, `isWeekend`, etc.) instead.
- `equalTo()`/`min()`/`max()` currently accept `CarbonInterface`/`DateTime`
  inputs. Comparisons against `CarbonInterval`/`CarbonPeriod` will be added in a
  later pass.
- PHP's microsecond caveat does not apply—Dart always compares the full instant
  since the VM retains microsecond precision.


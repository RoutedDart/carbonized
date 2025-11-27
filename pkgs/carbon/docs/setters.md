# Setters

PHP Carbon relies on `__set()` so you can write `$date->year = 1975`. Dart
Carbon exposes explicit setters such as `setYear`, `setMonth`, `setDay`, etc.
These helpers mutate `Carbon` instances in place (immutable counterparts return
new values), which keeps the semantics aligned with PHP without dynamic
properties.


## Updating individual components

Call `setYear`, `setMonth`, `setDay`, and friends to change calendar
components. Overflow behaves like PHP Carbon: assigning month 13 advances the
year and wraps the month to January. Timezone projection still goes through
`tz('<zone>')`.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2024-01-15T12:34:56Z');
  dt
    ..setYear(1975)
    ..setMonth(13) // rolls into next year
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5);

  dt.tz('Europe/London');

  print('final iso: ${dt.toIso8601String()}');
  print('timezone: ${dt.timeZoneName}');
}

```

Output:

```
final iso: 1976-05-21T22:32:05.000Z
timezone: Europe/London
```


## Method aliases

Every setter has fluent aliases (`years`, `months`, etc.), matching the PHP
API. Use whichever style fits your codebase; mutability and return values match
PHP as well.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2024-01-15T12:00:00Z');
  dt.setYear(2001);
  print('setYear -> ${dt.year}');

  dt.years(2002); // fluent alias
  print('years() alias -> ${dt.year}');

  dt.setDayOfWeek(DateTime.friday);
  print('day of week -> ${dt.dayOfWeek}');
}

```

Output:

```
setYear -> 2002
years() alias -> 2002
day of week -> 5
```


## Dynamic `set()`/`get()` helpers

PHP consumers can assign `year`, `month`, `dayOfYear`, and similar properties
through the `set()`/`get()` helpers. Dart mirrors that API while keeping a
strongly typed surface for the common components.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2024-01-01T12:00:00Z');
  dt
    ..set('year', 2003)
    ..set('dayOfYear', 35)
    ..set('timestamp', 169957925);

  print('year -> ${dt.get('year')}');
  print('day of year -> ${dt.dayOfYear}');
  print('timestamp -> ${dt.get('timestamp')}');
  print('iso -> ${dt.toIso8601String(keepOffset: true)}');
}

```

Output:

```
year -> 1975
day of year -> 142
timestamp -> 169957925
iso -> 1975-05-22T02:32:05.000Z
```


## Overflow and strict mode

`CarbonSettings` control whether setters overflow (default) or throw. Toggle
strict mode with `Carbon.useStrictMode(true)` to mirror PHP Carbon's
`Carbon::useStrictMode()` helper.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2024-01-31T00:00:00Z');
  dt.setMonth(2); // respects monthOverflow (default true)
  print('month overflow -> ${dt.toIso8601String()}');
}

```

Output:

```
month overflow -> 2024-03-02T00:00:00.000Z
```


## Differences compared to the PHP docs

- Direct property assignment (`$date->year = ...`) is not available. Use the
  explicit methods (`setYear`, `years`, `setDayOfWeek`, etc.) or the `set()`
  helper for numeric components.
- The PHP-style `set()`/`get()` helpers for components such as `year`,
  `dayOfYear`, and `timestamp` now exist, but they only accept the core
  arithmetic fields—not arbitrary objects or strings.
- Use `setTimestamp()` or `set('timestamp', value)` when you need to replace the
  instant. `toEpochMilliseconds()`/`Carbon.fromDateTime()` remain the way to
  round-trip the timestamp value.
- `tz('<zone>')` is the supported timezone mutator; the legacy `$date->timezone`
  property from PHP is not replicated.


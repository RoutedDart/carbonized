# Weeks

Locale metadata in Carbon defines the start of the week, weekend days, and the
threshold used for ISO week calculations. The Dart port loads the same locale
tables as PHP Carbon and exposes identical helpers such as `startOfWeek()`,
`endOfWeek()`, `isoWeek`, and `weeksInYear`. You can override the defaults via
`Carbon.setWeekStartsAt()` / `Carbon.setWeekendDays()` when you need
application-specific values.


## Locale-driven boundaries

Locales determine `startOfWeek()`/`endOfWeek()` as well as the default weekend
list. Switching from `en_US` (Sunday weeks) to Arabic (`ar`) mirrors the PHP
behavior without extra configuration, and you can still pass an explicit
weekday to `startOfWeek()` when you need a custom baseline.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('ar');

  Carbon.setLocale('en_US');
  final en = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('ar');
  final ar = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('en');

  print('en startOfWeek -> ${en.startOfWeek().isoFormat('YYYY-MM-DD')}');
  print('en endOfWeek -> ${en.endOfWeek().isoFormat('YYYY-MM-DD')}');
  print('ar startOfWeek -> ${ar.startOfWeek().isoFormat('YYYY-MM-DD')}');
  print('ar endOfWeek -> ${ar.endOfWeek().isoFormat('YYYY-MM-DD')}');
}

```

Output:

```
en startOfWeek -> 2025-11-09
en endOfWeek -> 2025-11-15
ar startOfWeek -> 2025-11-08
ar endOfWeek -> 2025-11-14
```


## Week numbers and week-based years

Use the strongly typed getters to inspect locale vs. ISO week numbers. The
example mirrors the PHP docs by showing both numbering systems and their
corresponding week-based years.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2017-02-05T00:00:00Z');
  print('localeWeek -> ${date.localeWeek}');
  print('isoWeek -> ${date.isoWeek}');
  print('localeWeekYear -> ${date.localeWeekYear}');
  print('isoWeekYear -> ${date.isoWeekYear}');
  print('weeksInYear -> ${date.weeksInYear}');
  print('isoWeeksInYear -> ${date.isoWeeksInYear}');
}

```

Output:

```
localeWeek -> 6
isoWeek -> 5
localeWeekYear -> 2017
isoWeekYear -> 2017
weeksInYear -> 53
isoWeeksInYear -> 52
```


## Moving between weeks

`setWeekNumber()` and `setIsoWeekNumber()` mirror PHP's setter-style helpers.
Use them to move relative to locale or ISO weeks while keeping the day/time
intact.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-06-05T00:00:00Z');
  final week = date.weekNumber();
  final moved = date.copy().setWeekNumber(week + 2);
  final isoMoved = date.copy().setIsoWeekNumber(2);

  print('weekNumber -> $week');
  print('setWeekNumber(week+2) -> ${moved.isoFormat('YYYY-MM-DD')}');
  print('setIsoWeekNumber(2) -> ${isoMoved.isoFormat('YYYY-MM-DD')}');
}

```

Output:

```
weekNumber -> 23
setWeekNumber(week+2) -> 2024-06-19
setIsoWeekNumber(2) -> 2024-01-10
```


## Jumping to another weekday

`setDayOfWeek()` reprojects a date onto another weekday using Carbon's locale
rules, which is the Dart equivalent of calling `weekday()`/`isoWeekday()` in the
PHP docs. You can chain it with other helpers (start/end of week, `next()`/`previous()`)
to build the same flows showcased on carbon.nesbot.com.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2017-02-05T00:00:00Z');
  final weekday = date.copy()..setDayOfWeek(DateTime.wednesday);

  print('weekday -> ${weekday.toIso8601String()}');
}

```

Output:

```
weekday -> 2017-02-01T00:00:00.000Z
```


## Days since start of week

`getDaysFromStartOfWeek()`/`setDaysFromStartOfWeek()` mirror the PHP helpers.
You can query how many days have elapsed since the locale-defined start and
jump to another offset using either locale defaults or custom weekday inputs.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-06-05T00:00:00Z');
  print('default days -> ${date.getDaysFromStartOfWeek()}');
  print("sunday start -> ${date.getDaysFromStartOfWeek('sunday')}");

  final monday = date.copy()..setDaysFromStartOfWeek(0);
  final tuesdayFromSunday = date.copy()..setDaysFromStartOfWeek(2, 'sunday');

  print('setDaysFromStartOfWeek(0) -> ${monday.toIso8601String()}');
  print("setDaysFromStartOfWeek(2, 'sunday') -> ${tuesdayFromSunday.toIso8601String()}");
}

```

Output:

```
default days -> 2
sunday start -> 3
setDaysFromStartOfWeek(0) -> 2024-06-03T00:00:00.000Z
setDaysFromStartOfWeek(2, 'sunday') -> 2024-06-04T00:00:00.000Z
```


## Differences compared to the PHP docs

- Dart Carbon does not expose the magic properties `firstWeekDay`,
  `lastWeekDay`, or `weekendDays`. Inspect `Carbon.defaultSettings.startOfWeek`
  and `Carbon.getWeekendDays()` instead.
- PHP's `week()`/`isoWeek()` setter-style helpers map to
  `setWeekNumber()`/`setIsoWeekNumber()` in Dart so the API stays strongly
  typed.
- Passing overrides (like custom first weekday) directly to
  `weeksInYear()`/`weekYear()` methods is not supported; configure the global
  defaults via `Carbon.setWeekStartsAt()` before calling the getters.


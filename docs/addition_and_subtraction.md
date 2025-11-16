# Addition and Subtraction

Carbon exposes the same additive helpers as PHP Carbon (`addYears()`,
`addWeekdays()`, `addRealHours()`, etc.) plus the `change()`/`modify()` shortcut
for natural-language adjustments. All mutators keep the "mutable vs immutable"
contract intact: `Carbon` mutates in place, `CarbonImmutable` returns copies.


## Typed helpers for calendar math

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2012-01-31T00:00:00Z');
  print('addYears -> ${(base.copy()..addYears(1)).toIso8601String()}');
  print('addMonths -> ${(base.copy()..addMonths(1)).toIso8601String()}');
  print('addWeekdays -> ${(base.copy()..addWeekdays(4)).toIso8601String()}');
  print('addWeeks -> ${(base.copy()..addWeeks(3)).toIso8601String()}');
  print('addHours -> ${(base.copy()..addHours(24)).toIso8601String()}');
  print('addRealHours -> ${(base.copy()..addRealHours(36)).toIso8601String()}');
}

```

Output:

```
addYears -> 2013-01-31T00:00:00.000Z
addMonths -> 2012-03-02T00:00:00.000Z
addWeekdays -> 2012-02-06T00:00:00.000Z
addWeeks -> 2012-02-21T00:00:00.000Z
addHours -> 2012-02-01T00:00:00.000Z
addRealHours -> 2012-02-01T12:00:00.000Z
```


## Generic `add`/`sub` and `change()`

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-02-03T00:00:00Z');
  print("add(Duration(days: 1)) -> ${(dt.copy()..add(const Duration(days: 1))).toIso8601String()}");
  print("sub(Duration(hours: 3)) -> ${(dt.copy()..sub(const Duration(hours: 3))).toIso8601String()}");
  print("change('next friday') -> ${(dt.copy()..change('next friday')).toIso8601String()}");
}

```

Output:

```
add(Duration(days: 1)) -> 2012-02-04T00:00:00.000Z
sub(Duration(hours: 3)) -> 2012-02-02T21:00:00.000Z
change('next friday') -> 2012-02-10T00:00:00.000Z
```


## Raw addition vs `add()`

`rawAdd()` and `rawSub()` call `DateTime.add()`/`subtract()` directly, mirroring
PHP's native `rawAdd()`/`rawSub()` helpers.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2024-01-01T00:00:00Z');
  print('rawAdd -> ${(base.copy()..rawAdd(const Duration(days: 1))).toIso8601String()}');
  print('rawSub -> ${(base.copy()..rawSub(const Duration(hours: 3))).toIso8601String()}');
}

```

Output:

```
rawAdd -> 2024-01-02T00:00:00.000Z
rawSub -> 2023-12-31T21:00:00.000Z
```


## `shiftTimezone()` (vs `tz()`)

`shiftTimezone()` reinterprets the current wall time in a different timezone,
while `tz()` keeps the instant intact and merely changes the projection.

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2024-11-10T00:00:00', timeZone: 'UTC');
  final tzProjection = base.copy().tz('Asia/Tokyo');
  final shifted = base.copy().shiftTimezone('Asia/Tokyo');

  print('tz -> ${tzProjection.toIso8601String(keepOffset: true)}');
  print('shiftTimezone -> ${shifted.toIso8601String(keepOffset: true)}');
}

```

Output:

```
tz -> 2024-11-10T14:00:00.000+09:00
shiftTimezone -> 2024-11-10T05:00:00.000+09:00
```


## Differences compared to the PHP docs

- Generic `add()`/`sub()` accept `Duration`, `CarbonInterval`, or explicit
  amount+unit values. Passing free-form strings like `'1 day'` works for the most
  common units, but PHP's `DateInterval` objects and obscure keywords are not
  fully supported.
- Use `rawAdd()`/`rawSub()` to call `DateTime.add()`/`subtract()` directly when you
  want to bypass Carbon-specific rounding or overflow rules.


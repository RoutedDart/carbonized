# Instantiation

PHP Carbon showcases multiple constructor paths (bare constructors, `now()`,
component factories, timestamps, and safe creation helpers). Dart Carbon mirrors
those entry points while leaning on the Time Machine timezone database and
Effective Dart idioms. Every example below calls
`Carbon.configureTimeMachine(testing: true)` so IANA timezone names (like
`America/Vancouver`) resolve the same way they do in PHP.


## Constructors and timezone arguments

`Carbon()` is an alias for `Carbon.now()` and accepts the same first argument as
PHP Carbon: a string, timestamp, `DateTime`, or existing `CarbonInterface`
instance. The optional `timeZone` parameter takes an IANA name or a fixed offset
string such as `+13:30`. Dart does not expose PHP's `DateTimeZone` type, so pass
the textual identifier directly after configuring the timezone database.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-01-15T10:00:00Z');

  final implicitNow = Carbon();
  final viaString = Carbon('first day of January 2008', 'America/Vancouver');
  final fromDateTime = Carbon(DateTime.utc(2008, 1, 1), 'America/Vancouver');
  final londonNow = Carbon.now(timeZone: 'Europe/London');
  final fixedOffset = Carbon.now(timeZone: '+13:30');

  print('implicitNow: ${implicitNow.toIso8601String()}');
  print(
    'viaString: ${viaString.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${viaString.timeZoneName})',
  );
  print('fromDateTime zone: ${fromDateTime.timeZoneName}');
  print('london offset: ${londonNow.isoFormat('ZZ')}');
  print('fixed offset name: ${fixedOffset.timeZoneName}');

  Carbon.setTestNow();
}

```

Output:

```
implicitNow: 2024-01-15T10:00:00.000Z
viaString: 2008-01-01 00:00 (America/Vancouver)
fromDateTime zone: America/Vancouver
london offset: +0000
fixed offset name: +13:30
```


## Component factories and `create*` helpers

The positional factory from PHP is available via `Carbon.createPhp`, while the
named `Carbon.create` constructor uses explicit parameters. `createFromDate`
and `createFromTime*` fill omitted components with the current (or test) clock,
and `Carbon.make()` returns `null` when the input cannot be parsed.
`createFromFormat()` supports PHP tokens (including `!`/`|` modifiers) by
translating them into ISO-style patterns, and `Carbon.lastErrorsSnapshot()`
captures parse warnings just like PHP's `DateTime::getLastErrors()`.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-06-15T09:30:00-05:00');

  final christmas = Carbon.createFromDate(null, 12, 25);
  final y2k = Carbon.createPhp(2000, 1, 1, 0, 0, 0)!;
  final alsoY2k = Carbon.createPhp(1999, 12, 31, 24)!;
  final noonLondon = Carbon.createFromTime(12, 0, 0, 0, 'Europe/London');
  final teaTime = Carbon.createFromTimeString('17:00:00', timeZone: 'Europe/London');
  final fromFormat = Carbon.createFromFormat('Y-m-d H', '1975-05-21 22');
  final viaMake = Carbon.make('2023-03-01');
  final invalidMake = Carbon.make('not a date');

  print('christmas defaults year: ${christmas.toIso8601String()}');
  print('y2k: ${y2k.toIso8601String()}');
  print('also y2k: ${alsoY2k.toIso8601String()}');
  print(
    'noon London: ${noonLondon.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${noonLondon.timeZoneName})',
  );
  print(
    'tea time: ${teaTime.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${teaTime.timeZoneName})',
  );
  print('from format: ${fromFormat.toIso8601String()}');
  print('via make: ${viaMake?.toIso8601String()}');
  print('invalid make: $invalidMake');

  Carbon.setTestNow();
}

```

Output:

```
christmas defaults year: 2024-12-25T00:00:00.000Z
y2k: 2000-01-01T00:00:00.000Z
also y2k: 2000-01-01T00:00:00.000Z
noon London: 2024-06-15 11:00 (Europe/London)
tea time: 2024-06-15 16:00 (Europe/London)
from format: 1975-05-21T22:30:00.000Z
via make: 2023-03-01T05:00:00.000Z
invalid make: null
```


## Safe and strict creation

`Carbon.create()` delegates to Dart's `DateTime`, so overflowing values (like
day 35) roll into the next month the same way PHP does. Use `Carbon.createSafe()`
when you want a nullable result instead of implicit overflow. To mirror PHP's
`InvalidDateException`, call `Carbon.createStrict()`, which temporarily enables
strict mode and throws whenever a component is invalid or falls inside a DST
gap (see the `Europe/London` example below).

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final previousStrict = Carbon.isStrictModeEnabled();
  Carbon.useStrictMode(false);

  final overflow = Carbon.create(year: 2000, month: 1, day: 35, hour: 13);
  print('create overflow: ${overflow.toIso8601String()}');

  final safe = Carbon.createSafe(2000, 1, 35, 13, 0, 0);
  print('createSafe result: $safe');

  final skippedHour =
      Carbon.createSafe(2014, 3, 30, 1, 30, 0, 0, 'Europe/London');
  print('DST gap result: $skippedHour');

  Carbon.useStrictMode(previousStrict);

  try {
    Carbon.createStrict(2000, 1, 35, 13, 0, 0);
  } on CarbonInvalidDateException catch (error) {
    print('createStrict throws: ${error.message}');
  }
}

```

Output:

```
create overflow: 2000-02-04T13:00:00.000Z
createSafe result: null
DST gap result: null
createStrict throws: Invalid value for day: 35
```


## Working with Unix timestamps

`createFromTimestamp()` accepts ints, doubles, or timestamp-like strings and
respects the optional timezone argument (defaulting to UTC since Carbon 3).
`createFromTimestampUTC()` always projects the result into UTC, while
`createFromTimestampMs()`/`createFromTimestampMsUTC()` operate on milliseconds.
Negative timestamps and fractional seconds behave the same way they do in PHP.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final seconds = Carbon.createFromTimestamp(-1);
  final fractional = Carbon.createFromTimestamp(-1.5, timeZone: 'Europe/London');
  final utc = Carbon.createFromTimestampUTC(-1);
  final millis = Carbon.createFromTimestampMs(1685724000123, timeZone: 'Asia/Tokyo');

  print('seconds: ${seconds.toIso8601String()}');
  print('fractional: ${fractional.isoFormat('YYYY-MM-DD HH:mm:ss.SSS zz')}');
  print('utc: ${utc.toIso8601String()}');
  print('millis: ${millis.isoFormat('YYYY-MM-DD HH:mm:ss z')}');
}

```

Output:

```
seconds: 1969-12-31T23:59:59.000Z
fractional: 1969-12-31 23:59:58.500 Europe/London
utc: 1969-12-31T23:59:59.000Z
millis: 2023-06-02 16:40:00 152
```


## UTC offset helpers

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-01-01T00:00:00Z');
  print('initial offset -> ${date.utcOffset}');
  date.setUtcOffset(180);
  print('after set -> ${date.utcOffset}');
  print('timezone name -> ${date.timeZoneName}');
}

```

Output:

```
initial offset -> 0
after set -> 180
timezone name -> +03:00
```


## Differences compared to the PHP docs

- No `DateTimeZone` class exists in Dart. Supply the timezone as a string (IANA
  name or `+/-HH:MM` offset) after calling `Carbon.configureTimeMachine()`.
- PHP's mutable `utcOffset()` getter/setter pair is not implemented. Use `tz()`
  to project the instance into a different timezone or fixed offset.
- Format-probing helpers (`Carbon::hasFormatWithModifiers()`, `hasFormat()`,
  `canBeCreatedFromFormat()`) are still TODO. Parsing via `createFromFormat()`
  works, but there is no boolean helper yet.
- `Carbon.createSafe()` returns `null` when strict mode is disabled, whereas the
  PHP version throws immediately. Call `Carbon.createStrict()` in Dart when you
  want that exception-first behavior.


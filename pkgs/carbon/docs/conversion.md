# Conversion

Carbon preserves the PHP conversion helpers: `toArray()`/`toObject()` snapshots,
bridges to platform `DateTime`/`DateTimeImmutable`, and easy switching between
mutable and immutable variants. The structured output mirrors PHP Carbon's keys
so serialized data travels cleanly between languages.


## Snapshot helpers (`toArray()` / `toObject()`)

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');
  final array = dt.toArray();
  final components = dt.toObject();

  print('array year -> ${array['year']}');
  print('array timezone -> ${array['timezone']}');
  print('components formatted -> ${components.formatted}');
  print('components timestamp -> ${components.timestamp}');
}

```

Output:

```
array year -> 2019
array timezone -> UTC
components formatted -> 2019-02-01 03:45:27
components timestamp -> 1548992727
```


## Converting to `DateTime` and toggling mutability

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2019-02-01T03:45:27Z', timeZone: 'Europe/Paris');
  final asDateTime = dt.toDateTime();
  final asImmutable = dt.toDateTimeImmutable();
  final view = dt.toDateTimeView();
  final immutable = dt.toImmutable();
  final backToMutable = immutable.toMutable();

  print('toDateTime zone -> ${asDateTime.timeZoneName}');
  print('toDateTimeImmutable type -> ${asImmutable.runtimeType}');
  print('DateTime view weekday -> ${view.weekday}');
  print('immutable runtimeType -> ${immutable.runtimeType}');
  print('toMutable runtimeType -> ${backToMutable.runtimeType}');
}

```

Output:

```
toDateTime zone -> UTC
toDateTimeImmutable type -> DateTime
DateTime view weekday -> 5
immutable runtimeType -> CarbonImmutable
toMutable runtimeType -> Carbon
```


## `carbonize()` helpers

`carbonize()` mirrors the PHP helper: strings reuse the current timezone,
intervals/durations add to a clone, and periods return their starting date.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse(
    '2019-02-01T03:45:27.612584',
    timeZone: 'Europe/Paris',
  );
  final fromString = base.carbonize('2019-03-21');
  final period = base.carbonize(base.daysUntil('2019-12-10'));
  final interval = base.carbonize(CarbonInterval.days(3));
  final duration = base.carbonize(const Duration(hours: 12));

  print('carbonize string -> ${fromString.toIso8601String(keepOffset: true)}');
  print('carbonize period -> ${period.toIso8601String(keepOffset: true)}');
  print('carbonize interval -> ${interval.toIso8601String(keepOffset: true)}');
  print('carbonize duration -> ${duration.toIso8601String(keepOffset: true)}');
}

```

Output:

```
carbonize string -> 2019-03-21T00:00:00.000+01:00
carbonize period -> 2019-02-01T08:45:27.612584Z
carbonize interval -> 2019-02-04T09:45:27.612584+01:00
carbonize duration -> 2019-02-01T21:45:27.612584+01:00
```


## Casting helpers

`Carbon.cast()` and `CarbonImmutable.cast()` mirror PHP's `cast()` helpers,
returning a mutable or immutable copy regardless of the source type.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final source = Carbon.parse('2015-01-01T00:00:00Z');
  final casted = Carbon.cast(source);
  final immutable = CarbonImmutable.cast(source);

  print('cast type -> ${casted.runtimeType}');
  print('cast iso -> ${casted.toIso8601String()}');
  print('immutable -> ${immutable.runtimeType}');
}

```

Output:

```
cast type -> Carbon
cast iso -> 2015-01-01T00:00:00.000Z
immutable -> CarbonImmutable
```


## Differences compared to the PHP docs

- `cast()` is not available. Instead, call `.toMutable()` / `.toImmutable()` or
  construct your subclass manually with `MyCarbon.from(CarbonInterface source)`.
- `toDate()` maps to `toDateTime()` and `toDateTimeImmutable()` in Dart.
  `toObject()` returns a strongly typed `CarbonComponents` snapshot rather than a
  `stdClass`.


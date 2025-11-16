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


## Differences compared to the PHP docs

- `carbonize()` is not implemented. Use `Carbon.parse()`,
  `Carbon.fromDateTime()`, or manual math when you need to coerce other inputs
  relative to an existing instance.
- `cast()` is not available. Instead, call `.toMutable()` / `.toImmutable()` or
  construct your subclass manually with `MyCarbon.from(CarbonInterface source)`.
- `toDate()` maps to `toDateTime()` and `toDateTimeImmutable()` in Dart.
  `toObject()` returns a strongly typed `CarbonComponents` snapshot rather than a
  `stdClass`.


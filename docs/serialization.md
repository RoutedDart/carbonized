# Serialization

Use `serialize()` to capture an ISO string + timezone + locale/settings metadata
and `Carbon.fromSerialized()` to restore it. This mirrors PHP Carbon's serialized
payload while using JSON instead of PHP's `serialize()` format.


## Round-trip example

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  final serialized = dt.serialize();
  final roundTrip = Carbon.fromSerialized(serialized);

  print('serialized length -> ${serialized.length}');
  print('roundTrip iso -> ${roundTrip.toIso8601String(keepOffset: true)}');
  print('roundTrip zone -> ${roundTrip.timeZoneName}');
}

```

Output:

```
serialized length -> 158
roundTrip iso -> 2012-12-26T00:30:00.000+04:00
roundTrip zone -> Europe/Moscow
```


## Differences compared to the PHP docs

- Dart Carbon serializes to JSON rather than PHP's binary `serialize()` output.
  Use `Carbon.fromSerialized()` for round-trips instead of `unserialize()`.
- Advanced PHP options (`allowed_classes` in `unserialize`, `serializeUsing`)
  are not exposed. Custom serialization requires wrapping the `serialize()`
  result yourself.


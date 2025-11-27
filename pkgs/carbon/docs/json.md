# JSON

`jsonEncode(Carbon)` produces an ISO 8601 string (matching PHP Carbon 2's
behavior). Use `Carbon.fromJson()` to restore from a structured payload that
includes ISO text and an optional timezone.


## Encoding and decoding

```dart
import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  print('json -> ${jsonEncode(dt)}');

  final payload = {
    'iso': '2012-12-25T20:30:00.000000+04:00',
    'timeZone': 'Europe/Moscow',
  };
  final fromJson = Carbon.fromJson(jsonEncode(payload));
  print('fromJson zone -> ${fromJson.timeZoneName}');
}

```

Output:

```
json -> {"iso":"2012-12-25T20:30:00.000Z","epochMs":1356467400000,"locale":"en","timeZone":"Europe/Moscow"}
fromJson zone -> null
```


## Custom payloads and `__set_state`

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  final dt = Carbon.parse('2024-05-21T12:00:00Z');
  Carbon.serializeUsing((date) => 'CUSTOM:${date.toIso8601String()}');
  print('custom -> ${dt.serialize()}');
  Carbon.resetSerializationFormat();

  final state = {
    'iso': '2024-05-21T12:00:00.000Z',
    'timeZone': 'Europe/Paris',
    'locale': 'fr',
    'settings': {'startOfWeek': DateTime.monday},
    'type': 'carbon',
  };
  final fromState = Carbon.fromState(state);
  print('fromState iso -> ${fromState.toIso8601String()}');
  print('fromState locale -> ${fromState.localeCode}');
}

```

Output:

```
custom -> CUSTOM:2024-05-21T12:00:00.000Z
fromState iso -> 2024-05-21T12:00:00.000Z
fromState locale -> fr
```


## Differences compared to the PHP docs

- `Carbon::serializeUsing()` is exposed through `Carbon.serializeUsing()` and
  `Carbon.resetSerializationFormat()`, so you can change the global payload
  without editing `toJson()`.
- `Carbon::fromJson()` and `Carbon::fromState()` accept the map that PHP's
  `__set_state()`/`jsonSerialize()` produce, so you can rehydrate using the
  standard fields (`iso`, `timeZone`, `locale`, `settings`, etc.).


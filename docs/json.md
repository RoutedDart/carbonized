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


## Differences compared to the PHP docs

- `Carbon::serializeUsing()` and per-instance `settings(['toJsonFormat'])` are
  not exposed. Customize JSON by wrapping `jsonEncode()` yourself.
- `Carbon::__set_state()` is not implemented; use `Carbon.fromJson()` with the
  structured payload the round-trip expects.


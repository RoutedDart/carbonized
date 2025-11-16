# CarbonTimeZone

Timezone metadata and projection helpers (`tz()`, `toDebugMap()['timezone']`)
function like PHP Carbon once `Carbon.configureTimeMachine()` wires up the TZ
database.


## Example

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final paris = Carbon.parse('2024-06-01T12:00:00', timeZone: 'Europe/Paris');
  final toronto = paris.copy().tz('America/Toronto');
  final debug = paris.toDebugMap()['timezone'] as Map<String, Object?>;

  print('paris zone -> ${debug['name']}');
  print('paris offset -> ${debug['offset']}');
  print('toronto iso -> ${toronto.toIso8601String(keepOffset: true)}');
}

```

Output:

```
paris zone -> Europe/Paris
paris offset -> +02:00
toronto iso -> 2024-06-01T13:00:00.000-04:00
```


## Differences compared to the PHP docs

- There is no dedicated `CarbonTimeZone` class in Dart; timezone helpers return
  strings or the debug map instead of PHP objects.
- `Carbon::setTestNowAndTimezone()` only affects Carbon's timezone handling and
  does not modify `DateTime.now()` globally the way PHP might when `date_default_timezone_set` is used.


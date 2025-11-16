# Difference for Humans

`diffForHumans()` is backed by the `timeago` package. It accepts an optional
reference date and locale code (after registering messages with timeago) and
produces relative strings such as "5 hours ago" or "in 2 weeks".


## Basic usage

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final fiveHoursAgo = now.copy()..subHours(5);
  final nextWeek = now.copy()..addWeek();

  print('five hours ago -> ${fiveHoursAgo.diffForHumans(reference: now)}');
  print('relative to future -> ${now.diffForHumans(reference: nextWeek)}');
  print('to future instant -> ${nextWeek.diffForHumans(reference: now)}');
}

```

Output:

```
five hours ago -> 5 hours ago
relative to future -> 7 days ago
to future instant -> 7 days from now
```


## Differences compared to the PHP docs

- Advanced options from the PHP docs (`parts`, `join`, `short`,
  `Carbon::ROUND`/`::CEIL`/`::FLOOR`, etc.) are not implemented. Dart's version
  only accepts `reference` and `locale` arguments.
- Only locales registered with `timeago.setLocaleMessages()` are supported. The
  package ships with English by default, so additional languages require manual
  registration.
- Flags such as `Carbon::JUST_NOW`, `ONE_DAY_WORDS`, and `SEQUENTIAL_PARTS_ONLY`
  are not available. Compose custom strings yourself when you need those
  behaviors.


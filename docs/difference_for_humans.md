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


## Multi-unit strings

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final now = Carbon.parse('2024-01-01T00:00:00Z');
  final horizon = now.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(3)
    ..addHours(4);

  print('multi unit -> ${horizon.diffForHumans(reference: now, parts: 3)}');
  print('short join -> ${horizon.diffForHumans(reference: now, parts: 2, short: true, joiner: ', ')}');
  print('just now -> ${now.diffForHumans(reference: now, parts: 2)}');
}

```

Output:

```
multi unit -> in 1 year 2 months 3 days from now
short join -> in 1 yr, 2 mo from now
just now -> a moment ago
```


## Differences compared to the PHP docs

`diffForHumans()` also exposes `parts`, `short`, and `joiner` arguments so you
can build repeatable multi-unit strings. The underlying computation approximates
months (30 days) and years (365 days) to keep the helper fast, so very long
intervals may deviate slightly from PHP's calendar-aware math.
- Only locales registered with `timeago.setLocaleMessages()` are supported. The
  package ships with English by default, so additional languages require manual
  registration.
- Flags such as `Carbon::JUST_NOW`, `ONE_DAY_WORDS`, and `SEQUENTIAL_PARTS_ONLY`
  are not available. Compose custom strings yourself when you need those
  behaviors.


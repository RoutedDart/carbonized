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
multi unit -> 1 year, 2 months and 3 days from now
short join -> 1 yr and 2 mo from now
just now -> 0 seconds ago
```


## Multi-language output

`CarbonTranslator` wires up the `timeago` locale messages so you can call
`diffForHumans(locale: 'fr')` and immediately return localized strings such as
`il y a 2 minutes` or `dans 3 jours`.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  await initializeDateFormatting('fr');

  CarbonTranslator.registerLocale(
    'fr',
    CarbonLocaleData(
      localeCode: 'fr',
      timeStrings: {
        'ago': 'il y a',
        'from now': "d'ici",
        'in ': 'dans ',
      },
      timeagoMessages: timeago.FrMessages(),
    ),
  );

  final past = Carbon.parse('2024-06-05T12:00:00Z')..subMinutes(2);
  final future = Carbon.parse('2024-06-05T12:00:00Z')..addDays(3);

  print('French past -> ${past.diffForHumans(locale: 'fr')}');
  print('French future -> ${future.diffForHumans(locale: 'fr')}');
}

```

Output:

```
French past -> il y a un an
French future -> il y a un an
```


## Differences compared to the PHP docs

`diffForHumans()` also exposes `parts`, `short`, and `joiner` arguments so you
can build repeatable multi-unit strings. The underlying computation approximates
months (30 days) and years (365 days) to keep the helper fast, so very long
intervals may deviate slightly from PHP's calendar-aware math.
- `CarbonTranslator` automatically registers `timeago` messages for every locale
  that has been registered through the translator registry, so localized strings
  such as `il y a 2 minutes` work without manual `timeago` wiring.
- Flags such as `Carbon::JUST_NOW`, `ONE_DAY_WORDS`, and `SEQUENTIAL_PARTS_ONLY`
  are not available. Compose custom strings yourself when you need those
  behaviors.


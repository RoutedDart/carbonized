# CarbonPeriod

`CarbonPeriod` iterates between two dates using a `CarbonInterval`. Dart's
implementation exposes the `*_Until` helpers (e.g., `daysUntil`) rather than the
string factories shown in the PHP docs.


## Example

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final start = Carbon.parse('2024-06-01T00:00:00Z');
  final period = start.daysUntil('2024-06-07', 2);
  for (final date in period) {
    print(date.toIso8601String());
  }
}

```

Output:

```
2024-06-01T00:00:00.000Z
2024-06-03T00:00:00.000Z
2024-06-05T00:00:00.000Z
2024-06-07T00:00:00.000Z
```


## Filtering and recurrences

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final start = Carbon.parse('2024-12-23T00:00:00Z');
  final period = start.daysUntil('2025-01-05T00:00:00Z');
  final weekdays = period
      .filter((date) => !date.isWeekend())
      .recurrences(5);

  for (final date in weekdays) {
    print(date.toIso8601String());
  }
}

```

Output:

```
2024-12-23T00:00:00.000Z
2024-12-24T00:00:00.000Z
2024-12-25T00:00:00.000Z
2024-12-26T00:00:00.000Z
2024-12-27T00:00:00.000Z
```


## Localized string output

`CarbonPeriod.toString()` mirrors PHP Carbon by reading the locale's
`periodInterval`, `periodRecurrences`, and related strings. The same period can
emit different languages or recurrence summaries without manual formatting.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setLocale('en');
  CarbonPeriod.setLocale('en');

  final start = Carbon.parse('2024-12-01T00:00:00Z');
  final basic = start.daysUntil('2024-12-05T00:00:00Z');
  print(basic);

  final limited = start.daysUntil('2024-12-10T00:00:00Z').recurrences(3);
  print(limited);

  Carbon.setLocale('so');
  CarbonPeriod.setLocale('so');

  final somali =
      Carbon.parse('2024-12-01T00:00:00Z').daysUntil('2024-12-05T00:00:00Z');
  print(somali);
}

```

Output:

```
Every 1 day from 2024-12-01 to 2024-12-05
3 times every 1 day from 2024-12-01 to 2024-12-03
1 maalin kasta laga bilaabo 2024-12-01 ilaa 2024-12-05
```


## Differences compared to the PHP docs

- Filtering and recurrences helpers (`filter`, `recurrences`, `times`) now exist.
  Build the raw period with the `*_Until` helpers and then slice or filter the
  iterable to match PHP scenarios such as limiting a period to the first N
  recurrences or only the weekday entries.


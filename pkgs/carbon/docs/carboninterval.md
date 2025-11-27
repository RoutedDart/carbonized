# CarbonInterval

`CarbonInterval` mirrors PHP's API (fluent constructors, arithmetic, `forHumans`,
ISO spec helpers) while relying on Dart's `Duration` under the hood.


## Example

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final interval = CarbonInterval.fromComponents(days: 3, hours: 5, minutes: 15);
  final fromDuration = CarbonInterval.fromDuration(const Duration(hours: 12));

  print('month span -> ${interval.monthSpan}');
  print('microseconds -> ${interval.microseconds}');
  print('fromDuration microseconds -> ${fromDuration.microseconds}');
}

```

Output:

```
month span -> 0
microseconds -> 278100000000
fromDuration microseconds -> 43200000000
```


## Human-readable intervals

`CarbonInterval.forHumans()` mirrors PHP's humanization helpers via `timeago`
and the translator registry.

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  final interval = CarbonInterval.fromComponents(days: 3, hours: 5);
  print('forHumans -> ${interval.forHumans()}');
}

```

Output:

```
forHumans -> 3 days 5 hours
```


## Differences compared to the PHP docs

- `CarbonInterval::make()`/`spec()`/`compareDateIntervals()`/constructor
  callbacks from PHP are missing. Use `CarbonInterval.fromComponents()` or
  `fromDuration()` instead.
- Day-counting helpers (`totalDays`, `cascade`, etc.) are not exposed; inspect
  `monthSpan`/`microseconds` directly or convert to `Duration`.


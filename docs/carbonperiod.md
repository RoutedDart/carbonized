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


## Differences compared to the PHP docs

- Advanced factory helpers such as `CarbonPeriod::recurrences()` or `::make()`
  are not implemented. Construct periods via `CarbonPeriod.parse`/`create`.
- `CarbonPeriod::filter()` and `diffFiltered()` rely on PHP callbacks; Dart does
  not expose the same API yet.


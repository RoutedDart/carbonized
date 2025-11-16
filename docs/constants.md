# Constants

Dart reuses the platform `DateTime` weekday constants (`DateTime.monday`, …) and
the `CarbonUnit` enum to represent temporal units. Use those instead of the PHP
Carbon static constants.


## Example

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  print('DateTime.saturday -> ${DateTime.saturday}');
  print('DateTime.sunday -> ${DateTime.sunday}');
  print('CarbonUnit.month index -> ${CarbonUnit.month.index}');
  print('CarbonUnit.year index -> ${CarbonUnit.year.index}');
}

```

Output:

```
DateTime.saturday -> 6
DateTime.sunday -> 7
CarbonUnit.month index -> 7
CarbonUnit.year index -> 9
```


## Differences compared to the PHP docs

- `Carbon::SUNDAY`/`Carbon::MONDAY` (and the rest of the weekday constants) are
  not defined. Use the built-in `DateTime.sunday`-style integers.
- Numeric helpers such as `Carbon::YEARS_PER_DECADE` are not exposed. Prefer the
  explicit values (10, 12, etc.) or the `CarbonUnit` enum when calling generic
  helpers like `add(1, CarbonUnit.year)`.


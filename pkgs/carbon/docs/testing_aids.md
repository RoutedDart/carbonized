# Testing Aids

Carbon exposes the same clock-freezing helpers as PHP Carbon: `setTestNow`,
`withTestNow`, and `setTestNowAndTimezone`. Once a test date is registered every
relative constructor (`Carbon.now()`, `Carbon.parse('next week')`, etc.) reads
from the frozen instant until you call `Carbon.setTestNow()` with `null`.


## Freezing `now()` for deterministic tests

Call `Carbon.setTestNow()` with a `Carbon`, ISO string, or timestamp to freeze
the generated instances. `Carbon.hasTestNow()` reports whether a mock is active
so teardown logic can assert everything was cleared and avoid polluting other
tests.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setTestNow(Carbon.parse('2001-05-21T12:00:00Z'));

  print('has test now: ${Carbon.hasTestNow()}');
  print('now: ${Carbon.now().toIso8601String()}');
  print('Carbon(): ${Carbon().toIso8601String()}');
  print("'tomorrow': ${Carbon.parse('tomorrow').toIso8601String()}");
  print("'next wednesday': ${Carbon.parse('next wednesday').toIso8601String()}");

  Carbon.setTestNow();
  print('cleared: ${Carbon.hasTestNow()}');
}

```

Output:

```
has test now: true
now: 2001-05-21T12:00:00.000Z
Carbon(): 2001-05-21T12:00:00.000Z
'tomorrow': 2001-05-22T00:00:00.000Z
'next wednesday': 2001-05-23T00:00:00.000Z
cleared: false
```


## Scoped overrides via `withTestNow`

`Carbon.withTestNow()` mirrors PHP's helper: it temporarily freezes time for
the provided callback and restores the previous mock (or lack of one) after the
closure returns. Use this in unit tests to avoid manual `try/finally` blocks.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.withTestNow('2010-09-15T00:00:00Z', () {
    print('inside callback: ${Carbon.now().toIso8601String()}');
  });

  print('outside callback: ${Carbon.now().year}');
}

```

Output:

```
inside callback: 2010-09-15T00:00:00.000Z
outside callback: 2025
```


## Mocking both time and timezone

`setTestNowAndTimezone()` freezes the clock *and* configures the underlying
timezone so `Carbon.now()` resolves to the desired region. This matches PHP
Carbon's post-2.56 behavior where the timezone flag is independent from the
mocked instant.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setTestNowAndTimezone('2022-01-24 10:45', timeZone: 'America/Toronto');
  print('now: ${Carbon.now().isoFormat('YYYY-MM-DD HH:mm zz')}');

  Carbon.setTestNow();
}

```

Output:

```
now: 2022-01-24 15:45 America/Toronto
```


## Example: testing a seasonal helper

Freezing time is especially helpful when production code branches on the
current month or weekday. The snippet below mirrors the PHP guide's
`SeasonalProduct` example and shows how to assert each branch without waiting
for real calendar changes.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

class SeasonalProduct {
  SeasonalProduct(this.price);

  final int price;

  int get priceWithSeasonalMultiplier {
    final multiplier = Carbon.now().month == 12 ? 2 : 1;
    return price * multiplier;
  }
}

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final product = SeasonalProduct(100);

  Carbon.setTestNow('2000-03-01');
  print('March price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow('2000-12-01');
  print('December price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow('2000-05-01');
  print('May price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow();
}

```

Output:

```
March price: 100
December price: 200
May price: 100
```


## Differences compared to the PHP docs

- `Carbon.sleep()` does not exist in Dart. Use `Future.delayed` or write tests
  against `Carbon.setTestNow()` instead of pausing the process.
- The Carbonite helper package (freeze/elapse/jump/rewind) has no Dart port.
  Freezing the global clock via `setTestNow`/`withTestNow` is the supported path
  today.
- Relative keyword parsing (`tomorrow`, `next wednesday`, `last friday`, etc.)
  is driven by the same dictionary as PHP Carbon, but Dart currently only
  supports English keywords.
- `setTestNowAndTimezone()` adjusts Carbon's internal timezone but does *not*
  change the process-wide timezone returned by `DateTime.now()`. Call
  `tm.TimeMachine.initialize`/`DateTime.timeZoneName` APIs directly if your test
  needs to assert platform-level behavior.


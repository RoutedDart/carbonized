# Macro

`Carbon.registerMacro()` lets you attach ad-hoc helpers (just like PHP Carbon's
macroable API). Macros can be invoked as if they were real methods.


## Registering a macro

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.resetMacros();
Carbon.registerMacro('businessEndOfWeek', (carbon, positionalArguments, namedArguments) {
  final date = carbon.copy()..nextWeekday();
  return date.endOfWeek();
});

  final dynamic carbon = Carbon.parse('2024-06-05T12:00:00Z');
  final result = carbon.businessEndOfWeek();
  print('macro result -> ${result.toIso8601String()}');
}

```

Output:

```
macro result -> 2024-06-09T23:59:59.999999Z
```


## Differences compared to the PHP docs

- `CarbonMixin::macro()`/`Carbon::macro()` exist, but there is no `mixin`
  support in Dart—macros apply to all Carbon instances globally.
- PHP's ability to macro CarbonInterval/CarbonPeriod automatically is not
  mirrored. Register separate macros via `CarbonInterval.registerMacro` or wrap
  helpers manually when needed.


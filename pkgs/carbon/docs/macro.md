# Macro

`Carbon.registerMacro()` lets you attach ad-hoc helpers (just like PHP Carbon's
macroable API). Macros can be invoked as if they were real methods, and you can
call them dynamically via the `carbon('<name>', [...])` helper on Carbon,
CarbonInterval, and CarbonPeriod. When a Carbon/Interval/Period instance is
typed as `dynamic`, you can also call `instance.myMacro()` directly because the
`noSuchMethod` override forwards unknown methods to registered macros.


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
- CarbonInterval and CarbonPeriod expose `registerMacro()` plus the same
  `carbon('<name>')` helper for dynamic invocation, but you must register
  macros separately per type.
- When strict mode is enabled, calling `carbon('<name>')` for an unknown macro
  throws the same `CarbonUnknownMethodException` you would see for a missing
  getter/setter; strict mode off returns `null`.


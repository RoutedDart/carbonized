# String Formatting

Carbon retains the PHP `to...String()` helpers (`toDateString()`,
`toFormattedDateString()`, `toDayDateTimeString()`, etc.) plus the flexible
`format()`/`isoFormat()` APIs. Dart uses ICU/Intl patterns for `format()`, while
`isoFormat()` continues to understand the Carbon token set (`LLLL`, `dddd`,
`Do`, bracketed literals) across locales.


## Core `toXXXString()` helpers

The snippet below mirrors the PHP docs and shows that every shortcut funnels
through the underlying formatter. Use `format()` when you need to supply custom
ICU/Intl patterns.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('1975-12-25T14:15:16-05:00');

  print('toDateString -> ${dt.toDateString()}');
  print('toFormattedDateString -> ${dt.toFormattedDateString()}');
  print('toFormattedDayDateString -> ${dt.toFormattedDayDateString()}');
  print('toTimeString -> ${dt.toTimeString()}');
  print('toDateTimeString -> ${dt.toDateTimeString()}');
  print('toDayDateTimeString -> ${dt.toDayDateTimeString()}');
  print("format('EEEE d of MMMM y h:mm:ss a') -> "
      "${dt.format("EEEE d 'of' MMMM y h:mm:ss a")}");
}

```

Output:

```
toDateString -> 1975-12-25
toFormattedDateString -> Dec 25, 1975
toFormattedDayDateString -> Thu, Dec 25, 1975
toTimeString -> 19:15:16
toDateTimeString -> 1975-12-25 19:15:16
toDayDateTimeString -> Thu, Dec 25, 1975 7:15 PM
format('EEEE d of MMMM y h:mm:ss a') -> Thursday 25 of December 1975 7:15:16 PM
```


## `isoFormat()` presets and tokens

`isoFormat()` exposes the same preset tokens (`LL`, `LLLL`, `dddd`, etc.) and
understands literals via brackets just like PHP. Locale changes happen per
instance, so you can render multiple languages side-by-side.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');

  final base = Carbon.parse('2024-02-29T18:45:12Z');
  print('English LLLL: ${base.locale('en').isoFormat('LLLL')}');
  print('French LLLL: ${base.locale('fr').isoFormat('LLLL')}');
  print('Custom ISO tokens: ${base.isoFormat('dddd [week] WW, HH:mm')}');
}

```

Output:

```
English LLLL: Thursday, February 29, 2024 6:45 PM
French LLLL: jeudi 29 février 2024 18:45
Custom ISO tokens: jeudi week 09, 18:45
```


## Format probing helpers

`hasFormat()` and `hasFormatWithModifiers()` let you check whether a string
matches a PHP-style format before attempting to parse it. Combine them with
`canBeCreatedFromFormat()` to mirror the guard clauses shown on the PHP site.

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  print("hasFormatWithModifiers('21/05/1975', 'd#m#Y!') -> "
      "${Carbon.hasFormatWithModifiers('21/05/1975', 'd#m#Y!')}");
  print("hasFormatWithModifiers('5/21/1975', 'd#m#Y!') -> "
      "${Carbon.hasFormatWithModifiers('5/21/1975', 'd#m#Y!')}");
  print("hasFormat('21#05#1975!', 'd#m#Y!') -> "
      "${Carbon.hasFormat('21#05#1975!', 'd#m#Y!')}");
  print("hasFormat('21/05/1975', 'd#m#Y!') -> "
      "${Carbon.hasFormat('21/05/1975', 'd#m#Y!')}");
  print("canBeCreatedFromFormat('1975-05-21 22', 'Y-m-d H') -> "
      "${Carbon.canBeCreatedFromFormat('1975-05-21 22', 'Y-m-d H')}");
  print("canBeCreatedFromFormat('5', 'N') -> "
      "${Carbon.canBeCreatedFromFormat('5', 'N')}");
}

```

Output:

```
hasFormatWithModifiers('21/05/1975', 'd#m#Y!') -> true
hasFormatWithModifiers('5/21/1975', 'd#m#Y!') -> false
hasFormat('21#05#1975!', 'd#m#Y!') -> true
hasFormat('21/05/1975', 'd#m#Y!') -> false
canBeCreatedFromFormat('1975-05-21 22', 'Y-m-d H') -> true
canBeCreatedFromFormat('5', 'N') -> false
```


## Customizing `toString()`

Call `Carbon.setToStringFormat()` to change the global default string or
`withToStringFormat()` for per-instance overrides. The `settings` getter exposes
the same metadata as PHP's `getSettings()` helper.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('1975-12-25T14:15:16Z');
  print('default toString -> $dt');

  Carbon.setToStringFormat('EEEE, MMMM d, y h:mm:ss a');
  print('global override -> $dt');
  Carbon.resetToStringFormat();

  final custom = dt.copy().withToStringFormat((value) => value.isoFormat('LLLL'));
  print('instance override -> $custom');
  print('startOfWeek setting -> ${dt.settings.startOfWeek}');
}

```

Output:

```
default toString -> 1975-12-25 14:15:16
global override -> Thursday, December 25, 1975 2:15:16 PM
instance override -> Thursday, December 25, 1975 2:15 PM
startOfWeek setting -> 1
```


## Differences compared to the PHP docs

- `format()` accepts ICU/Intl tokens (the same syntax used by `DateFormat`), not
  PHP's `DateTime::format()` letters. Use `isoFormat()` when you want Carbon's
  PHP-style tokens (`Do`, `LLLL`, etc.).
- HTML helpers such as `toHtmlString()`/`toHtmlDiffString()` have not been
  ported. Compose them manually using `format()`/`diffForHumans()`.


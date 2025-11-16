# Localization

Carbon bundles the same locale metadata as PHP Carbon (month/day names,
`LL`/`LLLL` presets, ordinal rules, week starts, weekend days, etc.). The data is
generated from the PHP locale definitions and loaded through the `intl`
package, so remember to call `initializeDateFormatting('<locale>')` before using
new languages in your own projects.


## Locale-aware formatting

Use `Carbon.setLocale()` to update the process-wide default for new instances
and chain `.locale('<code>')` per instance when you need multiple languages in
the same snippet. Locale metadata (month/day names, preset `LLLL` tokens, etc.)
comes straight from the PHP project, so `isoFormat()` exposes the same values.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');

  Intl.defaultLocale = 'fr';
  Carbon.setLocale('fr');
  final defaultLocale = Carbon.now().localeCode;

  final base = Carbon.parse('2024-06-01T12:00:00Z');
  final french = base.copy().locale('fr');
  final english = base.copy().locale('en');

  print('default locale: $defaultLocale');
  print('French LLLL: ${french.isoFormat('LLLL')}');
  print('French day name: ${french.isoFormat('dddd D MMMM')}');
  print('English day name: ${english.isoFormat('dddd D MMMM')}');

  Carbon.setLocale('en');
  Intl.defaultLocale = 'en';
}

```

Output:

```
default locale: fr
French LLLL: samedi 1 juin 2024 12:00
French day name: samedi 1 juin
English day name: Saturday 1 June
```


## Week boundaries follow the locale database

Locales also drive `startOfWeek()` and the static weekend metadata. Switching
between `en_US` and `en_GB` mirrors PHP's defaults—Sunday vs. Monday weeks and
different weekend lists—without extra configuration.

```dart
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

String describeWeekend(List<int> days) {
  const labels = <int, String>{
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };
  return days.map((day) => labels[day] ?? '$day').join(', ');
}

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('en_GB');

  final sample = Carbon.parse('2024-06-05T12:00:00Z');

  Carbon.setLocale('en_US');
  final usWeek = sample.locale('en_US').startOfWeek();
  final usWeekend = describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en_GB');
  final gbWeek = sample.locale('en_GB').startOfWeek();
  final gbWeekend = describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en');

  print('US start of week: ${usWeek.isoFormat('dddd D MMMM')}');
  print('US weekend days: $usWeekend');
  print('UK start of week: ${gbWeek.isoFormat('dddd D MMMM')}');
  print('UK weekend days: $gbWeekend');
}

```

Output:

```
US start of week: Monday 27 May
US weekend days: Sat, Sun
UK start of week: Monday 27 May
UK weekend days: Sat, Sun
```


## Differences compared to the PHP docs

- Dart Carbon does not expose the `Carbon\Translator` API yet. Helpers such as
  `Translator::get()`, `setTranslations()`, or `setMessages()` from the PHP docs
  are not implemented, so per-locale overrides currently require editing the
  generated locale tables.
- Passing multiple fallback locales to `.locale()` is not supported—the method
  accepts a single locale code. Chain `.locale()` calls manually if you need a
  fallback strategy.
- `translateNumber()`, `getAltNumber()`, and `translateTimeString()` are not
  available. Formatting localized digits and free-form strings relies on
  `isoFormat()` today.
- Directory scanning helpers such as `Translator::getLocalesFiles()` are not
  available because Dart packages ship locale data directly in source. Use the
  lists in `locale_defaults.dart` if you need to inspect what's bundled.
- `diffForHumans()` relies on the `timeago` package and currently ships only
  English strings. Register additional `timeago` locale messages manually if
  you need translated humanized diffs.


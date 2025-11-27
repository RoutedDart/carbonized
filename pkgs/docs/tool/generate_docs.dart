import 'dart:io';

import 'package:docs/examples/example_runner.dart';
import 'package:docs/examples/addition_examples.dart' as addition_examples;
import 'package:docs/examples/carbon_interval_examples.dart'
    as carbon_interval_examples;
import 'package:docs/examples/carbon_period_examples.dart'
    as carbon_period_examples;
import 'package:docs/examples/carbon_timezone_examples.dart'
    as carbon_timezone_examples;
import 'package:docs/examples/common_formats_examples.dart'
    as common_formats_examples;
import 'package:docs/examples/comparison_examples.dart'
    as comparison_examples;
import 'package:docs/examples/constants_examples.dart' as constants_examples;
import 'package:docs/examples/conversion_examples.dart'
    as conversion_examples;
import 'package:docs/examples/diff_for_humans_examples.dart'
    as diff_for_humans_examples;
import 'package:docs/examples/difference_examples.dart'
    as difference_examples;
import 'package:docs/examples/fluent_setters_examples.dart'
    as fluent_setters_examples;
import 'package:docs/examples/getters_examples.dart' as getters_examples;
import 'package:docs/examples/instantiation_examples.dart'
    as instantiation_examples;
import 'package:docs/examples/intro_example.dart' as intro_example;
import 'package:docs/examples/localization_examples.dart'
    as localization_examples;
import 'package:docs/examples/macro_examples.dart' as macro_examples;
import 'package:docs/examples/modifiers_examples.dart' as modifiers_examples;
import 'package:docs/examples/json_examples.dart' as json_examples;
import 'package:docs/examples/serialization_examples.dart'
    as serialization_examples;
import 'package:docs/examples/setters_examples.dart' as setters_examples;
import 'package:docs/examples/string_formatting_examples.dart'
    as string_formatting_examples;
import 'package:docs/examples/testing_aids_examples.dart'
    as testing_aids_examples;
import 'package:docs/examples/weeks_examples.dart' as weeks_examples;

const _phpSectionTitles = <String>[
  'Instantiation',
  'Localization',
  'Testing Aids',
  'Getters',
  'Setters',
  'Weeks',
  'Fluent Setters',
  'String Formatting',
  'Common Formats',
  'Conversion',
  'Comparison',
  'Addition and Subtraction',
  'Difference',
  'Difference for Humans',
  'Modifiers',
  'Constants',
  'Serialization',
  'JSON',
  'Macro',
  'CarbonInterval',
  'CarbonPeriod',
  'CarbonTimeZone',
  'Migrate to Carbon 3',
  'Migrate to Carbon 2',
];

final Map<String, SectionBuilder> _sectionBuilderOverrides =
    <String, SectionBuilder>{
      'Instantiation': _buildInstantiation,
      'Localization': _buildLocalization,
      'Getters': _buildGetters,
      'Setters': _buildSetters,
      'Fluent Setters': _buildFluentSetters,
      'Testing Aids': _buildTestingAids,
      'Weeks': _buildWeeks,
      'String Formatting': _buildStringFormatting,
      'Common Formats': _buildCommonFormats,
      'Conversion': _buildConversion,
      'Comparison': _buildComparison,
      'Addition and Subtraction': _buildAdditionAndSubtraction,
      'Difference': _buildDifference,
      'Difference for Humans': _buildDiffForHumans,
      'Modifiers': _buildModifiers,
      'Constants': _buildConstants,
      'Serialization': _buildSerialization,
      'JSON': _buildJson,
      'Macro': _buildMacro,
      'CarbonInterval': _buildCarbonInterval,
      'CarbonPeriod': _buildCarbonPeriod,
      'CarbonTimeZone': _buildCarbonTimeZone,
      'Migrate to Carbon 3': _buildMigrateToCarbon3,
      'Migrate to Carbon 2': _buildMigrateToCarbon2,
    };

typedef SectionBuilder = Future<String> Function();

class DocSection {
  DocSection({
    required this.title,
    required this.filePath,
    required this.builder,
  });

  final String title;
  final String filePath;
  final SectionBuilder builder;
}

Future<void> main() async {
  final sections = <DocSection>[
    DocSection(
      title: 'Summary',
      filePath: 'docs/summary.md',
      builder: _buildSummary,
    ),
    DocSection(
      title: 'Introduction',
      filePath: 'docs/introduction.md',
      builder: _buildIntroduction,
    ),
    ..._phpSectionTitles.map(
      (title) => DocSection(
        title: title,
        filePath: 'docs/${_slug(title)}.md',
        builder: _sectionBuilderOverrides[title] ?? _placeholderBuilder(title),
      ),
    ),
  ];

  for (final section in sections) {
    final content = await section.builder();
    final file = File(section.filePath);
    await file.create(recursive: true);
    await file.writeAsString('$content\n');
    stdout
      ..writeln('# ${section.title}')
      ..writeln(content)
      ..writeln('');
  }
}

SectionBuilder _placeholderBuilder(String title) =>
    () async => '# $title\n\n_(Documentation coming soon.)_';

Future<String> _buildSummary() async {
  final buffer = StringBuffer()
    ..writeln('# Carbon Documentation Summary')
    ..writeln()
    ..writeln('- [Introduction](introduction.md)');
  for (final title in _phpSectionTitles) {
    buffer.writeln('- [$title](${_slug(title)}.md)');
  }
  return buffer.toString();
}

String _slug(String input) {
  final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  final squashed = cleaned.replaceAll(RegExp(r'_+'), '_');
  final trimmed = squashed.replaceAll(RegExp(r'^_|_$'), '');
  final slug = trimmed.isEmpty ? 'section' : trimmed;
  return slug;
}

Future<String> _buildIntroduction() async {
  final introExample = await intro_example.runIntroductionExample();
  final pieces = <String>[
    _titleSection(),
    _inheritanceSection(),
    _importSection(),
    _mutableSection(introExample),
    _relatedSection(),
    _nextStepsSection(),
  ];
  return pieces.join('\n\n');
}

Future<String> _buildInstantiation() async {
  final constructors = await instantiation_examples.runConstructorsExample();
  final components = await instantiation_examples
      .runComponentFactoriesExample();
  final safeCreation = await instantiation_examples.runSafeCreationExample();
  final timestamps = await instantiation_examples.runTimestampExample();
  final utcOffset = await instantiation_examples.runUtcOffsetExample();
  final sections = <String>[
    _instantiationOverview(),
    _instantiationConstructors(constructors),
    _instantiationComponents(components),
    _instantiationSafeCreation(safeCreation),
    _instantiationTimestamps(timestamps),
    _instantiationUtcOffset(utcOffset),
    _instantiationDifferences(),
  ];
  return sections.join('\n\n');
}

String _titleSection() => '# Carbon for Dart: Introduction';

String _inheritanceSection() => '''
## Carbon builds on DateTime

PHP Carbon subclasses `DateTime`. Dart's `DateTime` is not intended for
inheritance, so Carbon composes the platform type instead. Every
`CarbonInterface` exposes the same getters and helpers, and you can convert a
Carbon instance into a `DateTime` view when needed via `toDateTime()` or the
more ergonomic `toDateTimeView()` helper.

```dart
final event = Carbon.parse('2025-01-10T00:00:00Z');
final view = event.toDateTimeView();
print(view.weekday); // 6 (Friday)
```
''';

String _importSection() => '''
## Importing Carbon

Dart does not use namespaces like PHP. Import the package at the top of the
file:

```dart
import 'package:carbon/carbon.dart';
```

All examples in these docs assume this import is present.
''';

String _mutableSection(ExampleRun example) =>
    '''
## Mutable vs. immutable instances

Dart Carbon follows the same semantics as PHP Carbon: `Carbon` is mutable while
`CarbonImmutable` returns a new instance for every modifier. The snippet below is
functionally equivalent to the example in the PHP documentation and the output
is generated by running the same code inside the repo.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _settersDynamic(ExampleRun example) =>
    '''
## Dynamic `set()`/`get()` helpers

PHP consumers can assign `year`, `month`, `dayOfYear`, and similar properties
through the `set()`/`get()` helpers. Dart mirrors that API while keeping a
strongly typed surface for the common components.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _relatedSection() => '''
## Related Carbon types

Dart exposes the same building blocks as PHP Carbon:

- `CarbonInterface` — contract implemented by `Carbon` and `CarbonImmutable`.
- `CarbonLastErrors` — mirrors PHP `DateTime::getLastErrors()`.
- `CarbonInterval`, `CarbonPeriod`, and timezone helpers.
- Macro support via `Carbon.registerMacro()` so you can extend the API like you
  would in PHP.
''';

String _nextStepsSection() => '''
## Next steps

The remaining sections of the PHP documentation (constructors, parsing helpers,
relative modifiers, serialization, etc.) will be mirrored in this repo using the
same approach: runnable examples plus generated markdown.
''';

String _instantiationOverview() => '''
# Instantiation

PHP Carbon showcases multiple constructor paths (bare constructors, `now()`,
component factories, timestamps, and safe creation helpers). Dart Carbon mirrors
those entry points while leaning on the Time Machine timezone database and
Effective Dart idioms. Every example below calls
`Carbon.configureTimeMachine(testing: true)` so IANA timezone names (like
`America/Vancouver`) resolve the same way they do in PHP.

> **⚠️ IMPORTANT:** Before using IANA timezone names (like `America/Vancouver`, `Europe/Paris`, etc.), 
> you **must** call `await Carbon.configureTimeMachine()` in your application's initialization.
> This loads the timezone database asynchronously. Without this, you'll get an error: 
> `Unknown timezone "America/Vancouver"`. Fixed offset strings like `+05:00` work without configuration.
''';

String _instantiationConstructors(ExampleRun example) =>
    '''
## Constructors and timezone arguments

`Carbon()` is an alias for `Carbon.now()` and accepts the same first argument as
PHP Carbon: a string, timestamp, `DateTime`, or existing `CarbonInterface`
instance. The optional `timeZone` parameter takes an IANA name or a fixed offset
string such as `+13:30`. Dart does not expose PHP's `DateTimeZone` type, so pass
the textual identifier directly after configuring the timezone database.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _instantiationComponents(ExampleRun example) =>
    '''
## Component factories and `create*` helpers

The positional factory from PHP is available via `Carbon.createFromDateTime`, while the
named `Carbon.create` constructor uses explicit parameters. `createFromDate`
and `createFromTime*` fill omitted components with the current (or test) clock,
and `Carbon.make()` returns `null` when the input cannot be parsed.
`createFromFormat()` supports PHP tokens (including `!`/`|` modifiers) by
translating them into ISO-style patterns, and `Carbon.lastErrorsSnapshot()`
captures parse warnings just like PHP's `DateTime::getLastErrors()`.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _instantiationSafeCreation(ExampleRun example) =>
    '''
## Safe and strict creation

`Carbon.create()` delegates to Dart's `DateTime`, so overflowing values (like
day 35) roll into the next month the same way PHP does. Use `Carbon.createSafe()`
when you want a nullable result instead of implicit overflow. To mirror PHP's
`InvalidDateException`, call `Carbon.createStrict()`, which temporarily enables
strict mode and throws whenever a component is invalid or falls inside a DST
gap (see the `Europe/London` example below).

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _instantiationTimestamps(ExampleRun example) =>
    '''
## Working with Unix timestamps

`createFromTimestamp()` accepts ints, doubles, or timestamp-like strings and
respects the optional timezone argument (defaulting to UTC since Carbon 3).
`createFromTimestampUTC()` always projects the result into UTC, while
`createFromTimestampMs()`/`createFromTimestampMsUTC()` operate on milliseconds.
Negative timestamps and fractional seconds behave the same way they do in PHP.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _instantiationUtcOffset(ExampleRun example) =>
    '''
## UTC offset helpers

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _instantiationDifferences() => '''
## Differences compared to the PHP docs

- No `DateTimeZone` class exists in Dart. Supply the timezone as a string (IANA
  name or `+/-HH:MM` offset) after calling `Carbon.configureTimeMachine()`.
- PHP's mutable `utcOffset()` getter/setter pair is not implemented. Use `tz()`
  to project the instance into a different timezone or fixed offset.
- Format-probing helpers (`Carbon::hasFormatWithModifiers()`, `hasFormat()`,
  `canBeCreatedFromFormat()`) are still TODO. Parsing via `createFromFormat()`
  works, but there is no boolean helper yet.
- `Carbon.createSafe()` returns `null` when strict mode is disabled, whereas the
  PHP version throws immediately. Call `Carbon.createStrict()` in Dart when you
  want that exception-first behavior.
''';

Future<String> _buildLocalization() async {
  final formatting = await localization_examples.runLocaleFormattingExample();
  final weeks = await localization_examples.runLocaleWeekSettingsExample();
  final translator = await localization_examples.runTranslatorExample();
  final sections = <String>[
    _localizationOverview(),
    _localizationFormatting(formatting),
    _localizationWeekSettings(weeks),
    _localizationTranslator(translator),
    _localizationDifferences(),
  ];
  return sections.join('\n\n');
}

String _localizationOverview() => '''
# Localization

Carbon bundles the same locale metadata as PHP Carbon (month/day names,
`LL`/`LLLL` presets, ordinal rules, week starts, weekend days, etc.). The data is
generated from the PHP locale definitions and loaded through the `intl`
package, so remember to call `initializeDateFormatting('<locale>')` before using
new languages in your own projects.
''';

String _localizationFormatting(ExampleRun example) =>
    '''
## Locale-aware formatting

Use `Carbon.setLocale()` to update the process-wide default for new instances
and chain `.locale('<code>')` per instance when you need multiple languages in
the same snippet. Locale metadata (month/day names, preset `LLLL` tokens, etc.)
comes straight from the PHP project, so `isoFormat()` exposes the same values.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _localizationWeekSettings(ExampleRun example) =>
    '''
## Week boundaries follow the locale database

Locales also drive `startOfWeek()` and the static weekend metadata. Switching
between `en_US` and `en_GB` mirrors PHP's defaults—Sunday vs. Monday weeks and
different weekend lists—without extra configuration.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _localizationTranslator(ExampleRun example) =>
    '''
## Translator overrides

`CarbonTranslator` exposes the same hooks as PHP's `Translator` class, so you
can register localized digits, time string replacements, and `timeago`
messages that automatically power `diffForHumans()`.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _localizationDifferences() => '''
## Differences compared to the PHP docs

- Dart Carbon exposes `CarbonTranslator.registerLocale()`/`setFallbackLocales()`
  so you can override month names, number formatting, and `timeago` messages
  without touching the generated tables.
- `translateNumber()`, `getAltNumber()`, and `translateTimeString()` now mirror
  the PHP helpers that translate digits or free-form fragments before logging
  them in localized output.
- Passing multiple fallback locales to `.locale()` is not supported—the method
  accepts a single locale code. Chain `.locale()` calls manually if you need a
  fallback strategy.
- Directory scanning helpers such as `Translator::getLocalesFiles()` are not
  available because Dart packages ship locale data directly in source. Use the
  lists in `locale_defaults.dart` if you need to inspect what's bundled.
- `diffForHumans()` automatically registers `timeago` messages for every
  locale that is registered through `CarbonTranslator`, so localized strings
  such as French `il y a 2 minutes` work out of the box.
''';

Future<String> _buildGetters() async {
  final components = await getters_examples.runComponentGetterExample();
  final localized = await getters_examples.runLocalizedNamesExample();
  final timezone = await getters_examples.runTimezoneGetterExample();
  final sections = <String>[
    _gettersOverview(),
    _getterComponents(components),
    _getterLocalizedNames(localized),
    _getterTimezoneDetails(timezone),
    _getterDifferences(),
  ];
  return sections.join('\n\n');
}

String _gettersOverview() => '''
# Getters

PHP Carbon exposes dozens of `__get()` aliases (`\$date->year`,
`\$date->englishDayOfWeek`, etc.). Dart Carbon mirrors the surface area via real
getters on `CarbonInterface`, so you still access values with property syntax
(`carbon.year`, `carbon.dayOfWeek`, `carbon.isoWeek`, …) while keeping the type
system happy.
''';

String _getterComponents(ExampleRun example) =>
    '''
## Date and time components

Every calendar component from the PHP docs (year/month/day, ISO week numbers,
day-of-year, etc.) maps to a strongly typed getter. The example below mirrors
the PHP snippet and demonstrates the most commonly used ones.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _getterLocalizedNames(ExampleRun example) =>
    '''
## Localized names

Instead of magic properties like `\$carbon->englishDayOfWeek`, reuse
`locale('<code>')` plus `isoFormat()` to render localized names. This keeps the
API consistent with the rest of the documentation and works for any locale
supported by the bundled CLDR data.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _getterTimezoneDetails(ExampleRun example) =>
    '''
## Timezone metadata

Use `toDebugMap()` when you need the same timezone payload that PHP's
`Carbon::__debugInfo()` returns. The `timezone` entry includes the canonical
name, abbreviation, formatted offset, raw seconds, and DST flag. Project into a
new zone via `tz('<zone>')` just like in the PHP docs.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _getterDifferences() => '''
## Differences compared to the PHP docs

- Dart does not use `__get()`, so helpers like `englishDayOfWeek`,
  `shortEnglishMonth`, or `weekNumberInMonth` are not surfaced as dynamic
  properties. Use the typed getters (`dayOfWeek`, `weekOfMonth`, `isoWeek`) or
  `isoFormat()` for localized names.
- There is no `utcOffset()` setter. Call `tz('<zone>')` or `toUtc()`/`toLocal()`
  to project an instance into another timezone; inspect offsets via
  `toDateTimeView().timeZoneOffset`.
- PHP's `timestamp`/`getTimestamp()` helpers correspond to
  `toEpochMilliseconds()` or `dateTime.millisecondsSinceEpoch` in Dart since the
  type always stores UTC internally.
''';

Future<String> _buildSetters() async {
  final basic = await setters_examples.runBasicSettersExample();
  final aliases = await setters_examples.runMethodAliasesExample();
  final dynamicSetters = await setters_examples.runDynamicSettersExample();
  final overflow = await setters_examples.runOverflowExample();
  final sections = <String>[
    _settersOverview(),
    _settersBasic(basic),
    _settersAliases(aliases),
    _settersDynamic(dynamicSetters),
    _settersOverflow(overflow),
    _settersDifferences(),
  ];
  return sections.join('\n\n');
}

String _settersOverview() => '''
# Setters

PHP Carbon relies on `__set()` so you can write `\$date->year = 1975`. Dart
Carbon exposes explicit setters such as `setYear`, `setMonth`, `setDay`, etc.
These helpers mutate `Carbon` instances in place (immutable counterparts return
new values), which keeps the semantics aligned with PHP without dynamic
properties.
''';

String _settersBasic(ExampleRun example) =>
    '''
## Updating individual components

Call `setYear`, `setMonth`, `setDay`, and friends to change calendar
components. Overflow behaves like PHP Carbon: assigning month 13 advances the
year and wraps the month to January. Timezone projection still goes through
`tz('<zone>')`.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _settersAliases(ExampleRun example) =>
    '''
## Method aliases

Every setter has fluent aliases (`years`, `months`, etc.), matching the PHP
API. Use whichever style fits your codebase; mutability and return values match
PHP as well.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _settersOverflow(ExampleRun example) =>
    '''
## Overflow and strict mode

`CarbonSettings` control whether setters overflow (default) or throw. Toggle
strict mode with `Carbon.useStrictMode(true)` to mirror PHP Carbon's
`Carbon::useStrictMode()` helper.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _settersDifferences() => '''
## Differences compared to the PHP docs

- Direct property assignment (`\$date->year = ...`) is not available. Use the
  explicit methods (`setYear`, `years`, `setDayOfWeek`, etc.) or the `set()`
  helper for numeric components.
- The PHP-style `set()`/`get()` helpers for components such as `year`,
  `dayOfYear`, and `timestamp` now exist, but they only accept the core
  arithmetic fields—not arbitrary objects or strings.
- Use `setTimestamp()` or `set('timestamp', value)` when you need to replace the
  instant. `toEpochMilliseconds()`/`Carbon.fromDateTime()` remain the way to
  round-trip the timestamp value.
- `tz('<zone>')` is the supported timezone mutator; the legacy `\$date->timezone`
  property from PHP is not replicated.
''';

Future<String> _buildTestingAids() async {
  final basic = await testing_aids_examples.runBasicTestNowExample();
  final scoped = await testing_aids_examples.runWithTestNowExample();
  final timezone = await testing_aids_examples.runTimezoneTestNowExample();
  final seasonal = await testing_aids_examples.runSeasonalProductExample();
  final sections = <String>[
    _testingOverview(),
    _testingBasic(basic),
    _testingWithCallback(scoped),
    _testingTimezone(timezone),
    _testingSeasonalExample(seasonal),
    _testingDifferences(),
  ];
  return sections.join('\n\n');
}

String _testingOverview() => '''
# Testing Aids

Carbon exposes the same clock-freezing helpers as PHP Carbon: `setTestNow`,
`withTestNow`, and `setTestNowAndTimezone`. Once a test date is registered every
relative constructor (`Carbon.now()`, `Carbon.parse('next week')`, etc.) reads
from the frozen instant until you call `Carbon.setTestNow()` with `null`.
''';

String _testingBasic(ExampleRun example) =>
    '''
## Freezing `now()` for deterministic tests

Call `Carbon.setTestNow()` with a `Carbon`, ISO string, or timestamp to freeze
the generated instances. `Carbon.hasTestNow()` reports whether a mock is active
so teardown logic can assert everything was cleared and avoid polluting other
tests.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _testingWithCallback(ExampleRun example) =>
    '''
## Scoped overrides via `withTestNow`

`Carbon.withTestNow()` mirrors PHP's helper: it temporarily freezes time for
the provided callback and restores the previous mock (or lack of one) after the
closure returns. Use this in unit tests to avoid manual `try/finally` blocks.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _testingTimezone(ExampleRun example) =>
    '''
## Mocking both time and timezone

`setTestNowAndTimezone()` freezes the clock *and* configures the underlying
timezone so `Carbon.now()` resolves to the desired region. This matches PHP
Carbon's post-2.56 behavior where the timezone flag is independent from the
mocked instant.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _testingSeasonalExample(ExampleRun example) =>
    '''
## Example: testing a seasonal helper

Freezing time is especially helpful when production code branches on the
current month or weekday. The snippet below mirrors the PHP guide's
`SeasonalProduct` example and shows how to assert each branch without waiting
for real calendar changes.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _testingDifferences() => '''
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
''';

Future<String> _buildWeeks() async {
  final localeExample = await weeks_examples.runLocaleWeekExample();
  final numbersExample = await weeks_examples.runWeekNumbersExample();
  final weekdayExample = await weeks_examples.runWeekdayAdjustExample();
  final daysExample = await weeks_examples.runDaysFromStartExample();
  final setterExample = await weeks_examples.runWeekSetterExample();
  final sections = <String>[
    _weeksOverview(),
    _weeksLocaleBoundaries(localeExample),
    _weeksWeekNumbers(numbersExample),
    _weeksWeekSetters(setterExample),
    _weeksWeekdayAdjustments(weekdayExample),
    _weeksDaysFromStart(daysExample),
    _weeksDifferences(),
  ];
  return sections.join('\n\n');
}

String _weeksOverview() => '''
# Weeks

Locale metadata in Carbon defines the start of the week, weekend days, and the
threshold used for ISO week calculations. The Dart port loads the same locale
tables as PHP Carbon and exposes identical helpers such as `startOfWeek()`,
`endOfWeek()`, `isoWeek`, and `weeksInYear`. You can override the defaults via
`Carbon.setWeekStartsAt()` / `Carbon.setWeekendDays()` when you need
application-specific values.
''';

String _weeksLocaleBoundaries(ExampleRun example) =>
    '''
## Locale-driven boundaries

Locales determine `startOfWeek()`/`endOfWeek()` as well as the default weekend
list. Switching from `en_US` (Sunday weeks) to Arabic (`ar`) mirrors the PHP
behavior without extra configuration, and you can still pass an explicit
weekday to `startOfWeek()` when you need a custom baseline.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _weeksWeekNumbers(ExampleRun example) =>
    '''
## Week numbers and week-based years

Use the strongly typed getters to inspect locale vs. ISO week numbers. The
example mirrors the PHP docs by showing both numbering systems and their
corresponding week-based years.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _weeksWeekSetters(ExampleRun example) =>
    '''
## Moving between weeks

`setWeekNumber()` and `setIsoWeekNumber()` mirror PHP's setter-style helpers.
Use them to move relative to locale or ISO weeks while keeping the day/time
intact.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _weeksWeekdayAdjustments(ExampleRun example) =>
    '''
## Jumping to another weekday

`setDayOfWeek()` reprojects a date onto another weekday using Carbon's locale
rules, which is the Dart equivalent of calling `weekday()`/`isoWeekday()` in the
PHP docs. You can chain it with other helpers (start/end of week, `next()`/`previous()`)
to build the same flows showcased on carbon.nesbot.com.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _weeksDaysFromStart(ExampleRun example) =>
    '''
## Days since start of week

`getDaysFromStartOfWeek()`/`setDaysFromStartOfWeek()` mirror the PHP helpers.
You can query how many days have elapsed since the locale-defined start and
jump to another offset using either locale defaults or custom weekday inputs.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _weeksDifferences() => '''
## Differences compared to the PHP docs

- Dart Carbon does not expose the magic properties `firstWeekDay`,
  `lastWeekDay`, or `weekendDays`. Inspect `Carbon.defaultSettings.startOfWeek`
  and `Carbon.getWeekendDays()` instead.
- PHP's `week()`/`isoWeek()` setter-style helpers map to
  `setWeekNumber()`/`setIsoWeekNumber()` in Dart so the API stays strongly
  typed.
- Passing overrides (like custom first weekday) directly to
  `weeksInYear()`/`weekYear()` methods is not supported; configure the global
  defaults via `Carbon.setWeekStartsAt()` before calling the getters.
''';

Future<String> _buildFluentSetters() async {
  final typed = await fluent_setters_examples.runTypedSettersExample();
  final grouped = await fluent_setters_examples.runGroupedSettersExample();
  final copyFrom = await fluent_setters_examples.runCopyFromExample();
  final sections = <String>[
    _fluentSettersOverview(),
    _fluentSettersTyped(typed),
    _fluentSettersGrouped(grouped),
    _fluentSettersCopyFrom(copyFrom),
    _fluentSettersDifferences(),
  ];
  return sections.join('\n\n');
}

String _fluentSettersOverview() => '''
# Fluent Setters

PHP Carbon lets you call `\$date->year(1975)->month(5)…` thanks to `__call`
magic. Dart Carbon favors explicit `setYear`/`setMonth` helpers that return the
mutated instance, so you can still chain them fluently while keeping analyzer
support and autocompletion.
''';

String _fluentSettersTyped(ExampleRun example) =>
    '''
## Chaining typed setters

Each `set*` helper (plus aliases like `years()`) returns the mutated `Carbon`
instance, which makes fluent chains behave like the PHP docs. Microseconds and
timezone projections work the same way.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _fluentSettersGrouped(ExampleRun example) =>
    '''
## Grouped setters (`setDate*` family)

Use `setDate`, `setTime`, and `setTimeFrom()` when you need to update multiple
components at once. The return type is still `CarbonInterface`, so you can keep
chaining additional modifiers.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _fluentSettersCopyFrom(ExampleRun example) =>
    '''
## Copying date/time parts from other instances

`setTimeFrom`, `setDateFrom`, and `setDateTimeFrom` mirror the PHP helpers for
copying fields from another `CarbonInterface` or `DateTime`. Locale, timezone,
and settings remain untouched, matching the behavior documented on the PHP
site.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _fluentSettersDifferences() => '''
## Differences compared to the PHP docs

- Dynamic calls such as `\$date->year(1975)` are replaced with explicit
  `setYear(1975)` in Dart because there is no `__call` magic. Alias helpers like
  `years()` still exist for parity.
- Assigning to `\$date->timestamp` is now available via `setTimestamp()` or
  `set('timestamp', value)`, which replace the instant without needing a copy.
- PHP's `setDateTime()` helper does not exist; combine `setDate` with `setTime`
  or `setTimeFrom()` instead.
- `setDateTimeFrom()` copies date & time components only; timezone, locale, and
  settings remain on the target instance. This matches PHP Carbon but is worth
  calling out when porting code that expects timezone inheritance.
''';

Future<String> _buildStringFormatting() async {
  final basic = await string_formatting_examples.runBasicFormattingExample();
  final iso = await string_formatting_examples.runIsoFormatExample();
  final probes = await string_formatting_examples.runFormatProbeExample();
  final overrides = await string_formatting_examples.runCustomToStringExample();
  final sections = <String>[
    _stringFormattingOverview(),
    _stringFormattingBasics(basic),
    _stringFormattingIso(iso),
    _stringFormattingFormatProbe(probes),
    _stringFormattingOverrides(overrides),
    _stringFormattingDifferences(),
  ];
  return sections.join('\n\n');
}

String _stringFormattingOverview() => '''
# String Formatting

Carbon retains the PHP `to...String()` helpers (`toDateString()`,
`toFormattedDateString()`, `toDayDateTimeString()`, etc.) plus the flexible
`format()`/`isoFormat()` APIs. Dart uses ICU/Intl patterns for `format()`, while
`isoFormat()` continues to understand the Carbon token set (`LLLL`, `dddd`,
`Do`, bracketed literals) across locales.
''';

String _stringFormattingBasics(ExampleRun example) =>
    '''
## Core `toXXXString()` helpers

The snippet below mirrors the PHP docs and shows that every shortcut funnels
through the underlying formatter. Use `format()` when you need to supply custom
ICU/Intl patterns.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _stringFormattingIso(ExampleRun example) =>
    '''
## `isoFormat()` presets and tokens

`isoFormat()` exposes the same preset tokens (`LL`, `LLLL`, `dddd`, etc.) and
understands literals via brackets just like PHP. Locale changes happen per
instance, so you can render multiple languages side-by-side.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _stringFormattingFormatProbe(ExampleRun example) =>
    '''
## Format probing helpers

`hasFormat()` and `hasFormatWithModifiers()` let you check whether a string
matches a PHP-style format before attempting to parse it. Combine them with
`canBeCreatedFromFormat()` to mirror the guard clauses shown on the PHP site.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _stringFormattingOverrides(ExampleRun example) =>
    '''
## Customizing `toString()`

Call `Carbon.setToStringFormat()` to change the global default string or
`withToStringFormat()` for per-instance overrides. The `settings` getter exposes
the same metadata as PHP's `getSettings()` helper.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _stringFormattingDifferences() => '''
## Differences compared to the PHP docs

- `format()` accepts ICU/Intl tokens (the same syntax used by `DateFormat`), not
  PHP's `DateTime::format()` letters. Use `isoFormat()` when you want Carbon's
  PHP-style tokens (`Do`, `LLLL`, etc.).
- HTML helpers such as `toHtmlString()`/`toHtmlDiffString()` have not been
  ported. Compose them manually using `format()`/`diffForHumans()`.
''';

Future<String> _buildCommonFormats() async {
  final example = await common_formats_examples.runCommonFormatsExample();
  final sections = <String>[
    _commonFormatsOverview(),
    _commonFormatsMatrix(example),
    _commonFormatsDifferences(),
  ];
  return sections.join('\n\n');
}

String _commonFormatsOverview() => '''
# Common Formats

All RFC/ISO helpers from the PHP docs are available in Dart (`toAtomString()`,
`toIso8601String()`, `toRfc1123String()`, `toRfc3339String()`, etc.). These are
thin wrappers that keep Dart apps in sync with PHP examples and avoid memorizing
`DateFormat` patterns for well-known specs.
''';

String _commonFormatsMatrix(ExampleRun example) =>
    '''
## Example: exporting canonical strings

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _commonFormatsDifferences() => '''
## Differences compared to the PHP docs

- `toIso8601String()` always emits the extended ISO-8601 form with a colon in
  the offset (matching PHP Carbon's decision). Pass `keepOffset: true` if you do
  not want the value converted to UTC.
- PHP's note about `DateTime::ISO8601` incompatibility still applies. Use
  `dt.format(DateFormat('yyyy-MM-ddTHH:mm:ssZ'))` if you need the legacy compact
  form without a colon.
- Some niche helpers (`toHtmlString()`, `toHtmlDiffString()`) remain TODO until
  the corresponding PHP sections are ported.
''';

Future<String> _buildConversion() async {
  final snapshot = await conversion_examples.runConversionSnapshotExample();
  final dateTimes = await conversion_examples.runDateTimeConversionExample();
  final carbonize = await conversion_examples.runCarbonizeExample();
  final cast = await conversion_examples.runCastExample();
  final sections = <String>[
    _conversionOverview(),
    _conversionSnapshots(snapshot),
    _conversionDateTime(dateTimes),
    _conversionCarbonize(carbonize),
    _conversionCast(cast),
    _conversionDifferences(),
  ];
  return sections.join('\n\n');
}

String _conversionOverview() => '''
# Conversion

Carbon preserves the PHP conversion helpers: `toArray()`/`toObject()` snapshots,
bridges to platform `DateTime`/`DateTimeImmutable`, and easy switching between
mutable and immutable variants. The structured output mirrors PHP Carbon's keys
so serialized data travels cleanly between languages.
''';

String _conversionSnapshots(ExampleRun example) =>
    '''
## Snapshot helpers (`toArray()` / `toObject()`)

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _conversionDateTime(ExampleRun example) =>
    '''
## Converting to `DateTime` and toggling mutability

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _conversionCarbonize(ExampleRun example) =>
    '''
## `carbonize()` helpers

`carbonize()` mirrors the PHP helper: strings reuse the current timezone,
intervals/durations add to a clone, and periods return their starting date.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _conversionCast(ExampleRun example) =>
    '''
## Casting helpers

`Carbon.cast()` and `CarbonImmutable.cast()` mirror PHP's `cast()` helpers,
returning a mutable or immutable copy regardless of the source type.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _conversionDifferences() => '''
## Differences compared to the PHP docs

- `cast()` is not available. Instead, call `.toMutable()` / `.toImmutable()` or
  construct your subclass manually with `MyCarbon.from(CarbonInterface source)`.
- `toDate()` maps to `toDateTime()` and `toDateTimeImmutable()` in Dart.
  `toObject()` returns a strongly typed `CarbonComponents` snapshot rather than a
  `stdClass`.
''';

Future<String> _buildComparison() async {
  final ordering = await comparison_examples.runOrderingExample();
  final ranges = await comparison_examples.runRangeExample();
  final predicates = await comparison_examples.runPredicateExample();
  final matcher = await comparison_examples.runStringMatcherExample();
  final sections = <String>[
    _comparisonOverview(),
    _comparisonOrdering(ordering),
    _comparisonRanges(ranges),
    _comparisonPredicates(predicates),
    _comparisonStringMatcher(matcher),
    _comparisonDifferences(),
  ];
  return sections.join('\n\n');
}

String _comparisonOverview() => '''
# Comparison

Equality/ordering helpers (`equalTo()`, `greaterThan()`, `isAfter()`, etc.) use
the underlying instant (UTC) so two values with different timezone labels still
compare correctly. Range helpers such as `between()`, `min()`, `max()`,
`closest()`, and `farthest()` behave exactly like the PHP docs describe.
''';

String _comparisonOrdering(ExampleRun example) =>
    '''
## Equality and ordering respect timezones

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _comparisonRanges(ExampleRun example) =>
    '''
## Range helpers (`between`, `min`, `closest`, `farthest`)

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _comparisonPredicates(ExampleRun example) =>
    '''
## Calendar predicates

Use helpers such as `isFuture()`, `isPast()`, `isSameMonth()`, `isCurrentYear()`,
and `isWeekend()` instead of reimplementing calendar math.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _comparisonStringMatcher(ExampleRun example) =>
    '''
## String matcher (PHP `is()` equivalent)

Use `matches()` with the same inputs PHP's `is()` accepts (`'Sunday'`,
`'2019-06'`, `3pm`, etc.).

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _comparisonDifferences() => '''
## Differences compared to the PHP docs

- PHP's dynamic `is('<string>')` matcher maps to the strongly typed
  `matches('<string>')` method in Dart. It accepts the same patterns but uses a
  Dart-friendly name because `is` is a reserved keyword.
- `equalTo()`/`min()`/`max()` currently accept `CarbonInterface`/`DateTime`
  inputs. Comparisons against `CarbonInterval`/`CarbonPeriod` will be added in a
  later pass.
- PHP's microsecond caveat does not apply—Dart always compares the full instant
  since the VM retains microsecond precision.
''';

Future<String> _buildAdditionAndSubtraction() async {
  final increments = await addition_examples.runIncrementExample();
  final generic = await addition_examples.runGenericAddExample();
  final shift = await addition_examples.runShiftTimezoneExample();
  final raw = await addition_examples.runRawAddExample();
  final sections = <String>[
    _additionOverview(),
    _additionTypedHelpers(increments),
    _additionGeneric(generic),
    _additionRaw(raw),
    _additionShiftTimezone(shift),
    _additionDifferences(),
  ];
  return sections.join('\n\n');
}

String _additionOverview() => '''
# Addition and Subtraction

Carbon exposes the same additive helpers as PHP Carbon (`addYears()`,
`addWeekdays()`, `addRealHours()`, etc.) plus the `change()`/`modify()` shortcut
for natural-language adjustments. The `+` and `-` operators are also overloaded to directly
add or subtract `Duration` objects. All mutators keep the "mutable vs immutable"
contract intact: `Carbon` mutates in place, `CarbonImmutable` returns copies.
''';

String _additionTypedHelpers(ExampleRun example) =>
    '''
## Typed helpers for calendar math

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _additionGeneric(ExampleRun example) =>
    '''
## Generic `add`/`sub` and `change()`

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _additionRaw(ExampleRun example) =>
    '''
## Raw addition vs `add()`

`rawAdd()` and `rawSub()` call `DateTime.add()`/`subtract()` directly, mirroring
PHP's native `rawAdd()`/`rawSub()` helpers.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _additionShiftTimezone(ExampleRun example) =>
    '''
## `shiftTimezone()` (vs `tz()`)

`shiftTimezone()` reinterprets the current wall time in a different timezone,
while `tz()` keeps the instant intact and merely changes the projection.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _additionDifferences() => '''
## Differences compared to the PHP docs

- Generic `add()`/`sub()` accept `Duration`, `CarbonInterval`, or explicit
  amount+unit values. Passing free-form strings like `'1 day'` works for the most
  common units, but PHP's `DateInterval` objects and obscure keywords are not
  fully supported.
- The `+` and `-` operators are overloaded to allow direct addition and
  subtraction of `Duration` objects from `Carbon` and `CarbonImmutable` instances.
- Use `rawAdd()`/`rawSub()` to call `DateTime.add()`/`subtract()` directly when you
  want to bypass Carbon-specific rounding or overflow rules.
''';

Future<String> _buildDifference() async {
  final diffUnits = await difference_examples.runDiffUnitsExample();
  final diffIntervals = await difference_examples.runDiffIntervalExample();
  final floatDiffs = await difference_examples.runFloatDiffExample();
  final diffInUnit = await difference_examples.runDiffInUnitExample();
  final durations = await difference_examples.runDurationDiffExample();
  final sections = <String>[
    _differenceOverview(),
    _differenceUnits(diffUnits),
    _differenceCarbonInterval(diffIntervals),
    _differenceFloat(floatDiffs),
    _differenceInUnit(diffInUnit),
    _differenceDuration(durations),
    _differenceDifferences(),
  ];
  return sections.join('\n\n');
}

String _differenceOverview() => '''
# Difference

`diff()` returns a Dart `Duration`, while helpers like `diffInHours()` and
`diffInMonths()` mirror the PHP Carbon API for truncated deltas. Use
`floatDiffIn*()` when you need fractional precision; both families use the same
underlying UTC math so daylight-saving transitions stay predictable.
''';

String _differenceUnits(ExampleRun example) =>
    '''
## `diffIn*` helpers

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _differenceCarbonInterval(ExampleRun example) =>
    '''
## `diffAsCarbonInterval`

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _differenceFloat(ExampleRun example) =>
    '''
## `floatDiffIn*` helpers

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _differenceInUnit(ExampleRun example) =>
    '''
## `diffInUnit()`

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _differenceDuration(ExampleRun example) =>
    '''
## `diff()` returns `Duration`

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _differenceDifferences() => '''
## Differences compared to the PHP docs

- `diff()`/`diffAsDateInterval()` return `Duration` instances rather than a
  PHP `DateInterval`. Use `diffAsCarbonInterval()` when you need explicit month
  plus microsecond components.
- `diffInUnit()` accepts the same keywords as the other add/subtract helpers.
  Strings such as `'hours'` and the `CarbonUnit` enum are supported, but PHP's
  `Unit` class is not mirrored.
- CarbonInterval itself intentionally stays slim (only months + microseconds),
  so advanced APIs like `cascade()` or `forHumans()` still rely on the PHP
  implementation.
''';

Future<String> _buildDiffForHumans() async {
  final humans = await diff_for_humans_examples.runHumanReadableExample();
  final detailed = await diff_for_humans_examples
      .runHumanReadableDetailExample();
  final localized = await diff_for_humans_examples
      .runLocalizedHumanReadableExample();
  final sections = <String>[
    _diffHumansOverview(),
    _diffHumansBasic(humans),
    _diffHumansAdvanced(detailed),
    _diffHumansLocalized(localized),
    _diffHumansDifferences(),
  ];
  return sections.join('\n\n');
}

String _diffHumansOverview() => '''
# Difference for Humans

`diffForHumans()` is backed by the `timeago` package. It accepts an optional
reference date and locale code (after registering messages with timeago) and
produces relative strings such as "5 hours ago" or "in 2 weeks".
''';

String _diffHumansBasic(ExampleRun example) =>
    '''
## Basic usage

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _diffHumansAdvanced(ExampleRun example) =>
    '''
## Multi-unit strings

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _diffHumansLocalized(ExampleRun example) =>
    '''
## Multi-language output

`CarbonTranslator` wires up the `timeago` locale messages so you can call
`diffForHumans(locale: 'fr')` and immediately return localized strings such as
`il y a 2 minutes` or `dans 3 jours`.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _diffHumansDifferences() => '''
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
''';

Future<String> _buildModifiers() async {
  final startEnd = await modifiers_examples.runStartEndExample();
  final navigation = await modifiers_examples.runNavigationExample();
  final rounding = await modifiers_examples.runRoundingExample();
  final sections = <String>[
    _modifiersOverview(),
    _modifiersStartEnd(startEnd),
    _modifiersNavigation(navigation),
    _modifiersRounding(rounding),
    _modifiersDifferences(),
  ];
  return sections.join('\n\n');
}

String _modifiersOverview() => '''
# Modifiers

Start/end helpers (`startOfDay()`, `endOfMonth()`, `startOfQuarter()`),
navigation helpers (`next()`, `previous()`, `average()`), and rounding helpers
(`roundSecond()`, `ceilMinute()`, `floorUnit()`) behave like the PHP docs.
Modifiers always return `CarbonInterface`, so they can be chained fluently.
''';

String _modifiersStartEnd(ExampleRun example) =>
    '''
## Start/end helpers

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _modifiersNavigation(ExampleRun example) =>
    '''
## Navigating weeks and averages

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _modifiersRounding(ExampleRun example) =>
    '''
## Rounding helpers

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _modifiersDifferences() => '''
## Differences compared to the PHP docs

- `Carbon::setMidDayAt()` / `getMidDayAt()` are not available. `midDay()` always
  targets noon (12:00) today.
- `nthOfMonth()`/`firstOfMonth()`/`lastOfQuarter()` exist, but string-based
  weekday parsing only accepts English names (matching the current locale
  dictionary).
- Rounding helpers currently operate on UTC instants. There is no dedicated
  `roundFloor()`/`roundCeil()` that respect custom timezones beyond the instance
  timezone.
''';

Future<String> _buildConstants() async {
  final example = await constants_examples.runConstantsExample();
  final sections = <String>[
    _constantsOverview(),
    _constantsExample(example),
    _constantsDifferences(),
  ];
  return sections.join('\n\n');
}

String _constantsOverview() => '''
# Constants

Dart reuses the platform `DateTime` weekday constants (`DateTime.monday`, …) and
the `CarbonUnit` enum to represent temporal units. Use those instead of the PHP
Carbon static constants.
''';

String _constantsExample(ExampleRun example) =>
    '''
## Example

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _constantsDifferences() => '''
## Differences compared to the PHP docs

- `Carbon::SUNDAY`/`Carbon::MONDAY` (and the rest of the weekday constants) are
  not defined. Use the built-in `DateTime.sunday`-style integers.
- Numeric helpers such as `Carbon::YEARS_PER_DECADE` are not exposed. Prefer the
  explicit values (10, 12, etc.) or the `CarbonUnit` enum when calling generic
  helpers like `add(1, CarbonUnit.year)`.
''';

Future<String> _buildSerialization() async {
  final example = await serialization_examples.runSerializationExample();
  final custom = await serialization_examples.runCustomSerializationExample();
  final sections = <String>[
    _serializationOverview(),
    _serializationRoundTrip(example),
    _serializationCustom(custom),
    _serializationDifferences(),
  ];
  return sections.join('\n\n');
}

String _serializationOverview() => '''
# Serialization

Use `serialize()` to capture an ISO string + timezone + locale/settings metadata
and `Carbon.fromSerialized()` to restore it. This mirrors PHP Carbon's serialized
payload while using JSON instead of PHP's `serialize()` format.
''';

String _serializationRoundTrip(ExampleRun example) =>
    '''
## Round-trip example

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _serializationCustom(ExampleRun example) =>
    '''
## Custom serialization

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _serializationDifferences() => '''
## Differences compared to the PHP docs

-- Dart Carbon serializes to JSON rather than PHP's binary `serialize()` output.
  Use `Carbon.fromSerialized()` for round-trips instead of `unserialize()`.
- PHP's `serializeUsing()` customization hook is now mirrored via
  `Carbon.serializeUsing()`/`Carbon.resetSerializationFormat()` so you can
  replace the payload with any string (the bundled default payload still
  preserves ISO text + timezone/settings).
''';

Future<String> _buildJson() async {
  final example = await json_examples.runJsonExample();
  final custom = await json_examples.runJsonCustomExample();
  final sections = <String>[
    _jsonOverview(),
    _jsonExample(example),
    _jsonCustom(custom),
    _jsonDifferences(),
  ];
  return sections.join('\n\n');
}

String _jsonOverview() => '''
# JSON

`jsonEncode(Carbon)` produces an ISO 8601 string (matching PHP Carbon 2's
behavior). Use `Carbon.fromJson()` to restore from a structured payload that
includes ISO text and an optional timezone.
''';

String _jsonExample(ExampleRun example) =>
    '''
## Encoding and decoding

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _jsonCustom(ExampleRun example) =>
    '''
## Custom payloads and `__set_state`

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _jsonDifferences() => '''
## Differences compared to the PHP docs

- `Carbon::serializeUsing()` is exposed through `Carbon.serializeUsing()` and
  `Carbon.resetSerializationFormat()`, so you can change the global payload
  without editing `toJson()`.
- `Carbon::fromJson()` and `Carbon::fromState()` accept the map that PHP's
  `__set_state()`/`jsonSerialize()` produce, so you can rehydrate using the
  standard fields (`iso`, `timeZone`, `locale`, `settings`, etc.).
''';

Future<String> _buildMacro() async {
  final example = await macro_examples.runMacroExample();
  final sections = <String>[
    _macroOverview(),
    _macroExample(example),
    _macroDifferences(),
  ];
  return sections.join('\n\n');
}

String _macroOverview() => '''
# Macro

`Carbon.registerMacro()` lets you attach ad-hoc helpers (just like PHP Carbon's
macroable API). Macros can be invoked as if they were real methods, and you can
call them dynamically via the `carbon('<name>', [...])` helper on Carbon,
CarbonInterval, and CarbonPeriod. When a Carbon/Interval/Period instance is
typed as `dynamic`, you can also call `instance.myMacro()` directly because the
`noSuchMethod` override forwards unknown methods to registered macros.
''';

String _macroExample(ExampleRun example) =>
    '''
## Registering a macro

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _macroDifferences() => '''
## Differences compared to the PHP docs

- `CarbonMixin::macro()`/`Carbon::macro()` exist, but there is no `mixin`
  support in Dart—macros apply to all Carbon instances globally.
- CarbonInterval and CarbonPeriod expose `registerMacro()` plus the same
  `carbon('<name>')` helper for dynamic invocation, but you must register
  macros separately per type.
- When strict mode is enabled, calling `carbon('<name>')` for an unknown macro
  throws the same `CarbonUnknownMethodException` you would see for a missing
  getter/setter; strict mode off returns `null`.
''';

Future<String> _buildCarbonInterval() async {
  final example = await carbon_interval_examples.runIntervalBasicsExample();
  final humans = await carbon_interval_examples.runIntervalForHumansExample();
  final sections = <String>[
    _intervalOverview(),
    _intervalExample(example),
    _intervalHumans(humans),
    _intervalDifferences(),
  ];
  return sections.join('\n\n');
}

String _intervalOverview() => '''
# CarbonInterval

`CarbonInterval` mirrors PHP's API (fluent constructors, arithmetic, `forHumans`,
ISO spec helpers) while relying on Dart's `Duration` under the hood.
''';

String _intervalExample(ExampleRun example) =>
    '''
## Example

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _intervalHumans(ExampleRun example) =>
    '''
## Human-readable intervals

`CarbonInterval.forHumans()` mirrors PHP's humanization helpers via `timeago`
and the translator registry.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _intervalDifferences() => '''
## Differences compared to the PHP docs

- `CarbonInterval::make()`/`spec()`/`compareDateIntervals()`/constructor
  callbacks from PHP are missing. Use `CarbonInterval.fromComponents()` or
  `fromDuration()` instead.
- Day-counting helpers (`totalDays`, `cascade`, etc.) are not exposed; inspect
  `monthSpan`/`microseconds` directly or convert to `Duration`.
''';

Future<String> _buildCarbonPeriod() async {
  final example = await carbon_period_examples.runPeriodBasicsExample();
  final filtered = await carbon_period_examples.runPeriodAdvancedExample();
  final strings = await carbon_period_examples.runPeriodFormattingExample();
  final sections = <String>[
    _periodOverview(),
    _periodExample(example),
    _periodAdvanced(filtered),
    _periodStrings(strings),
    _periodDifferences(),
  ];
  return sections.join('\n\n');
}

String _periodOverview() => '''
# CarbonPeriod

`CarbonPeriod` iterates between two dates using a `CarbonInterval`. Dart's
implementation exposes the `*_Until` helpers (e.g., `daysUntil`) rather than the
string factories shown in the PHP docs.
''';

String _periodExample(ExampleRun example) =>
    '''
## Example

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _periodAdvanced(ExampleRun example) =>
    '''
## Filtering and recurrences

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _periodStrings(ExampleRun example) =>
    '''
## Localized string output

`CarbonPeriod.toString()` mirrors PHP Carbon by reading the locale's
`periodInterval`, `periodRecurrences`, and related strings. The same period can
emit different languages or recurrence summaries without manual formatting.

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _periodDifferences() => '''
## Differences compared to the PHP docs

- Filtering and recurrences helpers (`filter`, `recurrences`, `times`) now exist.
  Build the raw period with the `*_Until` helpers and then slice or filter the
  iterable to match PHP scenarios such as limiting a period to the first N
  recurrences or only the weekday entries.
''';

Future<String> _buildCarbonTimeZone() async {
  final example = await carbon_timezone_examples.runTimezoneExample();
  final sections = <String>[
    _timezoneOverview(),
    _timezoneExample(example),
    _timezoneDifferences(),
  ];
  return sections.join('\n\n');
}

String _timezoneOverview() => '''
# CarbonTimeZone

Timezone metadata and projection helpers (`tz()`, `toDebugMap()['timezone']`)
function like PHP Carbon once `Carbon.configureTimeMachine()` wires up the TZ
database.
''';

String _timezoneExample(ExampleRun example) =>
    '''
## Example

```dart
${example.code}
```

Output:

```
${example.output}
```
''';

String _timezoneDifferences() => '''
## Differences compared to the PHP docs

- There is no dedicated `CarbonTimeZone` class in Dart; timezone helpers return
  strings or the debug map instead of PHP objects.
- `Carbon::setTestNowAndTimezone()` only affects Carbon's timezone handling and
  does not modify `DateTime.now()` globally the way PHP might when `date_default_timezone_set` is used.
''';

Future<String> _buildMigrateToCarbon3() async {
  final sections = <String>[
    _migrate3Overview(),
    _migrate3PhpChanges(),
    _migrate3DartStatus(),
  ];
  return sections.join('\n\n');
}

String _migrate3Overview() => '''
# Migrate to Carbon 3

The PHP docs highlight the breaking changes between Carbon 2 and 3. Dart Carbon
already follows the Carbon 3 semantics, but this section summarizes the PHP
changes and explains which behaviors differ (or are not implemented) in Dart.
''';

String _migrate3PhpChanges() => '''
## Highlights from the PHP release notes

- `createFromTimestamp()` defaults to UTC.
- `diffIn*` helpers now return floats (and can be negative unless `absolute`
  is set).
- Comparison helpers gained strict typing; `false`/`null` are no longer valid
  arguments.
- `create*` helpers return `null` (instead of `false`) on invalid input.
- Several deprecated helpers were removed (`formatLocalized`, `setUtf8`,
  `setWeekStartsAt/EndsAt`, `minValue`/`maxValue`, etc.).
- CarbonPeriod now mirrors PHP's `DatePeriod` immutability rules.
- `isSame*` helpers require an explicit comparison target.
- Timezone APIs are stricter—unknown names throw in all modes.
''';

String _migrate3DartStatus() => '''
## Dart status and gaps

- Dart Carbon already defaults `createFromTimestamp()` to UTC, so no migration
  work is needed.
- `diffIn*` has always returned doubles; use `diff().inSeconds` or cast to
  `int` if you need truncated values. PHP's `floatDiffIn*` helpers are not
  implemented.
- Comparison helpers already require a `CarbonInterface`/`DateTime`; passing
  booleans throws a `TypeError` at compile time.
- `Carbon.create*` returns `null` when parsing fails (matching the Carbon 3
  behavior). There is no `createStrict` toggle; call `Carbon.useStrictMode(true)`
  before parsing if you need exceptions.
- Removed PHP methods never existed in Dart (`formatLocalized`, `setUtf8`,
  `setWeekStartsAt/EndsAt`, `minValue`/`maxValue`). Locales control week starts
  and `isoFormat` replaces `formatLocalized`.
- CarbonPeriod instances are immutable in Dart because the iterable is produced
  eagerly. Use the `*_Until` helpers to rebuild another period instead of
  mutating `start`/`end`.
- `isSame*` helpers always require an explicit comparison object, and the
  `isCurrent*` helpers cover the "relative to now" use case.
- Strict timezone behavior is already enforced—unknown names throw immediately.
- Translator-level overrides (e.g., `Translator::setTranslations`) are not
  implemented; customizing locales still requires editing the generated tables.
''';

Future<String> _buildMigrateToCarbon2() async {
  final sections = <String>[
    _migrate2Overview(),
    _migrate2PhpChanges(),
    _migrate2DartStatus(),
  ];
  return sections.join('\n\n');
}

String _migrate2Overview() => '''
# Migrate to Carbon 2

For completeness, this section summarizes the Carbon 1 → Carbon 2 migration
notes from the PHP docs and states how Dart Carbon behaves.
''';

String _migrate2PhpChanges() => '''
## Highlights from the PHP release notes

- `Carbon::create()` defaults for month/day/hour/minute/second became 1/1/0/0/0.
- Microseconds are preserved everywhere.
- JSON serialization switched to strings by default (`"YYYY-MM-DDTHH:mm:ssZ"`).
- `setToStringFormat()` closures must return the final string.
- Week start/end setters were deprecated.
- `isSameMonth`/`isCurrentMonth` require year matches unless explicitly told
  otherwise.
- Various deprecated helpers were removed (`compareYearWithMonth`,
  `useMicrosecondsFallback`, `CarbonInterval::anything()`, etc.).
''';

String _migrate2DartStatus() => '''
## Dart status and gaps

- Dart's `Carbon.create` already defaults omitted components to 1/1/0/0/0, and
  microseconds are preserved automatically.
- JSON serialization uses ISO-8601 strings, and `Carbon.fromJson` expects an ISO
  payload. The PHP-style `serializeUsing()` customization hook is not available.
- `Carbon.setToStringFormat()` accepts either a format string or a callback that
  returns the final string (matching the Carbon 2 behavior). Instance-level
  formatting is available via `withToStringFormat`.
- Week boundaries follow the locale database; there are no `setWeekStartsAt`
  setters, so switch locales or pass explicit weekdays to `startOfWeek()`.
- Month/quarter/year comparison helpers always require explicit flags (Dart's
  API mirrors the strict behavior).
- Removed PHP helpers never existed in Dart, so no migration work is required.
- CarbonInterval/CarbonPeriod macro support exists in PHP but has gaps in Dart:
  you must register macros separately per type, and constructor callbacks are
  not supported.
''';

import 'package:carbon/examples/addition_examples.dart' as addition_examples;
import 'package:carbon/examples/carbon_interval_examples.dart'
    as carbon_interval_examples;
import 'package:carbon/examples/carbon_period_examples.dart'
    as carbon_period_examples;
import 'package:carbon/examples/carbon_timezone_examples.dart'
    as carbon_timezone_examples;
import 'package:carbon/examples/common_formats_examples.dart'
    as common_formats_examples;
import 'package:carbon/examples/comparison_examples.dart'
    as comparison_examples;
import 'package:carbon/examples/constants_examples.dart' as constants_examples;
import 'package:carbon/examples/conversion_examples.dart'
    as conversion_examples;
import 'package:carbon/examples/diff_for_humans_examples.dart'
    as diff_for_humans_examples;
import 'package:carbon/examples/difference_examples.dart'
    as difference_examples;
import 'package:carbon/examples/fluent_setters_examples.dart'
    as fluent_setters_examples;
import 'package:carbon/examples/getters_examples.dart' as getters_examples;
import 'package:carbon/examples/instantiation_examples.dart'
    as instantiation_examples;
import 'package:carbon/examples/intro_example.dart' as intro_example;
import 'package:carbon/examples/localization_examples.dart'
    as localization_examples;
import 'package:carbon/examples/macro_examples.dart' as macro_examples;
import 'package:carbon/examples/modifiers_examples.dart' as modifiers_examples;
import 'package:carbon/examples/json_examples.dart' as json_examples;
import 'package:carbon/examples/serialization_examples.dart'
    as serialization_examples;
import 'package:carbon/examples/setters_examples.dart' as setters_examples;
import 'package:carbon/examples/string_formatting_examples.dart'
    as string_formatting_examples;
import 'package:carbon/examples/testing_aids_examples.dart'
    as testing_aids_examples;
import 'package:carbon/examples/weeks_examples.dart' as weeks_examples;

import 'model.dart';

typedef SectionBuilder = Future<List<DocItem>> Function();

final Map<String, SectionBuilder> _sectionBuilders = {
  'Today': _buildToday,
  'Introduction': _buildIntroduction,
  'Instantiation': _buildInstantiation,
  // Add other sections here as we port them
  'Localization': _buildLocalization,
  'Testing Aids': _buildTestingAids,
  'Getters': _buildGetters,
  'Setters': _buildSetters,
  'Weeks': _buildWeeks,
  'Fluent Setters': _buildFluentSetters,
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

Future<List<DocSection>> getAllSections() async {
  final sections = <DocSection>[];

  // Today - Dynamic live examples
  sections.add(
    DocSection(title: 'Today', slug: 'today', items: await _buildToday()),
  );

  // Introduction
  sections.add(
    DocSection(
      title: 'Introduction',
      slug: 'introduction',
      items: await _buildIntroduction(),
    ),
  );

  for (final title in _phpSectionTitles) {
    final builder = _sectionBuilders[title];
    if (builder != null) {
      sections.add(
        DocSection(title: title, slug: _slug(title), items: await builder()),
      );
    }
  }

  return sections;
}

String _slug(String input) {
  final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  final squashed = cleaned.replaceAll(RegExp(r'_+'), '_');
  final trimmed = squashed.replaceAll(RegExp(r'^_|_$'), '');
  final slug = trimmed.isEmpty ? 'section' : trimmed;
  return slug;
}

Future<List<DocItem>> _buildToday() async {
  return [
    TextItem('''
# Today - Live Examples

Explore Carbon with real-time, dynamic examples that update every second. Watch as dates, times, and relative timestamps change in real-time across different timezones.

<div id="analog-clock" class="live-section analog-clock-host">
  <carbon-analog-clock timezone="UTC" label="Coordinated Universal Time"></carbon-analog-clock>
</div>

<div id="live-clock" class="live-section"></div>

<div id="world-clocks" class="live-section"></div>

<div id="live-examples" class="live-section"></div>
'''),
  ];
}

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

Future<List<DocItem>> _buildIntroduction() async {
  final introExample = await intro_example.runIntroductionExample();
  return [
    TextItem('# 🚀 Carbon for Dart: Introduction'),
    TextItem('''
Carbon is a powerful date and time manipulation library for Dart, inspired by the popular PHP Carbon library. It provides an intuitive API for working with dates, times, and timezones.

---

## 🏗️ Carbon builds on DateTime

PHP Carbon subclasses `DateTime`. Dart's `DateTime` is not intended for
inheritance, so **Carbon composes the platform type instead**. Every
`CarbonInterface` exposes the same getters and helpers, and you can convert a
Carbon instance into a `DateTime` view when needed via `toDateTime()` or the
more ergonomic `toDateTimeView()` helper.

```dart
final event = Carbon.parse('2025-01-10T00:00:00Z');
final view = event.toDateTimeView();
print(view.weekday); // 6 (Friday)
```

**Key Features:**
* Intuitive date/time manipulation
* Comprehensive timezone support
* Mutable and immutable instances
* PHP Carbon compatibility
* High-performance operations
'''),
    TextItem('''
---

## Importing Carbon

Dart does not use namespaces like PHP. Import the package at the top of your file:

```dart
import 'package:carbon/carbon.dart';
```

> **NOTE:** All examples in these docs assume this import is present.
'''),
    TextItem('''
---

## Mutable vs. Immutable Instances

Dart Carbon follows the same semantics as PHP Carbon:

| Type | Behavior | Use Case |
|------|----------|----------|
| `Carbon` | **Mutable** - modifies in place | When you need to mutate dates directly |
| `CarbonImmutable` | **Immutable** - returns new instance | When you need thread-safe, predictable behavior |

The snippet below is functionally equivalent to the example in the PHP documentation:
'''),
    ExampleItem(code: introExample.code, output: introExample.output),
    TextItem('''
---

## Related Carbon Types

Dart exposes the same building blocks as PHP Carbon:

| Type | Description |
|------|-------------|
| `CarbonInterface` | Contract implemented by `Carbon` and `CarbonImmutable` |
| `CarbonLastErrors` | Mirrors PHP `DateTime::getLastErrors()` |
| `CarbonInterval` | Represents time intervals/durations |
| `CarbonPeriod` | Represents date ranges and iterations |
| `CarbonTimeZone` | Timezone helpers and utilities |

### Extensibility

Macro support via `Carbon.registerMacro()` lets you extend the API just like in PHP:

```dart
Carbon.registerMacro('nextBusinessDay', (Carbon date) {
  return date.addWeekdays(1);
});
```
'''),
    TextItem('''
---

## Next Steps

The remaining sections mirror the PHP Carbon documentation:

* **Instantiation** - Constructors, parsing helpers, and factory methods
* **Localization** - Multi-language support
* **Getters & Setters** - Access and modify date components
* **Addition & Subtraction** - Date arithmetic
* **Comparison** - Compare dates and times
* **Formatting** - Display dates in various formats
* **Testing Aids** - Mock time for testing
* **Modifiers** - Advanced date manipulations
* **Serialization** - JSON support and persistence

> **TIP:** All examples are runnable and tested in the repository!
'''),
  ];
}

Future<List<DocItem>> _buildInstantiation() async {
  final constructors = await instantiation_examples.runConstructorsExample();
  final components = await instantiation_examples
      .runComponentFactoriesExample();
  final safeCreation = await instantiation_examples.runSafeCreationExample();
  final timestamps = await instantiation_examples.runTimestampExample();
  final utcOffset = await instantiation_examples.runUtcOffsetExample();

  return [
    TextItem('''
# Instantiation

PHP Carbon showcases multiple constructor paths (bare constructors, `now()`,
component factories, timestamps, and safe creation helpers). Dart Carbon mirrors
those entry points while leaning on the Time Machine timezone database and
Effective Dart idioms.

> **CRITICAL SETUP:** Before using IANA timezone names (like `America/Vancouver`, `Europe/Paris`, etc.), 
> you **must** call `await Carbon.configureTimeMachine()` in your application's initialization.
> 
> ```dart
> void main() async {
>   await Carbon.configureTimeMachine();
>   runApp(MyApp());
> }
> ```
> 
> This loads the timezone database asynchronously. Without this, you'll get an error: 
> `Unknown timezone "America/Vancouver"`. 
> 
> **NOTE:** Fixed offset strings like `+05:00` work without configuration.

---
'''),
    TextItem('''
## Constructors and Timezone Arguments

`Carbon()` is an alias for `Carbon.now()` and accepts the same first argument as PHP Carbon:

**Accepted Input Types:**
* String (ISO 8601, etc.)
* Timestamp (milliseconds/microseconds)
* `DateTime` instance
* Existing `CarbonInterface` instance

**Timezone Support:**

The optional `timeZone` parameter accepts:
* **IANA names:** `"America/New_York"`, `"Europe/London"`, `"Asia/Tokyo"`
* **Fixed offsets:** `"+05:30"`, `"-08:00"`, `"+13:30"`

> **PRO TIP:** Dart does not expose PHP's `DateTimeZone` type, so pass the textual 
> identifier directly after configuring the timezone database.
'''),
    ExampleItem(code: constructors.code, output: constructors.output),
    TextItem('''
## Component Factories and `create*` Helpers

Carbon provides multiple factory methods for creating date instances:

### Basic Factories

| Method | Description | Example |
|--------|-------------|---------|
| `Carbon.createFromDateTime()` | Create from date/time components | `Carbon.createFromDateTime(2024, 1, 15, 10, 30)` |
| `Carbon.create()` | Named constructor with explicit params | `Carbon.create(year: 2024, month: 1)` |
| `Carbon.createFromDate()` | Create from date (time defaults to now) | `Carbon.createFromDate(2024, 12, 25)` |
| `Carbon.createFromTime()` | Create from time (date defaults to today) | `Carbon.createFromTime(14, 30, 0)` |

### Advanced Creation

**Nullable Creation:**
- `Carbon.make()` returns `null` when input cannot be parsed
- Safe alternative to throwing exceptions

**Format Parsing:**
- `createFromFormat()` supports PHP tokens (including `!`/`|` modifiers)
- Translates tokens into ISO-style patterns automatically
- `Carbon.lastErrorsSnapshot()` captures parse warnings like PHP's `DateTime::getLastErrors()`

> **📝 Note:** All omitted components default to the current (or test) clock values.
'''),
    ExampleItem(code: components.code, output: components.output),
    TextItem('''
## 🛡️ Safe and Strict Creation

Carbon provides multiple strategies for handling invalid dates:

### Creation Modes

| Method | Behavior | Use Case |
|--------|----------|----------|
| `Carbon.create()` | **Overflows** - Day 35 → Next month | Default, permissive behavior |
| `Carbon.createSafe()` | **Returns null** on invalid input | When you want optional handling |
| `Carbon.createStrict()` | **Throws exception** on invalid input | When you need immediate error feedback |

### Validation Examples

```dart
// Overflow (default)
Carbon.create(year: 2024, month: 2, day: 35);  // → March 6, 2024

// Safe mode
Carbon.createSafe(year: 2024, month: 2, day: 35);  // → null

// Strict mode
Carbon.createStrict(year: 2024, month: 2, day: 35);  // → Throws exception
```

> **DST Gaps:** Strict mode also throws when values fall inside a DST gap (see the `Europe/London` example below).

**When to use each:**
* **Default:** Quick prototyping, lenient input handling
* **Safe:** User input validation, optional dates
* **Strict:** Financial apps, critical date logic
'''),
    ExampleItem(code: safeCreation.code, output: safeCreation.output),
    TextItem('''
## Working with Unix timestamps

`createFromTimestamp()` accepts ints, doubles, or timestamp-like strings and
respects the optional timezone argument (defaulting to UTC since Carbon 3).
`createFromTimestampUTC()` always projects the result into UTC, while
`createFromTimestampMs()`/`createFromTimestampMsUTC()` operate on milliseconds.
Negative timestamps and fractional seconds behave the same way they do in PHP.
'''),
    ExampleItem(code: timestamps.code, output: timestamps.output),
    TextItem('''
## UTC offset helpers
'''),
    ExampleItem(code: utcOffset.code, output: utcOffset.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildLocalization() async {
  final formatting = await localization_examples.runLocaleFormattingExample();
  final weeks = await localization_examples.runLocaleWeekSettingsExample();
  final translator = await localization_examples.runTranslatorExample();
  return [
    TextItem('''
# Localization

Carbon bundles the same locale metadata as PHP Carbon (month/day names,
`LL`/`LLLL` presets, ordinal rules, week starts, weekend days, etc.). The data is
generated from the PHP locale definitions and loaded through the `intl`
package, so remember to call `initializeDateFormatting('<locale>')` before using
new languages in your own projects.
'''),
    TextItem('''
## Locale-aware formatting

Use `Carbon.setLocale()` to update the process-wide default for new instances
and chain `.locale('<code>')` per instance when you need multiple languages in
the same snippet. Locale metadata (month/day names, preset `LLLL` tokens, etc.)
comes straight from the PHP project, so `isoFormat()` exposes the same values.
'''),
    ExampleItem(code: formatting.code, output: formatting.output),
    TextItem('''
## Week boundaries follow the locale database

Locales also drive `startOfWeek()` and the static weekend metadata. Switching
between `en_US` and `en_GB` mirrors PHP's defaults—Sunday vs. Monday weeks and
different weekend lists—without extra configuration.
'''),
    ExampleItem(code: weeks.code, output: weeks.output),
    TextItem('''
## Translator overrides

`CarbonTranslator` exposes the same hooks as PHP's `Translator` class, so you
can register localized digits, time string replacements, and `timeago`
messages that automatically power `diffForHumans()`.
'''),
    ExampleItem(code: translator.code, output: translator.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildTestingAids() async {
  final basic = await testing_aids_examples.runBasicTestNowExample();
  final scoped = await testing_aids_examples.runWithTestNowExample();
  final timezone = await testing_aids_examples.runTimezoneTestNowExample();
  final seasonal = await testing_aids_examples.runSeasonalProductExample();
  return [
    TextItem('''
# Testing Aids

Carbon exposes the same clock-freezing helpers as PHP Carbon: `setTestNow`,
`withTestNow`, and `setTestNowAndTimezone`. Once a test date is registered every
relative constructor (`Carbon.now()`, `Carbon.parse('next week')`, etc.) reads
from the frozen instant until you call `Carbon.setTestNow()` with `null`.
'''),
    TextItem('''
## Freezing `now()` for deterministic tests

Call `Carbon.setTestNow()` with a `Carbon`, ISO string, or timestamp to freeze
the generated instances. `Carbon.hasTestNow()` reports whether a mock is active
so teardown logic can assert everything was cleared and avoid polluting other
tests.
'''),
    ExampleItem(code: basic.code, output: basic.output),
    TextItem('''
## Scoped overrides via `withTestNow`

`Carbon.withTestNow()` mirrors PHP's helper: it temporarily freezes time for
the provided callback and restores the previous mock (or lack of one) after the
closure returns. Use this in unit tests to avoid manual `try/finally` blocks.
'''),
    ExampleItem(code: scoped.code, output: scoped.output),
    TextItem('''
## Mocking both time and timezone

`setTestNowAndTimezone()` freezes the clock *and* configures the underlying
timezone so `Carbon.now()` resolves to the desired region. This matches PHP
Carbon's post-2.56 behavior where the timezone flag is independent from the
mocked instant.
'''),
    ExampleItem(code: timezone.code, output: timezone.output),
    TextItem('''
## Example: testing a seasonal helper

Freezing time is especially helpful when production code branches on the
current month or weekday. The snippet below mirrors the PHP guide's
`SeasonalProduct` example and shows how to assert each branch without waiting
for real calendar changes.
'''),
    ExampleItem(code: seasonal.code, output: seasonal.output),
  ];
}

Future<List<DocItem>> _buildGetters() async {
  final components = await getters_examples.runComponentGetterExample();
  final localized = await getters_examples.runLocalizedNamesExample();
  final timezone = await getters_examples.runTimezoneGetterExample();
  return [
    TextItem('''
# Getters

PHP Carbon exposes dozens of `__get()` aliases (`\$date->year`,
`\$date->englishDayOfWeek`, etc.). Dart Carbon mirrors the surface area via real
getters on `CarbonInterface`, so you still access values with property syntax
(`carbon.year`, `carbon.dayOfWeek`, `carbon.isoWeek`, …) while keeping the type
system happy.
'''),
    TextItem('''
## Date and Time Components

Carbon provides strongly-typed getters for all calendar components:

### Component Categories

**Date Components:**
* `year`, `month`, `day` - Basic date values
* `dayOfWeek`, `dayOfYear` - Positional information
* `daysInMonth` - Month metadata

**Time Components:**
* `hour`, `minute`, `second`, `microsecond` - Precise time values

**Week Information:**
* `isoWeek`, `weekOfMonth`, `weekOfYear` - Week numbering
* ISO and locale-aware week calculations

**Timestamps:**
- `timestamp` - Unix timestamp (seconds since epoch)
- `millisecondsSinceEpoch` - Milliseconds precision

> **📝 Note:** All getters are strongly typed - the analyzer will catch typos at compile time!
'''),
    ExampleItem(code: components.code, output: components.output),
    TextItem('''
## Localized names

Instead of magic properties like `\$carbon->englishDayOfWeek`, reuse
`locale('<code>')` plus `isoFormat()` to render localized names. This keeps the
API consistent with the rest of the documentation and works for any locale
supported by the bundled CLDR data.
'''),
    ExampleItem(code: localized.code, output: localized.output),
    TextItem('''
## Timezone metadata

Use `toDebugMap()` when you need the same timezone payload that PHP's
`Carbon::__debugInfo()` returns. The `timezone` entry includes the canonical
name, abbreviation, formatted offset, raw seconds, and DST flag. Project into a
new zone via `tz('<zone>')` just like in the PHP docs.
'''),
    ExampleItem(code: timezone.code, output: timezone.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildSetters() async {
  final basic = await setters_examples.runBasicSettersExample();
  final aliases = await setters_examples.runMethodAliasesExample();
  final dynamicSetters = await setters_examples.runDynamicSettersExample();
  final overflow = await setters_examples.runOverflowExample();
  return [
    TextItem('''
# Setters

PHP Carbon relies on `__set()` so you can write `\$date->year = 1975`. Dart
Carbon exposes explicit setters such as `setYear`, `setMonth`, `setDay`, etc.
These helpers mutate `Carbon` instances in place (immutable counterparts return
new values), which keeps the semantics aligned with PHP without dynamic
properties.
'''),
    TextItem('''
## Updating individual components

Call `setYear`, `setMonth`, `setDay`, and friends to change calendar
components. Overflow behaves like PHP Carbon: assigning month 13 advances the
year and wraps the month to January. Timezone projection still goes through
`tz('<zone>')`.
'''),
    ExampleItem(code: basic.code, output: basic.output),
    TextItem('''
## Method aliases

Every setter has fluent aliases (`years`, `months`, etc.), matching the PHP
API. Use whichever style fits your codebase; mutability and return values match
PHP as well.
'''),
    ExampleItem(code: aliases.code, output: aliases.output),
    TextItem('''
## Dynamic `set()`/`get()` helpers

PHP consumers can assign `year`, `month`, `dayOfYear`, and similar properties
through the `set()`/`get()` helpers. Dart mirrors that API while keeping a
strongly typed surface for the common components.
'''),
    ExampleItem(code: dynamicSetters.code, output: dynamicSetters.output),
    TextItem('''
## Overflow and strict mode

`CarbonSettings` control whether setters overflow (default) or throw. Toggle
strict mode with `Carbon.useStrictMode(true)` to mirror PHP Carbon's
`Carbon::useStrictMode()` helper.
'''),
    ExampleItem(code: overflow.code, output: overflow.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildWeeks() async {
  final localeExample = await weeks_examples.runLocaleWeekExample();
  final numbersExample = await weeks_examples.runWeekNumbersExample();
  final weekdayExample = await weeks_examples.runWeekdayAdjustExample();
  final daysExample = await weeks_examples.runDaysFromStartExample();
  final setterExample = await weeks_examples.runWeekSetterExample();
  return [
    TextItem('''
# Weeks

Locale metadata in Carbon defines the start of the week, weekend days, and the
threshold used for ISO week calculations. The Dart port loads the same locale
tables as PHP Carbon and exposes identical helpers such as `startOfWeek()`,
`endOfWeek()`, `isoWeek`, and `weeksInYear`. You can override the defaults via
`Carbon.setWeekStartsAt()` / `Carbon.setWeekendDays()` when you need
application-specific values.
'''),
    TextItem('''
## Locale-driven boundaries

Locales determine `startOfWeek()`/`endOfWeek()` as well as the default weekend
list. Switching from `en_US` (Sunday weeks) to Arabic (`ar`) mirrors the PHP
behavior without extra configuration, and you can still pass an explicit
weekday to `startOfWeek()` when you need a custom baseline.
'''),
    ExampleItem(code: localeExample.code, output: localeExample.output),
    TextItem('''
## Week numbers and week-based years

Use the strongly typed getters to inspect locale vs. ISO week numbers. The
example mirrors the PHP docs by showing both numbering systems and their
corresponding week-based years.
'''),
    ExampleItem(code: numbersExample.code, output: numbersExample.output),
    TextItem('''
## Moving between weeks

`setWeekNumber()` and `setIsoWeekNumber()` mirror PHP's setter-style helpers.
Use them to move relative to locale or ISO weeks while keeping the day/time
intact.
'''),
    ExampleItem(code: setterExample.code, output: setterExample.output),
    TextItem('''
## Jumping to another weekday

`setDayOfWeek()` reprojects a date onto another weekday using Carbon's locale
rules, which is the Dart equivalent of calling `weekday()`/`isoWeekday()` in the
PHP docs. You can chain it with other helpers (start/end of week, `next()`/`previous()`)
to build the same flows showcased on carbon.nesbot.com.
'''),
    ExampleItem(code: weekdayExample.code, output: weekdayExample.output),
    TextItem('''
## Days since start of week

`getDaysFromStartOfWeek()`/`setDaysFromStartOfWeek()` mirror the PHP helpers.
You can query how many days have elapsed since the locale-defined start and
jump to another offset using either locale defaults or custom weekday inputs.
'''),
    ExampleItem(code: daysExample.code, output: daysExample.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildFluentSetters() async {
  final typed = await fluent_setters_examples.runTypedSettersExample();
  final grouped = await fluent_setters_examples.runGroupedSettersExample();
  final copyFrom = await fluent_setters_examples.runCopyFromExample();
  return [
    TextItem('''
# Fluent Setters

PHP Carbon lets you call `\$date->year(1975)->month(5)…` thanks to `__call`
magic. Dart Carbon favors explicit `setYear`/`setMonth` helpers that return the
mutated instance, so you can still chain them fluently while keeping analyzer
support and autocompletion.
'''),
    TextItem('''
## Chaining typed setters

Each `set*` helper (plus aliases like `years()`) returns the mutated `Carbon`
instance, which makes fluent chains behave like the PHP docs. Microseconds and
timezone projections work the same way.
'''),
    ExampleItem(code: typed.code, output: typed.output),
    TextItem('''
## Grouped setters (`setDate*` family)

Use `setDate`, `setTime`, and `setTimeFrom()` when you need to update multiple
components at once. The return type is still `CarbonInterface`, so you can keep
chaining additional modifiers.
'''),
    ExampleItem(code: grouped.code, output: grouped.output),
    TextItem('''
## Copying date/time parts from other instances

`setTimeFrom`, `setDateFrom`, and `setDateTimeFrom` mirror the PHP helpers for
copying fields from another `CarbonInterface` or `DateTime`. Locale, timezone,
and settings remain untouched, matching the behavior documented on the PHP
site.
'''),
    ExampleItem(code: copyFrom.code, output: copyFrom.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildStringFormatting() async {
  final basic = await string_formatting_examples.runBasicFormattingExample();
  final iso = await string_formatting_examples.runIsoFormatExample();
  final probes = await string_formatting_examples.runFormatProbeExample();
  final overrides = await string_formatting_examples.runCustomToStringExample();
  return [
    TextItem('''
# String Formatting

Carbon retains the PHP `to...String()` helpers (`toDateString()`,
`toFormattedDateString()`, `toDayDateTimeString()`, etc.) plus the flexible
`format()`/`isoFormat()` APIs. Dart uses ICU/Intl patterns for `format()`, while
`isoFormat()` continues to understand the Carbon token set (`LLLL`, `dddd`,
`Do`, bracketed literals) across locales.
'''),
    TextItem('''
## Core `toXXXString()` helpers

The snippet below mirrors the PHP docs and shows that every shortcut funnels
through the underlying formatter. Use `format()` when you need to supply custom
ICU/Intl patterns.
'''),
    ExampleItem(code: basic.code, output: basic.output),
    TextItem('''
## `isoFormat()` presets and tokens

`isoFormat()` exposes the same preset tokens (`LL`, `LLLL`, `dddd`, etc.) and
understands literals via brackets just like PHP. Locale changes happen per
instance, so you can render multiple languages side-by-side.
'''),
    ExampleItem(code: iso.code, output: iso.output),
    TextItem('''
## Format probing helpers

`hasFormat()` and `hasFormatWithModifiers()` let you check whether a string
matches a PHP-style format before attempting to parse it. Combine them with
`canBeCreatedFromFormat()` to mirror the guard clauses shown on the PHP site.
'''),
    ExampleItem(code: probes.code, output: probes.output),
    TextItem('''
## Customizing `toString()`

Call `Carbon.setToStringFormat()` to change the global default string or
`withToStringFormat()` for per-instance overrides. The `settings` getter exposes
the same metadata as PHP's `getSettings()` helper.
'''),
    ExampleItem(code: overrides.code, output: overrides.output),
    TextItem('''
## Differences compared to the PHP docs

- `format()` accepts ICU/Intl tokens (the same syntax used by `DateFormat`), not
  PHP's `DateTime::format()` letters. Use `isoFormat()` when you want Carbon's
  PHP-style tokens (`Do`, `LLLL`, etc.).
- HTML helpers such as `toHtmlString()`/`toHtmlDiffString()` have not been
  ported. Compose them manually using `format()`/`diffForHumans()`.
'''),
  ];
}

Future<List<DocItem>> _buildCommonFormats() async {
  final example = await common_formats_examples.runCommonFormatsExample();
  return [
    TextItem('''
# Common Formats

All RFC/ISO helpers from the PHP docs are available in Dart (`toAtomString()`,
`toIso8601String()`, `toRfc1123String()`, `toRfc3339String()`, etc.). These are
thin wrappers that keep Dart apps in sync with PHP examples and avoid memorizing
`DateFormat` patterns for well-known specs.
'''),
    TextItem('''
## Example: exporting canonical strings
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Differences compared to the PHP docs

- `toIso8601String()` always emits the extended ISO-8601 form with a colon in
  the offset (matching PHP Carbon's decision). Pass `keepOffset: true` if you do
  not want the value converted to UTC.
- PHP's note about `DateTime::ISO8601` incompatibility still applies. Use
  `dt.format(DateFormat('yyyy-MM-ddTHH:mm:ssZ'))` if you need the legacy compact
  form without a colon.
- Some niche helpers (`toHtmlString()`, `toHtmlDiffString()`) remain TODO until
  the corresponding PHP sections are ported.
'''),
  ];
}

Future<List<DocItem>> _buildConversion() async {
  final snapshot = await conversion_examples.runConversionSnapshotExample();
  final dateTimes = await conversion_examples.runDateTimeConversionExample();
  final carbonize = await conversion_examples.runCarbonizeExample();
  final cast = await conversion_examples.runCastExample();
  return [
    TextItem('''
# Conversion

Carbon preserves the PHP conversion helpers: `toArray()`/`toObject()` snapshots,
bridges to platform `DateTime`/`DateTimeImmutable`, and easy switching between
mutable and immutable variants. The structured output mirrors PHP Carbon's keys
so serialized data travels cleanly between languages.
'''),
    TextItem('''
## Snapshot helpers (`toArray()` / `toObject()`)
'''),
    ExampleItem(code: snapshot.code, output: snapshot.output),
    TextItem('''
## Converting to `DateTime` and toggling mutability
'''),
    ExampleItem(code: dateTimes.code, output: dateTimes.output),
    TextItem('''
## `carbonize()` helpers

`carbonize()` mirrors the PHP helper: strings reuse the current timezone,
intervals/durations add to a clone, and periods return their starting date.
'''),
    ExampleItem(code: carbonize.code, output: carbonize.output),
    TextItem('''
## Casting helpers

`Carbon.cast()` and `CarbonImmutable.cast()` mirror PHP's `cast()` helpers,
returning a mutable or immutable copy regardless of the source type.
'''),
    ExampleItem(code: cast.code, output: cast.output),
    TextItem('''
## Differences compared to the PHP docs

- `cast()` is not available. Instead, call `.toMutable()` / `.toImmutable()` or
  construct your subclass manually with `MyCarbon.from(CarbonInterface source)`.
- `toDate()` maps to `toDateTime()` and `toDateTimeImmutable()` in Dart.
  `toObject()` returns a strongly typed `CarbonComponents` snapshot rather than a
  `stdClass`.
'''),
  ];
}

Future<List<DocItem>> _buildComparison() async {
  final ordering = await comparison_examples.runOrderingExample();
  final ranges = await comparison_examples.runRangeExample();
  final predicates = await comparison_examples.runPredicateExample();
  final matcher = await comparison_examples.runStringMatcherExample();
  return [
    TextItem('''
# Comparison

Equality/ordering helpers (`equalTo()`, `greaterThan()`, `isAfter()`, etc.) use
the underlying instant (UTC) so two values with different timezone labels still
compare correctly. Range helpers such as `between()`, `min()`, `max()`,
`closest()`, and `farthest()` behave exactly like the PHP docs describe.
'''),
    TextItem('''
## Equality and ordering respect timezones
'''),
    ExampleItem(code: ordering.code, output: ordering.output),
    TextItem('''
## Range helpers (`between`, `min`, `closest`, `farthest`)
'''),
    ExampleItem(code: ranges.code, output: ranges.output),
    TextItem('''
## Calendar predicates

Use helpers such as `isFuture()`, `isPast()`, `isSameMonth()`, `isCurrentYear()`,
and `isWeekend()` instead of reimplementing calendar math.
'''),
    ExampleItem(code: predicates.code, output: predicates.output),
    TextItem('''
## String matcher (PHP `is()` equivalent)

Use `matches()` with the same inputs PHP's `is()` accepts (`'Sunday'`,
`'2019-06'`, `3pm`, etc.).
'''),
    ExampleItem(code: matcher.code, output: matcher.output),
    TextItem('''
## Differences compared to the PHP docs

- PHP's dynamic `is('<string>')` matcher maps to the strongly typed
  `matches('<string>')` method in Dart. It accepts the same patterns but uses a
  Dart-friendly name because `is` is a reserved keyword.
- `equalTo()`/`min()`/`max()` currently accept `CarbonInterface`/`DateTime`
  inputs. Comparisons against `CarbonInterval`/`CarbonPeriod` will be added in a
  later pass.
- PHP's microsecond caveat does not apply—Dart always compares the full instant
  since the VM retains microsecond precision.
'''),
  ];
}

Future<List<DocItem>> _buildAdditionAndSubtraction() async {
  final increments = await addition_examples.runIncrementExample();
  final generic = await addition_examples.runGenericAddExample();
  final shift = await addition_examples.runShiftTimezoneExample();
  final raw = await addition_examples.runRawAddExample();
  return [
    TextItem('''
# Addition and Subtraction

Carbon exposes the same additive helpers as PHP Carbon (`addYears()`,
`addWeekdays()`, `addRealHours()`, etc.) plus the `change()`/`modify()` shortcut
for natural-language adjustments. The `+` and `-` operators are also overloaded to directly
add or subtract `Duration` objects. All mutators keep the "mutable vs immutable"
contract intact: `Carbon` mutates in place, `CarbonImmutable` returns copies.
'''),
    TextItem('''
## Typed helpers for calendar math
'''),
    ExampleItem(code: increments.code, output: increments.output),
    TextItem('''
## Generic `add`/`sub` and `change()`
'''),
    ExampleItem(code: generic.code, output: generic.output),
    TextItem('''
## Raw addition vs `add()`

`rawAdd()` and `rawSub()` call `DateTime.add()`/`subtract()` directly, mirroring
PHP's native `rawAdd()`/`rawSub()` helpers.
'''),
    ExampleItem(code: raw.code, output: raw.output),
    TextItem('''
## `shiftTimezone()` (vs `tz()`)

`shiftTimezone()` reinterprets the current wall time in a different timezone,
while `tz()` keeps the instant intact and merely changes the projection.
'''),
    ExampleItem(code: shift.code, output: shift.output),
    TextItem('''
## Differences compared to the PHP docs

- Generic `add()`/`sub()` accept `Duration`, `CarbonInterval`, or explicit
  amount+unit values. Passing free-form strings like `'1 day'` works for the most
  common units, but PHP's `DateInterval` objects and obscure keywords are not
  fully supported.
- The `+` and `-` operators are overloaded to allow direct addition and
  subtraction of `Duration` objects from `Carbon` and `CarbonImmutable` instances.
- Use `rawAdd()`/`rawSub()` to call `DateTime.add()`/`subtract()` directly when you
  want to bypass Carbon-specific rounding or overflow rules.
'''),
  ];
}

Future<List<DocItem>> _buildDifference() async {
  final diffUnits = await difference_examples.runDiffUnitsExample();
  final diffIntervals = await difference_examples.runDiffIntervalExample();
  final floatDiffs = await difference_examples.runFloatDiffExample();
  final diffInUnit = await difference_examples.runDiffInUnitExample();
  final durations = await difference_examples.runDurationDiffExample();
  return [
    TextItem('''
# Difference

`diff()` returns a Dart `Duration`, while helpers like `diffInHours()` and
`diffInMonths()` mirror the PHP Carbon API for truncated deltas. Use
`floatDiffIn*()` when you need fractional precision; both families use the same
underlying UTC math so daylight-saving transitions stay predictable.
'''),
    TextItem('''
## `diffIn*` helpers
'''),
    ExampleItem(code: diffUnits.code, output: diffUnits.output),
    TextItem('''
## `diffAsCarbonInterval`
'''),
    ExampleItem(code: diffIntervals.code, output: diffIntervals.output),
    TextItem('''
## `floatDiffIn*` helpers
'''),
    ExampleItem(code: floatDiffs.code, output: floatDiffs.output),
    TextItem('''
## `diffInUnit()`
'''),
    ExampleItem(code: diffInUnit.code, output: diffInUnit.output),
    TextItem('''
## `diff()` returns `Duration`
'''),
    ExampleItem(code: durations.code, output: durations.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildDiffForHumans() async {
  final humans = await diff_for_humans_examples.runHumanReadableExample();
  final detailed = await diff_for_humans_examples
      .runHumanReadableDetailExample();
  final localized = await diff_for_humans_examples
      .runLocalizedHumanReadableExample();
  return [
    TextItem('''
# Difference for Humans

`diffForHumans()` is backed by the `timeago` package. It accepts an optional
reference date and locale code (after registering messages with timeago) and
produces relative strings such as "5 hours ago" or "in 2 weeks".
'''),
    TextItem('''
## Basic usage
'''),
    ExampleItem(code: humans.code, output: humans.output),
    TextItem('''
## Multi-unit strings
'''),
    ExampleItem(code: detailed.code, output: detailed.output),
    TextItem('''
## Multi-language output

`CarbonTranslator` wires up the `timeago` locale messages so you can call
`diffForHumans(locale: 'fr')` and immediately return localized strings such as
`il y a 2 minutes` or `dans 3 jours`.
'''),
    ExampleItem(code: localized.code, output: localized.output),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildModifiers() async {
  final startEnd = await modifiers_examples.runStartEndExample();
  final navigation = await modifiers_examples.runNavigationExample();
  final rounding = await modifiers_examples.runRoundingExample();
  return [
    TextItem('''
# Modifiers

Start/end helpers (`startOfDay()`, `endOfMonth()`, `startOfQuarter()`),
navigation helpers (`next()`, `previous()`, `average()`), and rounding helpers
(`roundSecond()`, `ceilMinute()`, `floorUnit()`) behave like the PHP docs.
Modifiers always return `CarbonInterface`, so they can be chained fluently.

> ⚠️ These helpers mutate the instance they are called on. Call `copy()` (or
> `Carbon.now()` again) when you need both the original timestamp and a
> modified version for elapsed-time math.
'''),
    TextItem('''
## Start/end helpers
'''),
    ExampleItem(code: startEnd.code, output: startEnd.output),
    TextItem('''
## Navigating weeks and averages
'''),
    ExampleItem(code: navigation.code, output: navigation.output),
    TextItem('''
## Rounding helpers
'''),
    ExampleItem(code: rounding.code, output: rounding.output),
    TextItem('''
## Differences compared to the PHP docs

- `Carbon::setMidDayAt()` / `getMidDayAt()` are not available. `midDay()` always
  targets noon (12:00) today.
- `nthOfMonth()`/`firstOfMonth()`/`lastOfQuarter()` exist, but string-based
  weekday parsing only accepts English names (matching the current locale
  dictionary).
- Rounding helpers currently operate on UTC instants. There is no dedicated
  `roundFloor()`/`roundCeil()` that respect custom timezones beyond the instance
  timezone.
'''),
  ];
}

Future<List<DocItem>> _buildConstants() async {
  final basic = await constants_examples.runConstantsExample();
  return [
    TextItem('''
# Constants

Carbon provides constants for days of the week, months, etc.
'''),
    ExampleItem(code: basic.code, output: basic.output),
  ];
}

Future<List<DocItem>> _buildSerialization() async {
  final example = await serialization_examples.runSerializationExample();
  final custom = await serialization_examples.runCustomSerializationExample();
  return [
    TextItem('''
# Serialization

Use `serialize()` to capture an ISO string + timezone + locale/settings metadata
and `Carbon.fromSerialized()` to restore it. This mirrors PHP Carbon's serialized
payload while using JSON instead of PHP's `serialize()` format.
'''),
    TextItem('''
## Round-trip example
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Custom serialization
'''),
    ExampleItem(code: custom.code, output: custom.output),
    TextItem('''
## Differences compared to the PHP docs

-- Dart Carbon serializes to JSON rather than PHP's binary `serialize()` output.
  Use `Carbon.fromSerialized()` for round-trips instead of `unserialize()`.
- PHP's `serializeUsing()` customization hook is now mirrored via
  `Carbon.serializeUsing()`/`Carbon.resetSerializationFormat()` so you can
  replace the payload with any string (the bundled default payload still
  preserves ISO text + timezone/settings).
'''),
  ];
}

Future<List<DocItem>> _buildJson() async {
  final example = await json_examples.runJsonExample();
  final custom = await json_examples.runJsonCustomExample();
  return [
    TextItem('''
# JSON

`jsonEncode(Carbon)` produces an ISO 8601 string (matching PHP Carbon 2's
behavior). Use `Carbon.fromJson()` to restore from a structured payload that
includes ISO text and an optional timezone.
'''),
    TextItem('''
## Encoding and decoding
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Custom payloads and `__set_state`
'''),
    ExampleItem(code: custom.code, output: custom.output),
    TextItem('''
## Differences compared to the PHP docs

- `Carbon::serializeUsing()` is exposed through `Carbon.serializeUsing()` and
  `Carbon.resetSerializationFormat()`, so you can change the global payload
  without editing `toJson()`.
- `Carbon::fromJson()` and `Carbon::fromState()` accept the map that PHP's
  `__set_state()`/`jsonSerialize()` produce, so you can rehydrate using the
  standard fields (`iso`, `timeZone`, `locale`, `settings`, etc.).
'''),
  ];
}

Future<List<DocItem>> _buildMacro() async {
  final example = await macro_examples.runMacroExample();
  return [
    TextItem('''
# Macro

`Carbon.registerMacro()` lets you attach ad-hoc helpers (just like PHP Carbon's
macroable API). Macros can be invoked as if they were real methods, and you can
call them dynamically via the `carbon('<name>', [...])` helper on Carbon,
CarbonInterval, and CarbonPeriod. When a Carbon/Interval/Period instance is
typed as `dynamic`, you can also call `instance.myMacro()` directly because the
`noSuchMethod` override forwards unknown methods to registered macros.
'''),
    TextItem('''
## Registering a macro
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Differences compared to the PHP docs

- `CarbonMixin::macro()`/`Carbon::macro()` exist, but there is no `mixin`
  support in Dart—macros apply to all Carbon instances globally.
- CarbonInterval and CarbonPeriod expose `registerMacro()` plus the same
  `carbon('<name>')` helper for dynamic invocation, but you must register
  macros separately per type.
- When strict mode is enabled, calling `carbon('<name>')` for an unknown macro
  throws the same `CarbonUnknownMethodException` you would see for a missing
  getter/setter; strict mode off returns `null`.
'''),
  ];
}

Future<List<DocItem>> _buildCarbonInterval() async {
  final example = await carbon_interval_examples.runIntervalBasicsExample();
  final humans = await carbon_interval_examples.runIntervalForHumansExample();
  return [
    TextItem('''
# CarbonInterval

`CarbonInterval` mirrors PHP's API (fluent constructors, arithmetic, `forHumans`,
ISO spec helpers) while relying on Dart's `Duration` under the hood.
'''),
    TextItem('''
## Example
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Human-readable intervals

`CarbonInterval.forHumans()` mirrors PHP's humanization helpers via `timeago`
and the translator registry.
'''),
    ExampleItem(code: humans.code, output: humans.output),
    TextItem('''
## Differences compared to the PHP docs

- `CarbonInterval::make()`/`spec()`/`compareDateIntervals()`/constructor
  callbacks from PHP are missing. Use `CarbonInterval.fromComponents()` or
  `fromDuration()` instead.
- Day-counting helpers (`totalDays`, `cascade`, etc.) are not exposed; inspect
  `monthSpan`/`microseconds` directly or convert to `Duration`.
'''),
  ];
}

Future<List<DocItem>> _buildCarbonPeriod() async {
  final example = await carbon_period_examples.runPeriodBasicsExample();
  final filtered = await carbon_period_examples.runPeriodAdvancedExample();
  final strings = await carbon_period_examples.runPeriodFormattingExample();
  return [
    TextItem('''
# CarbonPeriod

`CarbonPeriod` iterates between two dates using a `CarbonInterval`. Dart's
implementation exposes the `*_Until` helpers (e.g., `daysUntil`) rather than the
string factories shown in the PHP docs.
'''),
    TextItem('''
## Example
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Filtering and recurrences
'''),
    ExampleItem(code: filtered.code, output: filtered.output),
    TextItem('''
## Localized string output

`CarbonPeriod.toString()` mirrors PHP Carbon by reading the locale's
`periodInterval`, `periodRecurrences`, and related strings. The same period can
emit different languages or recurrence summaries without manual formatting.
'''),
    ExampleItem(code: strings.code, output: strings.output),
    TextItem('''
## Differences compared to the PHP docs

- Filtering and recurrences helpers (`filter`, `recurrences`, `times`) now exist.
  Build the raw period with the `*_Until` helpers and then slice or filter the
  iterable to match PHP scenarios such as limiting a period to the first N
  recurrences or only the weekday entries.
'''),
  ];
}

Future<List<DocItem>> _buildCarbonTimeZone() async {
  final example = await carbon_timezone_examples.runTimezoneExample();
  return [
    TextItem('''
# CarbonTimeZone

Timezone metadata and projection helpers (`tz()`, `toDebugMap()['timezone']`)
function like PHP Carbon once `Carbon.configureTimeMachine()` wires up the TZ
database.
'''),
    TextItem('''
## Example
'''),
    ExampleItem(code: example.code, output: example.output),
    TextItem('''
## Differences compared to the PHP docs

- There is no dedicated `CarbonTimeZone` class in Dart; timezone helpers return
  strings or the debug map instead of PHP objects.
- `Carbon::setTestNowAndTimezone()` only affects Carbon's timezone handling and
  does not modify `DateTime.now()` globally the way PHP might when `date_default_timezone_set` is used.
'''),
  ];
}

Future<List<DocItem>> _buildMigrateToCarbon3() async {
  return [
    TextItem('''
# Migrate to Carbon 3

The PHP docs highlight the breaking changes between Carbon 2 and 3. Dart Carbon
already follows the Carbon 3 semantics, but this section summarizes the PHP
changes and explains which behaviors differ (or are not implemented) in Dart.
'''),
    TextItem('''
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
'''),
    TextItem('''
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
'''),
  ];
}

Future<List<DocItem>> _buildMigrateToCarbon2() async {
  return [
    TextItem('''
# Migrate to Carbon 2

For completeness, this section summarizes the Carbon 1 → Carbon 2 migration
notes from the PHP docs and states how Dart Carbon behaves.
'''),
    TextItem('''
## Highlights from the PHP release notes

- `Carbon` is now macroable.
- `CarbonInterval` was added.
- `CarbonPeriod` was added.
- `CarbonTimeZone` was added.
- `Carbon` now implements `DateTimeInterface`.
'''),
    TextItem('''
## Dart status

- Macros are supported via `Carbon.registerMacro()`.
- `CarbonInterval` is fully supported.
- `CarbonPeriod` is fully supported.
- `CarbonTimeZone` logic is embedded in `Carbon` and `Carbon.configureTimeMachine()`.
- Dart's `Carbon` implements `CarbonInterface` which mimics `DateTimeInterface`.
'''),
  ];
}

# Migrate to Carbon 3

The PHP docs highlight the breaking changes between Carbon 2 and 3. Dart Carbon
already follows the Carbon 3 semantics, but this section summarizes the PHP
changes and explains which behaviors differ (or are not implemented) in Dart.


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


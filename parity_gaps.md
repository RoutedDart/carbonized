# PHP Carbon Parity Gaps

This table tracks every “Differences compared to the PHP docs” note from the generated markdown, along with the next action to close the gap.

| Document | Missing / Difference | Next action | Status |
| --- | --- | --- | --- |
| `addition_and_subtraction.md` | `add()`/`sub()` accept `Duration`, `CarbonInterval`, or explicit unit amounts, but do not fully mirror PHP’s `DateInterval` objects or obscure keywords. | Expand keyword parser and document fallback once complete. | Pending |
| `carboninterval.md` | `CarbonInterval::make()`, `spec()`, `compareDateIntervals()`, and day-counting helpers are missing. | Introduce helpers such as `spec()`/`make()` and expose cascade/totalDays-like utilities. | Pending |
| `carbonperiod.md` | Filtering/recurrence helpers exist but there are no PHP-style fluent slices; users must manually filter recurrences. | Evaluate whether helper wrappers are needed or keep documentation of slicing technique. | Pending |
| `carbontimezone.md` | No `CarbonTimeZone` class equivalent; timezone helpers return primitive data. `setTestNowAndTimezone()` doesn’t change the process timezone. | Document the limitation; no Dart change planned at this time. | Pending |
| `common_formats.md` | PHP HTML helpers (`toHtmlString()`, `toHtmlDiffString()`, etc.) are not implemented. | Implement the HTML-format helpers, add tests/examples, and regenerate docs. | In progress |
| `comparison.md` | PHP’s `is()` -> Dart `matches()` and comparators accept intervals/periods. | Already implemented; documentation matches. | Closed |
| `constants.md` | Weekday constants (`SUNDAY`, etc.) and numeric helpers (e.g., `YEARS_PER_DECADE`) are not defined. | Consider adding a constants helper object or document alternatives. | Pending |
| `conversion.md` | PHP’s `cast()` helper is missing; Dart exposes `toMutable()`/`toImmutable()` and manual constructors. | Consider adding a `cast()` convenience or document the current equivalents. | Pending |
| `difference.md` | `diff()` returns `Duration` instead of `DateInterval`. `CarbonInterval.forHumans()` now matches PHP behavior. | Add `CarbonInterval` helpers or improve documentation around `diffAsCarbonInterval()`. | Pending |
| `difference_for_humans.md` | `diffForHumans()` approximates months/years; PHP flags like `JUST_NOW` are missing. | Document the approximation and optionally add helper flags later. | Pending |
| `fluent_setters.md` | No dynamic setters (`$date->year(...)`), no `setDateTime()`, and `setDateTimeFrom()` doesn’t copy tz/settings. | Consider DSL or helper method for copying date/time/tz together if demand arises. | Pending |
| `json.md` | `serializeUsing()`, `fromJson()`, and `fromState()` exist, mirroring PHP. | Already implemented and documented. | Closed |
| `localization.md` | `.locale()` accepts only one locale; scanners and fallback lists aren’t available. | Document the limitation and refer to `locale_defaults.dart`. | Pending |
| `macro.md` | No Dart mixin support—macros register globally. | Document the difference once macro API stabilizes. | Pending |
| `modifiers.md` | Missing `setMidDayAt()`, string weekday parsing English-only, rounding helpers tied to UTC. | Plan whether to add more localized parsing and timezone-aware rounding. | Pending |
| `serialization.md` | JSON serialization used instead of PHP’s binary `serialize()`; `serializeUsing()` is mirrored. | Document the difference. | Pending |
| `setters.md` | Direct property assignment not supported; `set()` accepts limited fields; timezone set via `tz()` instead of property. | Document the Dart idioms and keep API concise. | Pending |
| `string_formatting.md` | `format()` uses ICU tokens; HTML helpers missing. | Implement HTML helpers and document token differences. | In progress |
| `testing_aids.md` | No `sleep()` or Carbonite helpers; relative keywords limited to English. | Discuss whether to add additional helpers or expand locale dictionary. | Pending |
| `weeks.md` | No `firstWeekDay`/`lastWeekDay` magic properties; week overrides must use settings. | Consider adding helper getters/writers for magic properties or document the settings approach. | Pending |

> **Next steps**: Implement the highest-impact missing features (starting with the HTML helpers in `common_formats`/`string_formatting`), regenerate `docs/*`, and update this table as each gap is resolved.

# Migrate to Carbon 2

For completeness, this section summarizes the Carbon 1 → Carbon 2 migration
notes from the PHP docs and states how Dart Carbon behaves.


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


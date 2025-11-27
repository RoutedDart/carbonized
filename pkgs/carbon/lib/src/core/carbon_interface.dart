/// Declares the public API shared by [Carbon] and [CarbonImmutable].
///
/// Consumers interact with the interface when referencing `CarbonInterface`
/// for testing or dependency injection.
part of '../carbon.dart';

/// Contract shared by [Carbon] and [CarbonImmutable].
///
/// The interface mirrors the PHP Carbon surface: every mutator returns
/// `CarbonInterface` to enable fluent chains and every getter exposes the same
/// calendar math helpers. See the PHP documentation for semantic notes where
/// behaviors are inherited verbatim.
abstract class CarbonInterface implements Comparable<CarbonInterface> {
  /// The underlying UTC DateTime value.
  DateTime get dateTime;

  /// The locale identifier (e.g., "en", "fr_FR").
  String get localeCode;

  /// The timezone name (e.g., "America/New_York"), or null for UTC.
  String? get timeZoneName;

  /// Global settings controlling calendar math and week boundaries.
  CarbonSettings get settings;

  /// Snapshot of the most recent parsing or creation attempt, or `null` when
  /// no operation has run yet.
  CarbonLastErrors? getLastErrors();

  /// Creates a clone with optional overrides.
  ///
  /// Mutating implementations may update `this`, while immutable ones return a
  /// new instance.
  CarbonInterface copyWith({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  });

  /// Creates a detached clone with the exact same state.
  ///
  /// Use this when you need to experiment on a snapshot without mutating the
  /// original value:
  ///
  /// ```dart
  /// final original = Carbon.parse('2024-02-01');
  /// final copy = original.copy()..addMonth();
  /// print(original.month); // 2 — untouched
  /// ```
  CarbonInterface copy();

  /// Alias for [copy] to mirror PHP's `$carbon->clone()` helper.
  CarbonInterface clone();

  /// Converts [input] into a Carbon instance relative to this value.
  ///
  /// Strings are parsed using the current timezone; [Duration] and
  /// [CarbonInterval] inputs add to a clone of the current instance; passing
  /// `null` yields `now()` in the same timezone.
  CarbonInterface carbonize([dynamic input]);

  /// Applies a locale code used by formatting helpers.
  CarbonInterface locale(String locale);

  /// Returns a clone (or this when mutable) with a per-instance toString format.
  CarbonInterface withToStringFormat(dynamic format);

  /// Projects the date/time into a timezone (IANA name or fixed offset).
  CarbonInterface tz(String zoneName);

  /// Sets the UTC offset expressed in minutes (mirrors PHP `utcOffset`).
  CarbonInterface setUtcOffset(int minutes);

  /// Number of minutes offset from UTC.
  int get utcOffset;

  /// Reinterprets the current local time in [zoneName], shifting the instant.
  ///
  /// Equivalent to PHP Carbon's `shiftTimezone()`: wall clock values stay the
  /// same, but the stored moment is adjusted so the new timezone reports the
  /// same local date/time.
  CarbonInterface shiftTimezone(String zoneName);

  /// Projects into the UTC timezone.
  CarbonInterface toUtc();

  /// Projects into the current system timezone.
  CarbonInterface toLocal();

  /// Adds a Dart [Duration] verbatim (no month/year semantics).
  CarbonInterface add(Duration duration);

  /// Subtracts a value expressed in Carbon units (e.g., `2, 'weeks'`).
  CarbonInterface subtract([dynamic value, dynamic unit]);

  /// Alias for [subtract].
  CarbonInterface sub([dynamic value, dynamic unit]);

  /// Adds a [Duration] to this CarbonInterface instance.
  CarbonInterface operator +(Duration duration);

  /// Subtracts a [Duration] from this CarbonInterface instance.
  CarbonInterface operator -(Duration duration);

  /// Adds a number of days. Negative values subtract.
  CarbonInterface addDays(int days);

  /// Adds a number of weeks.
  CarbonInterface addWeeks(int weeks);

  /// Adds a number of weekdays (skipping configured weekends).
  CarbonInterface addWeekdays(int weekdays);

  /// Adds [amount] weekdays (defaults to 1).
  CarbonInterface addWeekday([int amount = 1]);

  /// Adds calendar months (respecting overflow rules in [settings]).
  CarbonInterface addMonths(int months);

  /// Adds calendar years.
  CarbonInterface addYears(int years);

  /// Subtracts a number of weekdays.
  CarbonInterface subWeekdays(int weekdays);

  /// Subtracts [amount] weekdays (defaults to 1).
  CarbonInterface subWeekday([int amount = 1]);

  /// Moves to the next weekday (Monday–Friday).
  CarbonInterface nextWeekday();

  /// Moves to the previous weekday.
  CarbonInterface previousWeekday();

  /// Moves to the next weekend day (Saturday or Sunday).
  CarbonInterface nextWeekendDay();

  /// Moves to the previous weekend day.
  CarbonInterface previousWeekendDay();

  /// Sets time to 00:00:00.
  CarbonInterface startOfDay();

  /// Sets time to 23:59:59.999999.
  CarbonInterface endOfDay();

  /// Moves to the start of the week (according to [settings.startOfWeek]).
  CarbonInterface startOfWeek();

  /// Moves to the end of the week.
  CarbonInterface endOfWeek();

  /// Returns the number of days since the start of the current week.
  int getDaysFromStartOfWeek([dynamic weekStartsAt]);

  /// Sets the current date to `startOfWeek + numberOfDays`.
  CarbonInterface setDaysFromStartOfWeek(
    int numberOfDays, [
    dynamic weekStartsAt,
  ]);

  /// Reads the locale-driven week number using optional overrides.
  int weekNumber([dynamic dayOfWeek, int? dayOfYear]);

  /// Moves to a specific locale week number.
  CarbonInterface setWeekNumber(
    int weekNumber, [
    dynamic dayOfWeek,
    int? dayOfYear,
  ]);

  /// Reads the ISO week number with optional overrides.
  int isoWeekNumber([dynamic dayOfWeek, int? dayOfYear]);

  /// Moves to a specific ISO week number.
  CarbonInterface setIsoWeekNumber(
    int weekNumber, [
    dynamic dayOfWeek,
    int? dayOfYear,
  ]);

  /// Mirrors PHP Carbon's `is('Sunday')`/`is('2019-06')` matcher.
  bool matches(String tester);

  /// Moves to the first day of the month at 00:00:00.
  CarbonInterface startOfMonth();

  /// Moves to the last day of the month at 23:59:59.
  CarbonInterface endOfMonth();

  /// Finds the first occurrence of [weekday] in the month.
  ///
  /// Accepts ints, strings, or enums just like PHP Carbon. When omitted,
  /// returns the first day of the month.
  CarbonInterface firstOfMonth([dynamic weekday]);

  /// Finds the last occurrence of a weekday in the month.
  CarbonInterface lastOfMonth([dynamic weekday]);

  /// Finds the nth occurrence of a weekday in the month.
  ///
  /// Returns null if [nth] doesn't exist in the month.
  CarbonInterface? nthOfMonth(int nth, [dynamic weekday]);

  /// Moves to the first day of the year.
  CarbonInterface startOfYear();

  /// Moves to the last day of the year.
  CarbonInterface endOfYear();

  /// Finds the first occurrence of a weekday in the year.
  CarbonInterface firstOfYear([dynamic weekday]);

  /// Finds the last occurrence of a weekday in the year.
  CarbonInterface lastOfYear([dynamic weekday]);

  /// Finds the nth occurrence of a weekday in the year.
  CarbonInterface? nthOfYear(int nth, [dynamic weekday]);

  /// Moves to the first day of the quarter.
  CarbonInterface firstOfQuarter([dynamic weekday]);

  /// Moves to the last day of the quarter.
  CarbonInterface lastOfQuarter([dynamic weekday]);

  /// Finds the nth occurrence of a weekday in the quarter.
  CarbonInterface? nthOfQuarter(int nth, [dynamic weekday]);

  /// Sets time to the start of the current hour (HH:00:00).
  CarbonInterface startOfHour();

  /// Sets time to the end of the current hour (HH:59:59).
  CarbonInterface endOfHour();

  /// Sets time to the start of the current minute (HH:MM:00).
  CarbonInterface startOfMinute();

  /// Sets time to the end of the current minute (HH:MM:59).
  CarbonInterface endOfMinute();

  /// Sets time to the start of the current second.
  CarbonInterface startOfSecond();

  /// Sets time to the end of the current second (with max microseconds).
  CarbonInterface endOfSecond();

  /// Moves to the first day of the quarter at 00:00:00.
  CarbonInterface startOfQuarter();

  /// Moves to the last day of the quarter.
  CarbonInterface endOfQuarter();

  /// Moves to the first year of the decade.
  CarbonInterface startOfDecade();

  /// Moves to the last year of the decade.
  CarbonInterface endOfDecade();

  /// Moves to the first year of the century.
  CarbonInterface startOfCentury();

  /// Moves to the last year of the century.
  CarbonInterface endOfCentury();

  /// Moves to the first year of the millennium.
  CarbonInterface startOfMillennium();

  /// Moves to the last year of the millennium.
  CarbonInterface endOfMillennium();

  /// Sets time to noon (12:00:00).
  CarbonInterface midDay();

  /// Moves to the start of [unit] (day, week, month, etc.).
  CarbonInterface startOf(dynamic unit);

  /// Moves to the end of [unit].
  CarbonInterface endOf(dynamic unit);

  /// Returns the midpoint between this date and [other].
  CarbonInterface average([dynamic other]);

  /// Applies a PHP-style modification string (e.g., "+1 day").
  ///
  /// #### Throws
  /// - [ArgumentError] when the expression cannot be parsed.
  CarbonInterface modify(String expression);

  /// Alias for [modify]; mirrors PHP Carbon's `change()` helper so code ported
  /// from PHP continues to compile.
  CarbonInterface change(String expression);

  /// Applies relative string such as "next week" or "tomorrow".
  CarbonInterface relative(String expression);

  /// Moves to the next occurrence of the given [weekday].
  CarbonInterface next([dynamic weekday]);

  /// Moves to the previous occurrence of the given [weekday].
  CarbonInterface previous([dynamic weekday]);

  /// Adds fractional seconds without rounding (uses `Duration.microseconds`).
  CarbonInterface addRealSeconds(num value);

  /// Subtracts fractional seconds.
  CarbonInterface subRealSeconds(num value);

  /// Adds fractional minutes.
  CarbonInterface addRealMinutes(num value);

  /// Subtracts fractional minutes.
  CarbonInterface subRealMinutes(num value);

  /// Adds fractional hours.
  CarbonInterface addRealHours(num value);

  /// Subtracts fractional hours.
  CarbonInterface subRealHours(num value);

  /// Adds fractional days.
  CarbonInterface addRealDays(num value);

  /// Subtracts fractional days.
  CarbonInterface subRealDays(num value);

  /// Adds fractional weeks.
  CarbonInterface addRealWeeks(num value);

  /// Subtracts fractional weeks.
  CarbonInterface subRealWeeks(num value);

  /// Adds fractional months (month-aware).
  CarbonInterface addRealMonths(num value);

  /// Subtracts fractional months.
  CarbonInterface subRealMonths(num value);

  /// Adds fractional quarters.
  CarbonInterface addRealQuarters(num value);

  /// Subtracts fractional quarters.
  CarbonInterface subRealQuarters(num value);

  /// Adds fractional years (year-aware).
  CarbonInterface addRealYears(num value);

  /// Subtracts fractional years.
  CarbonInterface subRealYears(num value);

  /// Adds decades (10-year chunks).
  CarbonInterface addRealDecades(num value);

  /// Subtracts decades.
  CarbonInterface subRealDecades(num value);

  /// Adds centuries (100-year chunks).
  CarbonInterface addRealCenturies(num value);

  /// Subtracts centuries.
  CarbonInterface subRealCenturies(num value);

  /// Adds fractional millennia (1000-year chunks).
  CarbonInterface addRealMillennia(num value);

  /// Subtracts fractional millennia.
  CarbonInterface subRealMillennia(num value);

  /// Returns true when this date equals [other].
  bool eq(dynamic other);

  /// Alias for [eq].
  bool equalTo(dynamic other);

  /// Returns true when this date does not equal [other].
  bool ne(dynamic other);

  /// Alias for [ne].
  bool notEqualTo(dynamic other);

  /// Returns true when this date is greater than [other].
  bool gt(dynamic other);

  /// Alias for [gt].
  bool greaterThan(dynamic other);

  /// Returns true when this date is greater than or equal to [other].
  bool gte(dynamic other);

  /// Alias for [gte].
  bool greaterThanOrEqual(dynamic other);

  /// Returns true when this date is less than [other].
  bool lt(dynamic other);

  /// Alias for [lt].
  bool lessThan(dynamic other);

  /// Returns true when this date is less than or equal to [other].
  bool lte(dynamic other);

  /// Alias for [lte].
  bool lessThanOrEqual(dynamic other);

  /// Returns true when this date falls between [start] and [end].
  ///
  /// When [inclusive] is true (default), endpoints count as inside the range.
  bool between(dynamic start, dynamic end, {bool inclusive = true});

  /// Alias for [between] with inclusive=true.
  bool betweenIncluded(dynamic start, dynamic end);

  /// Alias for [between] with inclusive=false.
  bool betweenExcluded(dynamic start, dynamic end);

  /// Returns true when this date is before [other].
  bool isBefore(CarbonInterface other);

  /// Returns true when this date is after [other].
  bool isAfter(CarbonInterface other);

  /// Returns true when this date shares the same calendar day as [other].
  bool isSameDay(CarbonInterface other);

  /// Checks if between two dates.
  bool isBetween(
    CarbonInterface start,
    CarbonInterface end, {
    bool inclusive = true,
  });

  /// Checks if this is a weekday (Mon–Fri).
  bool isWeekday();

  /// Checks if this is a weekend day (Sat–Sun).
  bool isWeekend();

  /// Checks if this is yesterday.
  bool isYesterday();

  /// Checks if this is today.
  bool isToday();

  /// Checks if this is tomorrow.
  bool isTomorrow();

  /// Checks if this is in the future.
  bool isFuture();

  /// Checks if this is in the past.
  bool isPast();

  /// Checks if this is now or in the future.
  bool isNowOrFuture();

  /// Checks if this is now or in the past.
  bool isNowOrPast();

  /// Checks if this is a leap year.
  bool isLeapYear();

  /// Returns the earlier of this or another date.
  CarbonInterface min([dynamic other]);

  /// Alias for [min].
  CarbonInterface minimum([dynamic other]);

  /// Returns the later of this or another date.
  CarbonInterface max([dynamic other]);

  /// Alias for [max].
  CarbonInterface maximum([dynamic other]);

  /// Returns the closest of two dates to this one.
  CarbonInterface closest(dynamic date1, dynamic date2);

  /// Returns the farthest of two dates from this one.
  CarbonInterface farthest(dynamic date1, dynamic date2);

  /// Returns true when this date matches [comparison]'s month/day (birthday).
  bool isBirthday([dynamic comparison]);

  /// Checks if in the current microsecond.
  bool isCurrentMicro();

  /// Alias for [isCurrentMicro].
  bool isCurrentMicrosecond();

  /// Checks if in the current millisecond.
  bool isCurrentMilli();

  /// Alias for [isCurrentMilli].
  bool isCurrentMillisecond();

  /// Checks if in the current second.
  bool isCurrentSecond();

  /// Checks if in the current minute.
  bool isCurrentMinute();

  /// Checks if in the current hour.
  bool isCurrentHour();

  /// Checks if on the current day.
  bool isCurrentDay();

  /// Checks if in the current week.
  bool isCurrentWeek();

  /// Checks if in the current month.
  bool isCurrentMonth();

  /// Checks if in the current quarter.
  bool isCurrentQuarter();

  /// Checks if in the current year.
  bool isCurrentYear();

  /// Checks if in the current decade.
  bool isCurrentDecade();

  /// Checks if in the current century.
  bool isCurrentCentury();

  /// Checks if in the current millennium.
  bool isCurrentMillennium();

  /// Checks if in the next microsecond.
  bool isNextMicro();

  /// Alias for [isNextMicro].
  bool isNextMicrosecond();

  /// Checks if in the next millisecond.
  bool isNextMilli();

  /// Alias for [isNextMilli].
  bool isNextMillisecond();

  /// Checks if in the next second.
  bool isNextSecond();

  /// Checks if in the next minute.
  bool isNextMinute();

  /// Checks if in the next hour.
  bool isNextHour();

  /// Checks if on the next day.
  bool isNextDay();

  /// Checks if in the next week.
  bool isNextWeek();

  /// Checks if in the next month.
  bool isNextMonth();

  /// Checks if in the next quarter.
  bool isNextQuarter();

  /// Checks if in the next year.
  bool isNextYear();

  /// Checks if in the next decade.
  bool isNextDecade();

  /// Checks if in the next century.
  bool isNextCentury();

  /// Checks if in the next millennium.
  bool isNextMillennium();

  /// Checks if in the last microsecond.
  bool isLastMicro();

  /// Alias for [isLastMicro].
  bool isLastMicrosecond();

  /// Checks if in the last millisecond.
  bool isLastMilli();

  /// Alias for [isLastMilli].
  bool isLastMillisecond();

  /// Checks if in the last second.
  bool isLastSecond();

  /// Checks if in the last minute.
  bool isLastMinute();

  /// Checks if in the last hour.
  bool isLastHour();

  /// Checks if on the last day.
  bool isLastDay();

  /// Checks if in the last week.
  bool isLastWeek();

  /// Checks if in the last month.
  bool isLastMonth();

  /// Checks if in the last quarter.
  bool isLastQuarter();

  /// Checks if in the last year.
  bool isLastYear();

  /// Checks if in the last decade.
  bool isLastDecade();

  /// Checks if in the last century.
  bool isLastCentury();

  /// Checks if in the last millennium.
  bool isLastMillennium();

  /// Checks if in the same microsecond as another date.
  bool isSameMicro([CarbonInterface? other]);

  /// Alias for [isSameMicro].
  bool isSameMicrosecond([CarbonInterface? other]);

  /// Checks if in the same millisecond.
  bool isSameMilli([CarbonInterface? other]);

  /// Alias for [isSameMilli].
  bool isSameMillisecond([CarbonInterface? other]);

  /// Checks if in the same second.
  bool isSameSecond([CarbonInterface? other]);

  /// Checks if in the same minute.
  bool isSameMinute([CarbonInterface? other]);

  /// Checks if in the same hour.
  bool isSameHour([CarbonInterface? other]);

  /// Checks if in the same week.
  bool isSameWeek([CarbonInterface? other]);

  /// Checks if in the same month.
  bool isSameMonth([CarbonInterface? other]);

  /// Checks if in the same quarter.
  bool isSameQuarter([CarbonInterface? other]);

  /// Checks if in the same year.
  bool isSameYear([CarbonInterface? other]);

  /// Checks if in the same decade.
  bool isSameDecade([CarbonInterface? other]);

  /// Checks if in the same century.
  bool isSameCentury([CarbonInterface? other]);

  /// Checks if in the same millennium.
  bool isSameMillennium([CarbonInterface? other]);

  /// Checks if this is a Monday.
  bool isMonday();

  /// Checks if this is a Tuesday.
  bool isTuesday();

  /// Checks if this is a Wednesday.
  bool isWednesday();

  /// Checks if this is a Thursday.
  bool isThursday();

  /// Checks if this is a Friday.
  bool isFriday();

  /// Checks if this is a Saturday.
  bool isSaturday();

  /// Checks if this is a Sunday.
  bool isSunday();

  /// Copies date components (year/month/day) from [source].
  CarbonInterface setDateFrom(CarbonInterface source);

  /// Copies time components (hour/minute/second/microsecond) from [source].
  CarbonInterface setTimeFrom(CarbonInterface source);

  /// Copies both date and time components from [source].
  CarbonInterface setDateTimeFrom(CarbonInterface source);

  /// ISO 8601 week number (1-53).
  int get isoWeek;

  /// ISO 8601 week-based year.
  int get isoWeekYear;

  /// Number of ISO weeks in the current year (52 or 53).
  int get isoWeeksInYear;

  /// Locale-sensitive week number based on current settings/locale.
  int get localeWeek;

  /// Locale-sensitive week-based year.
  int get localeWeekYear;

  /// Checks if daylight saving time is in effect.
  bool isDST();

  /// Whether this is in local timezone.
  bool get isLocal;

  /// Whether this is in UTC timezone.
  bool get isUtc;

  /// Whether the underlying DateTime is valid.
  bool get isValid;

  /// Whether this is a mutable [Carbon] instance.
  bool get isMutable;

  /// Calculates the difference from another date.
  Duration diff(CarbonInterface other);

  /// Formats the date relative to the [reference] date (defaults to now).
  ///
  /// Uses localized strings like "Today at 2:30 PM", "Yesterday at...", etc.
  /// [formats] can be used to override the locale's calendar formats.
  String calendar({CarbonInterface? reference, Map<String, String>? formats});

  /// Difference in days.
  int diffInDays(CarbonInterface other, {bool absolute = true});

  /// Difference expressed as a [CarbonInterval].
  CarbonInterval diffAsCarbonInterval(
    CarbonInterface other, {
    bool absolute = true,
  });

  /// Difference expressed as a [Duration].
  Duration diffAsDateInterval(CarbonInterface other, {bool absolute = false});

  /// Difference in hours.
  int diffInHours(CarbonInterface other, {bool absolute = true});

  /// Difference in minutes.
  int diffInMinutes(CarbonInterface other, {bool absolute = true});

  /// Difference in seconds.
  int diffInSeconds(CarbonInterface other, {bool absolute = true});

  /// Difference in weeks.
  int diffInWeeks(CarbonInterface other, {bool absolute = true});

  /// Difference in months.
  int diffInMonths(CarbonInterface other, {bool absolute = true});

  /// Difference in quarters.
  int diffInQuarters(CarbonInterface other, {bool absolute = true});

  /// Difference in years.
  int diffInYears(CarbonInterface other, {bool absolute = true});

  /// Difference in decades.
  int diffInDecades(CarbonInterface other, {bool absolute = true});

  /// Difference in centuries.
  int diffInCenturies(CarbonInterface other, {bool absolute = true});

  /// Difference in millennia.
  int diffInMillennia(CarbonInterface other, {bool absolute = true});

  /// Difference in the specified [unit].
  double diffInUnit(
    dynamic unit,
    CarbonInterface other, {
    bool absolute = false,
  });

  /// Difference in days, floored (rounded down).
  int diffInDaysFloored(CarbonInterface other);

  /// Floating-point difference in microseconds (preserves fractions).
  double floatDiffInMicroseconds(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in milliseconds (preserves fractions).
  double floatDiffInMilliseconds(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in seconds (preserves fractions).
  double floatDiffInSeconds(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in minutes (preserves fractions).
  double floatDiffInMinutes(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in hours (preserves fractions).
  double floatDiffInHours(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in days (preserves fractions).
  double floatDiffInDays(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in weeks (preserves fractions).
  double floatDiffInWeeks(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in months (preserves fractions).
  double floatDiffInMonths(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in quarters (preserves fractions).
  double floatDiffInQuarters(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in years (preserves fractions).
  double floatDiffInYears(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in decades (preserves fractions).
  double floatDiffInDecades(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in centuries (preserves fractions).
  double floatDiffInCenturies(CarbonInterface other, {bool absolute = true});

  /// Floating-point difference in millennia (preserves fractions).
  double floatDiffInMillennia(CarbonInterface other, {bool absolute = true});

  /// Difference in UTC microseconds (with fractional part).
  double diffInUTCMicros([dynamic date, bool absolute = true]);

  /// Alias for [diffInUTCMicros].
  double diffInUTCMicroseconds([dynamic date, bool absolute = true]);

  /// Difference in UTC milliseconds (with fractional part).
  double diffInUTCMillis([dynamic date, bool absolute = true]);

  /// Alias for [diffInUTCMillis].
  double diffInUTCMilliseconds([dynamic date, bool absolute = true]);

  /// Difference in UTC seconds (with fractional part).
  double diffInUTCSeconds([dynamic date, bool absolute = true]);

  /// Difference in UTC minutes (with fractional part).
  double diffInUTCMinutes([dynamic date, bool absolute = true]);

  /// Difference in UTC hours (with fractional part).
  double diffInUTCHours([dynamic date, bool absolute = true]);

  /// Difference in UTC days (with fractional part).
  double diffInUTCDays([dynamic date, bool absolute = true]);

  /// Difference in UTC weeks (with fractional part).
  double diffInUTCWeeks([dynamic date, bool absolute = true]);

  /// Difference in UTC months (with fractional part).
  double diffInUTCMonths([dynamic date, bool absolute = true]);

  /// Difference in UTC quarters (with fractional part).
  double diffInUTCQuarters([dynamic date, bool absolute = true]);

  /// Difference in UTC years (with fractional part).
  double diffInUTCYears([dynamic date, bool absolute = true]);

  /// Difference in UTC decades (with fractional part).
  double diffInUTCDecades([dynamic date, bool absolute = true]);

  /// Difference in UTC centuries (with fractional part).
  double diffInUTCCenturies([dynamic date, bool absolute = true]);

  /// Difference in UTC millennia (with fractional part).
  double diffInUTCMillennia([dynamic date, bool absolute = true]);

  /// Difference in real seconds (fractional) ignoring calendar math quirks.
  /// Difference in wall-clock seconds between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealSeconds(CarbonInterface other, {bool absolute = true});

  /// Difference in real minutes (fractional).
  /// Difference in wall-clock minutes between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealMinutes(CarbonInterface other, {bool absolute = true});

  /// Difference in real hours (fractional).
  /// Difference in wall-clock hours between `this` and [other] with fractional
  /// precision.
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealHours(CarbonInterface other, {bool absolute = true});

  /// Difference in real days (fractional).
  /// Difference in wall-clock days between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealDays(CarbonInterface other, {bool absolute = true});

  /// Difference in real weeks (fractional).
  /// Difference in wall-clock weeks between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealWeeks(CarbonInterface other, {bool absolute = true});

  /// Difference in real milliseconds.
  /// Difference in wall-clock milliseconds between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealMilliseconds(CarbonInterface other, {bool absolute = true});

  /// Difference in real microseconds.
  /// Difference in wall-clock microseconds between `this` and [other].
  ///
  /// Set [absolute] to `false` to preserve the sign.
  double diffInRealMicroseconds(CarbonInterface other, {bool absolute = true});

  /// Formats using a pattern string and optional locale.
  String format(String pattern, {String? locale});

  /// ISO 8601 string representation.
  String toIso8601String({bool keepOffset = false});

  /// ISO 8601 Zulu (UTC) string.
  String toIso8601ZuluString();

  /// Alias for [toIso8601String].
  String toISOString({bool keepOffset = false});

  /// JSON string representation.
  String toJsonString();

  /// Serializes the instance into a structured string for persistence.
  ///
  /// The payload can be passed back to [Carbon.fromSerialized] (or
  /// [CarbonImmutable.fromSerialized]) to rebuild the same instance with the
  /// original timezone, locale, and settings.
  String serialize();

  /// Alias for [toJsonString] to mirror PHP's `toJSON()` helper.
  String toJSON();

  /// Date-only string (YYYY-MM-DD).
  String toDateString();

  /// Time-only string (HH:mm:ss).
  String toTimeString();

  /// Combined date and time string.
  String toDateTimeString();

  /// Local date/time string with specified precision.
  String toDateTimeLocalString([String precision = 'second']);

  /// Legacy PHP `DateTime::toString` output (`Thu Dec 25 1975 ...`).
  String toLegacyString();

  /// Converts to Dart DateTime.
  DateTime toDateTime();

  /// Alias for [toDateTime].
  DateTime toDate();

  /// Immutable DateTime copy.
  DateTime toDateTimeImmutable();

  /// Formatted date string (e.g., "Jan 1, 2020").
  String toFormattedDateString();

  /// Day, date, and time string (e.g., "Mon, Jan 1, 2020 12:30 PM").
  String toDayDateTimeString();

  /// Formatted day date string.
  String toFormattedDayDateString();

  /// Atom/ISO 8601 string.
  String toAtomString();

  /// RFC 2109 cookie format.
  String toCookieString();

  /// Formats using Moment/Carbon-style ISO format tokens.
  String isoFormat(String pattern);

  /// Formats with locale-specific translation of tokens.
  String translatedFormat(String pattern);

  /// Debug-friendly map representation.
  Map<String, Object?> toDebugMap();

  /// RFC 822 format.
  String toRfc822String();

  /// RFC 850 format.
  String toRfc850String();

  /// RFC 1036 format.
  String toRfc1036String();

  /// RFC 1123 format.
  String toRfc1123String();

  /// RFC 2822 format.
  String toRfc2822String();

  /// RFC 3339 format.
  String toRfc3339String({bool extended = false});

  /// RSS format.
  String toRssString();

  /// W3C/ISO 8601 format.
  String toW3cString();

  /// RFC 7231 (HTTP date) format.
  String toRfc7231String();

  /// Human-readable difference (e.g., "2 days ago").
  ///
  /// [parts] limits how many units should appear in a multi-unit string when
  /// the diff is composed manually; values <= 1 delegate back to `timeago`.
  /// [short] toggles abbreviated labels, and [joiner] controls how portions are
  /// stitched together when `parts > 1`.
  String diffForHumans({
    CarbonInterface? reference,
    String? locale,
    int parts = 1,
    bool short = false,
    String joiner = ' ',
  });

  /// Long absolute difference string.
  String longAbsoluteDiffForHumans([CarbonInterface? other]);

  /// Long relative difference string.
  String longRelativeDiffForHumans([CarbonInterface? other]);

  /// Long relative difference from now.
  String longRelativeToNowDiffForHumans();

  /// Long relative difference from another date.
  String longRelativeToOtherDiffForHumans(CarbonInterface other);

  /// Unix timestamp in milliseconds.
  int toEpochMilliseconds();

  /// Calendar year.
  int get year;

  /// Age in years (equivalent to diffInYears() with default parameters).
  int get age;

  /// ISO year (may differ from calendar year around year boundaries).
  int get yearIso;

  /// Sets the year.
  CarbonInterface setYear(int year);

  /// Alias for [setYear].
  CarbonInterface years(int year);

  /// Sets the month.
  CarbonInterface setMonths(int month);

  /// Alias for [setMonths].
  CarbonInterface setMonth(int month);

  /// Sets the day of month.
  CarbonInterface setDay(int day);

  /// Alias for [setDay].
  CarbonInterface setDays(int day);

  /// Sets the day of year (1-366).
  CarbonInterface setDayOfYear(int dayOfYear);

  /// Sets the instant from a Unix timestamp expressed in seconds.
  CarbonInterface setTimestamp(int timestamp);

  /// Sets a named component using PHP-style keys such as `year`, `month`,
  /// `timestamp`, or `dayOfYear`.
  CarbonInterface set(String property, Object? value);

  /// Returns a named component previously stored or computed by `set()`.
  Object? get(String property);

  /// Sets the quarter (1-4).
  CarbonInterface setQuarter(int quarter);

  /// Sets the day of week (1=Monday, 7=Sunday).
  CarbonInterface setDayOfWeek(int weekday);

  /// Day of month.
  int get day;

  /// Alias for [day].
  int get days;

  /// ISO weekday (1=Monday, 7=Sunday).
  int get dayOfWeek;

  /// Alias for [day].
  int get dayOfMonth;

  /// Day of year (1-366).
  int get dayOfYear;

  /// Day within the quarter.
  int get dayOfQuarter;

  /// Day within the decade.
  int get dayOfDecade;

  /// Day within the century.
  int get dayOfCentury;

  /// Day within the millennium.
  int get dayOfMillennium;

  /// Quarter of year (1-4).
  int get quarter;

  /// Decade (e.g., 2020s).
  int get decade;

  /// Century (e.g., 21st).
  int get century;

  /// Millennium (e.g., 3rd).
  int get millennium;

  /// Days in a week (always 7).
  int get daysInWeek;

  /// Days in the current month.
  int get daysInMonth;

  /// Days in the current quarter.
  int get daysInQuarter;

  /// Days in the current year.
  int get daysInYear;

  /// Days in the current decade.
  int get daysInDecade;

  /// Days in the current century.
  int get daysInCentury;

  /// Days in the current millennium.
  int get daysInMillennium;

  /// Sets the minute.
  CarbonInterface setMinutes(int minute);

  /// Alias for [setMinutes].
  CarbonInterface setMinute(int minute);

  /// Sets the second.
  CarbonInterface setSeconds(int second);

  /// Alias for [setSeconds].
  CarbonInterface setSecond(int second);

  /// Alias for [setYear].
  CarbonInterface setYears(int year);

  /// Sets the hour (0-23).
  CarbonInterface setHour(int hour);

  /// Alias for [setHour].
  CarbonInterface setHours(int hour);

  /// Hour (0-23).
  int get hour;

  /// Alias for [hour].
  int get hours;

  /// Hour of day (0-23).
  int get hourOfDay;

  /// Hour within the week.
  int get hourOfWeek;

  /// Hour within the month.
  int get hourOfMonth;

  /// Hour within the quarter.
  int get hourOfQuarter;

  /// Hour within the year.
  int get hourOfYear;

  /// Hour within the decade.
  int get hourOfDecade;

  /// Hour within the century.
  int get hourOfCentury;

  /// Hour within the millennium.
  int get hourOfMillennium;

  /// Hours in a day.
  int get hoursInDay;

  /// Hours in a week.
  int get hoursInWeek;

  /// Hours in the current month.
  int get hoursInMonth;

  /// Hours in the current quarter.
  int get hoursInQuarter;

  /// Hours in the current year.
  int get hoursInYear;

  /// Hours in the current decade.
  int get hoursInDecade;

  /// Hours in the current century.
  int get hoursInCentury;

  /// Hours in the current millennium.
  int get hoursInMillennium;

  /// Sets the microsecond.
  CarbonInterface setMicro(int microsecond);

  /// Alias for [setMicro].
  CarbonInterface setMicros(int microsecond);

  /// Alias for [setMicro].
  CarbonInterface setMicrosecond(int microsecond);

  /// Alias for [setMicro].
  CarbonInterface setMicroseconds(int microsecond);

  /// Sets the millisecond.
  CarbonInterface setMilli(int millisecond);

  /// Alias for [setMilli].
  CarbonInterface setMillis(int millisecond);

  /// Alias for [setMilli].
  CarbonInterface setMillisecond(int millisecond);

  /// Alias for [setMilli].
  CarbonInterface setMilliseconds(int millisecond);

  /// Adds [duration] directly using `DateTime.add()`.
  CarbonInterface rawAdd(Duration duration);

  /// Subtracts [duration] directly using `DateTime.subtract()`.
  CarbonInterface rawSub(Duration duration);

  /// Sets year, month, and optionally day.
  CarbonInterface setDate(int year, [int? month, int? day]);

  /// Sets hour, minute, second, and optional sub-second components.
  CarbonInterface setTime(
    int hour, [
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]);

  /// Microsecond component.
  int get micro;

  /// Alias for [micro].
  int get micros;

  /// Alias for [micro].
  int get microsecond;

  /// Alias for [micro].
  int get microseconds;

  /// Microsecond within the millisecond.
  int get microsecondOfMillisecond;

  /// Microsecond within the second.
  int get microsecondOfSecond;

  /// Microsecond within the minute.
  int get microsecondOfMinute;

  /// Microsecond within the hour.
  int get microsecondOfHour;

  /// Microsecond within the day.
  int get microsecondOfDay;

  /// Microsecond within the week.
  int get microsecondOfWeek;

  /// Microsecond within the month.
  int get microsecondOfMonth;

  /// Microsecond within the quarter.
  int get microsecondOfQuarter;

  /// Microsecond within the year.
  int get microsecondOfYear;

  /// Microsecond within the decade.
  int get microsecondOfDecade;

  /// Microsecond within the century.
  int get microsecondOfCentury;

  /// Microsecond within the millennium.
  int get microsecondOfMillennium;

  /// Microseconds in a millisecond (1000).
  int get microsecondsInMillisecond;

  /// Microseconds in a second (1000000).
  int get microsecondsInSecond;

  /// Microseconds in a minute.
  int get microsecondsInMinute;

  /// Microseconds in an hour.
  int get microsecondsInHour;

  /// Microseconds in a day.
  int get microsecondsInDay;

  /// Microseconds in a week.
  int get microsecondsInWeek;

  /// Microseconds in the current month.
  int get microsecondsInMonth;

  /// Microseconds in the current quarter.
  int get microsecondsInQuarter;

  /// Microseconds in the current year.
  int get microsecondsInYear;

  /// Microseconds in the current decade.
  int get microsecondsInDecade;

  /// Microseconds in the current century.
  int get microsecondsInCentury;

  /// Microseconds in the current millennium.
  int get microsecondsInMillennium;

  /// Creates a period from this date to another, stepping by microseconds.
  CarbonPeriod microsecondsUntil([dynamic endDate, num factor = 1]);

  /// Alias for [microsecondsUntil].
  CarbonPeriod microsUntil([dynamic endDate, num factor = 1]);

  /// Millisecond component.
  int get milli;

  /// Alias for [milli].
  int get millis;

  /// Alias for [milli].
  int get millisecond;

  /// Alias for [milli].
  int get milliseconds;

  /// Millisecond within the second.
  int get millisecondOfSecond;

  /// Millisecond within the minute.
  int get millisecondOfMinute;

  /// Millisecond within the hour.
  int get millisecondOfHour;

  /// Millisecond within the day.
  int get millisecondOfDay;

  /// Millisecond within the week.
  int get millisecondOfWeek;

  /// Millisecond within the month.
  int get millisecondOfMonth;

  /// Millisecond within the quarter.
  int get millisecondOfQuarter;

  /// Millisecond within the year.
  int get millisecondOfYear;

  /// Millisecond within the decade.
  int get millisecondOfDecade;

  /// Millisecond within the century.
  int get millisecondOfCentury;

  /// Millisecond within the millennium.
  int get millisecondOfMillennium;

  /// Milliseconds in a second (1000).
  int get millisecondsInSecond;

  /// Milliseconds in a minute.
  int get millisecondsInMinute;

  /// Milliseconds in an hour.
  int get millisecondsInHour;

  /// Milliseconds in a day.
  int get millisecondsInDay;

  /// Milliseconds in a week.
  int get millisecondsInWeek;

  /// Milliseconds in the current month.
  int get millisecondsInMonth;

  /// Milliseconds in the current quarter.
  int get millisecondsInQuarter;

  /// Milliseconds in the current year.
  int get millisecondsInYear;

  /// Milliseconds in the current decade.
  int get millisecondsInDecade;

  /// Milliseconds in the current century.
  int get millisecondsInCentury;

  /// Milliseconds in the current millennium.
  int get millisecondsInMillennium;

  /// Creates a period from this date to another, stepping by milliseconds.
  CarbonPeriod millisecondsUntil([dynamic endDate, num factor = 1]);

  /// Alias for [millisecondsUntil].
  CarbonPeriod millisUntil([dynamic endDate, num factor = 1]);

  /// Year within the century.
  int get yearOfCentury;

  /// Year within the decade.
  int get yearOfDecade;

  /// Year within the millennium.
  int get yearOfMillennium;

  /// Years in the current century.
  int get yearsInCentury;

  /// Years in the current decade.
  int get yearsInDecade;

  /// Years in the current millennium.
  int get yearsInMillennium;

  /// Decade within the century.
  int get centuryOfMillennium;

  /// Centuries in the current millennium.
  int get centuriesInMillennium;

  /// Creates a period from this date to another, stepping by centuries.
  CarbonPeriod centuriesUntil([dynamic endDate, num factor = 1]);

  /// Decade within the century.
  int get decadeOfCentury;

  /// Decade within the millennium.
  int get decadeOfMillennium;

  /// Decades in the current century.
  int get decadesInCentury;

  /// Decades in the current millennium.
  int get decadesInMillennium;

  /// Creates a period from this date to another, stepping by decades.
  CarbonPeriod decadesUntil([dynamic endDate, num factor = 1]);

  /// Creates a period from this date to another, stepping by millennia.
  CarbonPeriod millenniaUntil([dynamic endDate, num factor = 1]);

  /// Creates a period from this date to another, stepping by years.
  CarbonPeriod yearsUntil([dynamic endDate, num factor = 1]);

  /// Creates a period from this date to another, stepping by months.
  CarbonPeriod monthsUntil([dynamic endDate, num factor = 1]);

  /// Number of months (0-12).
  int get months;

  /// Month (1-12).
  int get month;

  /// Month within the year (1-12).
  int get monthOfYear;

  /// Month within the quarter (1-3).
  int get monthOfQuarter;

  /// Month within the decade.
  int get monthOfDecade;

  /// Month within the century.
  int get monthOfCentury;

  /// Month within the millennium.
  int get monthOfMillennium;

  /// Months in a year.
  int get monthsInYear;

  /// Months in the current decade.
  int get monthsInDecade;

  /// Months in the current century.
  int get monthsInCentury;

  /// Months in the current millennium.
  int get monthsInMillennium;

  /// Months in a quarter.
  int get monthsInQuarter;

  /// Week of year (1-53).
  int get weekOfYear;

  /// Week of month.
  int get weekOfMonth;

  /// Week number within the current month (1-5).
  int get weekNumberInMonth;

  /// Week of quarter.
  int get weekOfQuarter;

  /// Week of decade.
  int get weekOfDecade;

  /// Week of century.
  int get weekOfCentury;

  /// Week of millennium.
  int get weekOfMillennium;

  /// Weeks in the current month.
  int get weeksInMonth;

  /// Weeks in the current quarter.
  int get weeksInQuarter;

  /// Weeks in the current year.
  int get weeksInYear;

  /// Weeks in the current decade.
  int get weeksInDecade;

  /// Weeks in the current century.
  int get weeksInCentury;

  /// Weeks in the current millennium.
  int get weeksInMillennium;

  /// Creates a period from this date to another, stepping by weeks.
  CarbonPeriod weeksUntil([dynamic endDate, num factor = 1]);

  /// Quarter of year (1-4).
  int get quarterOfYear;

  /// Quarter within the decade.
  int get quarterOfDecade;

  /// Quarter within the century.
  int get quarterOfCentury;

  /// Quarter within the millennium.
  int get quarterOfMillennium;

  /// Quarters in the current year.
  int get quartersInYear;

  /// Quarters in the current decade.
  int get quartersInDecade;

  /// Quarters in the current century.
  int get quartersInCentury;

  /// Quarters in the current millennium.
  int get quartersInMillennium;

  /// Creates a period from this date to another, stepping by quarters.
  CarbonPeriod quartersUntil([dynamic endDate, num factor = 1]);

  /// Seconds in a minute.
  int get secondsInMinute;

  /// Seconds in an hour.
  int get secondsInHour;

  /// Seconds in a day.
  int get secondsInDay;

  /// Seconds in a week.
  int get secondsInWeek;

  /// Seconds in the current month.
  int get secondsInMonth;

  /// Seconds in the current quarter.
  int get secondsInQuarter;

  /// Seconds in the current year.
  int get secondsInYear;

  /// Seconds in the current decade.
  int get secondsInDecade;

  /// Seconds in the current century.
  int get secondsInCentury;

  /// Seconds in the current millennium.
  int get secondsInMillennium;

  /// Creates a period from this date to another, stepping by seconds.
  CarbonPeriod secondsUntil([dynamic endDate, num factor = 1]);

  /// Creates a period from this date to another, stepping by days.
  CarbonPeriod daysUntil([dynamic endDate, num factor = 1]);

  /// Creates a period from this date to another, stepping by hours.
  CarbonPeriod hoursUntil([dynamic endDate, num factor = 1]);

  /// Second (0-59).
  int get second;

  /// Minute (0-59).
  int get minute;

  /// Alias for [minute].
  int get minutes;

  /// Minute within the hour.
  int get minuteOfHour;

  /// Minute within the day.
  int get minuteOfDay;

  /// Minute within the week.
  int get minuteOfWeek;

  /// Minute within the month.
  int get minuteOfMonth;

  /// Minute within the quarter.
  int get minuteOfQuarter;

  /// Minute within the year.
  int get minuteOfYear;

  /// Minute within the decade.
  int get minuteOfDecade;

  /// Minute within the century.
  int get minuteOfCentury;

  /// Minute within the millennium.
  int get minuteOfMillennium;

  /// Minutes in an hour.
  int get minutesInHour;

  /// Minutes in a day.
  int get minutesInDay;

  /// Minutes in a week.
  int get minutesInWeek;

  /// Minutes in the current month.
  int get minutesInMonth;

  /// Minutes in the current quarter.
  int get minutesInQuarter;

  /// Minutes in the current year.
  int get minutesInYear;

  /// Minutes in the current decade.
  int get minutesInDecade;

  /// Minutes in the current century.
  int get minutesInCentury;

  /// Minutes in the current millennium.
  int get minutesInMillennium;

  /// Creates a period from this date to another, stepping by minutes.
  CarbonPeriod minutesUntil([dynamic endDate, num factor = 1]);

  /// Alias for [second].
  int get seconds;

  /// Second within the minute.
  int get secondOfMinute;

  /// Second within the hour.
  int get secondOfHour;

  /// Second within the day.
  int get secondOfDay;

  /// Second within the week.
  int get secondOfWeek;

  /// Second within the month.
  int get secondOfMonth;

  /// Second within the quarter.
  int get secondOfQuarter;

  /// Second within the year.
  int get secondOfYear;

  /// Second within the decade.
  int get secondOfDecade;

  /// Second within the century.
  int get secondOfCentury;

  /// Second within the millennium.
  int get secondOfMillennium;

  /// Short human-readable absolute difference.
  String shortAbsoluteDiffForHumans([CarbonInterface? other]);

  /// Short human-readable relative difference.
  String shortRelativeDiffForHumans([CarbonInterface? other]);

  /// Short relative difference from now.
  String shortRelativeToNowDiffForHumans();

  /// Short relative difference from another date.
  String shortRelativeToOtherDiffForHumans(CarbonInterface other);

  /// Rounds seconds to the nearest [precision].
  CarbonInterface roundSeconds({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundSeconds].
  CarbonInterface roundSecond({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils seconds.
  CarbonInterface ceilSeconds({double precision = 1});

  /// Alias for [ceilSeconds].
  CarbonInterface ceilSecond({double precision = 1});

  /// Floors seconds.
  CarbonInterface floorSeconds({double precision = 1});

  /// Alias for [floorSeconds].
  CarbonInterface floorSecond({double precision = 1});

  /// Rounds minutes.
  CarbonInterface roundMinutes({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundMinutes].
  CarbonInterface roundMinute({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils minutes.
  CarbonInterface ceilMinutes({double precision = 1});

  /// Alias for [ceilMinutes].
  CarbonInterface ceilMinute({double precision = 1});

  /// Floors minutes.
  CarbonInterface floorMinutes({double precision = 1});

  /// Alias for [floorMinutes].
  CarbonInterface floorMinute({double precision = 1});

  /// Rounds months.
  CarbonInterface roundMonths({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundMonths].
  CarbonInterface roundMonth({double precision = 1, String function = 'round'});

  /// Ceils months.
  CarbonInterface ceilMonths({double precision = 1});

  /// Alias for [ceilMonths].
  CarbonInterface ceilMonth({double precision = 1});

  /// Floors months.
  CarbonInterface floorMonths({double precision = 1});

  /// Alias for [floorMonths].
  CarbonInterface floorMonth({double precision = 1});

  /// Rounds quarters.
  CarbonInterface roundQuarters({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundQuarters].
  CarbonInterface roundQuarter({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils quarters.
  CarbonInterface ceilQuarters({double precision = 1});

  /// Alias for [ceilQuarters].
  CarbonInterface ceilQuarter({double precision = 1});

  /// Floors quarters.
  CarbonInterface floorQuarters({double precision = 1});

  /// Alias for [floorQuarters].
  CarbonInterface floorQuarter({double precision = 1});

  /// Rounds years.
  CarbonInterface roundYears({double precision = 1, String function = 'round'});

  /// Alias for [roundYears].
  CarbonInterface roundYear({double precision = 1, String function = 'round'});

  /// Ceils years.
  CarbonInterface ceilYears({double precision = 1});

  /// Alias for [ceilYears].
  CarbonInterface ceilYear({double precision = 1});

  /// Floors years.
  CarbonInterface floorYears({double precision = 1});

  /// Alias for [floorYears].
  CarbonInterface floorYear({double precision = 1});

  /// Rounds hours.
  CarbonInterface roundHours({double precision = 1, String function = 'round'});

  /// Alias for [roundHours].
  CarbonInterface roundHour({double precision = 1, String function = 'round'});

  /// Ceils hours.
  CarbonInterface ceilHours({double precision = 1});

  /// Alias for [ceilHours].
  CarbonInterface ceilHour({double precision = 1});

  /// Floors hours.
  CarbonInterface floorHours({double precision = 1});

  /// Alias for [floorHours].
  CarbonInterface floorHour({double precision = 1});

  /// Rounds decades.
  CarbonInterface roundDecades({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundDecades].
  CarbonInterface roundDecade({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils decades.
  CarbonInterface ceilDecades({double precision = 1});

  /// Alias for [ceilDecades].
  CarbonInterface ceilDecade({double precision = 1});

  /// Floors decades.
  CarbonInterface floorDecades({double precision = 1});

  /// Alias for [floorDecades].
  CarbonInterface floorDecade({double precision = 1});

  /// Rounds millennia.
  CarbonInterface roundMillennia({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundMillennia].
  CarbonInterface roundMillennium({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils millennia.
  CarbonInterface ceilMillennia({double precision = 1});

  /// Alias for [ceilMillennia].
  CarbonInterface ceilMillennium({double precision = 1});

  /// Floors millennia.
  CarbonInterface floorMillennia({double precision = 1});

  /// Alias for [floorMillennia].
  CarbonInterface floorMillennium({double precision = 1});

  /// Rounds milliseconds.
  CarbonInterface roundMilliseconds({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundMilliseconds].
  CarbonInterface roundMillisecond({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils milliseconds.
  CarbonInterface ceilMilliseconds({double precision = 1});

  /// Alias for [ceilMilliseconds].
  CarbonInterface ceilMillisecond({double precision = 1});

  /// Floors milliseconds.
  CarbonInterface floorMilliseconds({double precision = 1});

  /// Alias for [floorMilliseconds].
  CarbonInterface floorMillisecond({double precision = 1});

  /// Rounds microseconds.
  CarbonInterface roundMicroseconds({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundMicroseconds].
  CarbonInterface roundMicrosecond({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils microseconds.
  CarbonInterface ceilMicroseconds({double precision = 1});

  /// Alias for [ceilMicroseconds].
  CarbonInterface ceilMicrosecond({double precision = 1});

  /// Floors microseconds.
  CarbonInterface floorMicroseconds({double precision = 1});

  /// Alias for [floorMicroseconds].
  CarbonInterface floorMicrosecond({double precision = 1});

  /// Rounds days.
  CarbonInterface roundDays({double precision = 1, String function = 'round'});

  /// Alias for [roundDays].
  CarbonInterface roundDay({double precision = 1, String function = 'round'});

  /// Ceils days.
  CarbonInterface ceilDays({double precision = 1});

  /// Alias for [ceilDays].
  CarbonInterface ceilDay({double precision = 1});

  /// Floors days.
  CarbonInterface floorDays({double precision = 1});

  /// Alias for [floorDays].
  CarbonInterface floorDay({double precision = 1});

  /// Seconds elapsed since midnight.
  double secondsSinceMidnight();

  /// Seconds remaining until end of day.
  double secondsUntilEndOfDay();

  /// Rounds centuries.
  CarbonInterface roundCenturies({
    double precision = 1,
    String function = 'round',
  });

  /// Alias for [roundCenturies].
  CarbonInterface roundCentury({
    double precision = 1,
    String function = 'round',
  });

  /// Ceils centuries.
  CarbonInterface ceilCenturies({double precision = 1});

  /// Alias for [ceilCenturies].
  CarbonInterface ceilCentury({double precision = 1});

  /// Floors centuries.
  CarbonInterface floorCenturies({double precision = 1});

  /// Alias for [floorCenturies].
  CarbonInterface floorCentury({double precision = 1});

  /// Serializes to a JSON-compatible map.
  Map<String, dynamic> toJson();

  /// Exports as a map with all components.
  Map<String, dynamic> toArray();

  /// Exports as a [CarbonComponents] snapshot.
  CarbonComponents toObject();

  /// Converts to an immutable [CarbonImmutable] instance.
  CarbonImmutable toImmutable();

  /// Converts to a mutable [Carbon] instance.
  Carbon toMutable();

  /// Localized full day name for the current locale.
  String get localeDayOfWeek;

  /// Localized short day name for the current locale.
  String get shortLocaleDayOfWeek;

  /// Localized minimal day name for the current locale.
  String get minDayName;

  /// Localized full month name for the current locale.
  String get localeMonth;

  /// Localized short month name for the current locale.
  String get shortLocaleMonth;

  /// English full day name (regardless of current locale).
  String get englishDayOfWeek;

  /// English short day name (regardless of current locale).
  String get shortEnglishDayOfWeek;

  /// English full month name (regardless of current locale).
  String get englishMonth;

  /// English short month name (regardless of current locale).
  String get shortEnglishMonth;

  /// Localized day name using current locale (alias for localeDayOfWeek).
  String get dayName;

  /// Localized short day name using current locale.
  String get shortDayName;

  /// Localized month name using current locale (alias for localeMonth).
  String get monthName;

  /// Localized short month name using current locale.
  String get shortMonthName;
}

/// Extension providing deprecated locale alias.
extension CarbonLocaleAlias on CarbonInterface {
  /// Sets the locale (deprecated, use [locale] instead).
  CarbonInterface setLocale(String locale) => this.locale(locale);
}

/// Implements Carbon's hybrid interval structure (months + microseconds).
///
/// ```dart
/// final span = CarbonInterval.weeks(2);
/// ```
part of '../carbon.dart';

/// Span that can express both calendar months and exact microseconds.
///
/// PHP Carbon encodes intervals using a combination of month counts plus a
/// microsecond remainder so month-aware math can keep leap years consistent.
class CarbonInterval {
  static final Map<String, CarbonMacro> _macros = <String, CarbonMacro>{};
  static void registerMacro(String name, CarbonMacro macro) =>
      _macros[name] = macro;
  static void unregisterMacro(String name) => _macros.remove(name);
  static bool hasMacro(String name) => _macros.containsKey(name);
  static void resetMacros() => _macros.clear();

  /// Sets the global default locale for Carbon operations.
  static void setLocale(String locale) => CarbonBase.setDefaultLocale(locale);

  /// Gets the current global default locale.
  static String getLocale() => CarbonBase.defaultLocale;

  /// Sets the fallback locale for the default locale.
  static void setFallbackLocale(String locale) =>
      CarbonTranslator.setFallbackLocale(locale);

  /// Gets the fallback locale for the default locale.
  static String? getFallbackLocale() => CarbonTranslator.getFallbackLocale();

  CarbonInterval._({this.monthSpan = 0, this.microseconds = 0, String? locale})
    : _locale = locale ?? CarbonBase.defaultLocale;

  /// Invokes a registered macro by [name] for this interval.
  dynamic carbon(
    String name, [
    List<dynamic> positionalArguments = const <dynamic>[],
    Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{},
  ]) {
    final macro = _macros[name];
    if (macro == null) {
      if (CarbonBase.strictMode) {
        throw CarbonUnknownMethodException(name);
      }
      return null;
    }
    return macro(this, positionalArguments, namedArguments);
  }

  /// Number of whole months represented by the interval.
  final int monthSpan;

  /// Additional microseconds represented by the interval.
  final int microseconds;

  /// The locale code for this interval instance.
  final String _locale;

  /// Gets the locale code for this interval instance.
  String get localeCode => _locale;

  /// Creates a new CarbonInterval with the specified locale.
  CarbonInterval locale(String locale) => CarbonInterval._(
    monthSpan: monthSpan,
    microseconds: microseconds,
    locale: locale,
  );

  /// Total days approximated by treating months as 30 days.
  double get totalDays =>
      monthSpan * 30 + microseconds / Duration.microsecondsPerDay;

  /// Whether the interval includes a month component.
  bool get hasMonths => monthSpan != 0;

  /// Whether the interval includes a microsecond component.
  bool get hasMicroseconds => microseconds != 0;

  /// Builds a year-based interval (12 months per year).
  static CarbonInterval years(int years) =>
      CarbonInterval._(monthSpan: years * 12);

  /// Builds a pure month interval.
  static CarbonInterval months(int months) =>
      CarbonInterval._(monthSpan: months);

  /// Builds a quarter interval (3 months each).
  static CarbonInterval quarters(int quarters) =>
      CarbonInterval._(monthSpan: quarters * 3);

  /// Builds a week interval (converted to days).
  static CarbonInterval weeks(int weeks) => days(weeks * 7);

  /// Builds a day interval represented in microseconds.
  static CarbonInterval days(int days) =>
      CarbonInterval._(microseconds: days * Duration.microsecondsPerDay);

  /// Builds an hour interval represented in microseconds.
  static CarbonInterval hours(int hours) =>
      CarbonInterval._(microseconds: hours * Duration.microsecondsPerHour);

  /// Builds a minute interval represented in microseconds.
  static CarbonInterval minutes(int minutes) =>
      CarbonInterval._(microseconds: minutes * Duration.microsecondsPerMinute);

  /// Builds a second interval represented in microseconds.
  static CarbonInterval seconds(int seconds) =>
      CarbonInterval._(microseconds: seconds * Duration.microsecondsPerSecond);

  /// Builds an interval from a raw microsecond count.
  static CarbonInterval microsecondsInterval(int us) =>
      CarbonInterval._(microseconds: us);

  /// Converts a [Duration] into a [CarbonInterval].
  static CarbonInterval fromDuration(Duration duration) =>
      CarbonInterval._(microseconds: duration.inMicroseconds);

  /// Builds an interval from individual components.
  ///
  /// #### Throws
  /// * [ArgumentError] if every component is zero.
  factory CarbonInterval.fromComponents({
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int microseconds = 0,
  }) {
    final totalMonths = years * 12 + months;
    final totalMicros =
        microseconds +
        seconds * Duration.microsecondsPerSecond +
        minutes * Duration.microsecondsPerMinute +
        hours * Duration.microsecondsPerHour +
        (days + weeks * 7) * Duration.microsecondsPerDay;
    if (totalMonths == 0 && totalMicros == 0) {
      throw ArgumentError('CarbonInterval cannot be entirely zero');
    }
    return CarbonInterval._(monthSpan: totalMonths, microseconds: totalMicros);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      final name = _symbolToString(invocation.memberName);
      final macro = _macros[name];
      if (macro != null) {
        return macro(
          this,
          invocation.positionalArguments,
          invocation.namedArguments,
        );
      }
    }
    return super.noSuchMethod(invocation);
  }

  static String _symbolToString(Symbol symbol) =>
      symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');

  /// Alias for [fromComponents], mirroring PHP `CarbonInterval::make()`.
  static CarbonInterval make({
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int microseconds = 0,
  }) => CarbonInterval.fromComponents(
    years: years,
    months: months,
    weeks: weeks,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    microseconds: microseconds,
  );

  /// Returns a human-readable label for this interval.
  ///
  /// Mirrors PHP `CarbonInterval::forHumans()`.
  /// Produces a duration string like "3 days 5 hours" instead of relative time.
  String forHumans({
    String? locale,
    bool short = false,
    bool absolute =
        false, // Kept for API compatibility, but ignored for duration formatting
    int parts = -1, // Number of parts to show (default all)
    String joiner = ' ',
  }) {
    final localeData = CarbonTranslator.matchLocale(locale ?? _locale);
    final code = localeData.localeCode;

    // Decompose interval
    final years = monthSpan ~/ 12;
    final months = monthSpan % 12;

    var remainingMicros = microseconds;
    final days = remainingMicros ~/ Duration.microsecondsPerDay;
    remainingMicros %= Duration.microsecondsPerDay;

    final hours = remainingMicros ~/ Duration.microsecondsPerHour;
    remainingMicros %= Duration.microsecondsPerHour;

    final minutes = remainingMicros ~/ Duration.microsecondsPerMinute;
    remainingMicros %= Duration.microsecondsPerMinute;

    final seconds = remainingMicros ~/ Duration.microsecondsPerSecond;

    final segments = <String>[];

    void addSegment(String unit, int count) {
      if (count == 0) return;
      final key = short ? _shortUnit(unit) : unit;
      segments.add(CarbonTranslator.translateUnit(key, count, locale: code));
    }

    addSegment('year', years);
    addSegment('month', months);
    // Weeks are usually converted to days in standard cascade, but if we wanted weeks we'd need extra logic.
    // PHP CarbonInterval cascade usually goes Year > Month > Day > Hour...
    addSegment('day', days);
    addSegment('hour', hours);
    addSegment('minute', minutes);
    addSegment('second', seconds);

    if (segments.isEmpty) {
      // If empty, it's zero. Return "0 seconds" (or short equivalent)
      final key = short ? 's' : 'second';
      return CarbonTranslator.translateUnit(key, 0, locale: code);
    }

    var resultSegments = segments;
    if (parts > 0 && segments.length > parts) {
      resultSegments = segments.sublist(0, parts);
    }

    return resultSegments.join(joiner);
  }

  String _shortUnit(String unit) {
    switch (unit) {
      case 'year':
        return 'y';
      case 'month':
        return 'm';
      case 'week':
        return 'w';
      case 'day':
        return 'd';
      case 'hour':
        return 'h';
      case 'minute':
        return 'min';
      case 'second':
        return 's';
      default:
        return unit;
    }
  }

  int compareTo(CarbonInterval other) {
    final monthDiff = monthSpan - other.monthSpan;
    if (monthDiff != 0) return monthDiff.sign.toInt();
    return (microseconds - other.microseconds).sign.toInt();
  }

  bool equalTo(CarbonInterval other) => compareTo(other) == 0;
  bool greaterThan(CarbonInterval other) => compareTo(other) > 0;
  bool greaterThanOrEqualTo(CarbonInterval other) => compareTo(other) >= 0;
  bool lessThan(CarbonInterval other) => compareTo(other) < 0;
  bool lessThanOrEqualTo(CarbonInterval other) => compareTo(other) <= 0;

  /// Breaks the interval into calendar-friendly components.
  Map<String, int> cascade() {
    var remaining = microseconds;
    final days = remaining ~/ Duration.microsecondsPerDay;
    remaining %= Duration.microsecondsPerDay;
    final hours = remaining ~/ Duration.microsecondsPerHour;
    remaining %= Duration.microsecondsPerHour;
    final minutes = remaining ~/ Duration.microsecondsPerMinute;
    remaining %= Duration.microsecondsPerMinute;
    final seconds = remaining ~/ Duration.microsecondsPerSecond;
    remaining %= Duration.microsecondsPerSecond;
    return {
      'months': monthSpan,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'microseconds': remaining,
    };
  }

  /// Returns the ISO 8601 spec string for this interval.
  String spec() {
    final parts = cascade();
    final buffer = StringBuffer('P');
    final months = parts['months']!;
    if (months > 0) buffer.write('${months}M');
    final days = parts['days']!;
    if (days > 0) buffer.write('${days}D');
    if (parts['hours']! > 0 ||
        parts['minutes']! > 0 ||
        parts['seconds']! > 0 ||
        parts['microseconds']! > 0) {
      buffer.write('T');
      if (parts['hours']! > 0) buffer.write('${parts['hours']}H');
      if (parts['minutes']! > 0) buffer.write('${parts['minutes']}M');
      if (parts['seconds']! > 0 || parts['microseconds']! > 0) {
        final seconds =
            parts['seconds']! +
            parts['microseconds']! / Duration.microsecondsPerSecond;
        buffer.write('${seconds.toStringAsFixed(6)}S');
      }
    }
    return buffer.toString();
  }

  /// Add a given duration to the interval.
  CarbonInterval add(Duration duration) => CarbonInterval._(
    monthSpan: monthSpan,
    microseconds: microseconds + duration.inMicroseconds,
  );

  /// Subtract a given duration from the interval.
  CarbonInterval sub(Duration duration) => CarbonInterval._(
    monthSpan: monthSpan,
    microseconds: microseconds - duration.inMicroseconds,
  );

  /// Add a given duration to the interval.
  CarbonInterval operator +(Duration duration) => add(duration);

  /// Subtract a given duration from the interval.
  CarbonInterval operator -(Duration duration) => sub(duration);

  /// Compares intervals similar to PHP `CarbonInterval::compareDateIntervals()`.
  static int compareDateIntervals(CarbonInterval a, CarbonInterval b) {
    final monthDiff = a.monthSpan - b.monthSpan;
    if (monthDiff != 0) return monthDiff;
    return (a.microseconds - b.microseconds).sign.toInt();
  }
}

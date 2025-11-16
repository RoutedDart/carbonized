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
  const CarbonInterval._({this.monthSpan = 0, this.microseconds = 0});

  /// Number of whole months represented by the interval.
  final int monthSpan;

  /// Additional microseconds represented by the interval.
  final int microseconds;

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

  Duration _toDurationApprox() {
    const microsecondsPerMonth = 30 * Duration.microsecondsPerDay;
    return Duration(
      microseconds: microseconds + monthSpan * microsecondsPerMonth,
    );
  }

  /// Returns a human-readable label for this interval.
  ///
  /// Uses the same translator + `timeago` helpers as [Carbon.diffForHumans].
  String forHumans({
    String? locale,
    bool short = false,
    bool absolute = false,
  }) {
    final resolvedLocale = CarbonTranslator.matchLocale(
      locale ?? CarbonBase.defaultLocale,
    ).locale;
    CarbonTranslator.ensureTimeagoLocale(resolvedLocale);
    final now = clock.now().toUtc();
    final target = absolute
        ? now.add(_toDurationApprox())
        : now.add(_toDurationApprox());
    final formatted = timeago.format(
      target,
      locale: resolvedLocale,
      allowFromNow: !absolute,
      clock: now,
    );
    return CarbonTranslator.translateTimeString(
      formatted,
      locale: resolvedLocale,
    );
  }
}

/// Declares shared enums and settings used by the Carbon core helpers.
///
/// ```dart
/// CarbonSettings settings =
///     const CarbonSettings(startOfWeek: DateTime.sunday);
/// ```
part of '../carbon.dart';

/// Units accepted by helper methods such as `add`/`sub`.
enum CarbonUnit {
  /// Microseconds.
  microsecond,

  /// Milliseconds.
  millisecond,

  /// Whole seconds.
  second,

  /// Minutes.
  minute,

  /// Hours.
  hour,

  /// Days.
  day,

  /// ISO weeks.
  week,

  /// Calendar months.
  month,

  /// Calendar quarters (3 months).
  quarter,

  /// Calendar years.
  year,

  /// Decades (10 years).
  decade,

  /// Centuries (100 years).
  century,

  /// Millennia (1000 years).
  millennium,
}

/// Global knobs that shape how Carbon performs calendar math.
class CarbonSettings {
  const CarbonSettings({
    this.monthOverflow = true,
    this.startOfWeek = DateTime.monday,
  });

  /// Whether month-based math allows overflow (mirrors Carbon's `monthOverflow`).
  final bool monthOverflow;

  /// First weekday used by week-based helpers such as `startOfWeek`.
  final int startOfWeek;

  /// Creates a copy with selected fields replaced.
  CarbonSettings copyWith({bool? monthOverflow, int? startOfWeek}) =>
      CarbonSettings(
        monthOverflow: monthOverflow ?? this.monthOverflow,
        startOfWeek: startOfWeek ?? this.startOfWeek,
      );
}

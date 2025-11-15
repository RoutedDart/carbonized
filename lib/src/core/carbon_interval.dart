part of '../carbon.dart';

class CarbonInterval {
  const CarbonInterval._({this.monthSpan = 0, this.microseconds = 0});

  final int monthSpan;
  final int microseconds;

  bool get hasMonths => monthSpan != 0;
  bool get hasMicroseconds => microseconds != 0;

  static CarbonInterval years(int years) =>
      CarbonInterval._(monthSpan: years * 12);

  static CarbonInterval months(int months) =>
      CarbonInterval._(monthSpan: months);

  static CarbonInterval quarters(int quarters) =>
      CarbonInterval._(monthSpan: quarters * 3);

  static CarbonInterval weeks(int weeks) => days(weeks * 7);

  static CarbonInterval days(int days) =>
      CarbonInterval._(microseconds: days * Duration.microsecondsPerDay);

  static CarbonInterval hours(int hours) =>
      CarbonInterval._(microseconds: hours * Duration.microsecondsPerHour);

  static CarbonInterval minutes(int minutes) =>
      CarbonInterval._(microseconds: minutes * Duration.microsecondsPerMinute);

  static CarbonInterval seconds(int seconds) =>
      CarbonInterval._(microseconds: seconds * Duration.microsecondsPerSecond);

  static CarbonInterval microsecondsInterval(int us) =>
      CarbonInterval._(microseconds: us);

  static CarbonInterval fromDuration(Duration duration) =>
      CarbonInterval._(microseconds: duration.inMicroseconds);

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
    return CarbonInterval._(
      monthSpan: totalMonths,
      microseconds: totalMicros,
    );
  }
}

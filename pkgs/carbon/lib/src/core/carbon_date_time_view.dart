part of '../carbon.dart';

/// Bridges a [CarbonInterface] to the standard [DateTime] API surface so the
/// instance can be passed wherever a `DateTime` is expected.
class CarbonDateTimeView implements DateTime {
  /// Creates a view for [carbon].
  const CarbonDateTimeView(this.carbon);

  /// The underlying Carbon instance used for all delegated getters.
  final CarbonInterface carbon;

  DateTime get _delegate => carbon.toDateTime();

  @override
  int compareTo(DateTime other) => _delegate.compareTo(other);

  @override
  bool operator ==(Object other) =>
      other is DateTime &&
      microsecondsSinceEpoch == other.microsecondsSinceEpoch;

  @override
  int get hashCode => _delegate.hashCode;

  @override
  bool isAfter(DateTime other) => _delegate.isAfter(other);

  @override
  bool isBefore(DateTime other) => _delegate.isBefore(other);

  @override
  bool isAtSameMomentAs(DateTime other) => _delegate.isAtSameMomentAs(other);

  @override
  DateTime add(Duration duration) => _delegate.add(duration);

  @override
  DateTime subtract(Duration duration) => _delegate.subtract(duration);

  @override
  Duration difference(DateTime other) => _delegate.difference(other);

  @override
  int get day => _delegate.day;

  @override
  int get hour => _delegate.hour;

  @override
  bool get isUtc => _delegate.isUtc;

  @override
  int get microsecond => _delegate.microsecond;

  @override
  int get microsecondsSinceEpoch => _delegate.microsecondsSinceEpoch;

  @override
  int get millisecond => _delegate.millisecond;

  @override
  int get millisecondsSinceEpoch => _delegate.millisecondsSinceEpoch;

  @override
  int get minute => _delegate.minute;

  @override
  int get month => _delegate.month;

  @override
  int get second => _delegate.second;

  @override
  Duration get timeZoneOffset => _delegate.timeZoneOffset;

  @override
  String get timeZoneName => _delegate.timeZoneName;

  @override
  DateTime toLocal() => _delegate.toLocal();

  @override
  DateTime toUtc() => _delegate.toUtc();

  @override
  String toIso8601String() => _delegate.toIso8601String();

  @override
  String toString() => _delegate.toString();

  @override
  int get weekday => _delegate.weekday;

  @override
  int get year => _delegate.year;
}

/// Convenience extension to create [DateTime] views from any Carbon instance.
extension CarbonDateTimeInterop on CarbonInterface {
  /// Returns a [DateTime] proxy that delegates to this Carbon instance.
  CarbonDateTimeView toDateTimeView() => CarbonDateTimeView(this);
}

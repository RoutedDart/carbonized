/// Defines the structured output used by `Carbon.toArray()` / `toObject()`.
///
/// ```dart
/// final parts = Carbon.now().toArray();
/// print(parts['dayOfWeek']);
/// ```
part of '../carbon.dart';

/// Immutable snapshot returned by `Carbon.toArray()`/`toObject()`.
///
/// The fields mirror the keys emitted by PHP Carbon so serialized payloads stay
/// compatible across languages.
class CarbonComponents {
  CarbonComponents({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.hour,
    required this.minute,
    required this.second,
    required this.micro,
    required this.timestamp,
    required this.formatted,
    required this.timezone,
  });

  /// Rebuilds a component snapshot from `Carbon.toArray()` output.
  factory CarbonComponents.fromMap(Map<String, dynamic> source) =>
      CarbonComponents(
        year: source['year'] as int,
        month: source['month'] as int,
        day: source['day'] as int,
        dayOfWeek: source['dayOfWeek'] as int,
        dayOfYear: source['dayOfYear'] as int,
        hour: source['hour'] as int,
        minute: source['minute'] as int,
        second: source['second'] as int,
        micro: source['micro'] as int,
        timestamp: source['timestamp'] as int,
        formatted: source['formatted'] as String,
        timezone: source['timezone'] as String?,
      );

  /// Calendar year.
  final int year;

  /// Calendar month (1-12).
  final int month;

  /// Day of month (1-31).
  final int day;

  /// ISO weekday where Monday is 1.
  final int dayOfWeek;

  /// Day of year (1-366).
  final int dayOfYear;

  /// Hour in 24-hour time.
  final int hour;

  /// Minute of the hour.
  final int minute;

  /// Second of the minute.
  final int second;

  /// Microseconds component (0-999999).
  final int micro;

  /// Unix timestamp expressed in seconds.
  final int timestamp;

  /// Human-readable representation (`yyyy-MM-dd HH:mm:ss`).
  final String formatted;

  /// Optional timezone identifier.
  final String? timezone;

  /// Serializes the snapshot back to a map.
  Map<String, dynamic> toMap() => <String, dynamic>{
    'year': year,
    'month': month,
    'day': day,
    'dayOfWeek': dayOfWeek,
    'dayOfYear': dayOfYear,
    'hour': hour,
    'minute': minute,
    'second': second,
    'micro': micro,
    'timestamp': timestamp,
    'formatted': formatted,
    'timezone': timezone,
  };

  @override
  String toString() => 'CarbonComponents(${toMap()})';
}

part of '../carbon.dart';

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

  final int year;
  final int month;
  final int day;
  final int dayOfWeek;
  final int dayOfYear;
  final int hour;
  final int minute;
  final int second;
  final int micro;
  final int timestamp;
  final String formatted;
  final String? timezone;

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

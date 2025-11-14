part of '../carbon.dart';

class CarbonTimeZoneSnapshot {
  const CarbonTimeZoneSnapshot({
    required this.localDateTime,
    required this.abbreviation,
    required this.offset,
    required this.isDst,
  });

  final DateTime localDateTime;
  final String abbreviation;
  final Duration offset;
  final bool isDst;
}

part of carbon_internal;

class CarbonTimeZoneSnapshot {
  const CarbonTimeZoneSnapshot({
    required this.localDateTime,
    required this.abbreviation,
    required this.offset,
  });

  final DateTime localDateTime;
  final String abbreviation;
  final Duration offset;
}

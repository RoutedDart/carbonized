/// Captures timezone offset metadata for `Carbon.toDebugMap` and friends.
///
/// Helpful when comparing PHP Carbon's `__debugInfo` output.
part of '../carbon.dart';

/// Snapshot of timezone information at a specific moment.
///
/// Captures the local time representation, offset, abbreviation, and DST status
/// for a given UTC moment in a particular timezone.
class CarbonTimeZoneSnapshot {
  /// Creates a timezone snapshot with the given properties.
  const CarbonTimeZoneSnapshot({
    required this.localDateTime,
    required this.abbreviation,
    required this.offset,
    required this.isDst,
  });

  /// The local date/time representation in this timezone.
  final DateTime localDateTime;

  /// Timezone abbreviation (e.g., "EST", "PDT").
  final String abbreviation;

  /// UTC offset for this timezone at this moment.
  final Duration offset;

  /// Whether daylight saving time is in effect.
  final bool isDst;
}

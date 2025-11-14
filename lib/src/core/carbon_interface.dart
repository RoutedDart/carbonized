part of carbon_internal;

abstract class CarbonInterface implements Comparable<CarbonInterface> {
  DateTime get dateTime;
  String get localeCode;
  String? get timeZoneName;
  CarbonSettings get settings;

  CarbonInterface copyWith({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  });

  CarbonInterface setLocale(String locale);
  CarbonInterface tz(String zoneName);
  CarbonInterface toUtc();
  CarbonInterface toLocal();

  CarbonInterface add(Duration duration);
  CarbonInterface subtract(Duration duration);
  CarbonInterface addDays(int days);
  CarbonInterface addWeeks(int weeks);
  CarbonInterface addMonths(int months);
  CarbonInterface addYears(int years);

  CarbonInterface startOfDay();
  CarbonInterface endOfDay();
  CarbonInterface startOfWeek();
  CarbonInterface endOfWeek();
  CarbonInterface startOfMonth();
  CarbonInterface endOfMonth();
  CarbonInterface startOfYear();
  CarbonInterface endOfYear();

  bool isBefore(CarbonInterface other);
  bool isAfter(CarbonInterface other);
  bool isSameDay(CarbonInterface other);
  bool isBetween(
    CarbonInterface start,
    CarbonInterface end, {
    bool inclusive = true,
  });

  Duration diff(CarbonInterface other);
  int diffInDays(CarbonInterface other, {bool absolute = true});
  int diffInHours(CarbonInterface other, {bool absolute = true});
  int diffInMinutes(CarbonInterface other, {bool absolute = true});

  String format(String pattern, {String? locale});
  String toIso8601String();
  String diffForHumans({CarbonInterface? reference, String? locale});
  int toEpochMilliseconds();

  Map<String, dynamic> toJson();
  CarbonImmutable toImmutable();
  Carbon toMutable();
}

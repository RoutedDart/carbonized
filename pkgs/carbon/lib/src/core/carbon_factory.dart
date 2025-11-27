part of '../carbon.dart';

/// Builds Carbon instances with pre-configured locale, timezone, settings,
/// and per-instance `toString` format (mirrors PHP's `Carbon\Factory`).
class CarbonFactory {
  CarbonFactory({
    this.locale,
    this.timeZone,
    this.settings,
    this.toStringFormat,
  });

  /// Locale applied to every created instance.
  final String? locale;

  /// Timezone applied to every created instance.
  final String? timeZone;

  /// Settings cloned into every instance.
  final CarbonSettings? settings;

  /// Optional per-instance `toString` formatter.
  final dynamic toStringFormat;

  /// Creates a Carbon instance using `Carbon.create` semantics.
  CarbonInterface create(
    int year,
    int month,
    int day, [
    int hour = 0,
    int minute = 0,
    int second = 0,
    int microsecond = 0,
  ]) {
    final instance = Carbon.create(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      microsecond: microsecond,
      locale: locale,
      settings: settings ?? CarbonBase.defaultSettings,
    );
    return _applyPreferences(instance);
  }

  /// Parses arbitrary input using the factory defaults.
  CarbonInterface parse(dynamic input, {String? format}) {
    final instance = Carbon.parse(
      input,
      format: format,
      locale: locale,
      timeZone: timeZone,
    );
    final adjusted = settings == null
        ? instance
        : instance.copyWith(settings: settings);
    return _applyPreferences(adjusted);
  }

  CarbonInterface now() {
    final instance = Carbon.now(locale: locale, timeZone: timeZone);
    final adjusted = settings == null
        ? instance
        : instance.copyWith(settings: settings);
    return _applyPreferences(adjusted);
  }

  CarbonInterface _applyPreferences(CarbonInterface value) {
    var result = value;
    if (timeZone != null) {
      result = result.tz(timeZone!);
    }
    if (locale != null) {
      result = result.locale(locale!);
    }
    if (settings != null) {
      result = result.copyWith(settings: settings);
    }
    if (toStringFormat != null) {
      result = result.withToStringFormat(toStringFormat);
    }
    return result;
  }
}

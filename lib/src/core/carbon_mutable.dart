part of '../carbon.dart';

class Carbon extends CarbonBase {
  Carbon._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  });

  factory Carbon.now({String? locale}) =>
      Carbon._internal(dateTime: clock.now().toUtc(), locale: locale);

  factory Carbon.today({String? locale}) {
    final current = clock.now().toUtc();
    return Carbon._internal(
      dateTime: DateTime.utc(current.year, current.month, current.day),
      locale: locale,
    );
  }

  factory Carbon.create({
    required int year,
    required int month,
    required int day,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
    bool isUtc = true,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    final date = isUtc
        ? DateTime.utc(
            year,
            month,
            day,
            hour,
            minute,
            second,
            millisecond,
            microsecond,
          )
        : DateTime(
            year,
            month,
            day,
            hour,
            minute,
            second,
            millisecond,
            microsecond,
          ).toUtc();
    return Carbon._internal(dateTime: date, locale: locale, settings: settings);
  }

  factory Carbon.fromDateTime(
    DateTime dateTime, {
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon._internal(
    dateTime: dateTime.isUtc ? dateTime : dateTime.toUtc(),
    locale: locale,
    settings: settings,
  );

  factory Carbon.parse(dynamic input, {String? format, String? locale}) {
    DateTime resolved;
    if (input is int) {
      final isSeconds = input.abs() < 1000000000000;
      final millis = isSeconds ? input * 1000 : input;
      resolved = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
    } else if (input is DateTime) {
      resolved = input.isUtc ? input : input.toUtc();
    } else if (input is String) {
      if (format != null && format.isNotEmpty) {
        final formatter = DateFormat(format, locale);
        resolved = formatter.parseUtc(input);
      } else {
        final parsed = DateTime.parse(input);
        resolved = parsed.isUtc ? parsed : parsed.toUtc();
      }
    } else {
      throw ArgumentError(
        'Unsupported input for Carbon.parse: ${input.runtimeType}',
      );
    }
    return Carbon._internal(dateTime: resolved, locale: locale);
  }

  static void registerMacro(String name, CarbonMacro macro) =>
      CarbonBase.registerMacro(name, macro);

  static void unregisterMacro(String name) => CarbonBase.unregisterMacro(name);

  static Future<void> configureTimeMachine({
    tm.DateTimeZoneProvider? provider,
    bool testing = true,
  }) => CarbonBase.configureTimeMachine(provider: provider, testing: testing);

  static void resetTimeMachineSupport() => CarbonBase.resetTimeMachine();

  static CarbonInterface fromJson(String source, {String? locale}) {
    final decoded = jsonDecode(source);
    if (decoded is String || decoded is int) {
      return Carbon.parse(decoded, locale: locale);
    }
    if (decoded is Map<String, dynamic>) {
      if (decoded.containsKey('iso')) {
        return Carbon.parse(decoded['iso'], locale: locale);
      }
      if (decoded.containsKey('epochMs')) {
        return Carbon.parse(decoded['epochMs'], locale: locale);
      }
    }
    throw ArgumentError('Unsupported JSON payload for Carbon.fromJson');
  }
}

part of '../carbon.dart';

/// Internal helper used by tests to verify subclass behavior.
class CarbonTestSubclass extends Carbon {
  CarbonTestSubclass._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  }) : super._internal();

  factory CarbonTestSubclass.from(CarbonInterface other) =>
      CarbonTestSubclass._internal(
        dateTime: other.dateTime,
        locale: other.localeCode,
        timeZone: other.timeZoneName,
        settings: other.settings,
      );

  factory CarbonTestSubclass.now({String? locale, String? timeZone}) =>
      CarbonTestSubclass.from(Carbon.now(locale: locale, timeZone: timeZone));
}

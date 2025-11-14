part of '../carbon.dart';

class CarbonImmutable extends CarbonBase {
  CarbonImmutable._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  });

  factory CarbonImmutable.now({String? locale}) =>
      Carbon.now(locale: locale).toImmutable();

  factory CarbonImmutable.parse(
    dynamic input, {
    String? format,
    String? locale,
  }) => Carbon.parse(input, format: format, locale: locale).toImmutable();

  factory CarbonImmutable.from(CarbonInterface other) =>
      CarbonImmutable._internal(
        dateTime: other.dateTime,
        locale: other.localeCode,
        timeZone: other.timeZoneName,
        settings: other.settings,
      );
}

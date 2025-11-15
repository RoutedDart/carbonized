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
    String? timeZone,
  }) => Carbon.parse(
    input,
    format: format,
    locale: locale,
    timeZone: timeZone,
  ).toImmutable();

  factory CarbonImmutable.from(CarbonInterface other) =>
      CarbonImmutable._internal(
        dateTime: other.dateTime,
        locale: other.localeCode,
        timeZone: other.timeZoneName,
        settings: other.settings,
      );

  static CarbonImmutable createFromDate([
    int? year,
    int? month,
    int? day,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) => Carbon.createFromDate(
    year,
    month,
    day,
    timeZone,
    locale,
    settings,
  ).toImmutable();

  static CarbonImmutable createFromTime([
    int? hour,
    int? minute,
    int? second,
    int microsecond = 0,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) => Carbon.createFromTime(
    hour,
    minute,
    second,
    microsecond,
    timeZone,
    locale,
    settings,
  ).toImmutable();

  static CarbonImmutable createFromTimeString(
    String time, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromTimeString(
    time,
    timeZone: timeZone,
    locale: locale,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable createFromTimestamp(
    num timestamp, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromTimestamp(
    timestamp,
    timeZone: timeZone,
    locale: locale,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable createFromTimestampUTC(
    num timestamp, {
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromTimestampUTC(
    timestamp,
    locale: locale,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable createFromTimestampMs(
    num timestamp, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromTimestampMs(
    timestamp,
    timeZone: timeZone,
    locale: locale,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable createFromTimestampMsUTC(
    num timestamp, {
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromTimestampMsUTC(
    timestamp,
    locale: locale,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable createFromFormat(
    String format,
    String input, {
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromFormat(
    format,
    input,
    locale: locale,
    timeZone: timeZone,
    settings: settings,
  ).toImmutable();

  static CarbonImmutable? createSafe([
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int microsecond = 0,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) => Carbon.createSafe(
    year,
    month,
    day,
    hour,
    minute,
    second,
    microsecond,
    timeZone,
    locale,
    settings,
  )?.toImmutable();

  static CarbonImmutable createStrict([
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int microsecond = 0,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) => Carbon.createStrict(
    year,
    month,
    day,
    hour,
    minute,
    second,
    microsecond,
    timeZone,
    locale,
    settings,
  ).toImmutable();
}

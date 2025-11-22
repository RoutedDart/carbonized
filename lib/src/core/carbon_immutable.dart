/// Declares the immutable Carbon variant and factory helpers.
///
/// ```dart
/// final frozen = CarbonImmutable.now();
/// ```
part of '../carbon.dart';

/// Immutable Carbon implementation.
///
/// Instances share the same fluent surface area as [Carbon] but every mutating
/// helper returns a new object. Convert from a mutable instance with
/// [Carbon.toImmutable] or build directly via the factory constructors below.
class CarbonImmutable extends CarbonBase {
  CarbonImmutable._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  });

  factory CarbonImmutable.now({String? locale}) =>
      Carbon.now(locale: locale).toImmutable();

  /// Restores an immutable snapshot from [CarbonInterface.serialize].
  ///
  /// ```dart
  /// final frozen = CarbonImmutable.now();
  /// final roundTrip = CarbonImmutable.fromSerialized(frozen.serialize());
  /// ```
  static CarbonImmutable fromSerialized(dynamic payload) =>
      CarbonBase.deserializeSerialized(payload).toImmutable();

  static void setToStringFormat(dynamic formatter) =>
      Carbon.setToStringFormat(formatter);

  static void resetToStringFormat() => Carbon.resetToStringFormat();

  static void registerTranslatorLocale(
    String locale,
    CarbonLocaleData translation, {
    List<String>? fallbackLocales,
  }) => Carbon.registerTranslatorLocale(
    locale,
    translation,
    fallbackLocales: fallbackLocales,
  );

  static void setTranslatorFallbackLocales(
    String locale,
    List<String> fallbackLocales,
  ) => Carbon.setTranslatorFallbackLocales(locale, fallbackLocales);

  static String translateNumber(String value, {String? locale}) =>
      Carbon.translateNumber(value, locale: locale);

  static String getAltNumber(String value, {String? locale}) =>
      Carbon.getAltNumber(value, locale: locale);

  static String translateTimeString(String value, {String? locale}) =>
      Carbon.translateTimeString(value, locale: locale);

  /// Returns the most recent parsing/creation report tracked by Carbon.
  static CarbonLastErrors? lastErrorsSnapshot() => Carbon.lastErrorsSnapshot();

  /// Overrides the stored parsing/creation report (mainly for tests).
  static void setLastErrors([CarbonLastErrors? errors]) =>
      Carbon.setLastErrors(errors);

  /// Clears the stored parsing/creation report.
  static void resetLastErrors() => Carbon.resetLastErrors();

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

  /// Parses [input] expressed in [locale], applying optional [timeZone], and
  /// returns an immutable snapshot.
  static CarbonImmutable parseFromLocale(
    String input, [
    String? locale,
    String? timeZone,
  ]) => Carbon.parseFromLocale(input, locale, timeZone).toImmutable();

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

  /// Casts [source] to an immutable instance, like PHP's `CarbonImmutable::cast()`.
  static CarbonImmutable cast(CarbonInterface source) => source.toImmutable();

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

  /// Parses [input] using localized [format] metadata and returns an immutable
  /// instance. Mirrors PHP `CarbonImmutable::createFromLocaleFormat()`.
  static CarbonImmutable createFromLocaleFormat(
    String format,
    String locale,
    String input, {
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.createFromLocaleFormat(
    format,
    locale,
    input,
    timeZone: timeZone,
    settings: settings,
  ).toImmutable();

  static bool hasFormat(String? input, String format) =>
      Carbon.hasFormat(input, format);

  static bool hasFormatWithModifiers(String? input, String format) =>
      Carbon.hasFormatWithModifiers(input, format);

  static bool canBeCreatedFromFormat(
    String? input,
    String format, {
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) => Carbon.canBeCreatedFromFormat(
    input,
    format,
    locale: locale,
    timeZone: timeZone,
    settings: settings,
  );

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

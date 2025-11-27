/// Implements the mutable [Carbon] variant and all factory constructors.
///
/// Use this part when importing `package:carbon/carbon.dart`; it wires up
/// parsing, relative strings, timezone helpers, and fluent mutation.
part of '../carbon.dart';

/// Mutable Carbon implementation that mirrors the PHP Carbon API.
///
/// Create instances with [Carbon.now], [Carbon.parse], or one of the convenience
/// factories, then chain fluent helpers:
///
/// ```dart
/// final nextRelease = Carbon.now().addWeeks(2).endOfWeek();
/// ```
///
/// All mutation methods operate in place, so chaining continues to modify the
/// same object. Use [Carbon.toImmutable] when you need an immutable snapshot.
const Object _phpCreateMissing = Object();

class Carbon extends CarbonBase {
  Carbon._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  });

  /// Registers a custom isoFormat token formatter (mirrors PHP `Factory`).
  static void registerIsoFormatToken(
    String token,
    String Function(CarbonInterface) formatter,
  ) => CarbonBase.registerIsoFormatToken(token, formatter);

  /// Removes a previously registered isoFormat formatter.
  static bool unregisterIsoFormatToken(String token) =>
      CarbonBase.unregisterIsoFormatToken(token);

  /// Clears all registered isoFormat overrides.
  static void resetIsoFormatTokens() => CarbonBase.resetIsoFormatTokens();

  /// Sets a global serialization formatter (mirrors PHP's `serializeUsing`).
  static void serializeUsing(String Function(CarbonInterface) exporter) {
    CarbonBase.serializeUsing(exporter);
  }

  /// Weekday constants (align with PHP `Carbon::SUNDAY`, ...).
  static const int sunday = DateTime.sunday;
  static const int monday = DateTime.monday;
  static const int tuesday = DateTime.tuesday;
  static const int wednesday = DateTime.wednesday;
  static const int thursday = DateTime.thursday;
  static const int friday = DateTime.friday;
  static const int saturday = DateTime.saturday;

  /// Numeric helpers for common calendar values.
  static const int yearsPerDecade = 10;
  static const int monthsPerYear = 12;

  /// Resets the custom serialization formatter to the default JSON payload.
  static void resetSerializationFormat() {
    CarbonBase.resetSerializationFormat();
  }

  /// Creates a new instance from the attributes that `var_export`/`jsonSerialize`
  /// produce.
  static CarbonInterface fromState(Map<String, dynamic> state) =>
      CarbonBase.deserializeSerialized(state);

  /// Registers translator data for the specified [locale].
  static void registerTranslatorLocale(
    String locale,
    CarbonLocaleData translation, {
    List<String>? fallbackLocales,
  }) {
    CarbonTranslator.registerLocale(
      locale,
      translation,
      fallbackLocales: fallbackLocales,
    );
  }

  /// Updates the fallback locales that are consulted when a translation is
  /// missing for [locale].
  static void setTranslatorFallbackLocales(
    String locale,
    List<String> fallbackLocales,
  ) {
    CarbonTranslator.setFallbackLocales(locale, fallbackLocales);
  }

  /// Converts [value] using the translator metadata for [locale].
  static String translateNumber(String value, {String? locale}) =>
      CarbonTranslator.translateNumber(value, locale: locale);

  /// Returns the alternate numeric translation for [value].
  static String getAltNumber(String value, {String? locale}) =>
      CarbonTranslator.getAltNumber(value, locale: locale);

  /// Replaces tokens inside [value] using translator-provided snippets.
  static String translateTimeString(String value, {String? locale}) =>
      CarbonTranslator.translateTimeString(value, locale: locale);

  factory Carbon([dynamic input, String? timeZone]) {
    final resolved = _resolveTokenInput(input: input, timeZone: timeZone);
    if (resolved != null) {
      return resolved;
    }
    if (input is CarbonInterface) {
      final clone = input.toMutable();
      if (timeZone != null) {
        clone.tz(timeZone);
      }
      return clone;
    }
    return Carbon.parse(input, timeZone: timeZone);
  }

  /// Mirrors PHP `Carbon::create()` with positional arguments.
  ///
  /// Arguments default to `0000-01-01 00:00:00` unless explicitly `null`, in
  /// which case the current `now()` component is used. When [year] is a string
  /// or [DateTime], the optional [month] parameter doubles as a timezone label
  /// just like PHP's signature.
  static CarbonInterface? createFromDateTime([
    Object? year = _phpCreateMissing,
    Object? month = _phpCreateMissing,
    Object? day = _phpCreateMissing,
    Object? hour = _phpCreateMissing,
    Object? minute = _phpCreateMissing,
    Object? second = _phpCreateMissing,
    Object? timeZone = _phpCreateMissing,
  ]) {
    final explicitZone = _normalizePhpTimezone(timeZone);
    final bool monthLooksLikeZone =
        explicitZone == null && _looksLikeZone(month);
    final derivedZone =
        explicitZone ??
        (monthLooksLikeZone ? _normalizePhpTimezone(month) : null);
    if (!_isPhpMissing(year) &&
        (year is String || year is DateTime || year is CarbonInterface)) {
      return _createFromPhpInput(year as Object, derivedZone);
    }
    final Object? monthArg = monthLooksLikeZone ? _phpCreateMissing : month;
    final context = _resolveCreationBase(timeZone: derivedZone);
    final base = context.localBase;
    var invalid = false;

    int resolveIntUnit(
      Object? value, {
      required int fallback,
      required int nowValue,
      required int min,
      required int max,
      required String label,
    }) {
      final resolved = _coerceNumeric(
        value,
        fallback,
        nowValue,
        label,
      )?.round();
      if (resolved == null) {
        invalid = true;
        return fallback;
      }
      if (resolved < min || resolved > max) {
        if (CarbonBase.strictMode) {
          throw RangeError.range(resolved, min, max, label);
        }
        invalid = true;
      }
      return resolved;
    }

    double resolveSecondDouble(
      Object? value, {
      required int fallback,
      required int nowValue,
    }) {
      final resolved = _coerceNumeric(value, fallback, nowValue, 'second');
      if (resolved == null) {
        invalid = true;
        return fallback.toDouble();
      }
      final double doubleValue = resolved.toDouble();
      final intPart = doubleValue.floor();
      if (intPart < 0 || intPart > 99) {
        if (CarbonBase.strictMode) {
          throw RangeError.range(intPart, 0, 99, 'second');
        }
        invalid = true;
      }
      return doubleValue;
    }

    final yearValue = resolveIntUnit(
      year,
      fallback: 0,
      nowValue: base.year,
      min: -9999,
      max: 9999,
      label: 'year',
    );
    final monthValue = resolveIntUnit(
      monthArg,
      fallback: 1,
      nowValue: base.month,
      min: 0,
      max: 99,
      label: 'month',
    );
    final dayValue = resolveIntUnit(
      day,
      fallback: 1,
      nowValue: base.day,
      min: 0,
      max: 99,
      label: 'day',
    );
    final hourValue = resolveIntUnit(
      hour,
      fallback: 0,
      nowValue: base.hour,
      min: 0,
      max: 99,
      label: 'hour',
    );
    final minuteValue = resolveIntUnit(
      minute,
      fallback: 0,
      nowValue: base.minute,
      min: 0,
      max: 99,
      label: 'minute',
    );
    final secondDouble = resolveSecondDouble(
      second,
      fallback: 0,
      nowValue: base.second,
    );
    final secondValue = secondDouble.floor();
    final microFromSeconds = ((secondDouble - secondValue) * 1000000).round();
    if (invalid) {
      return null;
    }
    final utcDate = CarbonBase._localToUtc(
      year: yearValue,
      month: monthValue,
      day: dayValue,
      hour: hourValue,
      minute: minuteValue,
      second: secondValue,
      microsecond: microFromSeconds,
      timeZone: derivedZone,
    );
    return _fromUtc(utcDate, locale: context.locale, timeZone: derivedZone);
  }

  /// PHP-style helper which returns `null` when the input cannot be parsed.
  /// Mirrors PHP `Carbon::make()` by attempting to convert [input] into a
  /// Carbon instance or returning `null` when the value cannot be parsed.
  static CarbonInterface? make(dynamic input, {String? timeZone}) {
    if (input == null) {
      return null;
    }
    if (input is CarbonInterface) {
      return timeZone == null
          ? input.toMutable()
          : input.tz(timeZone).toMutable();
    }
    if (input is DateTime) {
      final result = Carbon.fromDateTime(input);
      return timeZone == null ? result : result.tz(timeZone);
    }
    if (input is String) {
      final trimmed = input.trim();
      if (trimmed.isEmpty) {
        return null;
      }
      try {
        return Carbon.parse(trimmed, timeZone: timeZone);
      } on FormatException {
        return null;
      }
    }
    return null;
  }

  factory Carbon.now({String? locale, String? timeZone}) {
    final resolvedLocale = locale ?? CarbonBase.defaultLocale;
    final settings = CarbonBase.defaultSettings;
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    if (reference != null) {
      final instance = reference.toMutable();
      instance.copyWith(locale: resolvedLocale, settings: settings);
      return instance;
    }
    final nowUtc = clock.now().toUtc();
    return Carbon._internal(
      dateTime: nowUtc,
      locale: resolvedLocale,
      timeZone: timeZone,
      settings: settings,
    );
  }

  factory Carbon.today({String? locale, String? timeZone}) {
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    final current = reference?.dateTime ?? clock.now().toUtc();
    final resolvedZone = timeZone ?? reference?.timeZoneName;
    final start = CarbonBase._startOfDayUtcForZone(
      current,
      timeZone: resolvedZone,
    );
    return Carbon._internal(
      dateTime: start,
      locale: locale ?? CarbonBase.defaultLocale,
      timeZone: resolvedZone,
      settings: CarbonBase.defaultSettings,
    );
  }

  factory Carbon.tomorrow({String? locale, String? timeZone}) {
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    final current = reference?.dateTime ?? clock.now().toUtc();
    final resolvedZone = timeZone ?? reference?.timeZoneName;
    final start = CarbonBase._startOfDayUtcForZone(
      current,
      timeZone: resolvedZone,
      dayOffset: 1,
    );
    return Carbon._internal(
      dateTime: start,
      locale: locale ?? CarbonBase.defaultLocale,
      timeZone: resolvedZone,
      settings: CarbonBase.defaultSettings,
    );
  }

  factory Carbon.yesterday({String? locale, String? timeZone}) {
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    final current = reference?.dateTime ?? clock.now().toUtc();
    final resolvedZone = timeZone ?? reference?.timeZoneName;
    final start = CarbonBase._startOfDayUtcForZone(
      current,
      timeZone: resolvedZone,
      dayOffset: -1,
    );
    return Carbon._internal(
      dateTime: start,
      locale: locale ?? CarbonBase.defaultLocale,
      timeZone: resolvedZone,
      settings: CarbonBase.defaultSettings,
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

  factory Carbon.parse(
    dynamic input, {
    String? format,
    String? locale,
    String? timeZone,
  }) {
    final special = _resolveTokenInput(
      input: input,
      locale: locale,
      timeZone: timeZone,
    );
    if (special != null) {
      CarbonBase.setLastErrors();
      return special;
    }

    DateTime resolved;
    if (input is int) {
      final isSeconds = input.abs() < 1000000000000;
      final millis = isSeconds ? input * 1000 : input;
      resolved = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
      CarbonBase.setLastErrors();
    } else if (input is DateTime) {
      resolved = input.isUtc ? input : input.toUtc();
      CarbonBase.setLastErrors();
    } else if (input is String) {
      final relative = _parseRelativeString(
        input,
        locale: locale,
        timeZone: timeZone,
      );
      if (relative != null) {
        CarbonBase.setLastErrors();
        return relative;
      }
      final pendingWarning = CarbonBase._calendarWarningForIsoString(input);
      try {
        if (format != null && format.isNotEmpty) {
          final formatter = DateFormat(format, locale);
          resolved = formatter.parseUtc(input);
        } else {
          final parsed = DateTime.parse(input);
          resolved = parsed.isUtc ? parsed : parsed.toUtc();
        }
      } on FormatException catch (error) {
        CarbonBase.setLastErrors(
          CarbonLastErrors(
            errorCount: 1,
            errors: <String, String>{'input': error.message},
          ),
        );
        rethrow;
      }
      CarbonBase.setLastErrors(
        pendingWarning ?? const CarbonLastErrors.empty(),
      );
    } else if (input is CarbonInterface) {
      resolved = input.dateTime;
      CarbonBase.setLastErrors();
    } else {
      CarbonBase.setLastErrors(
        CarbonLastErrors(
          errorCount: 1,
          errors: <String, String>{
            'type': 'Unsupported input ${input.runtimeType}',
          },
        ),
      );
      throw ArgumentError(
        'Unsupported input for Carbon.parse: ${input.runtimeType}',
      );
    }
    final instance = Carbon._internal(dateTime: resolved, locale: locale);
    if (timeZone != null) {
      return instance.tz(timeZone).toMutable();
    }
    return instance;
  }

  static Carbon? _resolveTokenInput({
    required dynamic input,
    String? locale,
    String? timeZone,
  }) {
    bool matchesToken(dynamic candidate) {
      if (candidate == null) {
        return true;
      }
      if (candidate is String) {
        final trimmed = candidate.trim();
        if (trimmed.isEmpty) {
          return true;
        }
        return trimmed.toLowerCase() == 'now';
      }
      return false;
    }

    if (!matchesToken(input)) {
      return null;
    }
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    if (reference != null) {
      final result = reference.toMutable();
      if (locale != null && result.localeCode != locale) {
        result.copyWith(locale: locale);
      }
      if (timeZone != null && result.timeZoneName != timeZone) {
        result.tz(timeZone);
      }
      return result;
    }
    return Carbon.now(locale: locale, timeZone: timeZone);
  }

  static Carbon? _parseRelativeString(
    String raw, {
    String? locale,
    String? timeZone,
    CarbonInterface? base,
  }) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return null;
    }
    final absolute = _parseAbsoluteCalendarString(normalized, locale: locale);
    if (absolute != null) {
      if (timeZone != null && absolute.timeZoneName != timeZone) {
        return absolute.tz(timeZone).toMutable();
      }
      return absolute;
    }
    final Carbon workingBase;
    if (base != null) {
      workingBase = base.toImmutable().toMutable();
    } else {
      workingBase = Carbon.now(locale: locale, timeZone: timeZone);
    }
    try {
      var candidate = workingBase.relative(normalized).toMutable();
      if (_requiresStartOfDayKeyword(normalized)) {
        candidate = candidate.startOfDay().toMutable();
      }
      if (timeZone != null && candidate.timeZoneName != timeZone) {
        candidate = candidate.tz(timeZone).toMutable();
      }
      if (locale != null && candidate.localeCode != locale) {
        candidate = candidate.copyWith(locale: locale) as Carbon;
      }
      return candidate;
    } catch (_) {
      return null;
    }
  }

  static Carbon? _parseAbsoluteCalendarString(
    String normalized, {
    String? locale,
  }) {
    final sanitized = normalized
        .replaceAll('-', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final firstLastRegex = RegExp(
      r'^(first|last) day of ([a-z]+) (\d{4})$',
      caseSensitive: false,
    );
    final firstLast = firstLastRegex.firstMatch(sanitized);
    if (firstLast != null) {
      final monthIndex = CarbonBase._monthIndex(firstLast.group(2)!);
      if (monthIndex != null) {
        final year = int.parse(firstLast.group(3)!);
        final date = firstLast.group(1)!.toLowerCase() == 'first'
            ? DateTime.utc(year, monthIndex, 1)
            : DateTime.utc(
                year,
                monthIndex + 1,
                1,
              ).subtract(const Duration(days: 1));
        return Carbon._internal(dateTime: date, locale: locale);
      }
    }
    final lastWeekdayPattern = RegExp(
      r'^last (sunday|monday|tuesday|wednesday|thursday|friday|saturday) of ([a-z]+) (\d{4})$',
      caseSensitive: false,
    ).firstMatch(sanitized);
    if (lastWeekdayPattern != null) {
      final monthIndex = CarbonBase._monthIndex(lastWeekdayPattern.group(2)!);
      if (monthIndex != null) {
        final year = int.parse(lastWeekdayPattern.group(3)!);
        var candidate = DateTime.utc(
          year,
          monthIndex + 1,
          1,
        ).subtract(const Duration(days: 1));
        final weekday = CarbonBase._weekdayIndex(lastWeekdayPattern.group(1)!);
        while (candidate.weekday % 7 != weekday) {
          candidate = candidate.subtract(const Duration(days: 1));
        }
        return Carbon._internal(dateTime: candidate, locale: locale);
      }
    }
    final weekdayMonthYear = RegExp(
      r'^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)\s+([a-z]+)\s+(\d{4})$',
      caseSensitive: false,
    ).firstMatch(sanitized);
    if (weekdayMonthYear != null) {
      final monthIndex = CarbonBase._monthIndex(weekdayMonthYear.group(2)!);
      if (monthIndex != null) {
        final year = int.parse(weekdayMonthYear.group(3)!);
        var candidate = DateTime.utc(year, monthIndex, 1);
        final weekday = CarbonBase._weekdayIndex(weekdayMonthYear.group(1)!);
        while (candidate.weekday % 7 != weekday) {
          candidate = candidate.add(const Duration(days: 1));
        }
        return Carbon._internal(dateTime: candidate, locale: locale);
      }
    }
    final monthYear = RegExp(
      r'^([a-z]+)\s+(\d{4})$',
      caseSensitive: false,
    ).firstMatch(sanitized);
    if (monthYear != null) {
      final monthIndex = CarbonBase._monthIndex(monthYear.group(1)!);
      if (monthIndex != null) {
        final year = int.parse(monthYear.group(2)!);
        final date = DateTime.utc(year, monthIndex, 1);
        return Carbon._internal(dateTime: date, locale: locale);
      }
    }
    final explicitDate = RegExp(
      r'^(\d{1,2})\s+([a-z]+)\s+(\d{4})$',
      caseSensitive: false,
    ).firstMatch(sanitized);
    if (explicitDate != null) {
      final monthIndex = CarbonBase._monthIndex(explicitDate.group(2)!);
      if (monthIndex != null) {
        final day = int.parse(explicitDate.group(1)!);
        final year = int.parse(explicitDate.group(3)!);
        final date = DateTime.utc(year, monthIndex, day);
        return Carbon._internal(dateTime: date, locale: locale);
      }
    }
    final monthDayYear = RegExp(
      r'^([a-z]+)\s+(\d{1,2})\s+(\d{4})$',
      caseSensitive: false,
    ).firstMatch(sanitized);
    if (monthDayYear != null) {
      final monthIndex = CarbonBase._monthIndex(monthDayYear.group(1)!);
      if (monthIndex != null) {
        final day = int.parse(monthDayYear.group(2)!);
        final year = int.parse(monthDayYear.group(3)!);
        final date = DateTime.utc(year, monthIndex, day);
        return Carbon._internal(dateTime: date, locale: locale);
      }
    }
    return null;
  }

  static bool _requiresStartOfDayKeyword(String expression) {
    final normalized = expression.trim().toLowerCase();
    if (normalized == 'today' ||
        normalized == 'tomorrow' ||
        normalized == 'yesterday' ||
        normalized == 'after tomorrow' ||
        normalized == 'before yesterday') {
      return true;
    }
    if (normalized.startsWith('last day')) {
      return false;
    }
    const prefixes = ['next ', 'last ', 'previous ', 'this '];
    for (final prefix in prefixes) {
      if (normalized.startsWith(prefix)) {
        final remainder = normalized.substring(prefix.length).trim();
        if (CarbonBase._parseTimeToken(remainder) != null) {
          return false;
        }
        return true;
      }
    }
    return false;
  }

  /// Returns whether [input] contains PHP-style relative keywords such as
  /// "tomorrow" or "next week".
  static bool hasRelativeKeywords(String? input) =>
      CarbonBase.hasRelativeKeywords(input);

  /// Returns whether the ISO-style [pattern] contains any formatting tokens.
  ///
  /// Use this to decide if `createFromIsoFormat` should attempt parsing a
  /// string or treat it as a literal.
  static bool hasIsoRelativeKeywords(String? pattern, {String? locale}) =>
      CarbonBase.hasIsoRelativeKeywords(pattern, locale: locale);

  static void registerMacro(String name, CarbonMacro macro) =>
      CarbonBase.registerMacro(name, macro);

  static void unregisterMacro(String name) => CarbonBase.unregisterMacro(name);

  static bool hasMacro(String name) => CarbonBase.hasMacro(name);

  static void resetMacros() => CarbonBase.resetMacros();

  static Future<void> configureTimeMachine({
    tm.DateTimeZoneProvider? provider,
    bool testing = true,
  }) => CarbonBase.configureTimeMachine(provider: provider, testing: testing);

  static void resetTimeMachineSupport() => CarbonBase.resetTimeMachine();

  static void useStrictMode(bool enabled) => CarbonBase.useStrictMode(enabled);

  static bool isStrictModeEnabled() => CarbonBase.strictMode;

  static void setToStringFormat(dynamic formatter) =>
      CarbonBase.setToStringFormat(formatter);

  static void resetToStringFormat() => CarbonBase.resetToStringFormat();

  static void setLocale(String locale) => CarbonBase.setDefaultLocale(locale);

  static String getLocale() => CarbonBase.defaultLocale;

  static void setWeekStartsAt(int day) => CarbonBase.setWeekStartsAt(day);

  static int getWeekStartsAt() => CarbonBase.defaultSettings.startOfWeek;

  static void setWeekendDays(List<int> days) => CarbonBase.setWeekendDays(days);

  static List<int> getWeekendDays() => CarbonBase.weekendDays;

  static void resetWeekendDays() => CarbonBase.resetWeekendDays();

  static void setTestNow([dynamic value]) => CarbonBase.setTestNow(value);

  static void setTestNowAndTimezone(dynamic value, {String? timeZone}) =>
      CarbonBase.setTestNowAndTimezone(value, timeZone: timeZone);

  static CarbonInterface? getTestNow() => CarbonBase.testNow;

  static bool hasTestNow() => CarbonBase.hasTestNow();

  static T withTestNow<T>(dynamic value, T Function() callback) =>
      CarbonBase.withTestNow(value, callback);

  /// Returns the most recent parsing/creation report, if any.
  static CarbonLastErrors? lastErrorsSnapshot() =>
      CarbonBase.lastErrorsSnapshot();

  /// Overrides the stored parsing/creation report (mainly for tests).
  static void setLastErrors([CarbonLastErrors? errors]) =>
      CarbonBase.setLastErrors(errors);

  /// Clears the stored parsing/creation report so the next call returns null.
  static void resetLastErrors() => CarbonBase.resetLastErrors();

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

  /// Restores an instance created via [CarbonInterface.serialize].
  ///
  /// ```dart
  /// final saved = original.serialize();
  /// final roundTrip = Carbon.fromSerialized(saved);
  /// ```
  static CarbonInterface fromSerialized(dynamic payload) =>
      CarbonBase.deserializeSerialized(payload);

  static ({DateTime localBase, String? zoneName, String? locale})
  _resolveCreationBase({String? timeZone, String? locale}) {
    final reference = CarbonBase._resolveTestNow(timeZone: timeZone);
    final resolvedZone = timeZone ?? reference?.timeZoneName;
    final resolvedLocale = locale ?? reference?.localeCode;
    final baseUtc = reference?.dateTime ?? clock.now().toUtc();
    final localBase = resolvedZone == null
        ? baseUtc
        : CarbonBase._utcToLocal(baseUtc, resolvedZone);
    return (
      localBase: localBase,
      zoneName: resolvedZone,
      locale: resolvedLocale,
    );
  }

  static DateTime _contextBaseToUtc(
    ({DateTime localBase, String? zoneName, String? locale}) context, {
    bool resetClock = false,
  }) {
    var local = context.localBase;
    if (resetClock) {
      local = DateTime(local.year, local.month, local.day);
    }
    final micro = local.microsecond + local.millisecond * 1000;
    if (context.zoneName == null) {
      return local.isUtc
          ? local
          : DateTime.utc(
              local.year,
              local.month,
              local.day,
              local.hour,
              local.minute,
              local.second,
              micro ~/ 1000,
              micro % 1000,
            );
    }
    return CarbonBase._localToUtc(
      year: local.year,
      month: local.month,
      day: local.day,
      hour: local.hour,
      minute: local.minute,
      second: local.second,
      microsecond: micro,
      timeZone: context.zoneName,
    );
  }

  static const Map<String, String> _phpTokenToIso = <String, String>{
    'Y': 'YYYY',
    'y': 'YY',
    'm': 'MM',
    'n': 'M',
    'F': 'MMMM',
    'M': 'MMM',
    'd': 'DD',
    'j': 'D',
    'D': 'ddd',
    'l': 'dddd',
    'H': 'HH',
    'G': 'H',
    'h': 'hh',
    'g': 'h',
    'i': 'mm',
    's': 'ss',
    'u': 'SSSSSS',
    'v': 'SSS',
    'A': 'A',
    'a': 'a',
    'e': 'zz',
    'O': 'ZZ',
    'P': 'P',
    'W': 'WW',
    'o': 'GGGG',
    'N': 'N',
    'w': 'w',
    'z': 'z',
    't': 't',
    'L': 'L',
    'U': 'X',
    'c': 'YYYY-MM-DD[T]HH:mm:ssZ',
    'r': 'ddd, DD MMM YYYY HH:mm:ss ZZ',
  };

  static const Map<String, String> _phpFormatRegex = <String, String>{
    'd': r'(3[01]|[12][0-9]|0[1-9])',
    'D': r'(Sun|Mon|Tue|Wed|Thu|Fri|Sat)',
    'j': r'([123][0-9]|[1-9])',
    'l': r'([a-zA-Z]{2,})',
    'N': r'([1-7])',
    'S': r'(st|nd|rd|th)',
    'w': r'([0-6])',
    'z': r'(36[0-5]|3[0-5][0-9]|[12][0-9]{2}|[1-9]?[0-9])',
    'W': r'(5[012]|[1-4][0-9]|0?[1-9])',
    'F': r'([a-zA-Z]{2,})',
    'm': r'(1[012]|0[1-9])',
    'M': r'([a-zA-Z]{3})',
    'n': r'(1[012]|[1-9])',
    't': r'(2[89]|3[01])',
    'L': r'(0|1)',
    'o': r'([1-9][0-9]{0,4})',
    'Y': r'([1-9]?[0-9]{4})',
    'y': r'([0-9]{2})',
    'a': r'(am|pm)',
    'A': r'(AM|PM)',
    'B': r'([0-9]{3})',
    'g': r'(1[012]|[1-9])',
    'G': r'(2[0-3]|1?[0-9])',
    'h': r'(1[012]|0[1-9])',
    'H': r'(2[0-3]|[01][0-9])',
    'i': r'([0-5][0-9])',
    's': r'([0-5][0-9])',
    'u': r'([0-9]{1,6})',
    'v': r'([0-9]{1,3})',
    'e': r'([a-zA-Z]{1,5})|([a-zA-Z]*\/[a-zA-Z]*)',
    'I': r'(0|1)',
    'O': r'([+-](1[0123]|0[0-9])[0134][05])',
    'P': r'([+-](1[0123]|0[0-9]):[0134][05])',
    'p': r'(Z|[+-](1[0123]|0[0-9]):[0134][05])',
    'T': r'([a-zA-Z]{1,5})',
    'Z': r'(-?[1-5]?[0-9]{1,4})',
    'U': r'([0-9]*)',
    'c':
        r'(([1-9]?[0-9]{4})-(1[012]|0[1-9])-(3[01]|[12][0-9]|0[1-9])T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])[+-](1[012]|0[0-9]):([0134][05]))',
    'r':
        r'(([a-zA-Z]{3}), ([123][0-9]|0[1-9]) ([a-zA-Z]{3}) ([1-9]?[0-9]{4}) (2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9]) [+-](1[012]|0[0-9])([0134][05]))',
  };

  static const Map<String, String> _phpFormatRegexModifiers = <String, String>{
    '*': r'.+',
    ' ': r'[ \t]',
    '#': r'[;:\/.,()-]',
    '?': r'([^a]|[a])',
    '!': '',
    '|': '',
    '+': '',
  };

  static final Map<String, String> _phpFormatRegexWithModifiers =
      Map<String, String>.unmodifiable(
        Map<String, String>.of(_phpFormatRegex)
          ..addAll(_phpFormatRegexModifiers),
      );

  static final RegExp _clockGlyphPattern = RegExp(r'[HhGgmsSavuaA]');

  static _PhpFormatTranslation _translatePhpFormat(String format) {
    final buffer = StringBuffer();
    var escape = false;
    var resetClock = false;
    var capturesFraction = false;
    var containsClockToken = false;
    for (var i = 0; i < format.length; i++) {
      final char = format[i];
      if (escape) {
        buffer
          ..write('[')
          ..write(char)
          ..write(']');
        escape = false;
        continue;
      }
      if (char == '\\') {
        escape = true;
        continue;
      }
      if (char == '|') {
        resetClock = true;
        continue;
      }
      if (char == '!') {
        buffer.write('!');
        continue;
      }
      final replacement = _phpTokenToIso[char];
      if (replacement != null) {
        if (char == 'u' || char == 'v') {
          capturesFraction = true;
        }
        if ('HhGgisauvA'.contains(char) ||
            _clockGlyphPattern.hasMatch(replacement)) {
          containsClockToken = true;
        }
        buffer.write(replacement);
        continue;
      }
      if (_isAsciiLetter(char)) {
        buffer
          ..write('[')
          ..write(char)
          ..write(']');
      } else {
        buffer.write(char);
      }
    }
    if (escape) {
      buffer.write('[\\]');
    }
    if (!containsClockToken) {
      resetClock = true;
    }
    return _PhpFormatTranslation(
      buffer.toString(),
      resetClock: resetClock,
      capturesFraction: capturesFraction,
      hasTimeTokens: containsClockToken,
    );
  }

  static CarbonInterface createFromDate([
    int? year,
    int? month,
    int? day,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) {
    final context = _resolveCreationBase(timeZone: timeZone, locale: locale);
    final base = context.localBase;
    final zone = context.zoneName;
    final resolvedLocale = context.locale;
    final resolvedYear = year ?? base.year;
    final resolvedMonth = month ?? base.month;
    final resolvedDay = day ?? base.day;
    final utcDate = CarbonBase._localToUtc(
      year: resolvedYear,
      month: resolvedMonth,
      day: resolvedDay,
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      timeZone: zone,
    );
    return _fromUtc(
      utcDate,
      locale: resolvedLocale,
      timeZone: zone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTime([
    int? hour,
    int? minute,
    int? second,
    int microsecond = 0,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) {
    final context = _resolveCreationBase(timeZone: timeZone, locale: locale);
    final base = context.localBase;
    final zone = context.zoneName;
    final resolvedLocale = context.locale;
    void validateRange(int value, int max, String label) {
      if (value < 0 || value > max) {
        throw RangeError.range(value, 0, max, label);
      }
    }

    final resolvedHour = hour ?? base.hour;
    final resolvedMinute = minute ?? base.minute;
    final resolvedSecond = second ?? base.second;
    validateRange(resolvedHour, 23, 'hour');
    validateRange(resolvedMinute, 59, 'minute');
    validateRange(resolvedSecond, 59, 'second');
    validateRange(microsecond, 999999, 'microsecond');
    final utcDate = CarbonBase._localToUtc(
      year: base.year,
      month: base.month,
      day: base.day,
      hour: resolvedHour,
      minute: resolvedMinute,
      second: resolvedSecond,
      microsecond: microsecond,
      timeZone: zone,
    );
    return _fromUtc(
      utcDate,
      locale: resolvedLocale,
      timeZone: zone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTimeString(
    String time, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    final context = _resolveCreationBase(timeZone: timeZone, locale: locale);
    final base = context.localBase;
    final zone = context.zoneName;
    final resolvedLocale = context.locale;
    final match = RegExp(
      r'^(\d{1,2})(?::(\d{1,2}))?(?::(\d{1,2}))?(?:\.(\d{1,6}))?$',
    ).firstMatch(time.trim());
    if (match == null) {
      throw FormatException('Invalid time string: $time');
    }
    int parsePart(String? value, int max) {
      if (value == null) return 0;
      final parsed = int.parse(value);
      if (parsed < 0 || parsed > max) {
        throw RangeError.range(parsed, 0, max, 'time part');
      }
      return parsed;
    }

    final hours = parsePart(match.group(1), 23);
    final minutes = parsePart(match.group(2), 59);
    final seconds = parsePart(match.group(3), 59);
    final micro = (() {
      final raw = match.group(4);
      if (raw == null) return 0;
      return int.parse(raw.padRight(6, '0'));
    })();
    final utcDate = CarbonBase._localToUtc(
      year: base.year,
      month: base.month,
      day: base.day,
      hour: hours,
      minute: minutes,
      second: seconds,
      microsecond: micro,
      timeZone: zone,
    );
    return _fromUtc(
      utcDate,
      locale: resolvedLocale,
      timeZone: zone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTimestamp(
    num timestamp, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    CarbonBase._requireZoneAvailability(timeZone);
    return _fromEpochMicro(
      (timestamp * Duration.microsecondsPerSecond).round(),
      locale: locale,
      timeZone: timeZone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTimestampUTC(
    num timestamp, {
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => createFromTimestamp(
    timestamp,
    timeZone: 'UTC',
    locale: locale,
    settings: settings,
  );

  static CarbonInterface createFromTimestampMs(
    num timestamp, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    CarbonBase._requireZoneAvailability(timeZone);
    return _fromEpochMicro(
      (timestamp * 1000).round(),
      locale: locale,
      timeZone: timeZone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTimestampMsUTC(
    num timestamp, {
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) => createFromTimestampMs(
    timestamp,
    timeZone: 'UTC',
    locale: locale,
    settings: settings,
  );

  /// Casts [source] to a mutable `Carbon`, mirroring `Carbon::cast()` in PHP.
  static CarbonInterface cast(CarbonInterface source) => source.toMutable();

  static CarbonInterface createFromFormat(
    String format,
    String input, {
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    final translation = _translatePhpFormat(format);
    final context = _resolveCreationBase(timeZone: timeZone, locale: locale);
    final baseUtc = _contextBaseToUtc(
      context,
      resetClock: translation.resetClock,
    );
    final parsed = createFromIsoFormat(
      translation.pattern,
      input,
      locale: locale,
      timeZone: timeZone,
      base: baseUtc,
      defaultTimeZone: context.zoneName,
    );
    final CarbonInterface normalized = translation.capturesFraction
        ? parsed
        : parsed.copyWith(
            dateTime: parsed.dateTime.subtract(
              Duration(
                microseconds:
                    parsed.dateTime.microsecond +
                    parsed.dateTime.millisecond * 1000,
              ),
            ),
          );
    final CarbonInterface adjusted = translation.hasTimeTokens
        ? normalized
        : _coerceToStartOfDay(normalized);
    return adjusted.copyWith(settings: settings);
  }

  static CarbonInterface _fromUtc(
    DateTime value, {
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) => Carbon._internal(
    dateTime: value.toUtc(),
    locale: locale ?? CarbonBase.defaultLocale,
    timeZone: timeZone,
    settings: settings ?? CarbonBase.defaultSettings,
  );

  static CarbonInterface _fromEpochMicro(
    int microseconds, {
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) {
    CarbonBase._requireZoneAvailability(timeZone);
    return _fromUtc(
      DateTime.fromMicrosecondsSinceEpoch(microseconds, isUtc: true),
      locale: locale,
      timeZone: timeZone,
      settings: settings,
    );
  }

  static CarbonInterface? createSafe([
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
  ]) {
    late int invalidHour;
    try {
      final resolved = _buildSafeDate(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        microsecond: microsecond,
      );
      invalidHour = resolved.hour;
      final totalMicro = _microsecondsOf(resolved);
      final utcDate = CarbonBase._localToUtc(
        year: resolved.year,
        month: resolved.month,
        day: resolved.day,
        hour: resolved.hour,
        minute: resolved.minute,
        second: resolved.second,
        microsecond: totalMicro,
        timeZone: timeZone,
      );
      return _fromUtc(
        utcDate,
        locale: locale,
        timeZone: timeZone,
        settings: settings,
      );
    } on CarbonInvalidDateException {
      if (CarbonBase.strictMode) rethrow;
      return null;
    } on StateError catch (error) {
      if (_isInvalidLocalTimeError(error)) {
        final exception = CarbonInvalidDateException('hour', invalidHour);
        if (CarbonBase.strictMode) {
          throw exception;
        }
        return null;
      }
      rethrow;
    }
  }

  static CarbonInterface createStrict([
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
  ]) {
    final previous = CarbonBase.strictMode;
    CarbonBase.useStrictMode(true);
    try {
      final result = createSafe(
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
      );
      if (result == null) {
        throw StateError('createStrict should not return null');
      }
      return result;
    } finally {
      CarbonBase.useStrictMode(previous);
    }
  }

  /// Parses [input] using a Moment/Carbon-style [format] string.
  ///
  /// The parser honors literal brackets, preset tokens such as `LL`, and the
  /// same semantics as PHP `createFromIsoFormat()`.
  ///
  /// ```dart
  /// final date = Carbon.createFromIsoFormat(
  ///   'MMMM D, YYYY h:mm A',
  ///   'April 4, 2019 2:45 PM',
  /// );
  /// print(date.toIso8601String());
  /// ```
  static CarbonInterface createFromIsoFormat(
    String format,
    String input, {
    String? locale,
    String? timeZone,
    DateTime? base,
    String? defaultTimeZone,
  }) {
    final parser = _IsoInputParser(
      format: format,
      locale: locale ?? CarbonBase.defaultLocale,
      base: base,
    );
    final components = parser.parse(input);
    final resolvedZone = timeZone ?? components.timeZone ?? defaultTimeZone;
    final utc = components.toUtc(resolvedZone);
    return Carbon._internal(
      dateTime: utc,
      locale: locale ?? CarbonBase.defaultLocale,
      timeZone: resolvedZone,
      settings: CarbonBase.defaultSettings,
    );
  }

  /// Parses localized [input] by translating month/day names from [locale]
  /// before delegating to [createFromIsoFormat].
  ///
  /// This mirrors PHP `createFromLocaleIsoFormat()` and allows strings such
  /// as `2019 四月 4 12,04,21` to be parsed when the locale is `zh_TW`.
  static CarbonInterface createFromLocaleIsoFormat(
    String format,
    String locale,
    String input, {
    String? timeZone,
    DateTime? base,
    String? defaultTimeZone,
  }) => createFromIsoFormat(
    format,
    input,
    locale: locale,
    timeZone: timeZone,
    base: base,
    defaultTimeZone: defaultTimeZone,
  );

  /// Parses [input] expressed in [locale], translating localized phrases to
  /// English before delegating to [Carbon.parse].
  static CarbonInterface parseFromLocale(
    String input, [
    String? locale,
    String? timeZone,
  ]) {
    final resolvedLocale = locale ?? CarbonBase.defaultLocale;
    final translated = _translateLocaleTimeString(input, resolvedLocale);
    final custom = _tryParseTranslatedLocaleString(
      translated,
      locale: resolvedLocale,
      timeZone: timeZone,
    );
    if (custom != null) {
      return custom;
    }
    CarbonInterface parsed = Carbon.parse(translated, locale: resolvedLocale);
    if (timeZone != null && timeZone.isNotEmpty) {
      parsed = _assignLocalTimezone(parsed, timeZone);
    }
    return parsed;
  }

  /// PHP-style helper that parses formatted [input] with localized tokens.
  static CarbonInterface createFromLocaleFormat(
    String format,
    String locale,
    String input, {
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    final translation = _translatePhpFormat(format);
    final context = _resolveCreationBase(timeZone: timeZone, locale: locale);
    final baseUtc = _contextBaseToUtc(
      context,
      resetClock: translation.resetClock,
    );
    var isoPattern = translation.pattern;
    if (_localeShortMonthUsesDigits(locale)) {
      isoPattern = isoPattern.replaceAll('MMM', 'MMMM');
    }
    final parsed = createFromLocaleIsoFormat(
      isoPattern,
      locale,
      input,
      timeZone: timeZone,
      base: baseUtc,
      defaultTimeZone: context.zoneName,
    );
    final CarbonInterface normalized = translation.capturesFraction
        ? parsed
        : parsed.copyWith(
            dateTime: parsed.dateTime.subtract(
              Duration(
                microseconds:
                    parsed.dateTime.microsecond +
                    parsed.dateTime.millisecond * 1000,
              ),
            ),
          );
    final CarbonInterface adjusted = translation.hasTimeTokens
        ? normalized
        : _coerceToStartOfDay(normalized);
    return adjusted.copyWith(settings: settings);
  }

  /// Checks whether [input] matches [format] exactly.
  static bool hasFormat(String? input, String format) {
    if (input == null || input.isEmpty || format.isEmpty) {
      return false;
    }
    return _matchFormatPattern(input, format, _phpFormatRegex);
  }

  /// Checks whether [input] matches [format] with PHP modifiers enabled.
  static bool hasFormatWithModifiers(String? input, String format) {
    if (input == null || input.isEmpty || format.isEmpty) {
      return false;
    }
    return _matchFormatPattern(input, format, _phpFormatRegexWithModifiers);
  }

  /// Returns true when [input] can be parsed using the PHP [format].
  static bool canBeCreatedFromFormat(
    String? input,
    String format, {
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    if (input == null || format.isEmpty) {
      return false;
    }
    try {
      createFromFormat(
        format,
        input,
        locale: locale,
        timeZone: timeZone,
        settings: settings,
      );
    } on FormatException {
      return false;
    } on CarbonMessageException {
      return false;
    } on ArgumentError {
      return false;
    }
    return hasFormatWithModifiers(input, format);
  }

  static bool _isPhpMissing(Object? value) =>
      identical(value, _phpCreateMissing);

  static String? _normalizePhpTimezone(Object? input) {
    if (_isPhpMissing(input) || input == null) {
      return null;
    }
    if (input is String) {
      final trimmed = input.trim();
      return trimmed.isEmpty ? null : trimmed;
    }
    if (input is CarbonInterface) {
      return input.timeZoneName;
    }
    return null;
  }

  static bool _matchFormatPattern(
    String input,
    String format,
    Map<String, String> replacements,
  ) {
    final buffer = StringBuffer('^');
    var escaping = false;
    for (var i = 0; i < format.length; i++) {
      final char = format[i];
      if (escaping) {
        buffer.write(RegExp.escape(char));
        escaping = false;
        continue;
      }
      if (char == '\\') {
        escaping = true;
        continue;
      }
      final replacement = replacements[char];
      if (replacement != null) {
        if (replacement.isEmpty) {
          continue;
        }
        buffer.write('(?:$replacement)');
        continue;
      }
      buffer.write(RegExp.escape(char));
    }
    buffer.write(r'$');
    try {
      return RegExp(buffer.toString()).hasMatch(input);
    } on FormatException {
      return false;
    }
  }

  static bool _looksLikeZone(Object? candidate) {
    if (candidate is String) {
      return int.tryParse(candidate.trim()) == null;
    }
    return false;
  }

  static num? _coerceNumeric(
    Object? value,
    int fallback,
    int nowValue,
    String label,
  ) {
    if (_isPhpMissing(value)) {
      return fallback;
    }
    if (value == null) {
      return nowValue;
    }
    if (value is num) {
      return value;
    }
    if (value is String) {
      return num.tryParse(value.trim());
    }
    throw ArgumentError('Unsupported $label value: $value');
  }

  static String _translateLocaleTimeString(String input, String locale) {
    var result = input.toLowerCase();
    for (final candidate in CarbonBase._localeCandidates(locale)) {
      final rules = _localeTranslationRules[candidate];
      if (rules == null) {
        continue;
      }
      for (final rule in rules) {
        result = result.replaceAllMapped(rule.pattern, rule.replacement);
      }
    }
    return result;
  }

  static CarbonInterface? _tryParseTranslatedLocaleString(
    String translated, {
    String? locale,
    String? timeZone,
  }) {
    final trimmed = translated.trim();
    final timeMatch = _localeRelativeTimePattern.firstMatch(trimmed);
    if (timeMatch != null) {
      final base = _relativeKeywordBase(
        timeMatch.group(1)!,
        locale: locale,
        timeZone: timeZone,
      );
      final token = CarbonBase._parseTimeToken(timeMatch.group(2)!);
      if (token == null) {
        return null;
      }
      return _applyTimeOfDay(base, token);
    }
    if (_localeRelativeKeywords.contains(trimmed)) {
      return _relativeKeywordBase(trimmed, locale: locale, timeZone: timeZone);
    }
    final weekdayMatch = _localeWeekdayPattern.firstMatch(trimmed);
    if (weekdayMatch != null) {
      final now = Carbon.today(locale: locale, timeZone: timeZone);
      final current = now.dateTime.weekday % 7;
      final target = CarbonBase._weekdayIndex(weekdayMatch.group(1)!);
      final delta = (target - current + 7) % 7;
      return now.addDays(delta);
    }
    return null;
  }

  static CarbonInterface _relativeKeywordBase(
    String keyword, {
    String? locale,
    String? timeZone,
  }) {
    switch (keyword) {
      case 'today':
        return Carbon.today(locale: locale, timeZone: timeZone);
      case 'tomorrow':
        return Carbon.tomorrow(locale: locale, timeZone: timeZone);
      case 'yesterday':
        return Carbon.yesterday(locale: locale, timeZone: timeZone);
      case 'after tomorrow':
        return Carbon.tomorrow(locale: locale, timeZone: timeZone).addDays(1);
      case 'before yesterday':
        return Carbon.yesterday(locale: locale, timeZone: timeZone).subDays(1);
    }
    return Carbon.today(locale: locale, timeZone: timeZone);
  }

  static CarbonInterface _applyTimeOfDay(
    CarbonInterface base,
    _ParsedTimeOfDay token,
  ) => base
      .startOfDay()
      .setHour(token.hour)
      .setMinute(token.minute)
      .setSecond(token.second)
      .setMicrosecond(token.microsecond);

  static CarbonInterface _assignLocalTimezone(
    CarbonInterface value,
    String timeZone,
  ) {
    final utc = CarbonBase._localToUtc(
      year: value.year,
      month: value.month,
      day: value.day,
      hour: value.hour,
      minute: value.minute,
      second: value.second,
      microsecond:
          value.microsecond +
          value.millisecond * Duration.microsecondsPerMillisecond,
      timeZone: timeZone,
    );
    return _fromUtc(
      utc,
      locale: value.localeCode,
      timeZone: timeZone,
      settings: value.settings,
    );
  }

  static CarbonInterface _coerceToStartOfDay(CarbonInterface value) {
    final start = CarbonBase._startOfDayUtcForZone(
      value.dateTime,
      timeZone: value.timeZoneName,
    );
    return value.copyWith(dateTime: start);
  }

  static CarbonInterface _createFromPhpInput(Object input, String? timeZone) {
    if (input is String) {
      return Carbon.parse(input, timeZone: timeZone);
    }
    if (input is DateTime) {
      final result = Carbon.fromDateTime(input);
      return timeZone == null ? result : result.tz(timeZone);
    }
    final source = input as CarbonInterface;
    return timeZone == null
        ? source.toMutable()
        : source.tz(timeZone).toMutable();
  }

  static DateTime _buildSafeDate({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int microsecond = 0,
  }) {
    final now = clock.now().toUtc();
    final resolvedYear = year ?? now.year;
    final resolvedMonth = month ?? now.month;
    final resolvedDay = day ?? now.day;
    final resolvedHour = hour ?? now.hour;
    final resolvedMinute = minute ?? now.minute;
    final resolvedSecond = second ?? now.second;
    _assertRange('year', resolvedYear, 1, 9999);
    _assertRange('month', resolvedMonth, 1, 12);
    final daysInMonth = DateTime.utc(resolvedYear, resolvedMonth + 1, 0).day;
    _assertRange('day', resolvedDay, 1, daysInMonth);
    _assertRange('hour', resolvedHour, 0, 23);
    _assertRange('minute', resolvedMinute, 0, 59);
    _assertRange('second', resolvedSecond, 0, 59);
    _assertRange('microsecond', microsecond, 0, 999999);
    return DateTime.utc(
      resolvedYear,
      resolvedMonth,
      resolvedDay,
      resolvedHour,
      resolvedMinute,
      resolvedSecond,
      microsecond ~/ 1000,
      microsecond % 1000,
    );
  }

  static void _assertRange(String field, num value, num min, num max) {
    if (value < min || value > max) {
      throw CarbonInvalidDateException(field, value);
    }
  }

  static bool _isInvalidLocalTimeError(StateError error) =>
      error.message.contains('not valid in timezone');

  static int _microsecondsOf(DateTime value) =>
      value.millisecond * 1000 + value.microsecond;
}

class _PhpFormatTranslation {
  const _PhpFormatTranslation(
    this.pattern, {
    this.resetClock = false,
    this.capturesFraction = false,
    this.hasTimeTokens = true,
  });

  final String pattern;
  final bool resetClock;
  final bool capturesFraction;
  final bool hasTimeTokens;
}

bool _isAsciiLetter(String value) {
  if (value.isEmpty) {
    return false;
  }
  final code = value.codeUnitAt(0);
  return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
}

class _LocaleTranslationRule {
  const _LocaleTranslationRule(this.pattern, this.replacement);

  final RegExp pattern;
  final String Function(Match match) replacement;
}

String Function(Match match) _literalLocaleReplacement(String value) =>
    (_) => value;

final RegExp _localeRelativeTimePattern = RegExp(
  r'^(today|tomorrow|yesterday|after tomorrow|before yesterday)\s+(?:at\s+)?(\d{1,2}:\d{2}(?::\d{2})?)$',
);

final RegExp _localeWeekdayPattern = RegExp(
  r'^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)$',
);

const Set<String> _localeRelativeKeywords = <String>{
  'today',
  'tomorrow',
  'yesterday',
  'after tomorrow',
  'before yesterday',
};

final List<_LocaleTranslationRule> _frLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r"après[- ]demain", unicode: true),
    _literalLocaleReplacement('after tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r"avant[- ]hier", unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r"à l['’]instant", unicode: true),
    _literalLocaleReplacement('now'),
  ),
  _LocaleTranslationRule(
    RegExp(r"aujourd['’]hui", unicode: true),
    _literalLocaleReplacement('today'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bdemain\b', unicode: true),
    _literalLocaleReplacement('tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bhier\b', unicode: true),
    _literalLocaleReplacement('yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\s+à\s+(?=\d)', unicode: true),
    _literalLocaleReplacement(' at '),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bdimanche\b', unicode: true),
    _literalLocaleReplacement('sunday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\blundi\b', unicode: true),
    _literalLocaleReplacement('monday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bmardi\b', unicode: true),
    _literalLocaleReplacement('tuesday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bmercredi\b', unicode: true),
    _literalLocaleReplacement('wednesday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bjeudi\b', unicode: true),
    _literalLocaleReplacement('thursday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bvendredi\b', unicode: true),
    _literalLocaleReplacement('friday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bsamedi\b', unicode: true),
    _literalLocaleReplacement('saturday'),
  ),
];

final List<_LocaleTranslationRule> _deLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r'\bheute\b', unicode: true),
    _literalLocaleReplacement('today'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bmorgen\b', unicode: true),
    _literalLocaleReplacement('tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bübermorgen\b', unicode: true),
    _literalLocaleReplacement('after tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bgestern\b', unicode: true),
    _literalLocaleReplacement('yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bvorgestern\b', unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\s+um\s+(?=\d)', unicode: true),
    _literalLocaleReplacement(' at '),
  ),
  _LocaleTranslationRule(
    RegExp(r'\boktober\b', unicode: true),
    _literalLocaleReplacement('october'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bokt\b', unicode: true),
    _literalLocaleReplacement('oct'),
  ),
];

final List<_LocaleTranslationRule> _csLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r'červenec', unicode: true),
    _literalLocaleReplacement('july'),
  ),
  _LocaleTranslationRule(
    RegExp(r'červen', unicode: true),
    _literalLocaleReplacement('june'),
  ),
];

final List<_LocaleTranslationRule> _ruLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r'послезавтра', unicode: true),
    _literalLocaleReplacement('after tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'позавчера', unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'завтра', unicode: true),
    _literalLocaleReplacement('tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'вчера', unicode: true),
    _literalLocaleReplacement('yesterday'),
  ),
];

final List<_LocaleTranslationRule> _esLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r'pasado\s+mañana', unicode: true),
    _literalLocaleReplacement('after tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'antes\s+de\s+ayer', unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'anteayer', unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bahora\b', unicode: true),
    _literalLocaleReplacement('now'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bhoy\b', unicode: true),
    _literalLocaleReplacement('today'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bmañana\b', unicode: true),
    _literalLocaleReplacement('tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bayer\b', unicode: true),
    _literalLocaleReplacement('yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\sa las\s+(?=\d)', unicode: true),
    _literalLocaleReplacement(' at '),
  ),
  _LocaleTranslationRule(
    RegExp(r'\sa la\s+(?=\d)', unicode: true),
    _literalLocaleReplacement(' at '),
  ),
];

final List<_LocaleTranslationRule> _itLocaleRules = <_LocaleTranslationRule>[
  _LocaleTranslationRule(
    RegExp(r'dopodomani', unicode: true),
    _literalLocaleReplacement('after tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r"l['’]altro\s+ieri", unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bavantieri\b', unicode: true),
    _literalLocaleReplacement('before yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\badesso\b', unicode: true),
    _literalLocaleReplacement('now'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bora\b', unicode: true),
    _literalLocaleReplacement('now'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\boggi\b', unicode: true),
    _literalLocaleReplacement('today'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bdomani\b', unicode: true),
    _literalLocaleReplacement('tomorrow'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\bieri\b', unicode: true),
    _literalLocaleReplacement('yesterday'),
  ),
  _LocaleTranslationRule(
    RegExp(r'\s+alle\s+(?=\d)', unicode: true),
    _literalLocaleReplacement(' at '),
  ),
  _LocaleTranslationRule(
    RegExp(r"\s+all['’]e?\s+(?=\d)", unicode: true),
    _literalLocaleReplacement(' at '),
  ),
];

final Map<String, List<_LocaleTranslationRule>> _localeTranslationRules =
    <String, List<_LocaleTranslationRule>>{
      'fr': _frLocaleRules,
      'fr_fr': _frLocaleRules,
      'de': _deLocaleRules,
      'de_de': _deLocaleRules,
      'cs': _csLocaleRules,
      'cs_cz': _csLocaleRules,
      'ru': _ruLocaleRules,
      'ru_ru': _ruLocaleRules,
      'es': _esLocaleRules,
      'es_es': _esLocaleRules,
      'es_mx': _esLocaleRules,
      'es_419': _esLocaleRules,
      'it': _itLocaleRules,
      'it_it': _itLocaleRules,
      'it_ch': _itLocaleRules,
    };

bool _localeShortMonthUsesDigits(String locale) {
  final sample = DateTime.utc(2000, 4, 1);
  for (final candidate in CarbonBase._localeCandidates(locale)) {
    try {
      final formatted = DateFormat('MMM', candidate).format(sample);
      if (_digitMatcher.hasMatch(formatted)) {
        return true;
      }
    } catch (_) {
      continue;
    }
  }
  return false;
}

final RegExp _digitMatcher = RegExp(r'\d');

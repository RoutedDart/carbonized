part of '../carbon.dart';

class Carbon extends CarbonBase {
  Carbon._internal({
    required super.dateTime,
    super.locale,
    super.timeZone,
    super.settings,
  });

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
      return special;
    }

    DateTime resolved;
    if (input is int) {
      final isSeconds = input.abs() < 1000000000000;
      final millis = isSeconds ? input * 1000 : input;
      resolved = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
    } else if (input is DateTime) {
      resolved = input.isUtc ? input : input.toUtc();
    } else if (input is String) {
      final relative = _parseRelativeString(
        input,
        locale: locale,
        timeZone: timeZone,
      );
      if (relative != null) {
        return relative;
      }
      if (format != null && format.isNotEmpty) {
        final formatter = DateFormat(format, locale);
        resolved = formatter.parseUtc(input);
      } else {
        final parsed = DateTime.parse(input);
        resolved = parsed.isUtc ? parsed : parsed.toUtc();
      }
    } else if (input is CarbonInterface) {
      resolved = input.dateTime;
    } else {
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

  static bool hasRelativeKeywords(String? input) =>
      CarbonBase.hasRelativeKeywords(input);

  static void registerMacro(String name, CarbonMacro macro) =>
      CarbonBase.registerMacro(name, macro);

  static void unregisterMacro(String name) => CarbonBase.unregisterMacro(name);

  static Future<void> configureTimeMachine({
    tm.DateTimeZoneProvider? provider,
    bool testing = true,
  }) => CarbonBase.configureTimeMachine(provider: provider, testing: testing);

  static void resetTimeMachineSupport() => CarbonBase.resetTimeMachine();

  static void useStrictMode(bool enabled) => CarbonBase.useStrictMode(enabled);

  static bool isStrictModeEnabled() => CarbonBase.strictMode;

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

  static CarbonInterface createFromDate([
    int? year,
    int? month,
    int? day,
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  ]) {
    final base = clock.now().toUtc();
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
      timeZone: timeZone,
    );
    return _fromUtc(
      utcDate,
      locale: locale,
      timeZone: timeZone,
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
    final base = clock.now().toUtc();
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
      timeZone: timeZone,
    );
    return _fromUtc(
      utcDate,
      locale: locale,
      timeZone: timeZone,
      settings: settings,
    );
  }

  static CarbonInterface createFromTimeString(
    String time, {
    String? timeZone,
    String? locale,
    CarbonSettings settings = const CarbonSettings(),
  }) {
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

    final base = clock.now().toUtc();
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
      timeZone: timeZone,
    );
    return _fromUtc(
      utcDate,
      locale: locale,
      timeZone: timeZone,
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

  static CarbonInterface createFromFormat(
    String format,
    String input, {
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) {
    final formatter = DateFormat(format, locale);
    final parsed = formatter.parse(input, timeZone == null);
    if (timeZone == null) {
      final resolved = parsed.isUtc ? parsed : parsed.toUtc();
      return _fromUtc(resolved, locale: locale, settings: settings);
    }
    final totalMicro = _microsecondsOf(parsed);
    final utcDate = CarbonBase._localToUtc(
      year: parsed.year,
      month: parsed.month,
      day: parsed.day,
      hour: parsed.hour,
      minute: parsed.minute,
      second: parsed.second,
      microsecond: totalMicro,
      timeZone: timeZone,
    );
    return _fromUtc(
      utcDate,
      locale: locale,
      timeZone: timeZone,
      settings: settings,
    );
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

  static int _microsecondsOf(DateTime value) =>
      value.millisecond * 1000 + value.microsecond;
}

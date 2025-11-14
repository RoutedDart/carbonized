part of carbon_internal;

abstract class CarbonBase implements CarbonInterface {
  CarbonBase({
    required DateTime dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings settings = const CarbonSettings(),
  }) : _dateTime = dateTime.toUtc(),
       _locale = locale ?? 'en',
       _timeZone = timeZone,
       _settings = settings;
  DateTime _dateTime;
  String _locale;
  String? _timeZone;
  CarbonSettings _settings;

  static final Map<String, CarbonMacro> _macros = <String, CarbonMacro>{};
  static tm.DateTimeZoneProvider? _zoneProvider;
  static final Map<String, tm.DateTimeZone> _zoneCache =
      <String, tm.DateTimeZone>{};
  static bool _timeMachineInitialized = false;

  bool get _isMutable => this is Carbon;

  @override
  DateTime get dateTime => _dateTime;

  @override
  String get localeCode => _locale;

  @override
  String? get timeZoneName => _timeZone;

  @override
  CarbonSettings get settings => _settings;

  static void registerMacro(String name, CarbonMacro macro) =>
      _macros[name] = macro;
  static void unregisterMacro(String name) => _macros.remove(name);

  static Future<void> configureTimeMachine({
    tm.DateTimeZoneProvider? provider,
    bool testing = true,
  }) async {
    if (!_timeMachineInitialized) {
      await tm.TimeMachine.initialize({'testing': testing});
      _timeMachineInitialized = true;
    }
    _zoneProvider = provider ?? await tm.DateTimeZoneProviders.tzdb;
    _zoneCache.clear();
  }

  static void resetTimeMachine() {
    _zoneProvider = null;
    _zoneCache.clear();
  }

  CarbonInterface _wrap(DateTime value) {
    final normalized = value.toUtc();
    if (_isMutable) {
      _dateTime = normalized;
      return this;
    }
    return CarbonImmutable._internal(
      dateTime: normalized,
      locale: _locale,
      timeZone: _timeZone,
      settings: _settings,
    );
  }

  CarbonInterface _duplicate({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) {
    if (_isMutable) {
      if (dateTime != null) {
        _dateTime = dateTime.toUtc();
      }
      if (locale != null) {
        _locale = locale;
      }
      if (timeZone != null) {
        _timeZone = timeZone;
      }
      if (settings != null) {
        _settings = settings;
      }
      return this;
    }
    return CarbonImmutable._internal(
      dateTime: (dateTime ?? _dateTime).toUtc(),
      locale: locale ?? _locale,
      timeZone: timeZone ?? _timeZone,
      settings: settings ?? _settings,
    );
  }

  @override
  CarbonInterface copyWith({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) => _duplicate(
    dateTime: dateTime,
    locale: locale,
    timeZone: timeZone,
    settings: settings,
  );

  @override
  CarbonInterface setLocale(String locale) => _duplicate(locale: locale);

  @override
  CarbonInterface tz(String zoneName) {
    if (_timeZone == zoneName) {
      return this;
    }
    if (zoneName == 'UTC') {
      return _duplicate(timeZone: 'UTC');
    }
    _getZoneOrThrow(zoneName);
    return _duplicate(timeZone: zoneName);
  }

  @override
  CarbonInterface toUtc() => _wrap(_dateTime.toUtc());

  @override
  CarbonInterface toLocal() => _wrap(_dateTime.toLocal());

  @override
  CarbonInterface add(Duration duration) => _wrap(_dateTime.add(duration));

  @override
  CarbonInterface subtract(Duration duration) => add(-duration);

  @override
  CarbonInterface addDays(int days) => add(Duration(days: days));

  @override
  CarbonInterface addWeeks(int weeks) => add(Duration(days: weeks * 7));

  @override
  CarbonInterface addMonths(int months) => _wrap(_addMonths(_dateTime, months));

  @override
  CarbonInterface addYears(int years) => addMonths(years * 12);

  DateTime _addMonths(DateTime value, int months) {
    final monthIndex = value.month - 1 + months;
    var targetYear = value.year + monthIndex ~/ 12;
    var targetMonth = monthIndex % 12;
    if (targetMonth < 0) {
      targetMonth += 12;
      targetYear -= 1;
    }
    targetMonth += 1;

    if (_settings.monthOverflow) {
      return DateTime.utc(
        targetYear,
        targetMonth,
        value.day,
        value.hour,
        value.minute,
        value.second,
        value.millisecond,
        value.microsecond,
      );
    }

    final lastDayOfTarget = DateTime.utc(targetYear, targetMonth + 1, 0).day;
    final clampedDay = value.day > lastDayOfTarget
        ? lastDayOfTarget
        : value.day;
    return DateTime.utc(
      targetYear,
      targetMonth,
      clampedDay,
      value.hour,
      value.minute,
      value.second,
      value.millisecond,
      value.microsecond,
    );
  }

  @override
  CarbonInterface startOfDay() =>
      _wrap(DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day));

  @override
  CarbonInterface endOfDay() => _wrap(
    DateTime.utc(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      23,
      59,
      59,
      999,
      999,
    ),
  );

  @override
  CarbonInterface startOfWeek() {
    final delta = (_dateTime.weekday - _settings.startOfWeek + 7) % 7;
    final start = DateTime.utc(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
    ).subtract(Duration(days: delta));
    return _wrap(start);
  }

  @override
  CarbonInterface endOfWeek() =>
      startOfWeek().addWeeks(1).subtract(const Duration(microseconds: 1));

  @override
  CarbonInterface startOfMonth() =>
      _wrap(DateTime.utc(_dateTime.year, _dateTime.month, 1));

  @override
  CarbonInterface endOfMonth() => _wrap(
    DateTime.utc(_dateTime.year, _dateTime.month + 1, 0, 23, 59, 59, 999, 999),
  );

  @override
  CarbonInterface startOfYear() => _wrap(DateTime.utc(_dateTime.year, 1, 1));

  @override
  CarbonInterface endOfYear() =>
      _wrap(DateTime.utc(_dateTime.year + 1, 1, 0, 23, 59, 59, 999, 999));

  @override
  bool isBefore(CarbonInterface other) => _dateTime.isBefore(other.dateTime);

  @override
  bool isAfter(CarbonInterface other) => _dateTime.isAfter(other.dateTime);

  @override
  bool isSameDay(CarbonInterface other) =>
      _dateTime.year == other.dateTime.year &&
      _dateTime.month == other.dateTime.month &&
      _dateTime.day == other.dateTime.day;

  @override
  bool isBetween(
    CarbonInterface start,
    CarbonInterface end, {
    bool inclusive = true,
  }) {
    if (inclusive) {
      final lower = isAfter(start) || isSameDay(start);
      final upper = isBefore(end) || isSameDay(end);
      return lower && upper;
    }
    return isAfter(start) && isBefore(end);
  }

  @override
  Duration diff(CarbonInterface other) => _dateTime.difference(other.dateTime);

  int _diffIn(Duration portion, CarbonInterface other, {bool absolute = true}) {
    final value = diff(other).inMicroseconds / portion.inMicroseconds;
    final truncated = value.truncate();
    return absolute ? truncated.abs() : truncated;
  }

  @override
  int diffInDays(CarbonInterface other, {bool absolute = true}) =>
      _diffIn(const Duration(days: 1), other, absolute: absolute);

  @override
  int diffInHours(CarbonInterface other, {bool absolute = true}) =>
      _diffIn(const Duration(hours: 1), other, absolute: absolute);

  @override
  int diffInMinutes(CarbonInterface other, {bool absolute = true}) =>
      _diffIn(const Duration(minutes: 1), other, absolute: absolute);

  @override
  String format(String pattern, {String? locale}) {
    final snapshot = _zoneSnapshot();
    if (snapshot == null) {
      final formatter = DateFormat(pattern, locale ?? _locale);
      return formatter.format(_dateTime.toUtc());
    }
    return _formatWithZone(pattern, snapshot, locale ?? _locale);
  }

  @override
  String toIso8601String() => _dateTime.toUtc().toIso8601String();

  @override
  String diffForHumans({CarbonInterface? reference, String? locale}) {
    final base = (reference?.dateTime ?? clock.now()).toUtc();
    return timeago.format(
      _dateTime,
      locale: locale ?? _locale,
      allowFromNow: true,
      clock: base,
    );
  }

  @override
  int toEpochMilliseconds() => _dateTime.toUtc().millisecondsSinceEpoch;

  @override
  Map<String, dynamic> toJson() => {
    'iso': toIso8601String(),
    'epochMs': toEpochMilliseconds(),
    'locale': _locale,
    if (_timeZone != null) 'timeZone': _timeZone,
  };

  @override
  CarbonImmutable toImmutable() => this is CarbonImmutable
      ? this as CarbonImmutable
      : CarbonImmutable._internal(
          dateTime: _dateTime,
          locale: _locale,
          timeZone: _timeZone,
          settings: _settings,
        );

  @override
  Carbon toMutable() => this is Carbon
      ? this as Carbon
      : Carbon._internal(
          dateTime: _dateTime,
          locale: _locale,
          timeZone: _timeZone,
          settings: _settings,
        );

  @override
  int compareTo(CarbonInterface other) => _dateTime.compareTo(other.dateTime);

  @override
  bool operator ==(Object other) =>
      other is CarbonInterface && dateTime == other.dateTime;

  @override
  int get hashCode => dateTime.hashCode;

  CarbonTimeZoneSnapshot? _zoneSnapshot() {
    final zoneName = _timeZone;
    if (zoneName == null) {
      return null;
    }
    if (zoneName == 'UTC') {
      return CarbonTimeZoneSnapshot(
        localDateTime: _dateTime.toUtc(),
        abbreviation: 'UTC',
        offset: Duration.zero,
      );
    }
    if (_zoneProvider == null) {
      return null;
    }
    final zone = _getZoneOrThrow(zoneName);
    final instant = tm.Instant.dateTime(_dateTime);
    final zoned = instant.inZone(zone);
    final zoneInterval = zone.getZoneInterval(instant);
    return CarbonTimeZoneSnapshot(
      localDateTime: zoned.localDateTime.toDateTimeLocal(),
      abbreviation: zoneInterval.name ?? zone.id,
      offset: Duration(seconds: zoned.offset.inSeconds),
    );
  }

  tm.DateTimeZone _getZoneOrThrow(String zoneName) {
    final provider = _zoneProvider;
    if (provider == null) {
      throw StateError(
        'Named timezone "$zoneName" requires calling Carbon.configureTimeMachine() first.',
      );
    }
    return _zoneCache.putIfAbsent(zoneName, () {
      try {
        return provider.getDateTimeZoneSync(zoneName);
      } on Object {
        throw StateError('Unknown timezone "$zoneName".');
      }
    });
  }

  String _formatWithZone(
    String pattern,
    CarbonTimeZoneSnapshot snapshot,
    String locale,
  ) {
    final placeholderRegex = RegExp('z+');
    var sanitizedPattern = pattern;
    final replacements = <String, String>{};
    var matchIndex = 0;
    for (final match in placeholderRegex.allMatches(pattern)) {
      final token = '@@carbon_zone_$matchIndex@@';
      sanitizedPattern = sanitizedPattern.replaceRange(
        match.start,
        match.end,
        "'$token'",
      );
      final length = match.group(0)!.length;
      replacements[token] = length <= 3
          ? snapshot.abbreviation
          : _formatOffset(snapshot.offset, includePrefix: true);
      matchIndex++;
    }
    final formatter = DateFormat(sanitizedPattern, locale);
    var result = formatter.format(snapshot.localDateTime);
    replacements.forEach((token, value) {
      result = result.replaceAll(token, value);
    });
    return result;
  }

  String _formatOffset(Duration offset, {bool includePrefix = false}) {
    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absMinutes = totalMinutes.abs();
    final hours = (absMinutes ~/ 60).toString().padLeft(2, '0');
    final minutes = (absMinutes % 60).toString().padLeft(2, '0');
    final core = '$sign$hours:$minutes';
    return includePrefix ? 'GMT$core' : core;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final name = _symbolToName(invocation.memberName);
    final macro = _macros[name];
    if (macro != null) {
      return macro(
        this,
        invocation.positionalArguments,
        invocation.namedArguments,
      );
    }
    return super.noSuchMethod(invocation);
  }

  String _symbolToName(Symbol symbol) {
    final description = symbol.toString();
    return description
        .replaceAll('Symbol("', '')
        .replaceAll('Symbol(\'', '')
        .replaceAll('")', '')
        .replaceAll("')", '');
  }
}

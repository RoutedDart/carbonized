part of '../carbon.dart';

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
  CarbonInterface addYears(int years) =>
      _wrap(_addMonths(_dateTime, years * 12));

  DateTime _addMonths(DateTime value, int months, {bool? monthOverflow}) {
    final overflow = monthOverflow ?? _settings.monthOverflow;
    final monthIndex = value.month - 1 + months;
    var targetYear = value.year + monthIndex ~/ 12;
    var targetMonth = monthIndex % 12;
    if (targetMonth < 0) {
      targetMonth += 12;
      targetYear -= 1;
    }
    targetMonth += 1;

    if (overflow) {
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
        : value.day.clamp(1, lastDayOfTarget);
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
  int get year => _dateTime.year;

  @override
  CarbonInterface setYear(int year) =>
      _duplicate(dateTime: _copyWith(year: year));

  @override
  CarbonInterface years(int year) => setYear(year);

  @override
  CarbonInterface setYears(int year) => setYear(year);

  @override
  CarbonPeriod monthsUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final step = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, monthStep: step);
  }

  @override
  int get months => _dateTime.month;

  @override
  int get month => _dateTime.month;

  @override
  int get monthOfYear => _dateTime.month;

  @override
  int get monthOfQuarter => ((_dateTime.month - 1) % 3) + 1;

  @override
  int get monthOfDecade =>
      (_dateTime.year - _decadeStart(_dateTime).year) * 12 + _dateTime.month;

  @override
  int get monthOfCentury =>
      (_dateTime.year - _centuryStart(_dateTime).year) * 12 + _dateTime.month;

  @override
  int get monthOfMillennium =>
      (_dateTime.year - _millenniumStart(_dateTime).year) * 12 +
      _dateTime.month;

  @override
  int get monthsInYear => 12;

  @override
  int get monthsInDecade => 120;

  @override
  int get monthsInCentury => 1200;

  @override
  int get monthsInMillennium => 12000;

  @override
  int get monthsInQuarter => 3;

  @override
  CarbonInterface setMonth(int month) =>
      _duplicate(dateTime: _copyWith(month: month));

  @override
  CarbonInterface setMonths(int month) => setMonth(month);

  @override
  CarbonInterface setDay(int day) => _duplicate(dateTime: _copyWith(day: day));

  @override
  CarbonInterface setDays(int day) => setDay(day);

  @override
  int get day => _dateTime.day;

  @override
  int get days => day;

  @override
  int get dayOfMonth => day;

  @override
  int get dayOfWeek {
    final weekday = _dateTime.weekday % 7;
    return weekday;
  }

  @override
  int get dayOfQuarter => _daysSince(_quarterStart(_dateTime)) + 1;

  @override
  int get dayOfDecade => _daysSince(_decadeStart(_dateTime)) + 1;

  @override
  int get dayOfCentury => _daysSince(_centuryStart(_dateTime)) + 1;

  @override
  int get dayOfMillennium => _daysSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get daysInWeek => 7;

  @override
  int get daysInMonth => _daysBetween(
    DateTime.utc(_dateTime.year, _dateTime.month, 1),
    DateTime.utc(_dateTime.year, _dateTime.month + 1, 1),
  );

  @override
  int get daysInQuarter => _daysBetween(
    _quarterStart(_dateTime),
    DateTime.utc(
      _quarterStart(_dateTime).year,
      _quarterStart(_dateTime).month + 3,
      1,
    ),
  );

  @override
  int get daysInYear => _daysBetween(
    DateTime.utc(_dateTime.year, 1, 1),
    DateTime.utc(_dateTime.year + 1, 1, 1),
  );

  @override
  int get daysInDecade => _daysBetween(
    _decadeStart(_dateTime),
    DateTime.utc(_decadeStart(_dateTime).year + 10, 1, 1),
  );

  @override
  int get daysInCentury => _daysBetween(
    _centuryStart(_dateTime),
    DateTime.utc(_centuryStart(_dateTime).year + 100, 1, 1),
  );

  @override
  int get daysInMillennium => _daysBetween(
    _millenniumStart(_dateTime),
    DateTime.utc(_millenniumStart(_dateTime).year + 1000, 1, 1),
  );

  @override
  CarbonPeriod daysUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepDays = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(days: stepDays));
  }

  @override
  CarbonInterface setMinute(int minute) =>
      _duplicate(dateTime: _copyWith(minute: minute));

  @override
  CarbonInterface setMinutes(int minute) => setMinute(minute);

  @override
  CarbonInterface setSecond(int second) =>
      _duplicate(dateTime: _copyWith(second: second));

  @override
  CarbonInterface setSeconds(int second) => setSecond(second);

  @override
  CarbonInterface setHour(int hour) =>
      _duplicate(dateTime: _copyWith(hour: hour));

  @override
  CarbonInterface setHours(int hour) => setHour(hour);

  @override
  int get hour => _dateTime.hour;

  @override
  int get hours => hour;

  @override
  int get hourOfDay => _dateTime.hour + 1;

  @override
  int get hourOfWeek => _hoursSince(_weekStart(_dateTime)) + 1;

  @override
  int get hourOfMonth =>
      _hoursSince(DateTime.utc(_dateTime.year, _dateTime.month, 1)) + 1;

  @override
  int get hourOfQuarter => _hoursSince(_quarterStart(_dateTime)) + 1;

  @override
  int get hourOfYear =>
      _hoursSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

  @override
  int get hourOfDecade => _hoursSince(_decadeStart(_dateTime)) + 1;

  @override
  int get hourOfCentury => _hoursSince(_centuryStart(_dateTime)) + 1;

  @override
  int get hourOfMillennium => _hoursSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get hoursInDay => 24;

  @override
  int get hoursInWeek => hoursInDay * daysInWeek;

  @override
  int get hoursInMonth => daysInMonth * hoursInDay;

  @override
  int get hoursInQuarter => daysInQuarter * hoursInDay;

  @override
  int get hoursInYear => daysInYear * hoursInDay;

  @override
  int get hoursInDecade => daysInDecade * hoursInDay;

  @override
  int get hoursInCentury => daysInCentury * hoursInDay;

  @override
  int get hoursInMillennium => daysInMillennium * hoursInDay;

  @override
  CarbonPeriod hoursUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepHours = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(hours: stepHours));
  }

  @override
  CarbonInterface setMilli(int millisecond) =>
      _duplicate(dateTime: _copyWith(millisecond: millisecond));

  @override
  CarbonInterface setMillis(int millisecond) => setMilli(millisecond);

  @override
  CarbonInterface setMillisecond(int millisecond) => setMilli(millisecond);

  @override
  CarbonInterface setMilliseconds(int millisecond) => setMilli(millisecond);

  @override
  int get millisecond => _dateTime.millisecond;

  @override
  int get milliseconds => millisecond;

  @override
  int get milli => millisecond;

  @override
  int get millis => millisecond;

  @override
  int get millisecondOfSecond => millisecond + 1;

  @override
  int get millisecondOfMinute => _millisecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
          _dateTime.minute,
        ),
      ) +
      1;

  @override
  int get millisecondOfHour => _millisecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
        ),
      ) +
      1;

  @override
  int get millisecondOfDay => _millisecondsSince(
        DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day),
      ) +
      1;

  @override
  int get millisecondOfWeek =>
      _millisecondsSince(_weekStart(_dateTime)) + 1;

  @override
  int get millisecondOfMonth =>
      _millisecondsSince(DateTime.utc(_dateTime.year, _dateTime.month, 1)) + 1;

  @override
  int get millisecondOfQuarter =>
      _millisecondsSince(_quarterStart(_dateTime)) + 1;

  @override
  int get millisecondOfYear =>
      _millisecondsSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

  @override
  int get millisecondOfDecade =>
      _millisecondsSince(_decadeStart(_dateTime)) + 1;

  @override
  int get millisecondOfCentury =>
      _millisecondsSince(_centuryStart(_dateTime)) + 1;

  @override
  int get millisecondOfMillennium =>
      _millisecondsSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get millisecondsInSecond => Duration.millisecondsPerSecond;

  @override
  int get millisecondsInMinute => Duration.millisecondsPerMinute;

  @override
  int get millisecondsInHour => Duration.millisecondsPerHour;

  @override
  int get millisecondsInDay => Duration.millisecondsPerDay;

  @override
  int get millisecondsInWeek => millisecondsInDay * daysInWeek;

  @override
  int get millisecondsInMonth => daysInMonth * Duration.millisecondsPerDay;

  @override
  int get millisecondsInQuarter =>
      daysInQuarter * Duration.millisecondsPerDay;

  @override
  int get millisecondsInYear =>
      daysInYear * Duration.millisecondsPerDay;

  @override
  int get millisecondsInDecade =>
      daysInDecade * Duration.millisecondsPerDay;

  @override
  int get millisecondsInCentury =>
      daysInCentury * Duration.millisecondsPerDay;

  @override
  int get millisecondsInMillennium =>
      daysInMillennium * Duration.millisecondsPerDay;

  @override
  CarbonPeriod millisecondsUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final step = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(milliseconds: step));
  }

  @override
  CarbonPeriod millisUntil([dynamic endDate, num factor = 1]) =>
      millisecondsUntil(endDate, factor);

  @override
  CarbonInterface setMicro(int microsecond) =>
      _duplicate(dateTime: _copyWith(microsecond: microsecond));

  @override
  CarbonInterface setMicros(int microsecond) => setMicro(microsecond);

  @override
  CarbonInterface setMicrosecond(int microsecond) => setMicro(microsecond);

  @override
  CarbonInterface setMicroseconds(int microsecond) => setMicro(microsecond);

  @override
  int get microsecond => _dateTime.microsecond;

  @override
  int get microseconds => microsecond;

  @override
  int get micro => microsecond;

  @override
  int get micros => microsecond;

  @override
  int get microsecondOfMillisecond => microsecond + 1;

  @override
  int get microsecondOfSecond =>
      _dateTime.millisecond * Duration.microsecondsPerMillisecond +
      microsecond +
      1;

  @override
  int get microsecondOfMinute => _microsecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
          _dateTime.minute,
        ),
      ) +
      1;

  @override
  int get microsecondOfHour => _microsecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
        ),
      ) +
      1;

  @override
  int get microsecondOfDay => _microsecondsSince(
        DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day),
      ) +
      1;

  @override
  int get microsecondOfWeek =>
      _microsecondsSince(_weekStart(_dateTime)) + 1;

  @override
  int get microsecondOfMonth =>
      _microsecondsSince(DateTime.utc(_dateTime.year, _dateTime.month, 1)) + 1;

  @override
  int get microsecondOfQuarter =>
      _microsecondsSince(_quarterStart(_dateTime)) + 1;

  @override
  int get microsecondOfYear =>
      _microsecondsSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

  @override
  int get microsecondOfDecade => _microsecondsSince(_decadeStart(_dateTime)) + 1;

  @override
  int get microsecondOfCentury =>
      _microsecondsSince(_centuryStart(_dateTime)) + 1;

  @override
  int get microsecondOfMillennium =>
      _microsecondsSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get microsecondsInMillisecond =>
      Duration.microsecondsPerMillisecond;

  @override
  int get microsecondsInSecond => Duration.microsecondsPerSecond;

  @override
  int get microsecondsInMinute => Duration.microsecondsPerMinute;

  @override
  int get microsecondsInHour => Duration.microsecondsPerHour;

  @override
  int get microsecondsInDay => Duration.microsecondsPerDay;

  @override
  int get microsecondsInWeek => microsecondsInDay * daysInWeek;

  @override
  int get microsecondsInMonth =>
      daysInMonth * Duration.microsecondsPerDay;

  @override
  int get microsecondsInQuarter =>
      daysInQuarter * Duration.microsecondsPerDay;

  @override
  int get microsecondsInYear =>
      daysInYear * Duration.microsecondsPerDay;

  @override
  int get microsecondsInDecade =>
      daysInDecade * Duration.microsecondsPerDay;

  @override
  int get microsecondsInCentury =>
      daysInCentury * Duration.microsecondsPerDay;

  @override
  int get microsecondsInMillennium =>
      daysInMillennium * Duration.microsecondsPerDay;

  @override
  CarbonPeriod microsecondsUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final step = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(microseconds: step));
  }

  @override
  CarbonPeriod microsUntil([dynamic endDate, num factor = 1]) =>
      microsecondsUntil(endDate, factor);

  @override
  int get yearOfCentury => _wrapModulo(_dateTime.year - 1, 100) + 1;

  @override
  int get yearOfDecade => _wrapModulo(_dateTime.year - 1, 10) + 1;

  @override
  int get yearOfMillennium => _wrapModulo(_dateTime.year - 1, 1000) + 1;

  @override
  int get yearsInCentury => 100;

  @override
  int get yearsInDecade => 10;

  @override
  int get yearsInMillennium => 1000;

  @override
  int get centuryOfMillennium =>
      ((_dateTime.year - _millenniumStart(_dateTime).year) ~/ 100) + 1;

  @override
  int get centuriesInMillennium => 10;

  @override
  CarbonPeriod centuriesUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepMonths = (factor == 0 ? 1 : factor.abs()).ceil() * 1200;
    return _buildPeriod(target, monthStep: stepMonths);
  }

  @override
  int get decadeOfCentury =>
      ((_dateTime.year - _centuryStart(_dateTime).year) ~/ 10) + 1;

  @override
  int get decadeOfMillennium =>
      ((_dateTime.year - _millenniumStart(_dateTime).year) ~/ 10) + 1;

  @override
  int get decadesInCentury => 10;

  @override
  int get decadesInMillennium => 100;

  @override
  CarbonPeriod decadesUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepMonths = (factor == 0 ? 1 : factor.abs()).ceil() * 120;
    return _buildPeriod(target, monthStep: stepMonths);
  }

  @override
  CarbonPeriod yearsUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepMonths = (factor == 0 ? 1 : factor.abs()).ceil() * 12;
    return _buildPeriod(target, monthStep: stepMonths);
  }

  @override
  CarbonPeriod millenniaUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepMonths = (factor == 0 ? 1 : factor.abs()).ceil() * 12000;
    return _buildPeriod(target, monthStep: stepMonths);
  }

  @override
  int get weekOfYear =>
      _weekIndex(DateTime.utc(_dateTime.year, 1, 1), _dateTime);

  @override
  int get weekOfMonth =>
      _weekIndex(DateTime.utc(_dateTime.year, _dateTime.month, 1), _dateTime);

  @override
  int get weekOfQuarter => _weekIndex(_quarterStart(_dateTime), _dateTime);

  @override
  int get weekOfDecade => _weekIndex(_decadeStart(_dateTime), _dateTime);

  @override
  int get weekOfCentury => _weekIndex(_centuryStart(_dateTime), _dateTime);

  @override
  int get weekOfMillennium =>
      _weekIndex(_millenniumStart(_dateTime), _dateTime);

  @override
  int get weeksInMonth => _weeksBetween(
    DateTime.utc(_dateTime.year, _dateTime.month, 1),
    DateTime.utc(_dateTime.year, _dateTime.month + 1, 1),
  );

  @override
  int get weeksInQuarter => _weeksBetween(
    _quarterStart(_dateTime),
    DateTime.utc(
      _quarterStart(_dateTime).year,
      _quarterStart(_dateTime).month + 3,
      1,
    ),
  );

  @override
  int get weeksInYear => _weeksBetween(
    DateTime.utc(_dateTime.year, 1, 1),
    DateTime.utc(_dateTime.year + 1, 1, 1),
  );

  @override
  int get weeksInDecade => _weeksBetween(
    _decadeStart(_dateTime),
    DateTime.utc(_decadeStart(_dateTime).year + 10, 1, 1),
  );

  @override
  int get weeksInCentury => _weeksBetween(
    _centuryStart(_dateTime),
    DateTime.utc(_centuryStart(_dateTime).year + 100, 1, 1),
  );

  @override
  int get weeksInMillennium => _weeksBetween(
    _millenniumStart(_dateTime),
    DateTime.utc(_millenniumStart(_dateTime).year + 1000, 1, 1),
  );

  @override
  CarbonPeriod weeksUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepWeeks = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(days: stepWeeks * 7));
  }

  @override
  int get quarterOfYear => ((_dateTime.month - 1) ~/ 3) + 1;

  @override
  int get quarterOfDecade =>
      (_dateTime.year - _decadeStart(_dateTime).year) * 4 + quarterOfYear;

  @override
  int get quarterOfCentury =>
      (_dateTime.year - _centuryStart(_dateTime).year) * 4 + quarterOfYear;

  @override
  int get quarterOfMillennium =>
      (_dateTime.year - _millenniumStart(_dateTime).year) * 4 + quarterOfYear;

  @override
  int get quartersInYear => 4;

  @override
  int get quartersInDecade => 40;

  @override
  int get quartersInCentury => 400;

  @override
  int get quartersInMillennium => 4000;

  @override
  CarbonPeriod quartersUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final step = (factor == 0 ? 1 : factor.abs()).ceil() * 3;
    return _buildPeriod(target, monthStep: step);
  }

  @override
  int get secondsInMinute => 60;

  @override
  int get secondsInHour => secondsInMinute * 60;

  @override
  int get secondsInDay => secondsInHour * 24;

  @override
  int get secondsInWeek => secondsInDay * 7;

  @override
  int get secondsInMonth => _secondsBetween(
    DateTime.utc(_dateTime.year, _dateTime.month, 1),
    DateTime.utc(_dateTime.year, _dateTime.month + 1, 1),
  );

  @override
  int get secondsInQuarter => _secondsBetween(
    _quarterStart(_dateTime),
    DateTime.utc(
      _quarterStart(_dateTime).year,
      _quarterStart(_dateTime).month + 3,
      1,
    ),
  );

  @override
  int get secondsInYear => _secondsBetween(
    DateTime.utc(_dateTime.year, 1, 1),
    DateTime.utc(_dateTime.year + 1, 1, 1),
  );

  @override
  int get secondsInDecade => secondsInYear * 10;

  @override
  int get secondsInCentury => secondsInYear * 100;

  @override
  int get secondsInMillennium => secondsInYear * 1000;

  @override
  CarbonPeriod secondsUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepSeconds = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(seconds: stepSeconds));
  }

  @override
  int get minutesInHour => 60;

  @override
  int get minutesInDay => minutesInHour * 24;

  @override
  int get minutesInWeek => minutesInDay * 7;

  @override
  int get minutesInMonth =>
      _secondsBetween(
        DateTime.utc(_dateTime.year, _dateTime.month, 1),
        DateTime.utc(_dateTime.year, _dateTime.month + 1, 1),
      ) ~/
      60;

  @override
  int get minutesInQuarter =>
      _secondsBetween(
        _quarterStart(_dateTime),
        DateTime.utc(
          _quarterStart(_dateTime).year,
          _quarterStart(_dateTime).month + 3,
          1,
        ),
      ) ~/
      60;

  @override
  int get minutesInYear => secondsInYear ~/ 60;

  @override
  int get minutesInDecade => minutesInYear * 10;

  @override
  int get minutesInCentury => minutesInYear * 100;

  @override
  int get minutesInMillennium => minutesInYear * 1000;

  @override
  CarbonPeriod minutesUntil([dynamic endDate, num factor = 1]) {
    final target = _coerceToDateTime(endDate);
    final stepMinutes = (factor == 0 ? 1 : factor.abs()).ceil();
    return _buildPeriod(target, durationStep: Duration(minutes: stepMinutes));
  }

  @override
  int get seconds => _dateTime.second;

  @override
  int get second => seconds;

  @override
  int get secondOfMinute => _dateTime.second + 1;

  @override
  int get secondOfHour => _dateTime.minute * secondsInMinute + secondOfMinute;

  @override
  int get secondOfDay =>
      _secondsSince(
        DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day),
      ) +
      1;

  @override
  int get secondOfWeek =>
      _secondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
        ).subtract(Duration(days: _dateTime.weekday - 1)),
      ) +
      1;

  @override
  int get secondOfMonth =>
      _secondsSince(DateTime.utc(_dateTime.year, _dateTime.month, 1)) + 1;

  @override
  int get secondOfQuarter => _secondsSince(_quarterStart(_dateTime)) + 1;

  @override
  int get secondOfYear => _secondsSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

  @override
  int get secondOfDecade => _secondsSince(_decadeStart(_dateTime)) + 1;

  @override
  int get secondOfCentury => _secondsSince(_centuryStart(_dateTime)) + 1;

  @override
  int get secondOfMillennium => _secondsSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get minute => _dateTime.minute;

  @override
  int get minutes => minute;

  @override
  int get minuteOfHour => _dateTime.minute + 1;

  @override
  int get minuteOfDay => _dateTime.hour * 60 + minuteOfHour;

  @override
  int get minuteOfWeek => _minutesSince(_weekStart(_dateTime)) + 1;

  @override
  int get minuteOfMonth =>
      (_dateTime.day - 1) * 24 * 60 + _dateTime.hour * 60 + minuteOfHour;

  @override
  int get minuteOfQuarter => _minutesSince(_quarterStart(_dateTime)) + 1;

  @override
  int get minuteOfYear =>
      (_secondsSince(DateTime.utc(_dateTime.year, 1, 1)) ~/ 60) + 1;

  @override
  int get minuteOfDecade => (_secondsSince(_decadeStart(_dateTime)) ~/ 60) + 1;

  @override
  int get minuteOfCentury =>
      (_secondsSince(_centuryStart(_dateTime)) ~/ 60) + 1;

  @override
  int get minuteOfMillennium =>
      (_secondsSince(_millenniumStart(_dateTime)) ~/ 60) + 1;

  @override
  CarbonInterface roundSeconds({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(seconds: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundSecond({
    double precision = 1,
    String function = 'round',
  }) => roundSeconds(precision: precision, function: function);

  @override
  CarbonInterface ceilSeconds({double precision = 1}) =>
      roundSeconds(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilSecond({double precision = 1}) =>
      ceilSeconds(precision: precision);

  @override
  CarbonInterface floorSeconds({double precision = 1}) =>
      roundSeconds(precision: precision, function: 'floor');

  @override
  CarbonInterface floorSecond({double precision = 1}) =>
      floorSeconds(precision: precision);

  @override
  CarbonInterface roundMinutes({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(minutes: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundMinute({
    double precision = 1,
    String function = 'round',
  }) => roundMinutes(precision: precision, function: function);

  @override
  CarbonInterface ceilMinutes({double precision = 1}) =>
      roundMinutes(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilMinute({double precision = 1}) =>
      ceilMinutes(precision: precision);

  @override
  CarbonInterface floorMinutes({double precision = 1}) =>
      roundMinutes(precision: precision, function: 'floor');

  @override
  CarbonInterface floorMinute({double precision = 1}) =>
      floorMinutes(precision: precision);

  @override
  CarbonInterface roundMonths({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision, function);

  @override
  CarbonInterface roundMonth({
    double precision = 1,
    String function = 'round',
  }) => roundMonths(precision: precision, function: function);

  @override
  CarbonInterface ceilMonths({double precision = 1}) =>
      roundMonths(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilMonth({double precision = 1}) =>
      ceilMonths(precision: precision);

  @override
  CarbonInterface floorMonths({double precision = 1}) =>
      roundMonths(precision: precision, function: 'floor');

  @override
  CarbonInterface floorMonth({double precision = 1}) =>
      floorMonths(precision: precision);

  @override
  CarbonInterface roundQuarters({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 3, function);

  @override
  CarbonInterface roundQuarter({
    double precision = 1,
    String function = 'round',
  }) => roundQuarters(precision: precision, function: function);

  @override
  CarbonInterface ceilQuarters({double precision = 1}) =>
      roundQuarters(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilQuarter({double precision = 1}) =>
      ceilQuarters(precision: precision);

  @override
  CarbonInterface floorQuarters({double precision = 1}) =>
      roundQuarters(precision: precision, function: 'floor');

  @override
  CarbonInterface floorQuarter({double precision = 1}) =>
      floorQuarters(precision: precision);

  @override
  CarbonInterface roundYears({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 12, function);

  @override
  CarbonInterface roundYear({
    double precision = 1,
    String function = 'round',
  }) => roundYears(precision: precision, function: function);

  @override
  CarbonInterface ceilYears({double precision = 1}) =>
      roundYears(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilYear({double precision = 1}) =>
      ceilYears(precision: precision);

  @override
  CarbonInterface floorYears({double precision = 1}) =>
      roundYears(precision: precision, function: 'floor');

  @override
  CarbonInterface floorYear({double precision = 1}) =>
      floorYears(precision: precision);

  @override
  CarbonInterface roundHours({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(hours: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundHour({
    double precision = 1,
    String function = 'round',
  }) => roundHours(precision: precision, function: function);

  @override
  CarbonInterface ceilHours({double precision = 1}) =>
      roundHours(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilHour({double precision = 1}) =>
      ceilHours(precision: precision);

  @override
  CarbonInterface floorHours({double precision = 1}) =>
      roundHours(precision: precision, function: 'floor');

  @override
  CarbonInterface floorHour({double precision = 1}) =>
      floorHours(precision: precision);

  @override
  CarbonInterface roundDecades({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 120, function);

  @override
  CarbonInterface roundDecade({
    double precision = 1,
    String function = 'round',
  }) => roundDecades(precision: precision, function: function);

  @override
  CarbonInterface ceilDecades({double precision = 1}) =>
      roundDecades(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilDecade({double precision = 1}) =>
      ceilDecades(precision: precision);

  @override
  CarbonInterface floorDecades({double precision = 1}) =>
      roundDecades(precision: precision, function: 'floor');

  @override
  CarbonInterface floorDecade({double precision = 1}) =>
      floorDecades(precision: precision);

  @override
  CarbonInterface roundMillennia({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 12000, function);

  @override
  CarbonInterface roundMillennium({
    double precision = 1,
    String function = 'round',
  }) => roundMillennia(precision: precision, function: function);

  @override
  CarbonInterface ceilMillennia({double precision = 1}) =>
      roundMillennia(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilMillennium({double precision = 1}) =>
      ceilMillennia(precision: precision);

  @override
  CarbonInterface floorMillennia({double precision = 1}) =>
      roundMillennia(precision: precision, function: 'floor');

  @override
  CarbonInterface floorMillennium({double precision = 1}) =>
      floorMillennia(precision: precision);

  @override
  CarbonInterface roundMilliseconds({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(milliseconds: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundMillisecond({
    double precision = 1,
    String function = 'round',
  }) => roundMilliseconds(precision: precision, function: function);

  @override
  CarbonInterface ceilMilliseconds({double precision = 1}) =>
      roundMilliseconds(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilMillisecond({double precision = 1}) =>
      ceilMilliseconds(precision: precision);

  @override
  CarbonInterface floorMilliseconds({double precision = 1}) =>
      roundMilliseconds(precision: precision, function: 'floor');

  @override
  CarbonInterface floorMillisecond({double precision = 1}) =>
      floorMilliseconds(precision: precision);

  @override
  CarbonInterface roundMicroseconds({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(microseconds: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundMicrosecond({
    double precision = 1,
    String function = 'round',
  }) => roundMicroseconds(precision: precision, function: function);

  @override
  CarbonInterface ceilMicroseconds({double precision = 1}) =>
      roundMicroseconds(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilMicrosecond({double precision = 1}) =>
      ceilMicroseconds(precision: precision);

  @override
  CarbonInterface floorMicroseconds({double precision = 1}) =>
      roundMicroseconds(precision: precision, function: 'floor');

  @override
  CarbonInterface floorMicrosecond({double precision = 1}) =>
      floorMicroseconds(precision: precision);

  @override
  CarbonInterface roundDays({
    double precision = 1,
    String function = 'round',
  }) => _roundDurationUnit(
        const Duration(days: 1),
        precision,
        function,
      );

  @override
  CarbonInterface roundDay({double precision = 1, String function = 'round'}) =>
      roundDays(precision: precision, function: function);

  @override
  CarbonInterface ceilDays({double precision = 1}) =>
      roundDays(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilDay({double precision = 1}) =>
      ceilDays(precision: precision);

  @override
  CarbonInterface floorDays({double precision = 1}) =>
      roundDays(precision: precision, function: 'floor');

  @override
  CarbonInterface floorDay({double precision = 1}) =>
      floorDays(precision: precision);

  @override
  CarbonInterface roundCenturies({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 1200, function);

  @override
  CarbonInterface roundCentury({
    double precision = 1,
    String function = 'round',
  }) => roundCenturies(precision: precision, function: function);

  @override
  CarbonInterface ceilCenturies({double precision = 1}) =>
      roundCenturies(precision: precision, function: 'ceil');

  @override
  CarbonInterface ceilCentury({double precision = 1}) =>
      ceilCenturies(precision: precision);

  @override
  CarbonInterface floorCenturies({double precision = 1}) =>
      roundCenturies(precision: precision, function: 'floor');

  @override
  CarbonInterface floorCentury({double precision = 1}) =>
      floorCenturies(precision: precision);

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
  bool isCurrentMicrosecond() => _isCurrentUnit(_ComparisonUnit.microsecond);

  @override
  bool isCurrentMicro() => isCurrentMicrosecond();

  @override
  bool isNextMicrosecond() => _isNextUnit(_ComparisonUnit.microsecond);

  @override
  bool isNextMicro() => isNextMicrosecond();

  @override
  bool isLastMicrosecond() => _isLastUnit(_ComparisonUnit.microsecond);

  @override
  bool isLastMicro() => isLastMicrosecond();

  @override
  bool isSameMicrosecond([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.microsecond, other);

  @override
  bool isSameMicro([CarbonInterface? other]) => isSameMicrosecond(other);

  @override
  bool isCurrentMillisecond() =>
      _isCurrentUnit(_ComparisonUnit.millisecond);

  @override
  bool isCurrentMilli() => isCurrentMillisecond();

  @override
  bool isNextMillisecond() => _isNextUnit(_ComparisonUnit.millisecond);

  @override
  bool isNextMilli() => isNextMillisecond();

  @override
  bool isLastMillisecond() => _isLastUnit(_ComparisonUnit.millisecond);

  @override
  bool isLastMilli() => isLastMillisecond();

  @override
  bool isSameMillisecond([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.millisecond, other);

  @override
  bool isSameMilli([CarbonInterface? other]) => isSameMillisecond(other);

  @override
  bool isCurrentSecond() => _isCurrentUnit(_ComparisonUnit.second);

  @override
  bool isNextSecond() => _isNextUnit(_ComparisonUnit.second);

  @override
  bool isLastSecond() => _isLastUnit(_ComparisonUnit.second);

  @override
  bool isSameSecond([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.second, other);

  @override
  bool isCurrentMinute() => _isCurrentUnit(_ComparisonUnit.minute);

  @override
  bool isNextMinute() => _isNextUnit(_ComparisonUnit.minute);

  @override
  bool isLastMinute() => _isLastUnit(_ComparisonUnit.minute);

  @override
  bool isSameMinute([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.minute, other);

  @override
  bool isCurrentHour() => _isCurrentUnit(_ComparisonUnit.hour);

  @override
  bool isNextHour() => _isNextUnit(_ComparisonUnit.hour);

  @override
  bool isLastHour() => _isLastUnit(_ComparisonUnit.hour);

  @override
  bool isSameHour([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.hour, other);

  @override
  bool isCurrentDay() => _isCurrentUnit(_ComparisonUnit.day);

  @override
  bool isNextDay() => _isNextUnit(_ComparisonUnit.day);

  @override
  bool isLastDay() => _isLastUnit(_ComparisonUnit.day);

  @override
  bool isCurrentWeek() => _isCurrentUnit(_ComparisonUnit.week);

  @override
  bool isNextWeek() => _isNextUnit(_ComparisonUnit.week);

  @override
  bool isLastWeek() => _isLastUnit(_ComparisonUnit.week);

  @override
  bool isSameWeek([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.week, other);

  @override
  bool isCurrentMonth() => _isCurrentUnit(_ComparisonUnit.month);

  @override
  bool isNextMonth() => _isNextUnit(_ComparisonUnit.month);

  @override
  bool isLastMonth() => _isLastUnit(_ComparisonUnit.month);

  @override
  bool isSameMonth([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.month, other);

  @override
  bool isCurrentQuarter() => _isCurrentUnit(_ComparisonUnit.quarter);

  @override
  bool isNextQuarter() => _isNextUnit(_ComparisonUnit.quarter);

  @override
  bool isLastQuarter() => _isLastUnit(_ComparisonUnit.quarter);

  @override
  bool isSameQuarter([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.quarter, other);

  @override
  bool isCurrentYear() => _isCurrentUnit(_ComparisonUnit.year);

  @override
  bool isNextYear() => _isNextUnit(_ComparisonUnit.year);

  @override
  bool isLastYear() => _isLastUnit(_ComparisonUnit.year);

  @override
  bool isSameYear([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.year, other);

  @override
  bool isCurrentDecade() => _isCurrentUnit(_ComparisonUnit.decade);

  @override
  bool isNextDecade() => _isNextUnit(_ComparisonUnit.decade);

  @override
  bool isLastDecade() => _isLastUnit(_ComparisonUnit.decade);

  @override
  bool isSameDecade([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.decade, other);

  @override
  bool isCurrentCentury() => _isCurrentUnit(_ComparisonUnit.century);

  @override
  bool isNextCentury() => _isNextUnit(_ComparisonUnit.century);

  @override
  bool isLastCentury() => _isLastUnit(_ComparisonUnit.century);

  @override
  bool isSameCentury([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.century, other);

  @override
  bool isCurrentMillennium() =>
      _isCurrentUnit(_ComparisonUnit.millennium);

  @override
  bool isNextMillennium() => _isNextUnit(_ComparisonUnit.millennium);

  @override
  bool isLastMillennium() => _isLastUnit(_ComparisonUnit.millennium);

  @override
  bool isSameMillennium([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.millennium, other);

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
  int diffInSeconds(CarbonInterface other, {bool absolute = true}) =>
      _diffIn(const Duration(seconds: 1), other, absolute: absolute);

  @override
  int diffInWeeks(CarbonInterface other, {bool absolute = true}) =>
      _diffIn(const Duration(days: 7), other, absolute: absolute);

  @override
  int diffInMonths(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 1, absolute: absolute);

  @override
  int diffInQuarters(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 3, absolute: absolute);

  @override
  int diffInYears(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 12, absolute: absolute);

  @override
  int diffInDecades(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 120, absolute: absolute);

  @override
  int diffInCenturies(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 1200, absolute: absolute);

  @override
  int diffInMillennia(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsUnit(other, monthsPerUnit: 12000, absolute: absolute);

  @override
  int diffInDaysFloored(CarbonInterface other) =>
      _dateTime.difference(other.dateTime).inDays;

  @override
  double diffInUTCMicros([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(microseconds: 1), date,
          absolute: absolute);

  @override
  double diffInUTCMicroseconds([dynamic date, bool absolute = true]) =>
      diffInUTCMicros(date, absolute);

  @override
  double diffInUTCMillis([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(milliseconds: 1), date,
          absolute: absolute);

  @override
  double diffInUTCMilliseconds([dynamic date, bool absolute = true]) =>
      diffInUTCMillis(date, absolute);

  @override
  double diffInUTCSeconds([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(seconds: 1), date,
          absolute: absolute);

  @override
  double diffInUTCMinutes([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(minutes: 1), date,
          absolute: absolute);

  @override
  double diffInUTCHours([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(hours: 1), date,
          absolute: absolute);

  @override
  double diffInUTCDays([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(days: 1), date,
          absolute: absolute);

  @override
  double diffInUTCWeeks([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(days: 7), date,
          absolute: absolute);

  @override
  double diffInUTCMonths([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, absolute: absolute);

  @override
  double diffInUTCQuarters([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, monthsPerUnit: 3, absolute: absolute);

  @override
  double diffInUTCYears([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, monthsPerUnit: 12, absolute: absolute);

  @override
  double diffInUTCDecades([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, monthsPerUnit: 120, absolute: absolute);

  @override
  double diffInUTCCenturies([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, monthsPerUnit: 1200, absolute: absolute);

  @override
  double diffInUTCMillennia([dynamic date, bool absolute = true]) =>
      _diffInUTCByMonths(date, monthsPerUnit: 12000, absolute: absolute);

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
  String longAbsoluteDiffForHumans([CarbonInterface? other]) =>
      diffForHumans(reference: other);

  @override
  String longRelativeDiffForHumans([CarbonInterface? other]) =>
      diffForHumans(reference: other);

  @override
  String longRelativeToNowDiffForHumans() => diffForHumans();

  @override
  String longRelativeToOtherDiffForHumans(CarbonInterface other) =>
      diffForHumans(reference: other);

  @override
  String shortAbsoluteDiffForHumans([CarbonInterface? other]) =>
      diffForHumans(reference: other);

  @override
  String shortRelativeDiffForHumans([CarbonInterface? other]) =>
      diffForHumans(reference: other);

  @override
  String shortRelativeToNowDiffForHumans() => diffForHumans();

  @override
  String shortRelativeToOtherDiffForHumans(CarbonInterface other) =>
      diffForHumans(reference: other);

  @override
  bool get isMutable => _isMutable;

  @override
  bool get isLocal => _timeZone == null;

  @override
  bool get isUtc => _timeZone == 'UTC';

  @override
  bool get isValid => true;

  @override
  bool isDST() {
    final snapshot = _zoneSnapshot();
    return snapshot?.isDst ?? false;
  }

  @override
  bool isMonday() => _dateTime.weekday == DateTime.monday;

  @override
  bool isTuesday() => _dateTime.weekday == DateTime.tuesday;

  @override
  bool isWednesday() => _dateTime.weekday == DateTime.wednesday;

  @override
  bool isThursday() => _dateTime.weekday == DateTime.thursday;

  @override
  bool isFriday() => _dateTime.weekday == DateTime.friday;

  @override
  bool isSaturday() => _dateTime.weekday == DateTime.saturday;

  @override
  bool isSunday() => _dateTime.weekday == DateTime.sunday;

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

  CarbonInterface _applyTemporalUnit(
    _TemporalUnit unit,
    int amount,
    bool? overflow,
  ) {
    if (unit.months != null) {
      final months = amount * unit.months!;
      return _wrap(_addMonths(_dateTime, months, monthOverflow: overflow));
    }
    final micros = amount * unit.microseconds!;
    return _wrap(_dateTime.add(Duration(microseconds: micros)));
  }

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
        isDst: false,
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
      abbreviation:
          zoneInterval.name.isNotEmpty ? zoneInterval.name : zone.id,
      offset: Duration(seconds: zoned.offset.inSeconds),
      isDst: zoneInterval.savings != tm.Offset.zero,
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
    final aliasResult = _invokeAlias(this, name, invocation);
    if (!identical(aliasResult, _aliasNotHandled)) {
      return aliasResult;
    }
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

  DateTime _copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) => DateTime.utc(
    year ?? _dateTime.year,
    month ?? _dateTime.month,
    day ?? _dateTime.day,
    hour ?? _dateTime.hour,
    minute ?? _dateTime.minute,
    second ?? _dateTime.second,
    millisecond ?? _dateTime.millisecond,
    microsecond ?? _dateTime.microsecond,
  );

  int _wrapModulo(int value, int modulus) {
    final result = value % modulus;
    return result < 0 ? result + modulus : result;
  }

  DateTime _coerceToDateTime(dynamic input) {
    if (input == null) {
      return clock.now().toUtc();
    }
    if (input is CarbonInterface) {
      return input.dateTime;
    }
    if (input is DateTime) {
      return input.isUtc ? input : input.toUtc();
    }
    if (input is String || input is num) {
      return Carbon.parse(input).dateTime;
    }
    throw ArgumentError('Unsupported endDate type: ${input.runtimeType}');
  }

  CarbonPeriod _buildPeriod(
    DateTime target, {
    int? monthStep,
    Duration? durationStep,
  }) {
    assert((monthStep != null) ^ (durationStep != null));
    final forward = !target.isBefore(_dateTime);
    final items = <Carbon>[];
    var cursor = _dateTime;
    const maxIterations = 10000;
    for (var i = 0; i < maxIterations; i++) {
      if (forward ? cursor.isAfter(target) : cursor.isBefore(target)) {
        break;
      }
      items.add(
        Carbon.fromDateTime(cursor, locale: _locale, settings: _settings),
      );
      DateTime next;
      if (monthStep != null) {
        next = _addMonths(cursor, forward ? monthStep : -monthStep);
      } else {
        final delta = durationStep!;
        final micro = delta.inMicroseconds * (forward ? 1 : -1);
        next = cursor.add(Duration(microseconds: micro));
      }
      if (next.isAtSameMomentAs(cursor)) {
        break;
      }
      cursor = next;
    }
    return CarbonPeriod._(items);
  }

  int _weekIndex(DateTime origin, DateTime current) {
    final days = current.difference(origin).inDays;
    return (days ~/ 7) + 1;
  }

  int _weeksBetween(DateTime start, DateTime endExclusive) {
    final days = endExclusive.difference(start).inDays;
    return (days / 7).ceil();
  }

  int _secondsBetween(DateTime start, DateTime endExclusive) =>
      endExclusive.difference(start).inSeconds;

  int _secondsSince(DateTime anchor) => _dateTime.difference(anchor).inSeconds;

  int _minutesSince(DateTime anchor) => _dateTime.difference(anchor).inMinutes;

  int _hoursSince(DateTime anchor) => _dateTime.difference(anchor).inHours;

  int _daysSince(DateTime anchor) => _dateTime.difference(anchor).inDays;

  int _millisecondsSince(DateTime anchor) =>
      _dateTime.difference(anchor).inMilliseconds;

  int _microsecondsSince(DateTime anchor) =>
      _dateTime.difference(anchor).inMicroseconds;

  int _daysBetween(DateTime start, DateTime endExclusive) =>
      endExclusive.difference(start).inDays;

  CarbonInterface _roundDurationUnit(
    Duration unit,
    double precision,
    String function,
  ) {
    final normalized = _normalizePrecision(precision);
    if (normalized == null) {
      return this;
    }
    final stepMicros = unit.inMicroseconds * normalized;
    if (stepMicros == 0) {
      return this;
    }
    final current = _dateTime.microsecondsSinceEpoch.toDouble();
    final quotient = current / stepMicros;
    final rounded = _applyRoundFunction(quotient, function) * stepMicros;
    final micros = rounded.round();
    final roundedDate = DateTime.fromMicrosecondsSinceEpoch(
      micros,
      isUtc: true,
    );
    return _wrap(roundedDate);
  }

  CarbonInterface _roundMonthUnit(double precisionInMonths, String function) {
    final normalized = _normalizePrecision(precisionInMonths);
    if (normalized == null) {
      return this;
    }
    final value = _monthPosition(_dateTime);
    final quotient = value / normalized;
    final rounded = _applyRoundFunction(quotient, function) * normalized;
    final date = _dateFromMonthPosition(rounded);
    return _wrap(date);
  }

  double? _normalizePrecision(double precision) {
    if (precision.isNaN) {
      return 1.0;
    }
    if (!precision.isFinite) {
      return null;
    }
    final normalized = precision == 0 ? 1.0 : precision.abs();
    return normalized;
  }

  double _applyRoundFunction(double value, String function) {
    switch (function.toLowerCase()) {
      case 'ceil':
        return value.ceilToDouble();
      case 'floor':
        return value.floorToDouble();
      default:
        return value.roundToDouble();
    }
  }

  DateTime _dateFromMonthPosition(double position) {
    final floorValue = position.floor();
    final fraction = position - floorValue;
    final monthIndex = floorValue.toInt();
    var year = monthIndex ~/ 12;
    var monthWithinYear = monthIndex % 12;
    if (monthWithinYear < 0) {
      monthWithinYear += 12;
      year -= 1;
    }
    final monthNumber = monthWithinYear + 1;
    final monthStart = DateTime.utc(year, monthNumber, 1);
    final nextMonth = DateTime.utc(year, monthNumber + 1, 1);
    final span = nextMonth.difference(monthStart).inMicroseconds;
    final offset = (fraction * span).round();
    return monthStart.add(Duration(microseconds: offset));
  }

  double _diffInUTCByDuration(
    Duration unit,
    dynamic other, {
    bool absolute = true,
  }) {
    final target = _coerceToDateTime(other);
    final diff = _dateTime.difference(target);
    final value = diff.inMicroseconds / unit.inMicroseconds;
    return absolute ? value.abs() : value;
  }

  double _diffInUTCByMonths(
    dynamic other, {
    int monthsPerUnit = 1,
    bool absolute = true,
  }) {
    final target = _coerceToDateTime(other);
    final months = _monthPosition(_dateTime) - _monthPosition(target);
    final value = months / monthsPerUnit;
    return absolute ? value.abs() : value;
  }

  int _diffInMonthsUnit(
    CarbonInterface other, {
    int monthsPerUnit = 1,
    bool absolute = true,
  }) {
    final months = (_monthPosition(_dateTime) - _monthPosition(other.dateTime)) /
        monthsPerUnit;
    final truncated = months.truncate();
    return absolute ? truncated.abs() : truncated;
  }

  double _monthPosition(DateTime value) {
    final start = DateTime.utc(value.year, value.month, 1);
    final end = DateTime.utc(value.year, value.month + 1, 1);
    final span = end.difference(start).inMicroseconds;
    if (span == 0) {
      return (value.year * 12 + (value.month - 1)).toDouble();
    }
    final offset = value.difference(start).inMicroseconds;
    return (value.year * 12 + (value.month - 1)) + offset / span;
  }

  bool _isSameUnit(
    DateTime first,
    DateTime second,
    _ComparisonUnit unit,
  ) =>
      _startOfUnit(first, unit).isAtSameMomentAs(
        _startOfUnit(second, unit),
      );

  bool _isCurrentUnit(_ComparisonUnit unit) =>
      _isSameUnit(_dateTime, _nowUtc(), unit);

  bool _isNextUnit(_ComparisonUnit unit) => _isSameUnit(
        _dateTime,
        _addComparisonUnit(_nowUtc(), unit, 1),
        unit,
      );

  bool _isLastUnit(_ComparisonUnit unit) => _isSameUnit(
        _dateTime,
        _addComparisonUnit(_nowUtc(), unit, -1),
        unit,
      );

  bool _isSameUnitWithTarget(
    _ComparisonUnit unit,
    CarbonInterface? other,
  ) => _isSameUnit(_dateTime, _resolveComparisonTarget(other), unit);

  DateTime _resolveComparisonTarget(CarbonInterface? other) =>
      other?.dateTime ?? _nowUtc();

  DateTime _nowUtc() => clock.now().toUtc();

  DateTime _startOfUnit(DateTime value, _ComparisonUnit unit) {
    switch (unit) {
      case _ComparisonUnit.microsecond:
        return value;
      case _ComparisonUnit.millisecond:
        return DateTime.utc(
          value.year,
          value.month,
          value.day,
          value.hour,
          value.minute,
          value.second,
          value.millisecond,
        );
      case _ComparisonUnit.second:
        return DateTime.utc(
          value.year,
          value.month,
          value.day,
          value.hour,
          value.minute,
          value.second,
        );
      case _ComparisonUnit.minute:
        return DateTime.utc(
          value.year,
          value.month,
          value.day,
          value.hour,
          value.minute,
        );
      case _ComparisonUnit.hour:
        return DateTime.utc(value.year, value.month, value.day, value.hour);
      case _ComparisonUnit.day:
        return DateTime.utc(value.year, value.month, value.day);
      case _ComparisonUnit.week:
        return _weekStart(value);
      case _ComparisonUnit.month:
        return DateTime.utc(value.year, value.month, 1);
      case _ComparisonUnit.quarter:
        return _quarterStart(value);
      case _ComparisonUnit.year:
        return DateTime.utc(value.year, 1, 1);
      case _ComparisonUnit.decade:
        return _decadeStart(value);
      case _ComparisonUnit.century:
        return _centuryStart(value);
      case _ComparisonUnit.millennium:
        return _millenniumStart(value);
    }
  }

  DateTime _addComparisonUnit(
    DateTime value,
    _ComparisonUnit unit,
    int amount,
  ) {
    if (amount == 0) {
      return value;
    }
    switch (unit) {
      case _ComparisonUnit.microsecond:
        return value.add(Duration(microseconds: amount));
      case _ComparisonUnit.millisecond:
        return value.add(Duration(milliseconds: amount));
      case _ComparisonUnit.second:
        return value.add(Duration(seconds: amount));
      case _ComparisonUnit.minute:
        return value.add(Duration(minutes: amount));
      case _ComparisonUnit.hour:
        return value.add(Duration(hours: amount));
      case _ComparisonUnit.day:
        return value.add(Duration(days: amount));
      case _ComparisonUnit.week:
        return value.add(Duration(days: amount * 7));
      case _ComparisonUnit.month:
        return _addMonths(value, amount);
      case _ComparisonUnit.quarter:
        return _addMonths(value, amount * 3);
      case _ComparisonUnit.year:
        return _addMonths(value, amount * 12);
      case _ComparisonUnit.decade:
        return _addMonths(value, amount * 120);
      case _ComparisonUnit.century:
        return _addMonths(value, amount * 1200);
      case _ComparisonUnit.millennium:
        return _addMonths(value, amount * 12000);
    }
  }

  DateTime _quarterStart(DateTime dateTime) {
    final quarter = ((dateTime.month - 1) ~/ 3) * 3 + 1;
    return DateTime.utc(dateTime.year, quarter, 1);
  }

  DateTime _weekStart(DateTime dateTime) {
    final startOfWeek = _settings.startOfWeek;
    final normalized = ((dateTime.weekday - startOfWeek) + 7) % 7;
    return DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    ).subtract(Duration(days: normalized));
  }

  DateTime _decadeStart(DateTime dateTime) {
    final decade = (dateTime.year ~/ 10) * 10;
    return DateTime.utc(decade, 1, 1);
  }

  DateTime _centuryStart(DateTime dateTime) {
    final century = ((dateTime.year - 1) ~/ 100) * 100 + 1;
    return DateTime.utc(century, 1, 1);
  }

  DateTime _millenniumStart(DateTime dateTime) {
    final millennium = ((dateTime.year - 1) ~/ 1000) * 1000 + 1;
    return DateTime.utc(millennium, 1, 1);
  }
}

enum _ComparisonUnit {
  microsecond,
  millisecond,
  second,
  minute,
  hour,
  day,
  week,
  month,
  quarter,
  year,
  decade,
  century,
  millennium,
}

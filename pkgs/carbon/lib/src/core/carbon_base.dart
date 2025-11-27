/// Shared implementation for [Carbon] and [CarbonImmutable], covering
/// calendar math, timezone helpers, and macro registration.
///
/// ```dart
/// CarbonBase.setDefaultLocale('es');
/// ```
part of '../carbon.dart';

const Object _handledPropertyMacro = Object();

/// Callback to generate a test "now" value dynamically.
///
/// Used by [Carbon.setTestNow] when testing code that depends on the current time.
/// Signature used for custom "now" generators during tests.
typedef CarbonTestNowGenerator =
    CarbonInterface Function(CarbonInterface current);

/// Abstract foundation shared by [Carbon] and [CarbonImmutable].
///
/// Provides all common logic for calendar math, comparisons, and formatting.
/// Subclasses implement mutability semantics (in-place vs. new objects).
abstract class CarbonBase implements CarbonInterface {
  /// Creates a Carbon base instance with UTC conversion and defaults.
  CarbonBase({
    required DateTime dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) : _dateTime = dateTime.toUtc(),
       _locale = locale ?? _defaultLocale,
       _timeZone = timeZone,
       _settings = settings ?? _defaultSettings;
  DateTime _dateTime;
  String _locale;
  String? _timeZone;
  CarbonSettings _settings;

  static final Map<String, CarbonMacro> _macros = <String, CarbonMacro>{};
  static tm.DateTimeZoneProvider? _zoneProvider;
  static final Map<String, tm.DateTimeZone> _zoneCache =
      <String, tm.DateTimeZone>{};
  static bool _timeMachineInitialized = false;
  static bool _strictMode = true;
  static final Map<String, String Function(CarbonInterface)>
  _isoFormatOverrides = <String, String Function(CarbonInterface)>{};
  static final RegExp _fixedOffsetPattern = RegExp(
    r'^[+-](\d{2})(?::?(\d{2}))?$',
  );
  static String _defaultLocale = 'en';
  static CarbonSettings _defaultSettings = const CarbonSettings();
  static CarbonInterface? _testNow;
  static List<int> _weekendDays = <int>[DateTime.saturday, DateTime.sunday];
  static CarbonTestNowGenerator? _testNowGenerator;
  static String Function(CarbonInterface)? _customToStringFormat;
  String Function(CarbonInterface)? _instanceToStringFormat;
  static const int _serializationVersion = 1;
  static const String _serializationTypeMutable = 'carbon';
  static const String _serializationTypeImmutable = 'carbon_immutable';
  static CarbonLastErrors? _lastErrors;
  static final RegExp _isoCalendarPrefixPattern = RegExp(
    r'^\s*([+-]?\d{1,6})-(\d{2})-(\d{2})',
  );
  static const String _invalidDateWarningMessage =
      'The parsed date was invalid';
  static final RegExp _explicitTimezonePattern = RegExp(
    r'(Z|[+-]\d{2}:?\d{2}|\b(?:UTC|GMT)\b|[A-Za-z]+/[A-Za-z_]+)',
    caseSensitive: false,
  );
  static final RegExp _hourLiteralPattern = RegExp(
    r'(\d)h$',
    caseSensitive: false,
  );
  static final RegExp _yearMonthPattern = RegExp(r'^(\d{3,})-(\d{1,2})$');
  static final RegExp _fullDatePattern = RegExp(
    r'^(\d{4})-(\d{1,2})-(\d{1,2})$',
  );
  static final RegExp _monthDayPattern = RegExp(r'^(\d{1,2})-(\d{1,2})$');
  static final RegExp _timeWithSecondsPattern = RegExp(
    r'^(\d{1,2}):(\d{1,2}):(\d{1,2})$',
  );
  static final RegExp _timeWithMinutesPattern = RegExp(
    r'^(\d{1,2}):(\d{1,2})$',
  );
  static final RegExp _timeHourPattern = RegExp(
    r'^(\d{1,2})(?:h|am|pm)$',
    caseSensitive: false,
  );
  static final RegExp _monthNamePattern = RegExp(
    r'^(jan(?:uary)?|feb(?:ruary)?|mar(?:ch)?|apr(?:il)?|may|jun(?:e)?|jul(?:y)?|aug(?:ust)?|sep(?:tember)?|oct(?:ober)?|nov(?:ember)?|dec(?:ember)?)(?:\s+\d+)?$',
    caseSensitive: false,
  );
  Map<String, dynamic>? _dynamicProperties;

  void _copyInstanceFormatterTo(CarbonBase target) {
    target._instanceToStringFormat = _instanceToStringFormat;
  }

  static String? _runIsoFormatOverride(String token, CarbonBase carbon) {
    final formatter = _isoFormatOverrides[token];
    if (formatter == null) {
      return null;
    }
    try {
      return formatter(carbon);
    } catch (_) {
      return '';
    }
  }

  bool get _isMutable => this is Carbon;

  @override
  DateTime get dateTime => _dateTime;

  @override
  String get localeCode => _locale;

  @override
  String? get timeZoneName => _timeZone;

  @override
  CarbonSettings get settings => _settings;

  @override
  CarbonLastErrors? getLastErrors() => CarbonBase.lastErrorsSnapshot();

  /// Registers a PHP-style macro callable that can be invoked dynamically.
  static void registerMacro(String name, CarbonMacro macro) =>
      _macros[name] = macro;

  /// Removes a previously registered macro.
  static void unregisterMacro(String name) => _macros.remove(name);

  /// Returns true when a macro has been registered.
  static bool hasMacro(String name) => _macros.containsKey(name);

  /// Clears all registered macros (primarily for tests).
  static void resetMacros() => _macros.clear();

  /// Invokes a registered macro by [name], returning null when strict mode is
  /// disabled and the macro is missing.
  dynamic carbon(
    String name, [
    List<dynamic> positionalArguments = const <dynamic>[],
    Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{},
  ]) {
    final macro = _macros[name];
    if (macro == null) {
      if (_strictMode) {
        throw CarbonUnknownMethodException(name);
      }
      return null;
    }
    return macro(this, positionalArguments, namedArguments);
  }

  /// Resets global locale/start-of-week/test-now defaults.
  static void resetDefaults() {
    _defaultLocale = 'en';
    _defaultSettings = const CarbonSettings();
    _testNow = null;
    _weekendDays = <int>[DateTime.saturday, DateTime.sunday];
    _weekendOverridden = false;
    _startOfWeekOverridden = false;
    _applyLocaleDefaults(_defaultLocale);
  }

  /// Most recent parsing/creation report, or null when nothing executed yet.
  static CarbonLastErrors? lastErrorsSnapshot() => _lastErrors;

  /// Records the latest parsing/creation outcome.
  static void setLastErrors([CarbonLastErrors? errors]) {
    _lastErrors = errors ?? const CarbonLastErrors.empty();
  }

  /// Clears the last error snapshot so subsequent calls return null.
  static void resetLastErrors() {
    _lastErrors = null;
  }

  /// Enables named timezone support via [time_machine](https://pub.dev).
  ///
  /// Must be called before using `.tz('America/New_York')` with real zone
  /// identifiers. Pass a custom [provider] to override the TZ database.
  static Future<void> configureTimeMachine({
    tm.DateTimeZoneProvider? provider,
    bool testing = true,
  }) async {
    if (!_timeMachineInitialized) {
      // CRITICAL: On web, timezone data must be explicitly loaded
      // This flag ensures all timezone information is loaded, not just the index
      // ignore: invalid_use_of_internal_member
      ITzdbDateTimeZoneSource.loadAllTimeZoneInformation_SetFlag();
      await tm.TimeMachine.initialize({'testing': testing});
      _timeMachineInitialized = true;
    }
    // Always use tzdb provider as it works consistently on both VM and web
    _zoneProvider = provider ?? await tm.DateTimeZoneProviders.tzdb;
    _zoneCache.clear();
  }

  /// Clears the timezone provider/cache configured via [configureTimeMachine].
  static void resetTimeMachine() {
    _zoneProvider = null;
    _zoneCache.clear();
  }

  /// Enables PHP-style strict mode (throws on invalid operations).
  static void useStrictMode(bool enabled) => _strictMode = enabled;

  /// Current strictness flag.
  static bool get strictMode => _strictMode;

  /// Updates the process-wide default locale.
  static void setDefaultLocale(String locale) {
    _defaultLocale = locale;
    _applyLocaleDefaults(locale);
  }

  static String get defaultLocale => _defaultLocale;

  /// Overrides the global start-of-week for new instances.
  static void setWeekStartsAt(int day) {
    _startOfWeekOverridden = true;
    final normalized = _normalizeWeekday(day);
    _defaultSettings = _defaultSettings.copyWith(startOfWeek: normalized);
  }

  /// Settings applied to factories that omit an explicit [CarbonSettings].
  static CarbonSettings get defaultSettings => _defaultSettings;

  /// Current weekend definition.
  static List<int> get weekendDays => List.unmodifiable(_weekendDays);

  /// Overrides which weekdays count as the weekend.
  static void setWeekendDays(List<int> days) {
    if (days.isEmpty) {
      throw ArgumentError('Weekend days cannot be empty');
    }
    _weekendDays = days.map(_normalizeWeekday).toSet().toList()..sort();
    _weekendOverridden = true;
  }

  /// Resets weekend defaults back to the locale-provided values.
  static void resetWeekendDays() {
    _weekendOverridden = false;
    _applyLocaleDefaults(_defaultLocale);
  }

  static bool _weekendOverridden = false;
  static bool _startOfWeekOverridden = false;

  static void setToStringFormat(dynamic formatter) {
    _customToStringFormat = _normalizeToStringFormatter(formatter);
  }

  static void resetToStringFormat() => _customToStringFormat = null;

  static String Function(CarbonInterface)? _normalizeToStringFormatter(
    dynamic formatter,
  ) {
    if (formatter == null) {
      return null;
    }
    if (formatter is String) {
      return (carbon) => carbon.format(formatter);
    }
    if (formatter is String Function(CarbonInterface)) {
      return formatter;
    }
    if (formatter is String Function(Carbon)) {
      return (value) => formatter(value is Carbon ? value : value.toMutable());
    }
    if (formatter is String Function(CarbonImmutable)) {
      return (value) =>
          formatter(value is CarbonImmutable ? value : value.toImmutable());
    }
    if (formatter is String Function()) {
      return (_) => formatter();
    }
    if (formatter is String Function(Object?)) {
      return (value) => formatter(value);
    }
    if (formatter is Function) {
      return (value) {
        final result = Function.apply(formatter, [value]);
        if (result is! String) {
          throw ArgumentError(
            'setToStringFormat callbacks must return a String.',
          );
        }
        return result;
      };
    }
    throw ArgumentError(
      'setToStringFormat expects a String or a CarbonInterface -> String callback.',
    );
  }

  static bool hasTestNow() => _testNow != null || _testNowGenerator != null;

  static CarbonInterface? get testNow => _resolveTestNow();

  static void setTestNow([dynamic value]) {
    if (value == null || value == false) {
      _testNow = null;
      _testNowGenerator = null;
      return;
    }
    if (value is CarbonInterface Function(CarbonInterface)) {
      _testNowGenerator = value;
      _testNow = null;
      return;
    }
    if (value is CarbonInterface Function(Carbon)) {
      _testNowGenerator = (current) => value(current.toMutable());
      _testNow = null;
      return;
    }
    if (value is CarbonInterface Function()) {
      _testNowGenerator = (_) => value();
      _testNow = null;
      return;
    }
    _testNowGenerator = null;
    _testNow = _coerceTestNow(value).toImmutable();
  }

  /// Registers a custom isoFormat token formatter (mirrors PHP's getIsoUnits overrides).
  static void registerIsoFormatToken(
    String token,
    String Function(CarbonInterface) formatter,
  ) {
    if (token.isEmpty) {
      throw ArgumentError('Token cannot be empty.');
    }
    _isoFormatOverrides[token] = formatter;
  }

  /// Removes a previously registered isoFormat token formatter.
  static bool unregisterIsoFormatToken(String token) =>
      _isoFormatOverrides.remove(token) != null;

  /// Clears every registered isoFormat override.
  static void resetIsoFormatTokens() => _isoFormatOverrides.clear();

  static void setTestNowAndTimezone(dynamic value, {String? timeZone}) {
    if (value == null || value == false) {
      setTestNow(null);
      return;
    }
    final resolved = _coerceTestNow(value);
    final targetZone = timeZone ?? resolved.timeZoneName;
    if (targetZone != null && resolved.timeZoneName != targetZone) {
      _testNow = resolved.copyWith(timeZone: targetZone).toImmutable();
    } else {
      _testNow = resolved.toImmutable();
    }
    _testNowGenerator = null;
  }

  static T withTestNow<T>(dynamic value, T Function() callback) {
    final previous = _testNow;
    final previousGenerator = _testNowGenerator;
    setTestNow(value);
    try {
      return callback();
    } finally {
      _testNow = previous;
      _testNowGenerator = previousGenerator;
    }
  }

  static CarbonInterface? _resolveTestNow({String? timeZone}) {
    CarbonInterface? reference;
    if (_testNowGenerator != null) {
      final base = _buildNowInstance(timeZone: timeZone);
      reference = _testNowGenerator!(base);
    } else {
      reference = _testNow;
    }
    if (reference == null) {
      return null;
    }
    var snapshot = reference.toImmutable();
    if (timeZone != null && snapshot.timeZoneName != timeZone) {
      snapshot = snapshot.copyWith(timeZone: timeZone).toImmutable();
    }
    return snapshot;
  }

  static CarbonInterface _coerceTestNow(dynamic value) {
    if (value is CarbonInterface) {
      return value;
    }
    if (value is DateTime) {
      return Carbon.fromDateTime(value);
    }
    if (value is String) {
      return Carbon.parse(value);
    }
    if (value is num) {
      return Carbon.createFromTimestamp(value);
    }
    throw ArgumentError('Unsupported testNow type `${value.runtimeType}`');
  }

  static Carbon _buildNowInstance({String? timeZone}) => Carbon._internal(
    dateTime: clock.now().toUtc(),
    locale: _defaultLocale,
    timeZone: timeZone,
    settings: _defaultSettings,
  );

  static bool hasRelativeKeywords(String? input) {
    if (input == null) {
      return false;
    }
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    final baselineA = Carbon._fromUtc(DateTime.utc(2000, 1, 1));
    final parsedA = Carbon._parseRelativeString(trimmed, base: baselineA);
    if (parsedA == null) {
      return false;
    }
    final baselineB = Carbon._fromUtc(DateTime.utc(2001, 12, 25));
    final parsedB = Carbon._parseRelativeString(trimmed, base: baselineB);
    if (parsedB == null) {
      return false;
    }
    return !parsedA.dateTime.isAtSameMomentAs(parsedB.dateTime);
  }

  static bool hasIsoRelativeKeywords(String? pattern, {String? locale}) {
    if (pattern == null || pattern.isEmpty) {
      return false;
    }
    final trimmed = pattern.trim();
    if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
      final inner = trimmed.substring(1, trimmed.length - 1);
      if (!inner.contains(']')) {
        return false;
      }
    }
    final expanded = _expandIsoPresetTokens(pattern, locale ?? _defaultLocale);
    var i = 0;
    var escaped = false;
    var inLiteral = false;
    while (i < expanded.length) {
      final char = expanded[i];
      if (escaped) {
        escaped = false;
        i++;
        continue;
      }
      if (char == '\\') {
        escaped = true;
        i++;
        continue;
      }
      if (char == '[' && !inLiteral) {
        inLiteral = true;
        i++;
        continue;
      }
      if (char == ']' && inLiteral) {
        inLiteral = false;
        i++;
        continue;
      }
      if (inLiteral) {
        i++;
        continue;
      }
      final remaining = expanded.substring(i);
      final match = _isoTokenRegex.firstMatch(remaining);
      if (match != null && match.start == 0) {
        return true;
      }
      i++;
    }
    return false;
  }

  static Duration? _parseFixedOffset(String zone) {
    final match = _fixedOffsetPattern.firstMatch(zone);
    if (match == null) {
      return null;
    }
    final hours = int.parse(match.group(1)!);
    final minutes = match.group(2) == null ? 0 : int.parse(match.group(2)!);
    Duration offset = Duration(hours: hours, minutes: minutes);
    if (zone.startsWith('-')) {
      offset = -offset;
    }
    return offset;
  }

  static DateTime _localDateTimeUtc(DateTime local, {String? timeZone}) {
    if (timeZone == null || timeZone == 'UTC') {
      return DateTime.utc(
        local.year,
        local.month,
        local.day,
        local.hour,
        local.minute,
        local.second,
        local.millisecond,
        local.microsecond,
      );
    }
    return _localToUtc(
      year: local.year,
      month: local.month,
      day: local.day,
      hour: local.hour,
      minute: local.minute,
      second: local.second,
      microsecond: local.microsecond,
      timeZone: timeZone,
    );
  }

  static void _applyLocaleDefaults(String? locale) {
    if (locale == null) {
      return;
    }
    final segments = _localeCandidates(locale);

    if (!_weekendOverridden) {
      var applied = false;
      for (final key in segments) {
        final weekend = kLocaleWeekendDefaults[key];
        if (weekend != null) {
          _weekendDays = weekend.toSet().toList()..sort();
          applied = true;
          break;
        }
      }
      if (!applied) {
        _weekendDays = <int>[DateTime.saturday, DateTime.sunday];
      }
    }

    if (!_startOfWeekOverridden) {
      final start = _weekStartForLocale(locale);
      if (start != null) {
        _defaultSettings = _defaultSettings.copyWith(startOfWeek: start);
      }
    }
  }

  static List<String> _localeCandidates(String locale) {
    final normalized = locale.toLowerCase().replaceAll('-', '_');
    final seen = <String>{};
    final result = <String>[];
    final queue = <String>[];
    void enqueue(String value) {
      if (value.isEmpty) return;
      if (seen.add(value)) {
        queue.add(value);
      }
    }

    enqueue(normalized);
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      result.add(current);
      final dot = current.indexOf('.');
      if (dot != -1) {
        enqueue(current.substring(0, dot));
      }
      final at = current.indexOf('@');
      if (at != -1) {
        enqueue(current.substring(0, at));
      }
      final underscore = current.lastIndexOf('_');
      if (underscore != -1) {
        enqueue(current.substring(0, underscore));
      }
    }
    return result;
  }

  static int? _weekStartForLocale(String? locale) {
    if (locale == null) {
      return null;
    }

    for (final candidate in _localeCandidates(locale)) {
      final start = kLocaleWeekStartDefaults[candidate];
      if (start != null) {
        return start;
      }
    }
    return null;
  }

  DateTime _localDateTimeForFormatting() {
    final zone = _timeZone;
    if (zone == null || zone == 'UTC') {
      return _dateTime.toUtc();
    }
    return _utcToLocal(_dateTime, zone);
  }

  Duration _currentOffset() {
    final zone = _timeZone;
    if (zone == null || zone == 'UTC') {
      return Duration.zero;
    }
    final fixed = _parseFixedOffset(zone);
    if (fixed != null) {
      return fixed;
    }
    final snapshot = _zoneSnapshot();
    if (snapshot != null) {
      return snapshot.offset;
    }
    return Duration.zero;
  }

  Duration _offsetForZone(String zoneName, DateTime referenceUtc) {
    final fixed = _parseFixedOffset(zoneName);
    if (fixed != null) {
      return fixed;
    }
    _ensureZoneProvider(zoneName);
    final zone = _getZoneOrThrow(zoneName);
    final instant = tm.Instant.dateTime(referenceUtc);
    final zoned = instant.inZone(zone);
    return Duration(seconds: zoned.offset.inSeconds);
  }

  String _formatIso(DateTime value, {Duration? offset, bool suffix = true}) {
    final date = _formatDatePart(value);
    final time = _formatTimePart(value);
    final micros = _fractionalMicroseconds(value, reference: _dateTime);
    final fraction = _formatIsoFraction(micros);
    final suffixText = suffix ? 'Z' : _formatOffset(offset ?? Duration.zero);
    final buffer = StringBuffer()
      ..write(date)
      ..write('T')
      ..write(time)
      ..write(fraction)
      ..write(suffixText);
    return buffer.toString();
  }

  static DateTime _utcToLocal(DateTime utc, String zoneName) {
    final fixed = _parseFixedOffset(zoneName);
    if (fixed != null) {
      return utc.add(fixed);
    }
    _ensureZoneProvider(zoneName);
    final zone = _getZoneOrThrow(zoneName);
    final zoned = tm.Instant.dateTime(utc).inZone(zone);
    return zoned.localDateTime.toDateTimeLocal();
  }

  static void _ensureZoneProvider(String zoneName) {
    if (_zoneProvider == null) {
      throw StateError(
        'Named timezone "$zoneName" requires calling Carbon.configureTimeMachine() first.',
      );
    }
  }

  static DateTime _localToUtc({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required int second,
    required int microsecond,
    String? timeZone,
  }) {
    final localUtc = DateTime.utc(
      year,
      month,
      day,
      hour,
      minute,
      second,
      0,
      microsecond,
    );
    if (timeZone == null || timeZone == 'UTC') {
      return localUtc;
    }
    final fixedOffset = _parseFixedOffset(timeZone);
    if (fixedOffset != null) {
      return localUtc.subtract(fixedOffset);
    }
    _ensureZoneProvider(timeZone);
    final zone = _getZoneOrThrow(timeZone);
    var localDateTime = tm.LocalDateTime(
      year,
      month,
      day,
      hour,
      minute,
      second,
      us: microsecond,
    );
    final mapping = zone.mapLocal(localDateTime);
    if (mapping.count == 0) {
      throw StateError(
        'Local time $localDateTime is not valid in timezone $timeZone',
      );
    }
    final tm.ZonedDateTime zoned = mapping.first();
    return zoned.toInstant().toDateTimeUtc();
  }

  static void _requireZoneAvailability(String? timeZone) {
    if (timeZone == null || timeZone == 'UTC') {
      return;
    }
    if (_parseFixedOffset(timeZone) != null) {
      return;
    }
    _ensureZoneProvider(timeZone);
  }

  static DateTime _startOfDayUtcForZone(
    DateTime baseUtc, {
    String? timeZone,
    int dayOffset = 0,
  }) {
    if (timeZone == null || timeZone == 'UTC') {
      final midnight = DateTime.utc(
        baseUtc.year,
        baseUtc.month,
        baseUtc.day,
      ).add(Duration(days: dayOffset));
      return midnight;
    }
    final local = _utcToLocal(baseUtc, timeZone);
    final localMidnight = DateTime(
      local.year,
      local.month,
      local.day,
    ).add(Duration(days: dayOffset));
    return _localToUtc(
      year: localMidnight.year,
      month: localMidnight.month,
      day: localMidnight.day,
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      timeZone: timeZone,
    );
  }

  CarbonInterface _wrap(DateTime value) {
    final normalized = value.toUtc();
    if (_isMutable) {
      _dateTime = normalized;
      return this;
    }
    final clone = CarbonImmutable._internal(
      dateTime: normalized,
      locale: _locale,
      timeZone: _timeZone,
      settings: _settings,
    );
    _copyInstanceFormatterTo(clone);
    return clone;
  }

  CarbonInterface _matchMutability(CarbonInterface candidate) =>
      _isMutable ? candidate.toMutable() : candidate.toImmutable();

  @override
  String toString() {
    final instanceFormatter = _instanceToStringFormat;
    if (instanceFormatter != null) {
      return instanceFormatter(this);
    }
    final custom = _customToStringFormat;
    if (custom != null) {
      return custom(this);
    }
    return toDateTimeString();
  }

  @override
  String toLegacyString() {
    final local = _localDateTimeForFormatting();
    final localeData = CarbonTranslator.matchLocale('en');
    final weekday = localeData.weekdaysShort[local.weekday % 7];
    final month = localeData.monthsShort[local.month - 1];
    final day = _twoDigits(local.day);
    final time = _formatTimePart(local);
    final offset = _formatOffset(_currentOffset(), compact: true);
    return '$weekday $month $day ${_padYear(local.year)} $time GMT$offset';
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
    final clone = CarbonImmutable._internal(
      dateTime: (dateTime ?? _dateTime).toUtc(),
      locale: locale ?? _locale,
      timeZone: timeZone ?? _timeZone,
      settings: settings ?? _settings,
    );
    _copyInstanceFormatterTo(clone);
    if (_dynamicProperties != null && _dynamicProperties!.isNotEmpty) {
      clone._dynamicProperties = Map<String, dynamic>.from(_dynamicProperties!);
    }
    return clone;
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

  CarbonBase _replicateInstance({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  }) {
    final clone = _isMutable
        ? Carbon._internal(
            dateTime: (dateTime ?? _dateTime).toUtc(),
            locale: locale ?? _locale,
            timeZone: timeZone ?? _timeZone,
            settings: settings ?? _settings,
          )
        : CarbonImmutable._internal(
            dateTime: (dateTime ?? _dateTime).toUtc(),
            locale: locale ?? _locale,
            timeZone: timeZone ?? _timeZone,
            settings: settings ?? _settings,
          );
    _copyInstanceFormatterTo(clone);
    if (_dynamicProperties != null && _dynamicProperties!.isNotEmpty) {
      clone._dynamicProperties = Map<String, dynamic>.from(_dynamicProperties!);
    }
    return clone;
  }

  @override
  CarbonInterface copy() => _replicateInstance();

  @override
  CarbonInterface clone() => copy();

  @override
  CarbonInterface carbonize([dynamic input]) {
    if (input == null) {
      final now = Carbon.now(
        locale: _locale,
        timeZone: _timeZone,
      ).copyWith(settings: _settings);
      return _matchMutability(now);
    }
    if (input is CarbonPeriod) {
      return _matchMutability(input.start.copy());
    }
    if (input is CarbonInterval) {
      final clone = _replicateInstance();
      return clone._applyCarbonInterval(input, true);
    }
    if (input is Duration) {
      final clone = _replicateInstance();
      return clone.add(input);
    }
    if (input is CarbonInterface) {
      return _matchMutability(input.copy());
    }
    if (input is DateTime) {
      return _matchMutability(
        Carbon.fromDateTime(input).copyWith(settings: _settings),
      );
    }
    if (input is num) {
      final parsed = Carbon.createFromTimestamp(
        input,
        timeZone: _timeZone,
        locale: _locale,
        settings: _settings,
      );
      return _matchMutability(parsed);
    }
    if (input is String) {
      final parsed = _carbonizeString(input);
      return _matchMutability(parsed);
    }
    throw ArgumentError(
      'Unsupported input for carbonize: ${input.runtimeType}',
    );
  }

  CarbonInterface _carbonizeString(String raw) {
    final trimmed = raw.trim();
    final desiredZone = _timeZone;
    if (trimmed.isEmpty) {
      final parsed = Carbon.parse(
        trimmed,
        locale: _locale,
        timeZone: desiredZone,
      ).copyWith(settings: _settings);
      return parsed;
    }
    if (_explicitTimezonePattern.hasMatch(trimmed)) {
      final parsed = Carbon.parse(
        trimmed,
        locale: _locale,
        timeZone: desiredZone,
      ).copyWith(settings: _settings);
      return parsed;
    }
    final conversionZone = desiredZone ?? 'UTC';
    try {
      final parsed = DateTime.parse(trimmed);
      final utc = _localToUtc(
        year: parsed.year,
        month: parsed.month,
        day: parsed.day,
        hour: parsed.hour,
        minute: parsed.minute,
        second: parsed.second,
        microsecond: parsed.microsecond + parsed.millisecond * 1000,
        timeZone: conversionZone,
      );
      return Carbon._internal(
        dateTime: utc,
        locale: _locale,
        timeZone: desiredZone,
        settings: _settings,
      );
    } catch (_) {
      final parsed = Carbon.parse(
        trimmed,
        locale: _locale,
        timeZone: desiredZone,
      ).copyWith(settings: _settings);
      return parsed;
    }
  }

  @override
  CarbonInterface locale(String locale) {
    _applyLocaleDefaults(locale);
    final localeStart = _weekStartForLocale(locale);
    final nextSettings = localeStart == null
        ? _settings
        : _settings.copyWith(startOfWeek: localeStart);
    return _duplicate(locale: locale, settings: nextSettings);
  }

  @override
  CarbonInterface withToStringFormat(dynamic format) {
    final normalized = _normalizeToStringFormatter(format);
    if (_isMutable) {
      _instanceToStringFormat = normalized;
      return this;
    }
    final clone = _duplicate() as CarbonBase;
    clone._instanceToStringFormat = normalized;
    return clone;
  }

  @override
  CarbonInterface tz(String zoneName) {
    if (_timeZone == zoneName) {
      return this;
    }
    if (zoneName == 'UTC') {
      return _duplicate(timeZone: 'UTC');
    }
    final fixed = _parseFixedOffset(zoneName);
    if (fixed != null) {
      return _duplicate(timeZone: zoneName);
    }
    _getZoneOrThrow(zoneName);
    return _duplicate(timeZone: zoneName);
  }

  @override
  CarbonInterface shiftTimezone(String zoneName) {
    if (zoneName.isEmpty) {
      throw ArgumentError('Timezone name cannot be empty');
    }
    _requireZoneAvailability(zoneName);
    final currentOffset = _currentOffset();
    final targetOffset = _offsetForZone(zoneName, _dateTime);
    final delta = currentOffset - targetOffset;
    final shifted = _dateTime.add(delta);
    return _duplicate(dateTime: shifted, timeZone: zoneName);
  }

  @override
  CarbonInterface toUtc() => _wrap(_dateTime.toUtc());

  @override
  CarbonInterface toLocal() => _wrap(_dateTime.toLocal());

  @override
  int get utcOffset => _currentOffset().inMinutes;

  @override
  CarbonInterface setUtcOffset(int minutes) =>
      tz(_formatOffset(Duration(minutes: minutes)));

  @override
  CarbonInterface add(Duration duration) => _wrap(_dateTime.add(duration));

  @override
  CarbonInterface rawAdd(Duration duration) => _wrap(_dateTime.add(duration));

  @override
  CarbonInterface rawSub(Duration duration) =>
      _wrap(_dateTime.subtract(duration));

  @override
  CarbonInterface operator +(Duration duration) => add(duration);

  @override
  CarbonInterface operator -(Duration duration) => subtract(duration);

  @override
  CarbonInterface subtract([dynamic value, dynamic unit]) =>
      _applyDynamicAdjustment(value: value, unit: unit, isAddition: false);

  @override
  CarbonInterface sub([dynamic value, dynamic unit]) => subtract(value, unit);

  CarbonInterface _applyDynamicAdjustment({
    required dynamic value,
    dynamic unit,
    required bool isAddition,
  }) {
    if (value == null) {
      return this;
    }
    if (value is Duration && unit == null) {
      final delta = isAddition ? value : -value;
      return add(delta);
    }
    if (value is CarbonInterval && unit == null) {
      return _applyCarbonInterval(value, isAddition);
    }

    dynamic amountInput = value;
    dynamic unitInput = unit;

    if (amountInput is num && unitInput != null) {
      final resolvedUnit = _unitFromInput(unitInput);
      if (resolvedUnit != null) {
        final amount = amountInput.round();
        if (amount == 0) {
          return this;
        }
        return _applyTemporalUnit(
          resolvedUnit,
          isAddition ? amount : -amount,
          null,
        );
      }
    }

    final swappedUnit = _unitFromInput(amountInput);
    if (swappedUnit != null && unitInput is num) {
      final amount = unitInput.round();
      if (amount == 0) {
        return this;
      }
      return _applyTemporalUnit(
        swappedUnit,
        isAddition ? amount : -amount,
        null,
      );
    }

    if (amountInput is String && unitInput == null) {
      final instruction = _parseUnitAmountExpression(amountInput);
      if (instruction != null) {
        final signedAmount = isAddition
            ? instruction.amount
            : -instruction.amount;
        return _applyTemporalUnit(instruction.unit, signedAmount, null);
      }
    }

    if (amountInput is CarbonInterface && unitInput == null) {
      final diff = amountInput.dateTime.difference(_dateTime);
      return add(isAddition ? diff : -diff);
    }

    if (amountInput is DateTime && unitInput == null) {
      final diff = amountInput.toUtc().difference(_dateTime);
      return add(isAddition ? diff : -diff);
    }

    if (amountInput is Function && unitInput == null) {
      final fn = amountInput;
      final isNegated = !isAddition;
      final result = Function.apply(fn, [dateTime.toUtc(), isNegated]);
      if (result is DateTime) {
        final target = result.isUtc ? result : result.toUtc();
        return _wrap(target);
      }
      throw ArgumentError(
        'Callback passed to ${isAddition ? 'add' : 'sub'} must return DateTime',
      );
    }

    throw ArgumentError(
      'Unsupported ${isAddition ? 'add' : 'subtract'} arguments: '
      '$value, $unit',
    );
  }

  @override
  CarbonInterface addDays(int days) => add(Duration(days: days));

  @override
  CarbonInterface addWeeks(int weeks) => add(Duration(days: weeks * 7));

  @override
  CarbonInterface addWeekdays(int weekdays) {
    if (weekdays == 0) {
      return this;
    }
    return _wrap(_shiftWeekdays(_dateTime, weekdays));
  }

  @override
  CarbonInterface addWeekday([int amount = 1]) => addWeekdays(amount);

  @override
  CarbonInterface subWeekdays(int weekdays) => addWeekdays(-weekdays);

  @override
  CarbonInterface subWeekday([int amount = 1]) => addWeekdays(-amount);

  @override
  CarbonInterface nextWeekday() {
    var cursor = _dateTime.add(const Duration(days: 1));
    while (_weekendDays.contains(cursor.weekday)) {
      cursor = cursor.add(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface previousWeekday() {
    var cursor = _dateTime.subtract(const Duration(days: 1));
    while (_weekendDays.contains(cursor.weekday)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface nextWeekendDay() {
    var cursor = _dateTime.add(const Duration(days: 1));
    while (!_weekendDays.contains(cursor.weekday)) {
      cursor = cursor.add(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface previousWeekendDay() {
    var cursor = _dateTime.subtract(const Duration(days: 1));
    while (!_weekendDays.contains(cursor.weekday)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface addMonths(int months) => _wrap(_addMonths(_dateTime, months));

  @override
  CarbonInterface addYears(int years) =>
      _wrap(_addMonths(_dateTime, years * 12));

  DateTime _addMonths(DateTime value, int months, {bool? monthOverflow}) {
    final overflow = monthOverflow ?? _settings.monthOverflow;
    final monthIndex = value.month - 1 + months;
    final yearDelta = _floorDiv(monthIndex, 12);
    final targetYear = value.year + yearDelta;
    final targetMonth = (monthIndex - yearDelta * 12) + 1;

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

  DateTime _shiftWeekdays(DateTime value, int weekdays) {
    var remaining = weekdays;
    var current = value;
    while (remaining != 0) {
      final step = remaining > 0 ? 1 : -1;
      current = current.add(Duration(days: step));
      if (_isWeekend(current)) {
        continue;
      }
      remaining -= step;
    }
    return current;
  }

  bool _isWeekend(DateTime value) => _weekendDays.contains(value.weekday);

  int _floorDiv(int a, int b) {
    final q = a ~/ b;
    if ((a ^ b) < 0 && a % b != 0) {
      return q - 1;
    }
    return q;
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
    final zone = _timeZone;
    final local = zone == null ? _dateTime : _utcToLocal(_dateTime, zone);
    final startOfWeek = _settings.startOfWeek;
    final normalized = ((local.weekday - startOfWeek) + 7) % 7;
    final localStart = DateTime(
      local.year,
      local.month,
      local.day,
    ).subtract(Duration(days: normalized));
    final utc = _localDateTimeUtc(localStart, timeZone: zone);
    return _wrap(utc);
  }

  @override
  CarbonInterface endOfWeek() {
    final zone = _timeZone;
    final local = zone == null ? _dateTime : _utcToLocal(_dateTime, zone);
    final startOfWeek = _settings.startOfWeek;
    final normalized = ((local.weekday - startOfWeek) + 7) % 7;
    final localStart = DateTime(
      local.year,
      local.month,
      local.day,
    ).subtract(Duration(days: normalized));
    final localEnd = localStart
        .add(const Duration(days: 7))
        .subtract(const Duration(microseconds: 1));
    final utc = _localDateTimeUtc(localEnd, timeZone: zone);
    return _wrap(utc);
  }

  int _startOfWeekIndex([dynamic weekStartsAt]) {
    if (weekStartsAt != null) {
      return _resolveWeekdayInput(weekStartsAt);
    }
    return _normalizeWeekday(_settings.startOfWeek) % 7;
  }

  @override
  int getDaysFromStartOfWeek([dynamic weekStartsAt]) {
    final start = _startOfWeekIndex(weekStartsAt);
    final current = _dateTime.weekday % 7;
    return (current + 7 - start) % 7;
  }

  @override
  CarbonInterface setDaysFromStartOfWeek(
    int numberOfDays, [
    dynamic weekStartsAt,
  ]) {
    final delta = numberOfDays - getDaysFromStartOfWeek(weekStartsAt);
    if (delta == 0) {
      return this;
    }
    return addDays(delta);
  }

  @override
  int weekNumber([dynamic dayOfWeek, int? dayOfYear]) {
    final spec = _resolveWeekSpec(dayOfWeek, dayOfYear);
    final (currentWeek, _) = _weekData(
      _localDateTimeForFormatting(),
      spec.startOfWeek,
      spec.firstWeekDay,
    );
    return currentWeek;
  }

  @override
  CarbonInterface setWeekNumber(
    int targetWeek, [
    dynamic dayOfWeek,
    int? dayOfYear,
  ]) {
    final current = weekNumber(dayOfWeek, dayOfYear);
    final delta = targetWeek.round() - current;
    return delta == 0 ? this : addWeeks(delta);
  }

  @override
  int isoWeekNumber([dynamic dayOfWeek, int? dayOfYear]) {
    final spec = _resolveWeekSpec(dayOfWeek, dayOfYear, isoDefaults: true);
    final (currentWeek, _) = _weekData(
      _localDateTimeForFormatting(),
      spec.startOfWeek,
      spec.firstWeekDay,
    );
    return currentWeek;
  }

  @override
  CarbonInterface setIsoWeekNumber(
    int targetWeek, [
    dynamic dayOfWeek,
    int? dayOfYear,
  ]) {
    final current = isoWeekNumber(dayOfWeek, dayOfYear);
    final delta = targetWeek.round() - current;
    return delta == 0 ? this : addWeeks(delta);
  }

  @override
  CarbonInterface startOfMonth() =>
      _wrap(DateTime.utc(_dateTime.year, _dateTime.month, 1));

  @override
  CarbonInterface endOfMonth() => _wrap(
    DateTime.utc(_dateTime.year, _dateTime.month + 1, 0, 23, 59, 59, 999, 999),
  );

  @override
  CarbonInterface firstOfMonth([dynamic weekday]) {
    if (weekday == null) {
      return startOfMonth();
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = DateTime.utc(_dateTime.year, _dateTime.month, 1);
    while (cursor.weekday % 7 != target) {
      cursor = cursor.add(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface lastOfMonth([dynamic weekday]) {
    if (weekday == null) {
      return endOfMonth();
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = DateTime.utc(
      _dateTime.year,
      _dateTime.month + 1,
      1,
    ).subtract(const Duration(days: 1));
    while (cursor.weekday % 7 != target) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface? nthOfMonth(int nth, [dynamic weekday]) {
    if (nth <= 0) {
      return null;
    }
    if (weekday == null) {
      final lastDay = DateTime.utc(_dateTime.year, _dateTime.month + 1, 0).day;
      if (nth > lastDay) {
        return null;
      }
      return _wrap(DateTime.utc(_dateTime.year, _dateTime.month, nth));
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = DateTime.utc(_dateTime.year, _dateTime.month, 1);
    var count = 0;
    while (cursor.month == _dateTime.month) {
      if (cursor.weekday % 7 == target) {
        count++;
        if (count == nth) {
          return _wrap(cursor);
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    return null;
  }

  @override
  CarbonInterface startOfYear() => _wrap(DateTime.utc(_dateTime.year, 1, 1));

  @override
  CarbonInterface endOfYear() =>
      _wrap(DateTime.utc(_dateTime.year + 1, 1, 0, 23, 59, 59, 999, 999));

  @override
  CarbonInterface firstOfYear([dynamic weekday]) {
    final start = DateTime.utc(_dateTime.year, 1, 1);
    if (weekday == null) {
      return _wrap(start);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = start;
    while (cursor.year == start.year && cursor.weekday % 7 != target) {
      cursor = cursor.add(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface lastOfYear([dynamic weekday]) {
    final end = DateTime.utc(
      _dateTime.year + 1,
      1,
      1,
    ).subtract(const Duration(days: 1));
    if (weekday == null) {
      return _wrap(end);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = end;
    while (cursor.year == end.year && cursor.weekday % 7 != target) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface? nthOfYear(int nth, [dynamic weekday]) {
    if (nth <= 0) {
      return null;
    }
    final start = DateTime.utc(_dateTime.year, 1, 1);
    final end = DateTime.utc(
      _dateTime.year + 1,
      1,
      1,
    ).subtract(const Duration(days: 1));
    if (weekday == null) {
      final date = start.add(Duration(days: nth - 1));
      if (date.isAfter(end)) {
        return null;
      }
      return _wrap(date);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = start;
    var count = 0;
    while (!cursor.isAfter(end)) {
      if (cursor.weekday % 7 == target) {
        count++;
        if (count == nth) {
          return _wrap(cursor);
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    return null;
  }

  @override
  CarbonInterface firstOfQuarter([dynamic weekday]) {
    final start = _quarterStart(_dateTime);
    if (weekday == null) {
      return _wrap(start);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = start;
    while (cursor.month <= start.month + 2 && cursor.weekday % 7 != target) {
      cursor = cursor.add(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface lastOfQuarter([dynamic weekday]) {
    final end = _quarterEnd(_dateTime);
    if (weekday == null) {
      return _wrap(end);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = end;
    final cutoff = _quarterStart(_dateTime).month - 1;
    while (cursor.month > cutoff && cursor.weekday % 7 != target) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _wrap(cursor);
  }

  @override
  CarbonInterface? nthOfQuarter(int nth, [dynamic weekday]) {
    if (nth <= 0) {
      return null;
    }
    final start = _quarterStart(_dateTime);
    final end = _quarterEnd(_dateTime);
    if (weekday == null) {
      final date = start.add(Duration(days: nth - 1));
      if (date.isAfter(end)) {
        return null;
      }
      return _wrap(date);
    }
    final target = _resolveWeekdayInput(weekday);
    var cursor = start;
    var count = 0;
    while (!cursor.isAfter(end)) {
      if (cursor.weekday % 7 == target) {
        count++;
        if (count == nth) {
          return _wrap(cursor);
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    return null;
  }

  @override
  CarbonInterface startOfHour() => _wrap(
    DateTime.utc(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour,
    ),
  );

  @override
  CarbonInterface endOfHour() => _wrap(
    _endExclusive(
      DateTime.utc(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _dateTime.hour + 1,
      ),
    ),
  );

  @override
  CarbonInterface startOfMinute() => _wrap(
    DateTime.utc(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
    ),
  );

  @override
  CarbonInterface endOfMinute() => _wrap(
    _endExclusive(
      DateTime.utc(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _dateTime.hour,
        _dateTime.minute + 1,
      ),
    ),
  );

  @override
  CarbonInterface startOfSecond() => _wrap(
    DateTime.utc(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      _dateTime.hour,
      _dateTime.minute,
      _dateTime.second,
    ),
  );

  @override
  CarbonInterface endOfSecond() => _wrap(
    _endExclusive(
      DateTime.utc(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _dateTime.hour,
        _dateTime.minute,
        _dateTime.second + 1,
      ),
    ),
  );

  @override
  CarbonInterface midDay() =>
      _wrap(DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day, 12));

  @override
  CarbonInterface startOfQuarter() => _wrap(_quarterStart(_dateTime));

  @override
  CarbonInterface endOfQuarter() =>
      _wrap(_endExclusive(_addMonths(_quarterStart(_dateTime), 3)));

  @override
  CarbonInterface startOfDecade() =>
      _wrap(DateTime.utc(_dateTime.year - (_dateTime.year % 10), 1, 1));

  @override
  CarbonInterface endOfDecade() => _wrap(
    _endExclusive(
      DateTime.utc(_dateTime.year - (_dateTime.year % 10) + 10, 1, 1),
    ),
  );

  @override
  CarbonInterface startOfCentury() => _wrap(_centuryStart(_dateTime));

  @override
  CarbonInterface endOfCentury() => _wrap(
    _endExclusive(DateTime.utc(_centuryStart(_dateTime).year + 100, 1, 1)),
  );

  @override
  CarbonInterface startOfMillennium() => _wrap(_millenniumStart(_dateTime));

  @override
  CarbonInterface endOfMillennium() => _wrap(
    _endExclusive(DateTime.utc(_millenniumStart(_dateTime).year + 1000, 1, 1)),
  );

  @override
  CarbonInterface startOf(dynamic unit) =>
      _applyStartEndUnit(unit, isStart: true);

  @override
  CarbonInterface endOf(dynamic unit) =>
      _applyStartEndUnit(unit, isStart: false);

  @override
  CarbonInterface average([dynamic other]) {
    final target = _coerceToDateTime(other);
    final sum =
        _dateTime.microsecondsSinceEpoch + target.microsecondsSinceEpoch;
    final averageMicros = sum ~/ 2;
    final averaged = DateTime.fromMicrosecondsSinceEpoch(
      averageMicros,
      isUtc: true,
    );
    return _wrap(averaged);
  }

  CarbonInterface _applyStartEndUnit(dynamic unit, {required bool isStart}) {
    final resolved = _resolveStartEndUnit(unit);
    switch (resolved) {
      case _StartEndUnit.second:
        return isStart ? startOfSecond() : endOfSecond();
      case _StartEndUnit.minute:
        return isStart ? startOfMinute() : endOfMinute();
      case _StartEndUnit.hour:
        return isStart ? startOfHour() : endOfHour();
      case _StartEndUnit.day:
        return isStart ? startOfDay() : endOfDay();
      case _StartEndUnit.week:
        return isStart ? startOfWeek() : endOfWeek();
      case _StartEndUnit.month:
        return isStart ? startOfMonth() : endOfMonth();
      case _StartEndUnit.quarter:
        return isStart ? startOfQuarter() : endOfQuarter();
      case _StartEndUnit.year:
        return isStart ? startOfYear() : endOfYear();
      case _StartEndUnit.decade:
        return isStart ? startOfDecade() : endOfDecade();
      case _StartEndUnit.century:
        return isStart ? startOfCentury() : endOfCentury();
      case _StartEndUnit.millennium:
        return isStart ? startOfMillennium() : endOfMillennium();
    }
  }

  _StartEndUnit _resolveStartEndUnit(dynamic value) {
    if (value is CarbonUnit) {
      switch (value) {
        case CarbonUnit.second:
          return _StartEndUnit.second;
        case CarbonUnit.minute:
          return _StartEndUnit.minute;
        case CarbonUnit.hour:
          return _StartEndUnit.hour;
        case CarbonUnit.day:
          return _StartEndUnit.day;
        case CarbonUnit.week:
          return _StartEndUnit.week;
        case CarbonUnit.month:
          return _StartEndUnit.month;
        case CarbonUnit.quarter:
          return _StartEndUnit.quarter;
        case CarbonUnit.year:
          return _StartEndUnit.year;
        case CarbonUnit.decade:
          return _StartEndUnit.decade;
        case CarbonUnit.century:
          return _StartEndUnit.century;
        case CarbonUnit.millennium:
          return _StartEndUnit.millennium;
        default:
          break;
      }
    } else if (value is String) {
      final normalized = value.trim().toLowerCase();
      final singular = normalized.endsWith('s') && normalized.length > 1
          ? normalized.substring(0, normalized.length - 1)
          : normalized;
      switch (singular) {
        case 'second':
          return _StartEndUnit.second;
        case 'minute':
          return _StartEndUnit.minute;
        case 'hour':
          return _StartEndUnit.hour;
        case 'day':
          return _StartEndUnit.day;
        case 'week':
          return _StartEndUnit.week;
        case 'month':
          return _StartEndUnit.month;
        case 'quarter':
          return _StartEndUnit.quarter;
        case 'year':
          return _StartEndUnit.year;
        case 'decade':
          return _StartEndUnit.decade;
        case 'century':
          return _StartEndUnit.century;
        case 'millennium':
        case 'millennia':
          return _StartEndUnit.millennium;
      }
    }
    throw CarbonUnknownUnitException(value.toString());
  }

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
  CarbonInterface setMonth(int month) {
    if (month == _dateTime.month) {
      return this;
    }
    final zeroIndexed = month - 1;
    var normalized = zeroIndexed % 12;
    if (normalized < 0) {
      normalized += 12;
    }
    final normalizedMonth = normalized + 1;
    final yearShift = (zeroIndexed - normalized) ~/ 12;
    final monthsDiff = yearShift * 12 + (normalizedMonth - _dateTime.month);
    return _wrap(
      _addMonths(_dateTime, monthsDiff, monthOverflow: _settings.monthOverflow),
    );
  }

  @override
  CarbonInterface setMonths(int month) => setMonth(month);

  @override
  CarbonInterface setQuarter(int quarter) {
    if (quarter < 1 || quarter > 4) {
      throw RangeError.range(quarter, 1, 4, 'quarter');
    }
    final targetMonth = (quarter - 1) * 3 + 1;
    final lastDayOfTarget = DateTime.utc(
      _dateTime.year,
      targetMonth + 1,
      0,
    ).day;
    final clampedDay = _dateTime.day.clamp(1, lastDayOfTarget);
    return _duplicate(
      dateTime: _copyWith(month: targetMonth, day: clampedDay),
    );
  }

  @override
  CarbonInterface setDay(int day) => _duplicate(dateTime: _copyWith(day: day));

  @override
  CarbonInterface setDays(int day) => setDay(day);

  @override
  CarbonInterface setDayOfWeek(int weekday) {
    if (weekday < 1 || weekday > 7) {
      throw RangeError.range(weekday, 1, 7, 'weekday');
    }
    final targetIso = weekday == 7 ? DateTime.sunday : weekday;
    final delta = targetIso - _dateTime.weekday;
    return _wrap(_dateTime.add(Duration(days: delta)));
  }

  @override
  int get day => _dateTime.day;

  @override
  int get days => day;

  @override
  int get dayOfMonth => day;

  @override
  int get dayOfYear => _daysSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

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
  int get quarter => ((_dateTime.month - 1) ~/ 3) + 1;

  @override
  int get age => diffInYears(Carbon.now(), absolute: true);

  @override
  int get yearIso {
    final thursday = _dateTime.add(
      Duration(days: 3 - ((_dateTime.weekday + 6) % 7)),
    );
    return thursday.year;
  }

  @override
  int get weekNumberInMonth {
    final startOfWeek = CarbonTranslator.matchLocale(_locale).firstDayOfWeek;
    final firstOfMonth = DateTime.utc(_dateTime.year, _dateTime.month, 1);

    final firstDayWeekday = firstOfMonth.weekday;

    final offset = (firstDayWeekday - startOfWeek + 7) % 7;

    return ((_dateTime.day + offset) / 7).ceil();
  }

  @override
  String get localeDayOfWeek {
    final localeData = CarbonTranslator.matchLocale(_locale);
    return localeData.weekdays[_dateTime.weekday % 7];
  }

  @override
  String get localeMonth {
    final localeData = CarbonTranslator.matchLocale(_locale);
    return localeData.months[_dateTime.month - 1];
  }

  @override
  String get englishDayOfWeek {
    final localeData = CarbonTranslator.matchLocale('en');
    return localeData.weekdays[_dateTime.weekday % 7];
  }

  @override
  String get dayName => localeDayOfWeek;

  @override
  String get shortLocaleDayOfWeek {
    final localeData = CarbonTranslator.matchLocale(_locale);
    return localeData.weekdaysShort[_dateTime.weekday % 7];
  }

  @override
  String get minDayName {
    final localeData = CarbonTranslator.matchLocale(_locale);
    return localeData.weekdaysMin[_dateTime.weekday % 7];
  }

  @override
  String get shortLocaleMonth {
    final localeData = CarbonTranslator.matchLocale(_locale);
    return localeData.monthsShort[_dateTime.month - 1];
  }

  @override
  String get shortEnglishDayOfWeek {
    final localeData = CarbonTranslator.matchLocale('en');
    return localeData.weekdaysShort[_dateTime.weekday % 7];
  }

  @override
  String get englishMonth {
    final localeData = CarbonTranslator.matchLocale('en');
    return localeData.months[_dateTime.month - 1];
  }

  @override
  String get shortEnglishMonth {
    final localeData = CarbonTranslator.matchLocale('en');
    return localeData.monthsShort[_dateTime.month - 1];
  }

  @override
  String get shortDayName => shortLocaleDayOfWeek;

  @override
  String get monthName => localeMonth;

  @override
  String get shortMonthName => shortLocaleMonth;

  @override
  int get decade => _dateTime.year ~/ 10;

  @override
  int get century => ((_dateTime.year - 1) ~/ 100) + 1;

  @override
  int get millennium => ((_dateTime.year - 1) ~/ 1000) + 1;

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
  int get hourOfYear => _hoursSince(DateTime.utc(_dateTime.year, 1, 1)) + 1;

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
  CarbonInterface setDate(int year, [int? month, int? day]) {
    final resolvedMonth = month ?? _dateTime.month;
    final resolvedDay = day ?? _dateTime.day;
    return _duplicate(
      dateTime: DateTime.utc(
        year,
        resolvedMonth,
        resolvedDay,
        _dateTime.hour,
        _dateTime.minute,
        _dateTime.second,
        _dateTime.millisecond,
        _dateTime.microsecond,
      ),
    );
  }

  @override
  CarbonInterface setDayOfYear(int dayOfYear) {
    final normalized = DateTime.utc(
      _dateTime.year,
      1,
      1,
    ).add(Duration(days: dayOfYear - 1));
    return _duplicate(
      dateTime: _copyWith(
        year: normalized.year,
        month: normalized.month,
        day: normalized.day,
      ),
    );
  }

  @override
  CarbonInterface setTimestamp(int timestamp) {
    final updated = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    return _duplicate(dateTime: updated);
  }

  @override
  CarbonInterface set(String property, Object? value) {
    final key = _normalizePropertyKey(property);
    switch (key) {
      case 'year':
      case 'years':
        return setYear(_parseInt(property, value));
      case 'month':
      case 'months':
        return setMonth(_parseInt(property, value));
      case 'day':
      case 'days':
      case 'dayofmonth':
        return setDay(_parseInt(property, value));
      case 'dayofyear':
        return setDayOfYear(_parseInt(property, value));
      case 'hour':
      case 'hours':
        return setHour(_parseInt(property, value));
      case 'minute':
      case 'minutes':
        return setMinute(_parseInt(property, value));
      case 'second':
      case 'seconds':
        return setSecond(_parseInt(property, value));
      case 'millisecond':
      case 'milliseconds':
      case 'milli':
      case 'millis':
        return setMillisecond(_parseInt(property, value));
      case 'microsecond':
      case 'microseconds':
      case 'micro':
      case 'micros':
        return setMicro(_parseInt(property, value));
      case 'timestamp':
        return setTimestamp(_parseInt(property, value));
      default:
        if (_strictMode) {
          throw CarbonUnknownSetterException(property);
        }
        final target = _dynamicProperties ??= <String, dynamic>{};
        target[key] = value;
        return this;
    }
  }

  @override
  Object? get(String property) {
    final key = _normalizePropertyKey(property);
    switch (key) {
      case 'year':
      case 'years':
        return year;
      case 'month':
      case 'months':
        return month;
      case 'day':
      case 'days':
      case 'dayofmonth':
        return day;
      case 'dayofyear':
        return dayOfYear;
      case 'hour':
      case 'hours':
        return hour;
      case 'minute':
      case 'minutes':
        return minute;
      case 'second':
      case 'seconds':
        return second;
      case 'millisecond':
      case 'milliseconds':
      case 'milli':
      case 'millis':
        return millisecond;
      case 'microsecond':
      case 'microseconds':
      case 'micro':
      case 'micros':
        return micro;
      case 'timestamp':
        return toEpochMilliseconds() ~/ 1000;
      default:
        final dynamicProperties = _dynamicProperties;
        if (dynamicProperties != null && dynamicProperties.containsKey(key)) {
          return dynamicProperties[key];
        }
        if (_strictMode) {
          throw CarbonUnknownGetterException(property);
        }
        return null;
    }
  }

  static int _parseInt(String property, Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed;
      }
    }
    throw ArgumentError.value(value, property, 'Expected an integer');
  }

  static String _normalizePropertyKey(String property) {
    final trimmed = property.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(property, 'property', 'Property name.');
    }
    return trimmed.toLowerCase();
  }

  @override
  CarbonInterface setTime(
    int hour, [
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]) {
    final resolvedMinute = minute ?? _dateTime.minute;
    final resolvedSecond = second ?? _dateTime.second;
    final resolvedMillisecond = millisecond ?? _dateTime.millisecond;
    final resolvedMicrosecond = microsecond ?? _dateTime.microsecond;
    return _duplicate(
      dateTime: DateTime.utc(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        hour,
        resolvedMinute,
        resolvedSecond,
        resolvedMillisecond,
        resolvedMicrosecond,
      ),
    );
  }

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
  int get millisecondOfMinute =>
      _millisecondsSince(
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
  int get millisecondOfHour =>
      _millisecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
        ),
      ) +
      1;

  @override
  int get millisecondOfDay =>
      _millisecondsSince(
        DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day),
      ) +
      1;

  @override
  int get millisecondOfWeek => _millisecondsSince(_weekStart(_dateTime)) + 1;

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
  int get millisecondsInQuarter => daysInQuarter * Duration.millisecondsPerDay;

  @override
  int get millisecondsInYear => daysInYear * Duration.millisecondsPerDay;

  @override
  int get millisecondsInDecade => daysInDecade * Duration.millisecondsPerDay;

  @override
  int get millisecondsInCentury => daysInCentury * Duration.millisecondsPerDay;

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
  CarbonInterface setMicro(int microsecond) {
    final milliPortion = microsecond ~/ Duration.microsecondsPerMillisecond;
    final microPortion = microsecond % Duration.microsecondsPerMillisecond;
    return _duplicate(
      dateTime: _copyWith(millisecond: milliPortion, microsecond: microPortion),
    );
  }

  @override
  CarbonInterface setMicros(int microsecond) => setMicro(microsecond);

  @override
  CarbonInterface setMicrosecond(int microsecond) => setMicro(microsecond);

  @override
  CarbonInterface setMicroseconds(int microsecond) => setMicro(microsecond);

  @override
  int get microsecond =>
      _dateTime.millisecond * Duration.microsecondsPerMillisecond +
      _dateTime.microsecond;

  @override
  int get microseconds => microsecond;

  @override
  int get micro => microsecond;

  @override
  int get micros => microsecond;

  @override
  int get microsecondOfMillisecond => _dateTime.microsecond + 1;

  @override
  int get microsecondOfSecond => microsecond + 1;

  @override
  int get microsecondOfMinute =>
      _microsecondsSince(
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
  int get microsecondOfHour =>
      _microsecondsSince(
        DateTime.utc(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          _dateTime.hour,
        ),
      ) +
      1;

  @override
  int get microsecondOfDay =>
      _microsecondsSince(
        DateTime.utc(_dateTime.year, _dateTime.month, _dateTime.day),
      ) +
      1;

  @override
  int get microsecondOfWeek => _microsecondsSince(_weekStart(_dateTime)) + 1;

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
  int get microsecondOfDecade =>
      _microsecondsSince(_decadeStart(_dateTime)) + 1;

  @override
  int get microsecondOfCentury =>
      _microsecondsSince(_centuryStart(_dateTime)) + 1;

  @override
  int get microsecondOfMillennium =>
      _microsecondsSince(_millenniumStart(_dateTime)) + 1;

  @override
  int get microsecondsInMillisecond => Duration.microsecondsPerMillisecond;

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
  int get microsecondsInMonth => daysInMonth * Duration.microsecondsPerDay;

  @override
  int get microsecondsInQuarter => daysInQuarter * Duration.microsecondsPerDay;

  @override
  int get microsecondsInYear => daysInYear * Duration.microsecondsPerDay;

  @override
  int get microsecondsInDecade => daysInDecade * Duration.microsecondsPerDay;

  @override
  int get microsecondsInCentury => daysInCentury * Duration.microsecondsPerDay;

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

  (int, int) get _isoWeekSnapshot =>
      _isoWeekData(_localDateTimeForFormatting());

  (int, int) get _localeWeekSnapshot =>
      _localeWeekData(_localDateTimeForFormatting());

  (int, int) _isoWeekData(DateTime current) {
    final weekday = _isoWeekday(current);
    final dayOfYear =
        current.difference(DateTime.utc(current.year, 1, 1)).inDays + 1;
    var week = ((dayOfYear - weekday + 10) / 7).floor();
    var year = current.year;
    if (week < 1) {
      year -= 1;
      week = _isoWeeksInYearInternal(year);
    } else {
      final weeksInYear = _isoWeeksInYearInternal(year);
      if (week > weeksInYear) {
        year += 1;
        week = 1;
      }
    }
    return (week, year);
  }

  int _isoWeeksInYearInternal(int year) {
    final dec28 = DateTime.utc(year, 12, 28);
    final dayOfYear = dec28.difference(DateTime.utc(year, 1, 1)).inDays + 1;
    final weekday = _isoWeekday(dec28);
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  int _isoWeekday(DateTime value) {
    final weekday = value.weekday;
    return weekday == DateTime.sunday ? 7 : weekday;
  }

  (int, int) _localeWeekData(DateTime current) =>
      _weekData(current, _settings.startOfWeek, _lookupLocaleFirstWeekDay());

  (int, int) _weekData(DateTime current, int startOfWeek, int firstWeekDay) {
    var weekYear = current.year;
    var start = _firstWeekStart(weekYear, startOfWeek, firstWeekDay);
    if (start.year == weekYear && current.isBefore(start)) {
      weekYear -= 1;
      start = _firstWeekStart(weekYear, startOfWeek, firstWeekDay);
    } else {
      final nextStart = _firstWeekStart(
        weekYear + 1,
        startOfWeek,
        firstWeekDay,
      );
      if (!current.isBefore(nextStart)) {
        weekYear += 1;
        start = nextStart;
      }
    }
    final alignedCurrent = _alignToWeekStart(current, startOfWeek);
    var weekNumber = (alignedCurrent.difference(start).inDays ~/ 7) + 1;
    final weeksInYear = _weeksInCustomYear(weekYear, startOfWeek, firstWeekDay);
    if (weekNumber > weeksInYear) {
      weekNumber = 1;
      weekYear += 1;
    }
    return (weekNumber, weekYear);
  }

  int _weeksInCustomYear(int year, int startOfWeek, int firstWeekDay) {
    final start = _firstWeekStart(year, startOfWeek, firstWeekDay);
    final end = _firstWeekStart(year + 1, startOfWeek, firstWeekDay);
    return (end.difference(start).inDays ~/ 7);
  }

  _WeekSpec _resolveWeekSpec(
    dynamic dayOfWeek,
    int? dayOfYear, {
    bool isoDefaults = false,
  }) {
    final start = dayOfWeek == null
        ? (isoDefaults ? DateTime.monday : _settings.startOfWeek)
        : _phpWeekdayToDateTime(_resolveWeekdayInput(dayOfWeek));
    final defaultDayOfYear = isoDefaults ? 4 : _lookupLocaleFirstWeekDay();
    final firstWeekDay = ((dayOfYear ?? defaultDayOfYear).clamp(
      1,
      366,
    )).toInt();
    return _WeekSpec(startOfWeek: start, firstWeekDay: firstWeekDay);
  }

  int _phpWeekdayToDateTime(int phpWeekday) =>
      phpWeekday == 0 ? DateTime.sunday : phpWeekday + 1;

  int _lookupLocaleFirstWeekDay() {
    for (final candidate in _localeCandidates(_locale)) {
      final value = kLocaleFirstWeekMinDays[candidate];
      if (value != null) {
        return value;
      }
    }
    return 1;
  }

  DateTime _firstWeekStart(int year, int startOfWeek, int firstWeekDay) {
    final base = DateTime.utc(year, 1, firstWeekDay);
    return _alignToWeekStart(base, startOfWeek);
  }

  DateTime _alignToWeekStart(DateTime date, int startOfWeek) {
    final normalizedStart = startOfWeek == DateTime.sunday ? 7 : startOfWeek;
    final weekday = date.weekday == DateTime.sunday ? 7 : date.weekday;
    final diff = ((weekday - normalizedStart) + 7) % 7;
    return date.subtract(Duration(days: diff));
  }

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
  }) => _roundDurationUnit(const Duration(seconds: 1), precision, function);

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
  }) => _roundDurationUnit(const Duration(minutes: 1), precision, function);

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
  }) => _roundMonthUnit(precision, function, useOneBasedRounding: true);

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
  }) => _roundMonthUnit(precision * 3, function, useOneBasedRounding: true);

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
  }) => _roundMonthUnit(precision * 12, function, useOneBasedRounding: true);

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
  }) => _roundDurationUnit(const Duration(hours: 1), precision, function);

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
  }) => _roundMonthUnit(precision * 12000, function, monthOffset: 12);

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
  }) =>
      _roundDurationUnit(const Duration(milliseconds: 1), precision, function);

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
  }) =>
      _roundDurationUnit(const Duration(microseconds: 1), precision, function);

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
  }) => _roundDurationUnit(const Duration(days: 1), precision, function);

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
  double secondsSinceMidnight() {
    final midnight = _startOfDayUtcForZone(_dateTime, timeZone: _timeZone);
    final diff = _dateTime.difference(midnight);
    return diff.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  double secondsUntilEndOfDay() {
    final midnight = _startOfDayUtcForZone(_dateTime, timeZone: _timeZone);
    final end = midnight.add(const Duration(days: 1));
    final diff = end.difference(_dateTime);
    return diff.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  CarbonInterface roundCenturies({
    double precision = 1,
    String function = 'round',
  }) => _roundMonthUnit(precision * 1200, function, monthOffset: 12);

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

  DateTime _comparisonTarget(dynamic other) => _coerceToDateTime(other);

  @override
  bool eq(dynamic other) => equalTo(other);

  @override
  bool equalTo(dynamic other) =>
      _dateTime.isAtSameMomentAs(_comparisonTarget(other));

  @override
  bool ne(dynamic other) => notEqualTo(other);

  @override
  bool notEqualTo(dynamic other) => !equalTo(other);

  @override
  bool gt(dynamic other) => greaterThan(other);

  @override
  bool greaterThan(dynamic other) =>
      _dateTime.isAfter(_comparisonTarget(other));

  @override
  bool gte(dynamic other) => greaterThanOrEqual(other);

  @override
  bool greaterThanOrEqual(dynamic other) {
    final target = _comparisonTarget(other);
    return _dateTime.isAfter(target) || _dateTime.isAtSameMomentAs(target);
  }

  @override
  bool lt(dynamic other) => lessThan(other);

  @override
  bool lessThan(dynamic other) => _dateTime.isBefore(_comparisonTarget(other));

  @override
  bool lte(dynamic other) => lessThanOrEqual(other);

  @override
  bool lessThanOrEqual(dynamic other) {
    final target = _comparisonTarget(other);
    return _dateTime.isBefore(target) || _dateTime.isAtSameMomentAs(target);
  }

  @override
  bool between(dynamic start, dynamic end, {bool inclusive = true}) =>
      _isBetweenRange(
        _coerceToDateTime(start),
        _coerceToDateTime(end),
        inclusive: inclusive,
      );

  @override
  bool betweenIncluded(dynamic start, dynamic end) =>
      between(start, end, inclusive: true);

  @override
  bool betweenExcluded(dynamic start, dynamic end) =>
      between(start, end, inclusive: false);

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
  bool matches(String tester) {
    final value = tester.trim();
    if (value.isEmpty) {
      return false;
    }
    final local = _localDateTimeForFormatting();
    final numeric = int.tryParse(value);
    if (numeric != null) {
      return local.year == numeric;
    }
    final matchYearMonth = _yearMonthPattern.firstMatch(value);
    if (matchYearMonth != null) {
      final year = int.parse(matchYearMonth.group(1)!);
      final month = int.parse(matchYearMonth.group(2)!);
      return local.year == year && local.month == month;
    }
    final matchFullDate = _fullDatePattern.firstMatch(value);
    if (matchFullDate != null) {
      final year = int.parse(matchFullDate.group(1)!);
      final month = int.parse(matchFullDate.group(2)!);
      final day = int.parse(matchFullDate.group(3)!);
      return local.year == year && local.month == month && local.day == day;
    }
    final matchMonthDay = _monthDayPattern.firstMatch(value);
    if (matchMonthDay != null) {
      final month = int.parse(matchMonthDay.group(1)!);
      final day = int.parse(matchMonthDay.group(2)!);
      return local.month == month && local.day == day;
    }
    final lower = value.toLowerCase();
    if (_monthNamePattern.hasMatch(lower)) {
      final monthIndex = _monthIndex(lower.split(' ').first) ?? -1;
      return monthIndex == local.month;
    }
    if (_matchesWeekdayName(lower)) {
      final weekday = _weekdayIndex(lower);
      return (local.weekday % 7) == weekday;
    }
    final timeSeconds = _timeWithSecondsPattern.firstMatch(value);
    if (timeSeconds != null &&
        _compareTime(local, timeSeconds, includeSeconds: true)) {
      return true;
    }
    final timeMinutes = _timeWithMinutesPattern.firstMatch(value);
    if (timeMinutes != null &&
        _compareTime(local, timeMinutes, includeSeconds: false)) {
      return true;
    }
    final timeHour = _timeHourPattern.firstMatch(value);
    if (timeHour != null && _compareHour(local, timeHour)) {
      return true;
    }
    final normalized = _normalizeMatcherExpression(value);
    try {
      final candidate = copy().modify(normalized);
      if (eq(candidate)) {
        return true;
      }
      final lowered = lower;
      if (_timeWithSecondsPattern.hasMatch(lowered)) {
        final current = copy()..startOfSecond();
        final modified = candidate.copy()..startOfSecond();
        return current.eq(modified);
      }
      if (_timeWithMinutesPattern.hasMatch(lowered)) {
        final current = copy()..startOfMinute();
        final modified = candidate.copy()..startOfMinute();
        return current.eq(modified);
      }
      if (_timeHourPattern.hasMatch(lowered)) {
        final current = copy()..startOfHour();
        final modified = candidate.copy()..startOfHour();
        return current.eq(modified);
      }
      if (_monthNamePattern.hasMatch(lowered)) {
        final current = copy()..startOfMonth();
        final modified = candidate.copy()..startOfMonth();
        return current.eq(modified);
      }
    } catch (_) {
      // Ignore parsing failures; fall through to false.
    }
    return false;
  }

  @override
  bool isBetween(
    CarbonInterface start,
    CarbonInterface end, {
    bool inclusive = true,
  }) => _isBetweenRange(start.dateTime, end.dateTime, inclusive: inclusive);

  bool _isBetweenRange(
    DateTime start,
    DateTime end, {
    required bool inclusive,
  }) {
    var lower = start;
    var upper = end;
    if (lower.isAfter(upper)) {
      final temp = lower;
      lower = upper;
      upper = temp;
    }
    if (inclusive) {
      return !_dateTime.isBefore(lower) && !_dateTime.isAfter(upper);
    }
    return _dateTime.isAfter(lower) && _dateTime.isBefore(upper);
  }

  DateTime _endExclusive(DateTime exclusive) =>
      exclusive.subtract(const Duration(microseconds: 1));

  bool _isWithin(DateTime startInclusive, DateTime endExclusive) =>
      !_dateTime.isBefore(startInclusive) && _dateTime.isBefore(endExclusive);

  @override
  bool isWeekday() => !_weekendDays.contains(_dateTime.weekday);

  @override
  bool isWeekend() => _weekendDays.contains(_dateTime.weekday);

  @override
  bool isYesterday() {
    final now = _nowUtc();
    final todayStart = _startOfDayUtcForZone(now, timeZone: _timeZone);
    final yesterdayStart = _startOfDayUtcForZone(
      now,
      timeZone: _timeZone,
      dayOffset: -1,
    );
    return _isWithin(yesterdayStart, todayStart);
  }

  @override
  bool isToday() {
    final now = _nowUtc();
    final todayStart = _startOfDayUtcForZone(now, timeZone: _timeZone);
    final tomorrowStart = _startOfDayUtcForZone(
      now,
      timeZone: _timeZone,
      dayOffset: 1,
    );
    return _isWithin(todayStart, tomorrowStart);
  }

  @override
  bool isTomorrow() {
    final now = _nowUtc();
    final tomorrowStart = _startOfDayUtcForZone(
      now,
      timeZone: _timeZone,
      dayOffset: 1,
    );
    final dayAfterTomorrow = _startOfDayUtcForZone(
      now,
      timeZone: _timeZone,
      dayOffset: 2,
    );
    return _isWithin(tomorrowStart, dayAfterTomorrow);
  }

  @override
  bool isFuture() => _dateTime.isAfter(_nowUtc());

  @override
  bool isPast() => _dateTime.isBefore(_nowUtc());

  @override
  bool isNowOrFuture() => !_dateTime.isBefore(_nowUtc());

  @override
  bool isNowOrPast() => !_dateTime.isAfter(_nowUtc());

  @override
  bool isLeapYear() {
    final year = _dateTime.year;
    if (year % 4 != 0) {
      return false;
    }
    if (year % 100 != 0) {
      return true;
    }
    return year % 400 == 0;
  }

  @override
  CarbonInterface min([dynamic other]) {
    final comparison = _coerceToCarbonInterface(other);
    return _dateTime.isBefore(comparison.dateTime) ? this : comparison;
  }

  @override
  CarbonInterface minimum([dynamic other]) => min(other);

  @override
  CarbonInterface max([dynamic other]) {
    final comparison = _coerceToCarbonInterface(other);
    return _dateTime.isAfter(comparison.dateTime) ? this : comparison;
  }

  @override
  CarbonInterface maximum([dynamic other]) => max(other);

  @override
  CarbonInterface closest(dynamic date1, dynamic date2) {
    final first = _coerceToCarbonInterface(date1);
    final second = _coerceToCarbonInterface(date2);
    final firstDelta = (_dateTime.difference(first.dateTime).inMicroseconds)
        .abs();
    final secondDelta = (_dateTime.difference(second.dateTime).inMicroseconds)
        .abs();
    return firstDelta < secondDelta ? first : second;
  }

  @override
  CarbonInterface farthest(dynamic date1, dynamic date2) {
    final first = _coerceToCarbonInterface(date1);
    final second = _coerceToCarbonInterface(date2);
    final firstDelta = (_dateTime.difference(first.dateTime).inMicroseconds)
        .abs();
    final secondDelta = (_dateTime.difference(second.dateTime).inMicroseconds)
        .abs();
    return firstDelta > secondDelta ? first : second;
  }

  @override
  bool isBirthday([dynamic comparison]) {
    final reference = _coerceToDateTime(comparison);
    return _dateTime.month == reference.month && _dateTime.day == reference.day;
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
  bool isCurrentMillisecond() => _isCurrentUnit(_ComparisonUnit.millisecond);

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
  bool isCurrentMillennium() => _isCurrentUnit(_ComparisonUnit.millennium);

  @override
  bool isNextMillennium() => _isNextUnit(_ComparisonUnit.millennium);

  @override
  bool isLastMillennium() => _isLastUnit(_ComparisonUnit.millennium);

  @override
  bool isSameMillennium([CarbonInterface? other]) =>
      _isSameUnitWithTarget(_ComparisonUnit.millennium, other);

  @override
  Duration diff(CarbonInterface other) => _dateTime.difference(other.dateTime);

  @override
  CarbonInterval diffAsCarbonInterval(
    CarbonInterface other, {
    bool absolute = true,
  }) {
    final ascending = !_dateTime.isAfter(other.dateTime);
    var start = ascending ? _dateTime : other.dateTime;
    var end = ascending ? other.dateTime : _dateTime;
    var months = _adjustedMonthDelta(start, end);
    if (months < 0) {
      months = -months;
    }
    final anchor = _addMonths(start, months, monthOverflow: true);
    final remainderMicros = end.difference(anchor).inMicroseconds;
    var monthSpan = ascending ? months : -months;
    var micros = ascending ? remainderMicros : -remainderMicros;
    if (absolute) {
      monthSpan = monthSpan.abs();
      micros = micros.abs();
    }
    return CarbonInterval._(monthSpan: monthSpan, microseconds: micros);
  }

  @override
  Duration diffAsDateInterval(CarbonInterface other, {bool absolute = false}) {
    final delta = diff(other);
    if (!absolute) {
      return delta;
    }
    final micros = delta.inMicroseconds;
    return Duration(microseconds: micros.abs());
  }

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
  double diffInUnit(
    dynamic unitInput,
    CarbonInterface other, {
    bool absolute = false,
  }) {
    final resolved = _carbonUnitFromInput(unitInput);
    if (resolved == null) {
      throw ArgumentError('Unknown diff unit "$unitInput"');
    }
    switch (resolved) {
      case CarbonUnit.microsecond:
        return floatDiffInMicroseconds(other, absolute: absolute);
      case CarbonUnit.millisecond:
        return floatDiffInMilliseconds(other, absolute: absolute);
      case CarbonUnit.second:
        return floatDiffInSeconds(other, absolute: absolute);
      case CarbonUnit.minute:
        return floatDiffInMinutes(other, absolute: absolute);
      case CarbonUnit.hour:
        return floatDiffInHours(other, absolute: absolute);
      case CarbonUnit.day:
        return floatDiffInDays(other, absolute: absolute);
      case CarbonUnit.week:
        return floatDiffInWeeks(other, absolute: absolute);
      case CarbonUnit.month:
        return _diffInMonthsDouble(other, absolute: absolute);
      case CarbonUnit.quarter:
        return _diffInMonthsDouble(other, monthsPerUnit: 3, absolute: absolute);
      case CarbonUnit.year:
        return _diffInYearsDouble(other, absolute: absolute);
      case CarbonUnit.decade:
        return _diffInYearsDouble(other, absolute: absolute) / 10;
      case CarbonUnit.century:
        return _diffInYearsDouble(other, absolute: absolute) / 100;
      case CarbonUnit.millennium:
        return _diffInYearsDouble(other, absolute: absolute) / 1000;
    }
  }

  @override
  int diffInDaysFloored(CarbonInterface other) =>
      _dateTime.difference(other.dateTime).inDays;

  @override
  double floatDiffInMicroseconds(
    CarbonInterface other, {
    bool absolute = true,
  }) => _floatDiffLinear(
    other,
    const Duration(microseconds: 1),
    absolute: absolute,
  );

  @override
  double floatDiffInMilliseconds(
    CarbonInterface other, {
    bool absolute = true,
  }) => _floatDiffLinear(
    other,
    const Duration(milliseconds: 1),
    absolute: absolute,
  );

  @override
  double floatDiffInSeconds(CarbonInterface other, {bool absolute = true}) =>
      _floatDiffLinear(other, const Duration(seconds: 1), absolute: absolute);

  @override
  double floatDiffInMinutes(CarbonInterface other, {bool absolute = true}) =>
      _floatDiffLinear(other, const Duration(minutes: 1), absolute: absolute);

  @override
  double floatDiffInHours(CarbonInterface other, {bool absolute = true}) =>
      _floatDiffLinear(other, const Duration(hours: 1), absolute: absolute);

  @override
  double floatDiffInDays(CarbonInterface other, {bool absolute = true}) =>
      _floatDiffLinear(other, const Duration(days: 1), absolute: absolute);

  @override
  double floatDiffInWeeks(CarbonInterface other, {bool absolute = true}) =>
      _floatDiffLinear(other, const Duration(days: 7), absolute: absolute);

  @override
  double floatDiffInMonths(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsDouble(other, absolute: absolute);

  @override
  double floatDiffInQuarters(CarbonInterface other, {bool absolute = true}) =>
      _diffInMonthsDouble(other, monthsPerUnit: 3, absolute: absolute);

  @override
  double floatDiffInYears(CarbonInterface other, {bool absolute = true}) =>
      _diffInYearsDouble(other, absolute: absolute);

  @override
  double floatDiffInDecades(CarbonInterface other, {bool absolute = true}) =>
      _diffInYearsDouble(other, absolute: absolute) / 10;

  @override
  double floatDiffInCenturies(CarbonInterface other, {bool absolute = true}) =>
      _diffInYearsDouble(other, absolute: absolute) / 100;

  @override
  double floatDiffInMillennia(CarbonInterface other, {bool absolute = true}) =>
      _diffInYearsDouble(other, absolute: absolute) / 1000;

  @override
  double diffInUTCMicros([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(
        const Duration(microseconds: 1),
        date,
        absolute: absolute,
      );

  @override
  double diffInUTCMicroseconds([dynamic date, bool absolute = true]) =>
      diffInUTCMicros(date, absolute);

  @override
  double diffInUTCMillis([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(
        const Duration(milliseconds: 1),
        date,
        absolute: absolute,
      );

  @override
  double diffInUTCMilliseconds([dynamic date, bool absolute = true]) =>
      diffInUTCMillis(date, absolute);

  @override
  double diffInUTCSeconds([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(
        const Duration(seconds: 1),
        date,
        absolute: absolute,
      );

  @override
  double diffInUTCMinutes([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(
        const Duration(minutes: 1),
        date,
        absolute: absolute,
      );

  @override
  double diffInUTCHours([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(hours: 1), date, absolute: absolute);

  @override
  double diffInUTCDays([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(days: 1), date, absolute: absolute);

  @override
  double diffInUTCWeeks([dynamic date, bool absolute = true]) =>
      _diffInUTCByDuration(const Duration(days: 7), date, absolute: absolute);

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

  double _diffInRealUnit(
    CarbonInterface other,
    int unitMicros, {
    bool absolute = true,
  }) {
    final delta =
        (_dateTime.microsecondsSinceEpoch -
                other.dateTime.microsecondsSinceEpoch)
            .toDouble() /
        unitMicros;
    return absolute ? delta.abs() : delta;
  }

  @override
  double diffInRealSeconds(CarbonInterface other, {bool absolute = true}) =>
      _diffInRealUnit(
        other,
        Duration.microsecondsPerSecond,
        absolute: absolute,
      );

  @override
  double diffInRealMinutes(CarbonInterface other, {bool absolute = true}) =>
      _diffInRealUnit(
        other,
        Duration.microsecondsPerMinute,
        absolute: absolute,
      );

  @override
  double diffInRealHours(CarbonInterface other, {bool absolute = true}) =>
      _diffInRealUnit(other, Duration.microsecondsPerHour, absolute: absolute);

  @override
  double diffInRealDays(CarbonInterface other, {bool absolute = true}) =>
      _diffInRealUnit(other, Duration.microsecondsPerDay, absolute: absolute);

  @override
  double diffInRealWeeks(CarbonInterface other, {bool absolute = true}) =>
      _diffInRealUnit(
        other,
        Duration.microsecondsPerDay * 7,
        absolute: absolute,
      );

  @override
  double diffInRealMilliseconds(
    CarbonInterface other, {
    bool absolute = true,
  }) => _diffInRealUnit(
    other,
    Duration.microsecondsPerMillisecond,
    absolute: absolute,
  );

  @override
  double diffInRealMicroseconds(
    CarbonInterface other, {
    bool absolute = true,
  }) => _diffInRealUnit(other, 1, absolute: absolute);

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
  String toIso8601String({bool keepOffset = false}) {
    if (keepOffset && _timeZone != null && _timeZone != 'UTC') {
      final local = _localDateTimeForFormatting();
      return _formatIso(local, offset: _currentOffset(), suffix: false);
    }
    return _formatIso(_dateTime.toUtc(), suffix: true);
  }

  @override
  String toIso8601ZuluString() => _formatIso(_dateTime.toUtc(), suffix: true);

  @override
  String toISOString({bool keepOffset = false}) =>
      toIso8601String(keepOffset: keepOffset);

  @override
  String toJsonString() => toIso8601String();

  @override
  String toJSON() => toJsonString();

  static String Function(CarbonInterface)? _serializationOverride;

  static void serializeUsing(String Function(CarbonInterface) exporter) {
    _serializationOverride = exporter;
  }

  static void resetSerializationFormat() {
    _serializationOverride = null;
  }

  @override
  String serialize() =>
      _serializationOverride?.call(this) ?? jsonEncode(_serializationPayload());

  Map<String, Object?> _serializationPayload() => <String, Object?>{
    'version': _serializationVersion,
    'type': _isMutable
        ? _serializationTypeMutable
        : _serializationTypeImmutable,
    'iso': toIso8601String(keepOffset: true),
    'locale': _locale,
    if (_timeZone != null) 'timeZone': _timeZone,
    'settings': {
      'monthOverflow': _settings.monthOverflow,
      'startOfWeek': _settings.startOfWeek,
    },
  };

  @override
  String toDateString() => _formatDatePart(_localDateTimeForFormatting());

  @override
  String toTimeString() => _formatTimePart(_localDateTimeForFormatting());

  @override
  String toDateTimeString() {
    final local = _localDateTimeForFormatting();
    return '${_formatDatePart(local)} ${_formatTimePart(local)}';
  }

  @override
  DateTime toDateTime() => _localSnapshot();

  @override
  DateTime toDateTimeImmutable() => toDateTime();

  @override
  DateTime toDate() {
    final local = _localDateTimeForFormatting();
    return DateTime.utc(local.year, local.month, local.day);
  }

  @override
  String toDateTimeLocalString([String precision = 'second']) {
    final local = _localDateTimeForFormatting();
    final normalized = precision.toLowerCase();
    final mode = switch (normalized) {
      'minute' => _LocalPrecision.minute,
      'second' => _LocalPrecision.second,
      'millisecond' => _LocalPrecision.millisecond,
      'microsecond' || 'µs' => _LocalPrecision.microsecond,
      _ => throw ArgumentError(
        'Precision unit expected among: minute, second, millisecond and microsecond.',
      ),
    };
    return _formatLocalDateTime(local, mode, reference: _dateTime);
  }

  @override
  String toFormattedDateString() {
    final local = _localDateTimeForFormatting();
    final month = _localizedMonthShortName(_locale, local.month);
    return '$month ${local.day}, ${_padYear(local.year)}';
  }

  @override
  String toDayDateTimeString() {
    final local = _localDateTimeForFormatting();
    final weekday = _localizedWeekdayShortName(_locale, local.weekday);
    final month = _localizedMonthShortName(_locale, local.month);
    return '$weekday, $month ${local.day}, ${_padYear(local.year)} ${_formatTwelveHour(local, _locale)}';
  }

  @override
  String toFormattedDayDateString() {
    final local = _localDateTimeForFormatting();
    final weekday = _localizedWeekdayShortName(_locale, local.weekday);
    final month = _localizedMonthShortName(_locale, local.month);
    return '$weekday, $month ${local.day}, ${_padYear(local.year)}';
  }

  @override
  String toAtomString() {
    final local = _localDateTimeForFormatting();
    return '${_formatDatePart(local)}T${_formatTimePart(local)}${_formatOffset(_currentOffset())}';
  }

  @override
  String toCookieString() {
    final local = _localDateTimeForFormatting();
    final localeData = CarbonTranslator.matchLocale('en');
    final weekday = localeData.weekdays[local.weekday % 7];
    final month = localeData.monthsShort[local.month - 1];
    final day = _twoDigits(local.day);
    final base =
        '$weekday, $day-$month-${_padYear(local.year)} ${_formatTimePart(local)}';
    return '$base GMT${_formatOffset(_currentOffset())}';
  }

  @override
  String isoFormat(String pattern) => _IsoFormatter(this).format(pattern);

  @override
  String translatedFormat(String pattern) =>
      isoFormat(_TranslatedFormatConverter(pattern).toIsoPattern());

  @override
  String toRfc822String() => _formatRfcFamily(shortYear: true);

  @override
  String toRfc1036String() => _formatRfcFamily(shortYear: true);

  @override
  String toRfc1123String() => _formatRfcFamily(shortYear: false);

  @override
  String toRfc2822String() => _formatRfcFamily(shortYear: false);

  @override
  String toRssString() => _formatRfcFamily(shortYear: false);

  @override
  String toRfc850String() {
    final local = _localDateTimeForFormatting();
    final snapshot = _zoneSnapshot();
    final offset = snapshot?.offset ?? _currentOffset();
    final zone = _zoneAbbreviationFromSnapshot(snapshot, offset);
    final localeData = CarbonTranslator.matchLocale('en');
    final weekday = localeData.weekdays[local.weekday % 7];
    final month = localeData.monthsShort[local.month - 1];
    return '$weekday, ${_twoDigits(local.day)}-$month-${_twoDigitYear(local)} ${_formatTimePart(local)} $zone';
  }

  @override
  String toRfc3339String({bool extended = false}) {
    final local = _localDateTimeForFormatting();
    final buffer = StringBuffer()
      ..write(_formatDatePart(local))
      ..write('T')
      ..write(_formatTimePart(local));
    if (extended) {
      final millis =
          (_fractionalMicroseconds(local, reference: _dateTime) ~/ 1000)
              .toString()
              .padLeft(3, '0');
      buffer
        ..write('.')
        ..write(millis);
    }
    buffer.write(_formatOffset(_currentOffset()));
    return buffer.toString();
  }

  @override
  String toW3cString() => toRfc3339String();

  @override
  String toRfc7231String() {
    final utc = _dateTime.toUtc();
    final localeData = CarbonTranslator.matchLocale('en');
    final weekday = localeData.weekdaysShort[utc.weekday % 7];
    final month = localeData.monthsShort[utc.month - 1];
    return '$weekday, ${_twoDigits(utc.day)} $month ${_padYear(utc.year)} ${_formatTimePart(utc)} GMT';
  }

  String _formatRfcFamily({required bool shortYear}) {
    final local = _localDateTimeForFormatting();
    final localeData = CarbonTranslator.matchLocale('en');
    final weekday = localeData.weekdaysShort[local.weekday % 7];
    final month = localeData.monthsShort[local.month - 1];
    final year = shortYear ? _twoDigitYear(local) : _padYear(local.year);
    return '$weekday, ${_twoDigits(local.day)} $month $year ${_formatTimePart(local)} ${_formatOffset(_currentOffset(), compact: true)}';
  }

  @override
  String diffForHumans({
    CarbonInterface? reference,
    String? locale,
    int parts = 1,
    bool short = false,
    String joiner = ' ',
  }) {
    final localeMatch = CarbonTranslator.matchLocale(locale ?? _locale);
    final humanLocale = localeMatch;
    CarbonTranslator.ensureTimeagoLocale(humanLocale.localeCode);
    final base = (reference?.dateTime ?? clock.now()).toUtc();
    if (parts <= 1) {
      final result = timeago.format(
        _dateTime,
        locale: humanLocale.localeCode,
        allowFromNow: true,
        clock: base,
      );
      return CarbonTranslator.translateTimeString(
        result,
        locale: humanLocale.localeCode,
      );
    }

    final diff = _dateTime.difference(base);
    if (diff == Duration.zero) {
      final diffNowKey = short ? 'now' : 'diff_now';
      return humanLocale.translationStrings[diffNowKey] ??
          (short ? 'now' : 'just now');
    }
    final future = diff > Duration.zero;
    final segments = _buildHumanDiffSegments(
      diff.abs(),
      short: short,
      limit: parts,
    );
    final translatedSegments = segments
        .map(
          (segment) => CarbonTranslator.translateTimeString(
            segment,
            locale: humanLocale.localeCode,
          ),
        )
        .toList();

    // Use locale list separators if available, otherwise use joiner parameter
    String joined;
    if (translatedSegments.length <= 1) {
      joined = translatedSegments.join();
    } else if (humanLocale.listSeparators.isEmpty) {
      // No locale separators, use joiner parameter
      joined = translatedSegments.join(joiner);
    } else {
      // Use locale list separators
      final regularSep = humanLocale.listSeparators.isNotEmpty
          ? humanLocale.listSeparators[0]
          : joiner;
      final finalSep = humanLocale.listSeparators.length > 1
          ? humanLocale.listSeparators[1]
          : regularSep;

      if (translatedSegments.length == 2) {
        joined = translatedSegments.join(finalSep);
      } else {
        final allButLast = translatedSegments.sublist(
          0,
          translatedSegments.length - 1,
        );
        final last = translatedSegments.last;
        joined = allButLast.join(regularSep) + finalSep + last;
      }
    }

    // Use localized templates from translation strings
    final key = future ? 'from_now' : 'ago';
    final template =
        humanLocale.translationStrings[key] ??
        (future
            ? (short ? ':time' : 'in :time')
            : (short ? ':time' : ':time ago'));

    final text = template.replaceAll(':time', joined);
    return CarbonTranslator.translateTimeString(
      text,
      locale: humanLocale.localeCode,
    );
  }

  @override
  String calendar({CarbonInterface? reference, Map<String, String>? formats}) {
    final ref = reference ?? Carbon.now();

    // Calculate difference in days using start of day comparison
    // Match PHP: $other->diffInDays($current) where $other=ref, $current=self
    // Note: Dart's diffInDays has opposite sign semantics from PHP
    // PHP: ref.diffInDays(target) = +1 when target is tomorrow
    // Dart: ref.diffInDays(target) = -1 when target is tomorrow
    // So we negate the result to match PHP behavior
    final startOfSelf = copy().startOfDay();
    final startOfRef = ref.copy().startOfDay();
    final diff = -startOfRef.diffInDays(startOfSelf, absolute: false);

    final format = formats ?? CarbonTranslator.matchLocale(_locale).calendar;

    String formatString;
    if (diff < -6) {
      formatString = format['sameElse'] ?? 'L';
    } else if (diff < -1) {
      formatString = format['lastWeek'] ?? 'L';
    } else if (diff < 0) {
      formatString = format['lastDay'] ?? 'L';
    } else if (diff < 1) {
      formatString = format['sameDay'] ?? 'L';
    } else if (diff < 2) {
      formatString = format['nextDay'] ?? 'L';
    } else if (diff < 7) {
      formatString = format['nextWeek'] ?? 'L';
    } else {
      formatString = format['sameElse'] ?? 'L';
    }

    return isoFormat(formatString);
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
  CarbonInterface setDateFrom(CarbonInterface source) {
    final other = source.dateTime;
    return _duplicate(
      dateTime: _copyWith(year: other.year, month: other.month, day: other.day),
    );
  }

  @override
  CarbonInterface setTimeFrom(CarbonInterface source) {
    final other = source.dateTime;
    return _duplicate(
      dateTime: _copyWith(
        hour: other.hour,
        minute: other.minute,
        second: other.second,
        millisecond: other.millisecond,
        microsecond: other.microsecond,
      ),
    );
  }

  @override
  CarbonInterface setDateTimeFrom(CarbonInterface source) {
    final other = source.dateTime;
    return _duplicate(dateTime: other);
  }

  @override
  int get isoWeek => _isoWeekSnapshot.$1;

  @override
  int get isoWeekYear => _isoWeekSnapshot.$2;

  @override
  int get isoWeeksInYear => _isoWeeksInYearInternal(_dateTime.year);

  @override
  int get localeWeek => _localeWeekSnapshot.$1;

  @override
  int get localeWeekYear => _localeWeekSnapshot.$2;

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
  Map<String, dynamic> toArray() =>
      Map<String, dynamic>.unmodifiable(_componentSnapshot());

  @override
  CarbonComponents toObject() => CarbonComponents.fromMap(_componentSnapshot());

  /// Returns a structured snapshot similar to PHP Carbon's `__debugInfo`.
  ///
  /// The payload includes the formatted local date/time, timezone metadata,
  /// and translator details when the locale differs from [_defaultLocale].
  @override
  Map<String, Object?> toDebugMap() {
    final snapshot = _zoneSnapshot();
    final offset = snapshot?.offset ?? _currentOffset();
    final timezoneName = _timeZone ?? snapshot?.abbreviation ?? 'UTC';
    final abbreviation = snapshot?.abbreviation ?? timezoneName;
    final map = <String, Object?>{
      'date': DateFormat(
        'yyyy-MM-dd HH:mm:ss.SSSSSS',
      ).format(_localDateTimeForFormatting()),
      'timezone': {
        'name': timezoneName,
        'abbreviation': abbreviation,
        'offset': _formatOffset(offset),
        'offsetSeconds': offset.inSeconds,
        'isDst': snapshot?.isDst ?? false,
      },
      'timezoneType': 3,
    };
    if (_locale != _defaultLocale) {
      map['locale'] = _locale;
      map['translator'] = {
        'type': 'CarbonTranslator',
        'locale': _locale,
        'fallbackLocale': _defaultLocale,
      };
    }
    return map;
  }

  Map<String, dynamic> _componentSnapshot() => <String, dynamic>{
    'year': year,
    'month': month,
    'day': day,
    'dayOfWeek': dayOfWeek,
    'dayOfYear': dayOfYear,
    'hour': hour,
    'minute': minute,
    'second': second,
    'micro': microsecond,
    'timestamp':
        _dateTime.microsecondsSinceEpoch ~/ Duration.microsecondsPerSecond,
    'timezone': _timeZone ?? 'UTC',
    'formatted': toDateTimeString(),
  };

  static CarbonInterface deserializeSerialized(dynamic payload) =>
      _deserializeSerialized(payload);

  static CarbonInterface _deserializeSerialized(dynamic payload) {
    final map = _coerceSerializedMap(payload);
    final iso = map['iso'];
    if (iso is! String || iso.isEmpty) {
      _throwInvalidSerialized(payload);
    }
    CarbonInterface instance = Carbon.parse(iso);
    final timeZone = map['timeZone'];
    if (timeZone is String && timeZone.isNotEmpty) {
      instance = instance.tz(timeZone);
    }
    final locale = map['locale'];
    if (locale is String && locale.isNotEmpty) {
      instance = instance.locale(locale);
    }
    final settings = _settingsFromSerialized(map['settings']);
    instance = instance.copyWith(settings: settings);
    final type = (map['type'] as String?) ?? _serializationTypeMutable;
    return type == _serializationTypeImmutable
        ? instance.toImmutable()
        : instance;
  }

  static Map<String, dynamic> _coerceSerializedMap(dynamic input) {
    dynamic raw = input;
    if (input is String) {
      try {
        raw = jsonDecode(input);
      } catch (_) {
        _throwInvalidSerialized(input);
      }
    } else if (input is Map<String, dynamic>) {
      raw = input;
    } else if (input is Map) {
      raw = input.map((key, value) => MapEntry(key.toString(), value));
    } else {
      _throwInvalidSerialized(input);
    }
    if (raw is! Map<String, dynamic>) {
      _throwInvalidSerialized(input);
    }
    final Object? version = raw['version'];
    if (version != null && version != _serializationVersion) {
      throw ArgumentError('Unsupported serialized value version: $version');
    }
    return raw;
  }

  static CarbonSettings _settingsFromSerialized(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final overflow = raw['monthOverflow'];
      final start = raw['startOfWeek'];
      return CarbonSettings(
        monthOverflow: overflow is bool ? overflow : true,
        startOfWeek: start is int ? _normalizeWeekday(start) : DateTime.monday,
      );
    }
    if (raw is Map) {
      final normalized = raw.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      final overflow = normalized['monthOverflow'];
      final start = normalized['startOfWeek'];
      return CarbonSettings(
        monthOverflow: overflow is bool ? overflow : true,
        startOfWeek: start is int ? _normalizeWeekday(start) : DateTime.monday,
      );
    }
    return const CarbonSettings();
  }

  static Never _throwInvalidSerialized(dynamic value) =>
      throw ArgumentError('Invalid serialized value: $value');

  DateTime _localSnapshot() {
    final local = _localDateTimeForFormatting();
    var micros =
        _dateTime.microsecondsSinceEpoch % Duration.microsecondsPerSecond;
    if (micros < 0) {
      micros += Duration.microsecondsPerSecond;
    }
    return DateTime.utc(
      local.year,
      local.month,
      local.day,
      local.hour,
      local.minute,
      local.second,
      micros ~/ 1000,
      micros % 1000,
    );
  }

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
      abbreviation: zoneInterval.name.isNotEmpty ? zoneInterval.name : zone.id,
      offset: Duration(seconds: zoned.offset.inSeconds),
      isDst: zoneInterval.savings != tm.Offset.zero,
    );
  }

  static tm.DateTimeZone _getZoneOrThrow(String zoneName) {
    final provider = _zoneProvider;
    if (provider == null) {
      throw CarbonInvalidTimeZoneException(
        zoneName,
        reason:
            'Named timezone "$zoneName" requires calling Carbon.configureTimeMachine() first.',
      );
    }
    return _zoneCache.putIfAbsent(zoneName, () {
      try {
        return provider.getDateTimeZoneSync(zoneName);
      } on Object {
        throw CarbonInvalidTimeZoneException(zoneName);
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

  String _formatOffset(
    Duration offset, {
    bool includePrefix = false,
    bool compact = false,
  }) {
    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absMinutes = totalMinutes.abs();
    final hours = (absMinutes ~/ 60).toString().padLeft(2, '0');
    final minutes = (absMinutes % 60).toString().padLeft(2, '0');
    final separator = compact ? '' : ':';
    final core = '$sign$hours$separator$minutes';
    return includePrefix ? 'GMT$core' : core;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final name = _symbolToName(invocation.memberName);
    final propertyMacroResult = _invokePropertyMacro(name, invocation);
    if (!identical(propertyMacroResult, _aliasNotHandled)) {
      if (identical(propertyMacroResult, _handledPropertyMacro)) {
        return null;
      }
      return propertyMacroResult;
    }
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
    final fallback = _handleUnknownInvocation(name, invocation);
    if (!identical(fallback, _aliasNotHandled)) {
      return fallback;
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

  Object _invokePropertyMacro(String name, Invocation invocation) {
    final isSetter = name.endsWith('=');
    final trimmed = isSetter ? name.substring(0, name.length - 1) : name;
    if (trimmed.isEmpty) {
      return _aliasNotHandled;
    }
    final pascal = trimmed[0].toUpperCase() + trimmed.substring(1);
    if (invocation.isGetter && !isSetter) {
      final getter = _macros['get$pascal'];
      if (getter != null) {
        return getter(this, const [], const {});
      }
    }
    if (isSetter) {
      final setter = _macros['set$pascal'];
      if (setter != null) {
        setter(this, invocation.positionalArguments, invocation.namedArguments);
        return _handledPropertyMacro;
      }
    }
    return _aliasNotHandled;
  }

  Object? _handleUnknownInvocation(String name, Invocation invocation) {
    final isSetter = invocation.isSetter;
    final trimmed = isSetter && name.isNotEmpty
        ? name.substring(0, name.length - 1)
        : name;
    if (trimmed.isEmpty) {
      return _aliasNotHandled;
    }
    if (invocation.isGetter) {
      if (_strictMode) {
        throw CarbonUnknownGetterException(trimmed);
      }
      return _dynamicProperties?[trimmed];
    }
    if (isSetter) {
      if (_strictMode) {
        throw CarbonUnknownSetterException(trimmed);
      }
      final value = invocation.positionalArguments.isEmpty
          ? null
          : invocation.positionalArguments.first;
      final target = _dynamicProperties ??= <String, dynamic>{};
      target[trimmed] = value;
      return value;
    }
    if (invocation.isMethod) {
      if (_strictMode) {
        throw CarbonUnknownMethodException(trimmed);
      }
      return null;
    }
    return _aliasNotHandled;
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

  CarbonInterface _instantiateRelative(DateTime value) {
    final normalized = value.toUtc();
    if (_isMutable) {
      return Carbon._internal(
        dateTime: normalized,
        locale: _locale,
        timeZone: _timeZone,
        settings: _settings,
      );
    }
    return CarbonImmutable._internal(
      dateTime: normalized,
      locale: _locale,
      timeZone: _timeZone,
      settings: _settings,
    );
  }

  CarbonInterface _coerceToCarbonInterface(dynamic input) {
    if (input is CarbonInterface) {
      return input;
    }
    return _instantiateRelative(_coerceToDateTime(input));
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
    // Create interval from step information
    final CarbonInterval interval;
    if (monthStep != null) {
      interval = CarbonInterval.months(monthStep);
    } else {
      interval = CarbonInterval.fromDuration(durationStep!);
    }

    return CarbonPeriod._(
      items,
      locale: _locale,
      interval: interval,
      explicitlyLimited: false,
    );
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
    final lowered = function.toLowerCase();
    var rounded = _applyRoundFunction(quotient, function) * stepMicros;
    if (lowered == 'ceil' && rounded <= current) {
      rounded = current + stepMicros;
    }
    final micros = rounded.round();
    final roundedDate = DateTime.fromMicrosecondsSinceEpoch(
      micros,
      isUtc: true,
    );
    return _wrap(roundedDate);
  }

  CarbonInterface _roundMonthUnit(
    double precisionInMonths,
    String function, {
    int monthOffset = 0,
    bool useOneBasedRounding = false,
  }) {
    final normalized = _normalizePrecision(precisionInMonths);
    if (normalized == null) {
      return this;
    }
    final lowered = function.toLowerCase();
    final value =
        _monthPosition(_dateTime) -
        monthOffset +
        ((useOneBasedRounding && lowered == 'round') ? 1 : 0);
    final quotient = value / normalized;
    var rounded = _applyRoundFunction(quotient, function) * normalized;
    if (lowered == 'ceil' && rounded <= value) {
      rounded = value + normalized;
    }
    final date = _dateFromMonthPosition(rounded + monthOffset);
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

  @override
  CarbonInterface modify(String expression) {
    final normalized = expression.trim().toLowerCase();
    if (normalized.isEmpty) {
      throw ArgumentError('modify expression cannot be empty');
    }
    final durationResult = _trySignedDuration(normalized);
    if (durationResult != null) {
      return durationResult;
    }
    final keywordResult = _tryRelativeKeyword(normalized);
    if (keywordResult != null) {
      return keywordResult;
    }
    throw ArgumentError('Unsupported modify expression "$expression"');
  }

  @override
  CarbonInterface change(String expression) => modify(expression);

  @override
  CarbonInterface relative(String expression) => CarbonImmutable._internal(
    dateTime: _dateTime,
    locale: _locale,
    timeZone: _timeZone,
    settings: _settings,
  ).modify(expression);

  @override
  CarbonInterface next([dynamic input]) {
    if (input is String) {
      final token = _parseTimeToken(input);
      if (token != null) {
        return _moveToTimeOfDay(token, forward: true);
      }
    }
    return _moveToWeekday(input, forward: true);
  }

  @override
  CarbonInterface previous([dynamic input]) {
    if (input is String) {
      final token = _parseTimeToken(input);
      if (token != null) {
        return _moveToTimeOfDay(token, forward: false);
      }
    }
    return _moveToWeekday(input, forward: false);
  }

  @override
  CarbonInterface addRealSeconds(num value) =>
      _applyRealDuration(value, _RealUnit.second);

  @override
  CarbonInterface subRealSeconds(num value) => addRealSeconds(-value);

  @override
  CarbonInterface addRealMinutes(num value) =>
      _applyRealDuration(value, _RealUnit.minute);

  @override
  CarbonInterface subRealMinutes(num value) => addRealMinutes(-value);

  @override
  CarbonInterface addRealHours(num value) =>
      _applyRealDuration(value, _RealUnit.hour);

  @override
  CarbonInterface subRealHours(num value) => addRealHours(-value);

  @override
  CarbonInterface addRealDays(num value) =>
      _applyRealDuration(value, _RealUnit.day);

  @override
  CarbonInterface subRealDays(num value) => addRealDays(-value);

  @override
  CarbonInterface addRealWeeks(num value) =>
      _applyRealDuration(value, _RealUnit.week);

  @override
  CarbonInterface subRealWeeks(num value) => addRealWeeks(-value);

  @override
  CarbonInterface addRealMonths(num value) =>
      _applyRealDuration(value, _RealUnit.month);

  @override
  CarbonInterface subRealMonths(num value) => addRealMonths(-value);

  @override
  CarbonInterface addRealQuarters(num value) =>
      _applyRealDuration(value, _RealUnit.quarter);

  @override
  CarbonInterface subRealQuarters(num value) => addRealQuarters(-value);

  @override
  CarbonInterface addRealYears(num value) =>
      _applyRealDuration(value, _RealUnit.year);

  @override
  CarbonInterface subRealYears(num value) => addRealYears(-value);

  @override
  CarbonInterface addRealDecades(num value) =>
      _applyRealDuration(value, _RealUnit.decade);

  @override
  CarbonInterface subRealDecades(num value) => addRealDecades(-value);

  @override
  CarbonInterface addRealCenturies(num value) =>
      _applyRealDuration(value, _RealUnit.century);

  @override
  CarbonInterface subRealCenturies(num value) => addRealCenturies(-value);

  @override
  CarbonInterface addRealMillennia(num value) =>
      _applyRealDuration(value, _RealUnit.millennium);

  @override
  CarbonInterface subRealMillennia(num value) => addRealMillennia(-value);

  CarbonInterface _moveToWeekday(dynamic weekday, {required bool forward}) {
    final target = _resolveWeekdayInput(weekday);
    var current = _dateTime.weekday % 7;
    var delta = forward
        ? (target - current + 7) % 7
        : -((current - target + 7) % 7);
    if (delta == 0) {
      delta = forward ? 7 : -7;
    }
    return _wrap(_dateTime.add(Duration(days: delta)));
  }

  CarbonInterface _moveToTimeOfDay(
    _ParsedTimeOfDay token, {
    required bool forward,
  }) {
    final zone = _timeZone;
    final isUtcContext = zone == null || zone == 'UTC';
    final String? resolvedZone = isUtcContext ? null : zone;
    final localBase = resolvedZone == null
        ? _dateTime
        : _utcToLocal(_dateTime, resolvedZone);
    var candidate = isUtcContext
        ? DateTime.utc(
            localBase.year,
            localBase.month,
            localBase.day,
            token.hour,
            token.minute,
            token.second,
            0,
            token.microsecond,
          )
        : DateTime(
            localBase.year,
            localBase.month,
            localBase.day,
            token.hour,
            token.minute,
            token.second,
            0,
            token.microsecond,
          );
    final comparison = candidate.compareTo(localBase);
    if (forward) {
      if (comparison <= 0) {
        candidate = candidate.add(const Duration(days: 1));
      }
    } else if (comparison >= 0) {
      candidate = candidate.subtract(const Duration(days: 1));
    }
    return _wrap(
      _localToUtc(
        year: candidate.year,
        month: candidate.month,
        day: candidate.day,
        hour: candidate.hour,
        minute: candidate.minute,
        second: candidate.second,
        microsecond: candidate.microsecond,
        timeZone: zone,
      ),
    );
  }

  CarbonInterface _setToTimeOfDay(_ParsedTimeOfDay token) {
    final zone = _timeZone;
    final isUtcContext = zone == null || zone == 'UTC';
    final String? resolvedZone = isUtcContext ? null : zone;
    final localBase = resolvedZone == null
        ? _dateTime
        : _utcToLocal(_dateTime, resolvedZone);
    final candidate = isUtcContext
        ? DateTime.utc(
            localBase.year,
            localBase.month,
            localBase.day,
            token.hour,
            token.minute,
            token.second,
            0,
            token.microsecond,
          )
        : DateTime(
            localBase.year,
            localBase.month,
            localBase.day,
            token.hour,
            token.minute,
            token.second,
            0,
            token.microsecond,
          );
    return _wrap(
      _localToUtc(
        year: candidate.year,
        month: candidate.month,
        day: candidate.day,
        hour: candidate.hour,
        minute: candidate.minute,
        second: candidate.second,
        microsecond: candidate.microsecond,
        timeZone: zone,
      ),
    );
  }

  CarbonInterface _moveToThisWeekday(dynamic weekday) {
    final target = _resolveWeekdayInput(weekday);
    final current = _dateTime.weekday % 7;
    final delta = (target - current + 7) % 7;
    return _wrap(_dateTime.add(Duration(days: delta)));
  }

  static int _weekdayIndex(String input) {
    final value = input.trim().toLowerCase();
    const names = [
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
    ];
    final index = names.indexOf(value);
    if (index == -1) {
      throw ArgumentError('Unknown weekday "$input"');
    }
    return index;
  }

  static int _normalizeWeekday(int value) {
    var normalized = value % 7;
    if (normalized <= 0) {
      normalized += 7;
    }
    return normalized;
  }

  static int? _monthIndex(String input) {
    final value = input.trim().toLowerCase();
    const full = [
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'october',
      'november',
      'december',
    ];
    final index = full.indexOf(value);
    if (index != -1) {
      return index + 1;
    }
    const short = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];
    final shortIndex = short.indexOf(value);
    if (shortIndex != -1) {
      return shortIndex + 1;
    }
    return null;
  }

  bool _matchesWeekdayName(String value) {
    try {
      _weekdayIndex(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool _compareTime(
    DateTime local,
    RegExpMatch match, {
    required bool includeSeconds,
  }) {
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    if (!_isValidHour(hour) || !_isValidMinute(minute)) {
      return false;
    }
    if (includeSeconds) {
      final second = int.parse(match.group(3)!);
      if (!_isValidMinute(second)) {
        return false;
      }
      return local.hour == hour &&
          local.minute == minute &&
          local.second == second;
    }
    return local.hour == hour && local.minute == minute;
  }

  bool _compareHour(DateTime local, RegExpMatch match) {
    final token = match.group(0)!;
    final suffix = token.replaceAll(RegExp(r'\d'), '').toLowerCase();
    var hour = int.parse(match.group(1)!);
    if (suffix.endsWith('am')) {
      hour = hour == 12 ? 0 : hour % 12;
    } else if (suffix.endsWith('pm')) {
      hour = hour % 12 + 12;
    } else if (suffix.endsWith('h')) {
      hour = hour % 24;
    }
    if (!_isValidHour(hour)) {
      return false;
    }
    return local.hour == hour;
  }

  bool _isValidHour(int value) => value >= 0 && value < 24;

  bool _isValidMinute(int value) => value >= 0 && value < 60;

  String _normalizeMatcherExpression(String input) => input.replaceAllMapped(
    _hourLiteralPattern,
    (match) => '${match.group(1)}:00',
  );

  static int _daysInMonthCount(int year, int month) =>
      DateTime.utc(year, month + 1, 0).day;

  static CarbonLastErrors? _calendarWarningForIsoString(String input) {
    final match = _isoCalendarPrefixPattern.firstMatch(input.trim());
    if (match == null) {
      return null;
    }
    final year = int.tryParse(match.group(1)!);
    final month = int.tryParse(match.group(2)!);
    final day = int.tryParse(match.group(3)!);
    if (year == null || month == null || day == null) {
      return null;
    }
    if (month < 1 || month > 12) {
      return CarbonLastErrors(
        warningCount: 1,
        warnings: const <String, String>{'month': _invalidDateWarningMessage},
      );
    }
    final lastDay = _daysInMonthCount(year, month);
    if (day < 1 || day > lastDay) {
      return CarbonLastErrors(
        warningCount: 1,
        warnings: const <String, String>{'day': _invalidDateWarningMessage},
      );
    }
    return null;
  }

  static _ParsedTimeOfDay? _parseTimeToken(String input) {
    var token = input.trim().toLowerCase();
    if (token.isEmpty) {
      return null;
    }
    final hasMeridiem = token.endsWith('am') || token.endsWith('pm');
    final hasDelimiter = token.contains(':') || token.contains('h');
    if (!hasMeridiem && !hasDelimiter) {
      return null;
    }
    var meridiem = '';
    if (hasMeridiem) {
      meridiem = token.substring(token.length - 2);
      token = token.substring(0, token.length - 2).trim();
      if (token.isEmpty) {
        return null;
      }
    }
    token = token.replaceAll(RegExp(r'\s+'), '');
    token = token.replaceAll('h', ':');
    final parts = token.split(':').where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty || parts.length > 3) {
      return null;
    }
    int? parsePart(String value, int max) {
      final parsed = int.tryParse(value);
      if (parsed == null || parsed < 0 || parsed > max) {
        return null;
      }
      return parsed;
    }

    var hour = parsePart(parts[0], 23);
    if (hour == null) {
      return null;
    }
    final minute = parts.length > 1 ? parsePart(parts[1], 59) : 0;
    if (minute == null) {
      return null;
    }
    final second = parts.length > 2 ? parsePart(parts[2], 59) : 0;
    if (second == null) {
      return null;
    }
    if (meridiem.isNotEmpty) {
      if (hour > 12) {
        return null;
      }
      if (meridiem == 'am') {
        hour = hour % 12;
      } else {
        hour = hour % 12 + 12;
      }
    }
    if (hour < 0 || hour > 23) {
      return null;
    }
    return _ParsedTimeOfDay(hour, minute, second, 0);
  }

  int _resolveWeekdayInput(dynamic input) {
    if (input == null) {
      return _dateTime.weekday % 7;
    }
    if (input is int) {
      return (_normalizeWeekday(input)) % 7;
    }
    if (input is String) {
      return _weekdayIndex(input);
    }
    throw ArgumentError('Unsupported weekday input "$input"');
  }

  _TemporalUnit? _unitFromInput(dynamic input) {
    if (input == null) {
      return null;
    }
    if (input is _TemporalUnit) {
      return input;
    }
    if (input is String) {
      final key = input.trim().toLowerCase();
      return _temporalUnits[key];
    }
    if (input is CarbonUnit) {
      switch (input) {
        case CarbonUnit.microsecond:
          return _TemporalUnit.microseconds(1);
        case CarbonUnit.millisecond:
          return _TemporalUnit.microseconds(
            Duration.microsecondsPerMillisecond,
          );
        case CarbonUnit.second:
          return _TemporalUnit.microseconds(Duration.microsecondsPerSecond);
        case CarbonUnit.minute:
          return _TemporalUnit.microseconds(Duration.microsecondsPerMinute);
        case CarbonUnit.hour:
          return _TemporalUnit.microseconds(Duration.microsecondsPerHour);
        case CarbonUnit.day:
          return _TemporalUnit.microseconds(Duration.microsecondsPerDay);
        case CarbonUnit.week:
          return _TemporalUnit.microseconds(Duration.microsecondsPerDay * 7);
        case CarbonUnit.month:
          return _TemporalUnit.months(1);
        case CarbonUnit.quarter:
          return _TemporalUnit.months(3);
        case CarbonUnit.year:
          return _TemporalUnit.months(12);
        case CarbonUnit.decade:
          return _TemporalUnit.months(120);
        case CarbonUnit.century:
          return _TemporalUnit.months(1200);
        case CarbonUnit.millennium:
          return _TemporalUnit.months(12000);
      }
    }
    return null;
  }

  CarbonUnit? _carbonUnitFromInput(dynamic input) {
    if (input == null) {
      return null;
    }
    if (input is CarbonUnit) {
      return input;
    }
    if (input is String) {
      final key = input.trim().toLowerCase();
      return _carbonUnitAliases[key];
    }
    return null;
  }

  _UnitAmount? _parseUnitAmountExpression(String expression) {
    final trimmed = expression.trim().toLowerCase();
    final match = RegExp(r'^([+-]?\d+)\s+([a-z]+)$').firstMatch(trimmed);
    if (match != null) {
      final unit = _unitFromInput(match.group(2));
      if (unit != null) {
        return _UnitAmount(int.parse(match.group(1)!), unit);
      }
    }
    final unitOnly = _unitFromInput(trimmed);
    if (unitOnly != null) {
      return _UnitAmount(1, unitOnly);
    }
    return null;
  }

  CarbonInterface _applyCarbonInterval(
    CarbonInterval interval,
    bool isAddition,
  ) {
    var result = _dateTime;
    if (interval.monthSpan != 0) {
      result = _addMonths(
        result,
        isAddition ? interval.monthSpan : -interval.monthSpan,
      );
    }
    if (interval.microseconds != 0) {
      final delta = Duration(
        microseconds: isAddition
            ? interval.microseconds
            : -interval.microseconds,
      );
      result = result.add(delta);
    }
    return _wrap(result);
  }

  CarbonInterface? _trySignedDuration(String expr) {
    const unitPattern =
        r'(seconds?|minutes?|hours?|days?|weeks?|months?|years?)';
    final signed = RegExp('^([+-])(\\d+)\\s+$unitPattern\$').firstMatch(expr);
    if (signed != null) {
      final sign = signed.group(1) == '-' ? -1 : 1;
      final amount = int.parse(signed.group(2)!);
      return _applySignedDurationUnit(sign * amount, signed.group(3)!);
    }
    final ago = RegExp('^(\\d+)\\s+$unitPattern\\s+ago\$').firstMatch(expr);
    if (ago != null) {
      final amount = int.parse(ago.group(1)!);
      return _applySignedDurationUnit(-amount, ago.group(2)!);
    }
    final inMatch = RegExp('^in\\s+(\\d+)\\s+$unitPattern\$').firstMatch(expr);
    if (inMatch != null) {
      final amount = int.parse(inMatch.group(1)!);
      return _applySignedDurationUnit(amount, inMatch.group(2)!);
    }
    return null;
  }

  CarbonInterface? _applySignedDurationUnit(int quantity, String unit) {
    switch (unit) {
      case 'second':
      case 'seconds':
        return _applyDuration(Duration(seconds: quantity));
      case 'minute':
      case 'minutes':
        return _applyDuration(Duration(minutes: quantity));
      case 'hour':
      case 'hours':
        return _applyDuration(Duration(hours: quantity));
      case 'day':
      case 'days':
        return _applyDuration(Duration(days: quantity));
      case 'week':
      case 'weeks':
        return _applyDuration(Duration(days: quantity * 7));
      case 'month':
      case 'months':
        return _applyTemporalUnit(_TemporalUnit.months(1), quantity, null);
      case 'year':
      case 'years':
        return _applyTemporalUnit(_TemporalUnit.months(12), quantity, null);
    }
    return null;
  }

  CarbonInterface? _tryRelativeKeyword(String expr) {
    final weekdayTime = RegExp(
      r'^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)\s+(noon|midnight)$',
      caseSensitive: false,
    ).firstMatch(expr);
    if (weekdayTime != null) {
      final weekday = weekdayTime.group(1)!;
      final target = _moveToThisWeekday(
        weekday,
      ).dateTime; // start-of-day preserved
      final isNoon = weekdayTime.group(2)!.toLowerCase() == 'noon';
      final adjusted = DateTime.utc(
        target.year,
        target.month,
        target.day,
        isNoon ? 12 : 0,
      );
      return _wrap(adjusted);
    }

    final weekdayMonth = RegExp(
      r'^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)\s+([a-z]+)$',
      caseSensitive: false,
    ).firstMatch(expr);
    if (weekdayMonth != null) {
      final monthIndex = _monthIndex(weekdayMonth.group(2)!);
      if (monthIndex != null) {
        var year = _dateTime.year;
        if (monthIndex < _dateTime.month) {
          year += 1;
        }
        var candidate = DateTime.utc(year, monthIndex, 1);
        final weekdayIdx = _weekdayIndex(weekdayMonth.group(1)!);
        while (candidate.weekday % 7 != weekdayIdx) {
          candidate = candidate.add(const Duration(days: 1));
        }
        return _wrap(candidate);
      }
    }

    final monthOnly = _monthIndex(expr);
    if (monthOnly != null) {
      var year = _dateTime.year;
      if (monthOnly < _dateTime.month) {
        year += 1;
      }
      final firstDay = DateTime.utc(year, monthOnly, 1);
      return _wrap(firstDay);
    }

    switch (expr) {
      case 'today':
        return startOfDay();
      case 'tomorrow':
        return startOfDay().addDays(1);
      case 'yesterday':
        return startOfDay().addDays(-1);
      case 'after tomorrow':
        return startOfDay().addDays(2);
      case 'before yesterday':
        return startOfDay().addDays(-2);
      case 'first day of month':
        return startOfMonth();
      case 'last day of month':
        return endOfMonth();
      case 'first day of next month':
        final base = _dateTime;
        final nextMonth = DateTime.utc(
          base.year,
          base.month + 1,
          1,
          base.hour,
          base.minute,
          base.second,
          base.millisecond,
          base.microsecond,
        );
        return _wrap(nextMonth);
      case 'last day of this month':
        final base = _dateTime;
        final nextMonthStart = DateTime.utc(
          base.year,
          base.month + 1,
          1,
          base.hour,
          base.minute,
          base.second,
          base.millisecond,
          base.microsecond,
        );
        return _wrap(nextMonthStart.subtract(const Duration(days: 1)));
      case 'first day of year':
        return startOfYear();
      case 'last day of year':
        return endOfYear();
    }
    if (expr.startsWith('next ')) {
      final remainder = expr.substring(5).trim();
      final time = _parseTimeToken(remainder);
      if (time != null) {
        return _moveToTimeOfDay(time, forward: true);
      }
      return _moveToWeekday(remainder, forward: true).startOfDay();
    }
    if (expr.startsWith('previous ')) {
      final remainder = expr.substring(9).trim();
      final time = _parseTimeToken(remainder);
      if (time != null) {
        return _moveToTimeOfDay(time, forward: false);
      }
      return _moveToWeekday(remainder, forward: false).startOfDay();
    }
    if (expr.startsWith('last ')) {
      final remainder = expr.substring(5).trim();
      final time = _parseTimeToken(remainder);
      if (time != null) {
        return _moveToTimeOfDay(time, forward: false);
      }
      return _moveToWeekday(remainder, forward: false).startOfDay();
    }
    if (expr.startsWith('this ')) {
      final remainder = expr.substring(5).trim();
      final time = _parseTimeToken(remainder);
      if (time != null) {
        return _setToTimeOfDay(time);
      }
      return _moveToThisWeekday(remainder).startOfDay();
    }
    return null;
  }

  CarbonInterface _applyDuration(Duration duration) =>
      _wrap(_dateTime.add(duration));

  CarbonInterface _applyRealDuration(num value, _RealUnit unit) {
    final micros = (value * _realUnitMicros(unit)).round();
    if (micros == 0) {
      return this;
    }
    return _wrap(_dateTime.add(Duration(microseconds: micros)));
  }

  int _realUnitMicros(_RealUnit unit) {
    const second = Duration.microsecondsPerSecond;
    switch (unit) {
      case _RealUnit.microsecond:
        return 1;
      case _RealUnit.millisecond:
        return 1000;
      case _RealUnit.second:
        return second;
      case _RealUnit.minute:
        return second * 60;
      case _RealUnit.hour:
        return second * 3600;
      case _RealUnit.day:
        return second * 86400;
      case _RealUnit.week:
        return second * 604800;
      case _RealUnit.month:
        return second * 86400 * 30;
      case _RealUnit.quarter:
        return second * 86400 * 90;
      case _RealUnit.year:
        return second * 86400 * 365;
      case _RealUnit.decade:
        return second * 86400 * 3650;
      case _RealUnit.century:
        return second * 86400 * 36500;
      case _RealUnit.millennium:
        return second * 86400 * 365000;
    }
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

  double _floatDiffLinear(
    CarbonInterface other,
    Duration unit, {
    bool absolute = true,
  }) {
    final delta =
        (other.dateTime.microsecondsSinceEpoch -
                _dateTime.microsecondsSinceEpoch)
            .toDouble() /
        unit.inMicroseconds;
    return absolute ? delta.abs() : delta;
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
    final months =
        (_monthPosition(_dateTime) - _monthPosition(other.dateTime)) /
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

  double _diffInMonthsDouble(
    CarbonInterface other, {
    int monthsPerUnit = 1,
    bool absolute = true,
  }) {
    var start = _dateTime;
    var end = other.dateTime;
    final ascending = !start.isAfter(end);
    final sign = absolute || ascending ? 1.0 : -1.0;
    final monthsDelta = _adjustedMonthDelta(start, end).abs();

    if (!ascending) {
      final tmp = start;
      start = end;
      end = tmp;
    }

    final floorEnd = _addMonths(start, monthsDelta, monthOverflow: true);

    double monthsValue;
    if (!floorEnd.isBefore(end)) {
      monthsValue = monthsDelta.toDouble();
    } else {
      final ceilEnd = _addMonths(start, monthsDelta + 1, monthOverflow: true);
      final daysToFloor = _preciseDayDiff(floorEnd, end);
      final daysToCeil = _preciseDayDiff(end, ceilEnd);
      final denominator = daysToCeil + daysToFloor;
      final fraction = denominator == 0 ? 0.0 : daysToFloor / denominator;
      monthsValue = monthsDelta + fraction;
    }

    final scaled = monthsValue / monthsPerUnit;
    return sign * scaled;
  }

  double _diffInYearsDouble(CarbonInterface other, {bool absolute = true}) {
    var start = _dateTime;
    var end = other.dateTime;
    final ascending = !start.isAfter(end);
    final sign = absolute || ascending ? 1.0 : -1.0;

    if (!ascending) {
      final tmp = start;
      start = end;
      end = tmp;
    }

    var yearsDiff = end.year - start.year;
    var floorEnd = _addMonths(start, yearsDiff * 12, monthOverflow: true);
    if (floorEnd.isAfter(end)) {
      yearsDiff -= 1;
      floorEnd = _addMonths(start, yearsDiff * 12, monthOverflow: true);
    }

    if (!floorEnd.isBefore(end)) {
      return sign * yearsDiff.toDouble();
    }

    final ceilEnd = _addMonths(
      start,
      (yearsDiff + 1) * 12,
      monthOverflow: true,
    );
    final daysToFloor = _preciseDayDiff(floorEnd, end);
    final daysToCeil = _preciseDayDiff(end, ceilEnd);
    final denominator = daysToCeil + daysToFloor;
    final fraction = denominator == 0 ? 0.0 : daysToFloor / denominator;
    return sign * (yearsDiff + fraction);
  }

  int _adjustedMonthDelta(DateTime start, DateTime end) {
    final monthDelta = (end.year - start.year) * 12 + (end.month - start.month);
    if (monthDelta > 0 && _isDayTimeAfter(start, end)) {
      return monthDelta - 1;
    }
    if (monthDelta < 0 && _isDayTimeBefore(start, end)) {
      return monthDelta + 1;
    }
    return monthDelta;
  }

  bool _isDayTimeAfter(DateTime a, DateTime b) {
    if (a.day != b.day) return a.day > b.day;
    if (a.hour != b.hour) return a.hour > b.hour;
    if (a.minute != b.minute) return a.minute > b.minute;
    if (a.second != b.second) return a.second > b.second;
    if (a.millisecond != b.millisecond) {
      return a.millisecond > b.millisecond;
    }
    return a.microsecond > b.microsecond;
  }

  bool _isDayTimeBefore(DateTime a, DateTime b) {
    if (a.day != b.day) return a.day < b.day;
    if (a.hour != b.hour) return a.hour < b.hour;
    if (a.minute != b.minute) return a.minute < b.minute;
    if (a.second != b.second) return a.second < b.second;
    if (a.millisecond != b.millisecond) {
      return a.millisecond < b.millisecond;
    }
    return a.microsecond < b.microsecond;
  }

  double _preciseDayDiff(DateTime start, DateTime end) =>
      end.difference(start).inMicroseconds.toDouble() /
      Duration.microsecondsPerDay;

  List<String> _buildHumanDiffSegments(
    Duration delta, {
    required bool short,
    required int limit,
  }) {
    final units = _humanDiffUnits;
    final segments = <String>[];
    if (limit <= 0) {
      limit = 1;
    }
    var remaining = delta;
    for (final unit in units) {
      if (segments.length >= limit) {
        break;
      }
      final count = remaining.inMicroseconds ~/ unit.duration.inMicroseconds;
      if (count > 0) {
        final micros = unit.duration.inMicroseconds * count;
        remaining -= Duration(microseconds: micros);
        final label = short ? unit.shortLabel : unit.label(count);
        segments.add('$count $label');
      }
    }
    if (segments.isEmpty) {
      final label = short ? _humanDiffUnits.last.shortLabel : 'seconds';
      segments.add('0 $label');
    }
    return segments;
  }

  bool _isSameUnit(DateTime first, DateTime second, _ComparisonUnit unit) =>
      _startOfUnit(first, unit).isAtSameMomentAs(_startOfUnit(second, unit));

  bool _isCurrentUnit(_ComparisonUnit unit) =>
      _isSameUnit(_dateTime, _nowUtc(), unit);

  bool _isNextUnit(_ComparisonUnit unit) =>
      _isSameUnit(_dateTime, _addComparisonUnit(_nowUtc(), unit, 1), unit);

  bool _isLastUnit(_ComparisonUnit unit) =>
      _isSameUnit(_dateTime, _addComparisonUnit(_nowUtc(), unit, -1), unit);

  bool _isSameUnitWithTarget(_ComparisonUnit unit, CarbonInterface? other) =>
      _isSameUnit(_dateTime, _resolveComparisonTarget(other), unit);

  DateTime _resolveComparisonTarget(CarbonInterface? other) =>
      other?.dateTime ?? _nowUtc();

  DateTime _nowUtc() => (_resolveTestNow()?.dateTime ?? clock.now().toUtc());

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

  DateTime _quarterEnd(DateTime dateTime) {
    return _addMonths(
      _quarterStart(dateTime),
      3,
    ).subtract(const Duration(days: 1));
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

String _zoneAbbreviationFromSnapshot(
  CarbonTimeZoneSnapshot? snapshot,
  Duration offset,
) {
  if (snapshot != null && snapshot.abbreviation.isNotEmpty) {
    return snapshot.abbreviation;
  }
  if (offset == Duration.zero) {
    return 'GMT';
  }
  final totalMinutes = offset.inMinutes;
  final sign = totalMinutes >= 0 ? '+' : '-';
  final absMinutes = totalMinutes.abs();
  final hours = (absMinutes ~/ 60).toString().padLeft(2, '0');
  final minutes = (absMinutes % 60).toString().padLeft(2, '0');
  return 'GMT$sign$hours$minutes';
}

String _padYear(int year) {
  if (year >= 0 && year <= 9999) {
    return year.toString().padLeft(4, '0');
  }
  final sign = year >= 0 ? '+' : '-';
  return '$sign${year.abs().toString().padLeft(6, '0')}';
}

String _twoDigitYear(DateTime value) {
  var normalized = value.year % 100;
  if (normalized < 0) {
    normalized += 100;
  }
  return normalized.toString().padLeft(2, '0');
}

String _twoDigits(int value) => value.abs().toString().padLeft(2, '0');

String _localizedMonthShortName(String locale, int month) {
  // Try CarbonTranslator first, but fall back to DateFormat for unregistered locales
  try {
    final data = CarbonTranslator.matchLocale(locale);
    if (data.localeCode == locale ||
        data.localeCode.startsWith(locale.split('_')[0])) {
      return data.monthsShort[month - 1];
    }
  } catch (_) {}
  // Fallback to DateFormat for locales in intl but not in CarbonTranslator
  try {
    return DateFormat('MMM', locale).format(DateTime.utc(2000, month, 1));
  } catch (_) {
    // Last resort: use English
    final data = CarbonTranslator.matchLocale('en');
    return data.monthsShort[month - 1];
  }
}

String _localizedMonthLongName(
  String locale,
  DateTime sample, {
  bool genitive = false,
}) {
  if (genitive) {
    for (final candidate in CarbonBase._localeCandidates(locale)) {
      final overrides = kLocaleGenitiveMonths[candidate];
      if (overrides != null) {
        return overrides[sample.month - 1];
      }
    }
  }
  // Try CarbonTranslator first, but fall back to DateFormat for unregistered locales
  try {
    final data = CarbonTranslator.matchLocale(locale);
    if (data.localeCode == locale ||
        data.localeCode.startsWith(locale.split('_')[0])) {
      return data.months[sample.month - 1];
    }
  } catch (_) {}
  // Fallback to DateFormat for locales in intl but not in CarbonTranslator
  try {
    return DateFormat('MMMM', locale).format(sample);
  } catch (_) {
    // Last resort: use English
    final data = CarbonTranslator.matchLocale('en');
    return data.months[sample.month - 1];
  }
}

String _localizedWeekdayShortName(String locale, int weekday) {
  // Try CarbonTranslator first, but fall back to DateFormat for unregistered locales
  try {
    final data = CarbonTranslator.matchLocale(locale);
    if (data.localeCode == locale ||
        data.localeCode.startsWith(locale.split('_')[0])) {
      return data.weekdaysShort[weekday % 7];
    }
  } catch (_) {}
  // Fallback to DateFormat for locales in intl but not in CarbonTranslator
  try {
    return DateFormat(
      'EEE',
      locale,
    ).format(DateTime.utc(2000, 1, 3 + ((weekday - 1) % 7)));
  } catch (_) {
    // Last resort: use English
    final data = CarbonTranslator.matchLocale('en');
    return data.weekdaysShort[weekday % 7];
  }
}

String _formatDatePart(DateTime value) =>
    '${_padYear(value.year)}-${_twoDigits(value.month)}-${_twoDigits(value.day)}';

String _formatTimePart(DateTime value) =>
    '${_twoDigits(value.hour)}:${_twoDigits(value.minute)}:${_twoDigits(value.second)}';

String _formatLocalDateTime(
  DateTime value,
  _LocalPrecision precision, {
  DateTime? reference,
}) {
  var effectiveMicros = _fractionalMicroseconds(value, reference: reference);
  final buffer = StringBuffer()
    ..write(_formatDatePart(value))
    ..write('T')
    ..write(_twoDigits(value.hour))
    ..write(':')
    ..write(_twoDigits(value.minute));
  if (precision == _LocalPrecision.minute) {
    return buffer.toString();
  }
  buffer
    ..write(':')
    ..write(_twoDigits(value.second));
  if (precision == _LocalPrecision.second) {
    return buffer.toString();
  }
  if (precision == _LocalPrecision.millisecond) {
    final millis = (effectiveMicros ~/ 1000).toString().padLeft(3, '0');
    buffer
      ..write('.')
      ..write(millis);
    return buffer.toString();
  }
  buffer
    ..write('.')
    ..write(effectiveMicros.toString().padLeft(6, '0'));
  return buffer.toString();
}

int _fractionalMicroseconds(DateTime value, {DateTime? reference}) {
  final micros = value.millisecond * 1000 + value.microsecond;
  if (micros != 0 || reference == null) {
    return micros;
  }
  final fallback = reference.millisecond * 1000 + reference.microsecond;
  if (fallback != 0) {
    return fallback;
  }
  final remainder =
      reference.microsecondsSinceEpoch.abs() % Duration.microsecondsPerSecond;
  return remainder;
}

String _formatIsoFraction(int micros) {
  if (micros == 0) {
    return '.000';
  }
  if (micros % 1000 == 0) {
    final millis = (micros ~/ 1000).toString().padLeft(3, '0');
    return '.$millis';
  }
  var text = micros.toString().padLeft(6, '0');
  while (text.endsWith('0')) {
    text = text.substring(0, text.length - 1);
  }
  return '.$text';
}

String _formatTwelveHour(DateTime value, String locale) {
  var hour = value.hour % 12;
  if (hour == 0) {
    hour = 12;
  }
  // Use locale's meridiem function if available
  final localeData = CarbonTranslator.matchLocale(locale);
  final suffix =
      localeData.meridiem?.call(value.hour, value.minute, false) ??
      (value.hour >= 12 ? 'PM' : 'AM');
  return '$hour:${_twoDigits(value.minute)} $suffix';
}

/// Time unit used for same-unit comparisons.
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

/// Time unit used for start/end-of-unit calculations.
enum _StartEndUnit {
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

class _WeekSpec {
  const _WeekSpec({required this.startOfWeek, required this.firstWeekDay});

  final int startOfWeek;
  final int firstWeekDay;
}

/// Time unit used for real-time interval calculations.
enum _RealUnit {
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

/// Precision level for local time formatting.
enum _LocalPrecision { minute, second, millisecond, microsecond }

/// Parsed representation of a time-of-day component.
class _ParsedTimeOfDay {
  /// Creates a parsed time-of-day with the given components.
  const _ParsedTimeOfDay(this.hour, this.minute, this.second, this.microsecond);

  /// Hour component (0-23).
  final int hour;

  /// Minute component (0-59).
  final int minute;

  /// Second component (0-59).
  final int second;

  /// Microsecond component (0-999999).
  final int microsecond;
}

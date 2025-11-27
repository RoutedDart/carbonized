/// Defines iterable date ranges returned by helpers like `Carbon.daysUntil`.
///
/// ```dart
/// for (final day in Carbon.now().daysUntil('2024-01-03')) {
///   print(day.toDateString());
/// }
/// ```
part of '../carbon.dart';

/// Iterable range produced by Carbon's `range*` helpers.
///
/// [start] and [end] describe the
/// inclusive bounds and iterating returns every intermediate `Carbon`.
class CarbonPeriod extends Iterable<Carbon> {
  static final Map<String, CarbonMacro> _macros = <String, CarbonMacro>{};
  static void registerMacro(String name, CarbonMacro macro) =>
      _macros[name] = macro;
  static void unregisterMacro(String name) => _macros.remove(name);
  static bool hasMacro(String name) => _macros.containsKey(name);
  static void resetMacros() => _macros.clear();

  /// Sets the global default locale for Carbon operations.
  static void setLocale(String locale) => CarbonBase.setDefaultLocale(locale);

  /// Gets the current global default locale.
  static String getLocale() => CarbonBase.defaultLocale;

  /// Sets the fallback locale for the default locale.
  static void setFallbackLocale(String locale) =>
      CarbonTranslator.setFallbackLocale(locale);

  /// Gets the fallback locale for the default locale.
  static String? getFallbackLocale() => CarbonTranslator.getFallbackLocale();

  CarbonPeriod._(
    this._instances, {
    int? recurrences,
    String? locale,
    CarbonInterval? interval,
    bool? explicitlyLimited,
  }) : _recurrencesLimit = recurrences ?? _instances.length,
       _locale = locale ?? CarbonBase.defaultLocale,
       _interval = interval,
       _recurrencesExplicitlyLimited =
           explicitlyLimited ?? (recurrences != null);

  /// Invokes a registered macro by [name] for this period.
  dynamic carbon(
    String name, [
    List<dynamic> positionalArguments = const <dynamic>[],
    Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{},
  ]) {
    final macro = _macros[name];
    if (macro == null) {
      if (CarbonBase.strictMode) {
        throw CarbonUnknownMethodException(name);
      }
      return null;
    }
    return macro(this, positionalArguments, namedArguments);
  }

  final List<Carbon> _instances;
  final int _recurrencesLimit;
  final String _locale;

  /// The interval between dates in this period.
  final CarbonInterval? _interval;

  /// Whether the recurrences limit was explicitly set.
  final bool _recurrencesExplicitlyLimited;

  /// Gets the locale code for this period instance.
  String get localeCode => _locale;

  /// Creates a new CarbonPeriod with the specified locale.
  CarbonPeriod locale(String locale) => CarbonPeriod._(
    _instances,
    recurrences: _recurrencesLimit,
    locale: locale,
    interval: _interval,
    explicitlyLimited: _recurrencesExplicitlyLimited,
  );

  @override
  bool get isEmpty => _instances.isEmpty;
  @override
  int get length => _instances.length;

  /// First `Carbon` in the period (inclusive).
  Carbon get start => _instances.first;

  /// Last `Carbon` in the period (inclusive).
  Carbon get end => _instances.last;

  @override
  Iterator<Carbon> get iterator => _instances.iterator;

  /// Returns the configured maximum number of occurrences this period should
  /// return. The actual length might be smaller if the source range ended
  /// before the recurrence limit was reached.
  int get maxRecurrences => _recurrencesLimit;

  /// Returns the interval between dates in this period.
  CarbonInterval? get interval => _interval;

  /// Returns a new period limited to [count] recurrences.
  CarbonPeriod recurrences(int count) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'must be positive');
    }
    final truncated = _instances.take(count).toList();
    return CarbonPeriod._(
      truncated,
      recurrences: count,
      locale: _locale,
      interval: _interval,
      explicitlyLimited: true,
    );
  }

  /// Alias for [recurrences].
  CarbonPeriod times(int count) => recurrences(count);

  /// Filters the current period using [predicate] and returns a new period.
  CarbonPeriod filter(bool Function(Carbon) predicate) {
    final filtered = _instances.where(predicate).toList();
    final limited = filtered.take(_recurrencesLimit).toList();
    return CarbonPeriod._(
      limited,
      recurrences: _recurrencesLimit,
      locale: _locale,
      interval: _interval,
      explicitlyLimited: _recurrencesExplicitlyLimited,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      final name = _symbolToString(invocation.memberName);
      final macro = _macros[name];
      if (macro != null) {
        return macro(
          this,
          invocation.positionalArguments,
          invocation.namedArguments,
        );
      }
    }
    return super.noSuchMethod(invocation);
  }

  @override
  String toString() {
    if (_instances.isEmpty) return 'empty period';

    final localeData = CarbonTranslator.matchLocale(_locale);
    final buffer = StringBuffer();

    // Add recurrences if explicitly limited
    if (_recurrencesExplicitlyLimited) {
      final recurrencesStr = _formatRecurrences(localeData, _recurrencesLimit);
      if (recurrencesStr.isNotEmpty) {
        buffer.write(recurrencesStr);
        buffer.write(' ');
      }
    }

    // Add interval (don't capitalize if recurrences were added)
    final hasRecurrences = _recurrencesExplicitlyLimited;
    if (_interval != null) {
      final intervalStr = _formatInterval(
        localeData,
        _interval,
        capitalize: !hasRecurrences,
      );
      buffer.write(intervalStr);
    }

    // Add start date
    final startStr = _formatStartDate(localeData, start);
    if (startStr.isNotEmpty) {
      buffer.write(startStr);
    }

    // Add end date
    final endStr = _formatEndDate(localeData, end);
    if (endStr.isNotEmpty) {
      buffer.write(endStr);
    }

    return buffer.toString().trim();
  }

  String _formatRecurrences(CarbonLocaleData localeData, int count) {
    final template = localeData.periodRecurrences;
    if (template == null) return '';

    // Handle pluralization patterns like '{1}once|{0}:count times|[-Inf,Inf]:count times'
    final patterns = template.split('|');

    // Try explicit conditions first
    for (final part in patterns) {
      final match = RegExp(r'^([\[\]\{].+?[\]\}\}])(.*)$').firstMatch(part);
      if (match != null) {
        final condition = match.group(1)!;
        final text = match.group(2)!;
        if (_checkRecurrenceCondition(condition, count)) {
          // Replace :count placeholder
          var result = text.replaceAll(':count', count.toString());
          // Handle special case for "once"
          result = result.replaceAll(RegExp(r'\{1\}'), '');
          return result;
        }
      }
    }

    // Fallback: implicit rules (singular | plural)
    if (patterns.length > 1) {
      if (count == 1) {
        var result = patterns[0].replaceAll(RegExp(r'\{1\}'), '');
        return result.replaceAll(':count', count.toString());
      } else {
        var result = patterns.length > 2
            ? patterns[patterns.length - 1]
            : patterns[1];
        return result.replaceAll(':count', count.toString());
      }
    }

    return template.replaceAll(':count', count.toString());
  }

  bool _checkRecurrenceCondition(String condition, int count) {
    if (condition.startsWith('{')) {
      // Set: {1} or {0}
      final content = condition.substring(1, condition.length - 1);
      final values = content.split(',');
      return values.any((v) => int.tryParse(v) == count);
    } else if (condition.startsWith('[') || condition.startsWith(']')) {
      // Interval: [1,10] or ]1,Inf[ or [-Inf,Inf]
      final leftOpen = condition.startsWith(']');
      final rightOpen = condition.endsWith('[');
      final content = condition.substring(1, condition.length - 1);
      final parts = content.split(',');
      if (parts.length != 2) return false;

      final minStr = parts[0];
      final maxStr = parts[1];

      final min = minStr == '-Inf'
          ? double.negativeInfinity
          : double.tryParse(minStr) ?? double.negativeInfinity;
      final max = maxStr == 'Inf'
          ? double.infinity
          : double.tryParse(maxStr) ?? double.infinity;

      final val = count.toDouble();

      final minOk = leftOpen ? val > min : val >= min;
      final maxOk = rightOpen ? val < max : val <= max;

      return minOk && maxOk;
    }
    return false;
  }

  String _formatInterval(
    CarbonLocaleData localeData,
    CarbonInterval? interval, {
    bool capitalize = true,
  }) {
    final template = localeData.periodInterval;
    if (template == null || interval == null) return '';

    // Format interval to show numeric count like "1 day" instead of "a day"
    final intervalStr = _formatIntervalForPeriod(interval, _locale);
    var result = template.replaceAll(':interval', intervalStr);

    // Capitalize first letter to match PHP's "Every" vs "every" (only at start of string)
    if (capitalize && result.isNotEmpty) {
      result = result[0].toUpperCase() + result.substring(1);
    }

    return result;
  }

  String _formatIntervalForPeriod(CarbonInterval interval, String locale) {
    final localeData = CarbonTranslator.matchLocale(locale);

    // Decompose interval to find the primary unit
    final years = interval.monthSpan ~/ 12;
    final months = interval.monthSpan % 12;
    var remainingMicros = interval.microseconds;
    final days = remainingMicros ~/ Duration.microsecondsPerDay;
    remainingMicros %= Duration.microsecondsPerDay;
    final hours = remainingMicros ~/ Duration.microsecondsPerHour;
    remainingMicros %= Duration.microsecondsPerHour;
    final minutes = remainingMicros ~/ Duration.microsecondsPerMinute;
    remainingMicros %= Duration.microsecondsPerMinute;
    final seconds = remainingMicros ~/ Duration.microsecondsPerSecond;

    // Format with explicit count like "1 day" (not "a day")
    // Find the first non-zero unit (PHP Carbon shows the primary unit)
    if (years > 0) {
      return _formatUnitWithCount('year', years, localeData);
    } else if (months > 0) {
      return _formatUnitWithCount('month', months, localeData);
    } else if (days > 0) {
      // Check if it's a week (7 days)
      if (days % 7 == 0) {
        final weeks = days ~/ 7;
        return _formatUnitWithCount('week', weeks, localeData);
      }
      return _formatUnitWithCount('day', days, localeData);
    } else if (hours > 0) {
      return _formatUnitWithCount('hour', hours, localeData);
    } else if (minutes > 0) {
      return _formatUnitWithCount('minute', minutes, localeData);
    } else if (seconds > 0) {
      return _formatUnitWithCount('second', seconds, localeData);
    }

    // Fallback
    return '0 seconds';
  }

  String _formatUnitWithCount(
    String unit,
    int count,
    CarbonLocaleData localeData,
  ) {
    // Use the base unit translation (e.g., 'day' not 'a_day') which has :count placeholder
    // This ensures we get "1 day" format, not "a day" or "un jour"
    final messages = localeData.translationStrings;
    final template = messages[unit];

    if (template == null) {
      // Fallback: use translateUnit
      return CarbonTranslator.translateUnit(
        unit,
        count,
        locale: localeData.localeCode,
      );
    }

    // Parse the pluralization pattern and extract the unit name
    // Templates like: ':count day|:count days' or '{1}:count day|{0}:count days|[-Inf,Inf]:count days'
    final parts = template.split('|');

    // Find the right part based on count
    String? selectedPart;
    for (final part in parts) {
      // Check if part has a condition that matches our count
      final match = RegExp(r'^([\[\]\{].+?[\]\}\}])(.*)$').firstMatch(part);
      if (match != null) {
        final condition = match.group(1)!;
        final text = match.group(2)!;
        if (_checkRecurrenceCondition(condition, count)) {
          selectedPart = text;
          break;
        }
      }
    }

    // If no condition matched, use implicit rules (singular | plural)
    if (selectedPart == null) {
      if (parts.length > 1) {
        selectedPart = count == 1 ? parts[0] : parts[1];
      } else {
        selectedPart = parts.first;
      }
    }

    // Replace :count with actual count and remove any article prefixes
    var result = selectedPart.replaceAll(':count', count.toString());

    // Remove common article patterns at the start (language-agnostic)
    // This handles patterns like "a day", "un jour", etc. by detecting if it doesn't start with a digit
    // and removing word(s) before the unit name
    if (!RegExp(r'^\d').hasMatch(result)) {
      // Extract just the unit name (everything after the first word which is the article)
      // Pattern: look for word boundary after article, then capture the rest
      final unitMatch = RegExp(r'^\S+\s+(.+)$').firstMatch(result);
      if (unitMatch != null) {
        result = '$count ${unitMatch.group(1)!}';
      } else {
        result = '$count $result';
      }
    }

    return result;
  }

  String _formatStartDate(CarbonLocaleData localeData, Carbon date) {
    final template = localeData.periodStartDate;
    if (template == null) return '';

    final dateStr = date.toDateString();
    return ' ${template.replaceAll(':date', dateStr)}';
  }

  String _formatEndDate(CarbonLocaleData localeData, Carbon date) {
    final template = localeData.periodEndDate;
    if (template == null) return '';

    final dateStr = date.toDateString();
    return ' ${template.replaceAll(':date', dateStr)}';
  }

  static String _symbolToString(Symbol symbol) =>
      symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');
}

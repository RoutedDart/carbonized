part of '../carbon.dart';

/// Adapts PHP Carbon's translation strings to `timeago`'s [LookupMessages].
class CarbonLookupMessages implements timeago.LookupMessages {
  final Map<String, String> _messages;

  CarbonLookupMessages(this._messages);

  @override
  String prefixAgo() => _getPrefix('ago');
  @override
  String prefixFromNow() => _getPrefix('from_now');
  @override
  String suffixAgo() => _getSuffix('ago');
  @override
  String suffixFromNow() => _getSuffix('from_now');

  @override
  String lessThanOneMinute(int seconds) => _choice('second', seconds);
  @override
  String aboutAMinute(int minutes) => _choice('minute', minutes);
  @override
  String minutes(int minutes) => _choice('minute', minutes);
  @override
  String aboutAnHour(int minutes) => _choice('hour', minutes);
  @override
  String hours(int hours) => _choice('hour', hours);
  @override
  String aDay(int hours) => _choice('day', hours);
  @override
  String days(int days) => _choice('day', days);
  @override
  String aboutAMonth(int days) => _choice('month', days);
  @override
  String months(int months) => _choice('month', months);

  @override
  String aboutAYear(int year) => _choice('year', 1);

  @override
  String years(int years) => _choice('year', years);

  @override
  String wordSeparator() => ' ';

  String _getPrefix(String key) {
    final raw = _messages[key];
    if (raw == null) return '';
    final index = raw.indexOf(':time');
    if (index > 0) {
      return raw.substring(0, index).trimRight();
    }
    return '';
  }

  String _getSuffix(String key) {
    final raw = _messages[key];
    if (raw == null) return '';
    final index = raw.indexOf(':time');
    if (index != -1 && index < raw.length - 5) {
      // -5 for length of ':time'
      return raw.substring(index + 5).trimLeft();
    }
    return '';
  }

  String _choice(String key, int count) {
    return pluralize(key, count, _messages);
  }

  static String pluralize(String key, int count, Map<String, String> messages) {
    // 1. Try explicit plural key first (e.g., 'a_year' vs 'year')
    // PHP Carbon uses 'a_year' for single year, 'year' for multiple.
    // But the 'year' string itself might contain pluralization logic.

    String? message = messages[key];

    // If count is 1, try to find a singular variant like 'a_year'
    if (count == 1) {
      final singularKey = 'a_$key';
      if (messages.containsKey(singularKey)) {
        message = messages[singularKey];
      }
    }

    if (message == null) return '$count $key';

    // 2. Parse PHP pluralization format:
    // "1:count year|]1,Inf[:count years"
    // "{1}:count year|{0}:count years|[-Inf,Inf]:count years"

    final parts = message.split('|');

    // First pass: look for explicit conditions
    for (final part in parts) {
      final match = RegExp(r'^([\[\]\{].+?[\]\}\}])(.*)$').firstMatch(part);
      if (match != null) {
        final condition = match.group(1)!;
        final text = match.group(2)!;
        if (_checkCondition(condition, count)) {
          return _replaceCount(text, count);
        }
      }
    }

    // Second pass: implicit rules (singular | plural)
    // If we are here, no explicit condition matched.
    if (parts.length > 1) {
      if (count == 1) {
        return _replaceCount(parts[0], count);
      } else {
        return _replaceCount(parts[1], count);
      }
    }

    return _replaceCount(parts.first, count);
  }

  static bool _checkCondition(String condition, int count) {
    if (condition.startsWith('{')) {
      // Set: {1} or {1,3,5}
      final content = condition.substring(1, condition.length - 1);
      final values = content.split(',');
      return values.any((v) => int.tryParse(v) == count);
    } else if (condition.startsWith('[') || condition.startsWith(']')) {
      // Interval: [1,10] or ]1,Inf[
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

  static String _replaceCount(String text, int count) {
    return text.replaceAll(':count', count.toString());
  }
}

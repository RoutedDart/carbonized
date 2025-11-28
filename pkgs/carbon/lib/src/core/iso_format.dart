/// Implements ISO/Moment-style token parsing for `Carbon.isoFormat` helpers.
///
/// The parser expands preset tokens, handles locale overrides, and keeps
/// literal bracket semantics identical to PHP Carbon.
part of '../carbon.dart';

/// Internal formatter/parser for Moment-style ISO tokens.
///
/// PHP Carbon relies heavily on `isoFormat()` plus helpers such as
/// `createFromIsoFormat()`. This file mirrors the token map, literal handling,
/// and preset expansion to stay source-compatible.

const String _kIsoTokenPattern =
    r'zz|ZZZ|LTS|LT|L{1,4}|l{1,4}|Do|Mo|Qo|wo|GGGGG|GGGG|GGG|GG|G|ggggg|gggg|ggg|gg|g|MMMM_GEN|MMMM|MMM|MM|M|WW|W|SSSSSSSSS|SSSSSSSS|SSSSSSS|SSSSSS|SSSSS|SSSS|SSS|SS|S|YYYYY|YYYY|YY|Q|DDDD|DDD|DD|D|dddd|ddd|dd|d|t|HH|H|hh|h|kk|k|mm|m|ss|s|A|a|w|ww|z|L|X|x|O|P|Z{1,2}|[A-Za-z]';

const Map<String, String> _presetIsoTemplates = <String, String>{
  'LT': 'h:mm A',
  'LTS': 'h:mm:ss A',
  'L': 'MM/DD/YYYY',
  'LL': 'MMMM D, YYYY',
  'LLL': 'MMMM D, YYYY h:mm A',
  'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  'l': 'M/D/YYYY',
  'll': 'MMM D, YYYY',
  'lll': 'MMM D, YYYY h:mm A',
  'llll': 'ddd, MMM D, YYYY h:mm A',
};

const Map<String, Map<String, String>> _localePresetIsoOverrides = {
  'es': <String, String>{
    'LL': 'D [de] MMMM [de] YYYY',
    'll': 'D [de] MMM [de] YYYY',
    'LLL': 'D [de] MMMM [de] YYYY h:mm A',
    'lll': 'D [de] MMM [de] YYYY h:mm A',
  },
  'es_es': <String, String>{
    'LL': 'D [de] MMMM [de] YYYY',
    'll': 'D [de] MMM [de] YYYY',
    'LLL': 'D [de] MMMM [de] YYYY h:mm A',
    'lll': 'D [de] MMM [de] YYYY h:mm A',
  },
  'es_mx': <String, String>{
    'LL': 'D [de] MMMM [de] YYYY',
    'll': 'D [de] MMM [de] YYYY',
  },
};

final RegExp _isoTokenRegex = RegExp(_kIsoTokenPattern);
final RegExp _presetTokenRegex = RegExp(r'LTS|LT|L{1,4}|l{1,4}');

String _expandIsoPresetTokens(String pattern, String locale) {
  final buffer = StringBuffer();
  var i = 0;
  var escaped = false;
  var inLiteral = false;
  while (i < pattern.length) {
    final char = pattern[i];
    if (escaped) {
      buffer.write(char);
      escaped = false;
      i++;
      continue;
    }
    if (char == '\\') {
      escaped = true;
      buffer.write(char);
      i++;
      continue;
    }
    if (char == '[') {
      inLiteral = true;
      buffer.write(char);
      i++;
      continue;
    }
    if (char == ']' && inLiteral) {
      inLiteral = false;
      buffer.write(char);
      i++;
      continue;
    }
    if (inLiteral) {
      buffer.write(char);
      i++;
      continue;
    }
    final remaining = pattern.substring(i);
    final match = _presetTokenRegex.firstMatch(remaining);
    if (match != null && match.start == 0) {
      final token = match.group(0)!;
      buffer.write(_isoPresetExpansion(token, locale) ?? token);
      i += token.length;
      continue;
    }
    buffer.write(pattern[i]);
    i++;
  }
  return buffer.toString();
}

String? _isoPresetExpansion(String token, String locale) {
  // First check if the locale data has this format defined
  final localeData = CarbonTranslator.matchLocale(locale);
  if (localeData.formats.containsKey(token)) {
    return localeData.formats[token];
  }

  // Fallback to hardcoded overrides for specific locales
  for (final candidate in CarbonBase._localeCandidates(locale)) {
    final overrides = _localePresetIsoOverrides[candidate];
    if (overrides != null && overrides.containsKey(token)) {
      return overrides[token];
    }
  }
  final derived = _derivePresetIsoPattern(token, locale);
  if (derived != null) {
    return derived;
  }
  return _presetIsoTemplates[token];
}

String? _derivePresetIsoPattern(String token, String locale) {
  String? convertPattern(DateFormat formatter) {
    try {
      final converted = _convertIntlPatternToIso(
        formatter.pattern ?? '',
      ).trim();
      return converted.isEmpty ? null : converted;
    } catch (_) {
      return null;
    }
  }

  try {
    switch (token) {
      case 'LT':
        return convertPattern(DateFormat.jm(locale));
      case 'LTS':
        return convertPattern(DateFormat.jms(locale));
      case 'L':
        return convertPattern(DateFormat.yMd(locale));
      case 'l':
        return convertPattern(DateFormat.Md(locale));
      case 'LL':
        return convertPattern(DateFormat.yMMMMd(locale));
      case 'll':
        return convertPattern(DateFormat.yMMMd(locale));
      case 'LLL':
        final date = _derivePresetIsoPattern('LL', locale);
        final time = _derivePresetIsoPattern('LT', locale);
        if (date != null && time != null) {
          return '$date $time';
        }
        return null;
      case 'lll':
        final date = _derivePresetIsoPattern('ll', locale);
        final time = _derivePresetIsoPattern('LT', locale);
        if (date != null && time != null) {
          return '$date $time';
        }
        return null;
      case 'LLLL':
        final dayPattern = convertPattern(DateFormat('EEEE', locale));
        final rest = _derivePresetIsoPattern('LLL', locale);
        if (dayPattern != null && rest != null) {
          return '$dayPattern, $rest';
        }
        return null;
      case 'llll':
        final dayPattern = convertPattern(DateFormat('EEE', locale));
        final rest = _derivePresetIsoPattern('lll', locale);
        if (dayPattern != null && rest != null) {
          return '$dayPattern, $rest';
        }
        return null;
      default:
        return null;
    }
  } catch (_) {
    return null;
  }
}

String _convertIntlPatternToIso(String pattern) {
  if (pattern.isEmpty) {
    return '';
  }
  final buffer = StringBuffer();
  var i = 0;
  while (i < pattern.length) {
    final char = pattern[i];
    if (char == "'") {
      final literal = StringBuffer();
      i++;
      while (i < pattern.length) {
        final current = pattern[i];
        if (current == "'") {
          if (i + 1 < pattern.length && pattern[i + 1] == "'") {
            literal.write("'");
            i += 2;
            continue;
          }
          i++;
          break;
        }
        literal.write(current);
        i++;
      }
      if (literal.isNotEmpty) {
        buffer
          ..write('[')
          ..write(literal.toString())
          ..write(']');
      }
      continue;
    }
    final start = i;
    while (i < pattern.length && pattern[i] == char) {
      i++;
    }
    final length = i - start;
    final mapped = _intlTokenToIso(char, length);
    if (mapped != null) {
      buffer.write(mapped);
    } else {
      final literal = pattern.substring(start, i);
      buffer
        ..write('[')
        ..write(literal)
        ..write(']');
    }
  }
  return buffer.toString();
}

String? _intlTokenToIso(String symbol, int length) {
  switch (symbol) {
    case 'y':
      if (length == 2) return 'YY';
      if (length >= 5) return 'YYYYY';
      return 'YYYY';
    case 'Y':
      return length >= 2 ? 'YYYY' : 'YY';
    case 'M':
    case 'L':
      if (length >= 4) return 'MMMM';
      if (length == 3) return 'MMM';
      if (length == 2) return 'MM';
      return 'M';
    case 'd':
      return length >= 2 ? 'DD' : 'D';
    case 'E':
      if (length >= 4) return 'dddd';
      if (length == 3) return 'ddd';
      return 'dd';
    case 'c':
      return length >= 4 ? 'dddd' : 'ddd';
    case 'a':
      return 'A';
    case 'h':
      return length >= 2 ? 'hh' : 'h';
    case 'H':
      return length >= 2 ? 'HH' : 'H';
    case 'k':
      return length >= 2 ? 'kk' : 'k';
    case 'K':
      return length >= 2 ? 'hh' : 'h';
    case 'm':
      return length >= 2 ? 'mm' : 'm';
    case 's':
      return length >= 2 ? 'ss' : 's';
    case 'S':
      return 'S' * length;
    case 'z':
      return 'zz';
    case 'Z':
      return length >= 3 ? 'ZZ' : 'Z';
    case 'G':
    case 'u':
      return null;
    default:
      return null;
  }
}

final class _IsoFormatter {
  _IsoFormatter(this._carbon);

  final CarbonBase _carbon;
  int _literalStack = 0;
  (int, int)? _localeWeekDataCache;

  static final Map<String, String Function(DateTime, String)>
  _presetFormatters = <String, String Function(DateTime, String)>{
    'LT': (local, locale) => DateFormat.jm(locale).format(local),
    'LTS': (local, locale) => DateFormat.jms(locale).format(local),
    'L': (local, locale) => DateFormat.yMd(locale).format(local),
    'LL': (local, locale) => DateFormat.yMMMMd(locale).format(local),
    'LLL': (local, locale) =>
        '${DateFormat.yMMMMd(locale).format(local)} ${DateFormat.jm(locale).format(local)}',
    'LLLL': (local, locale) =>
        '${DateFormat.yMMMMEEEEd(locale).format(local)} ${DateFormat.jm(locale).format(local)}',
    'l': (local, locale) => DateFormat.yMd(locale).format(local),
    'll': (local, locale) => DateFormat.yMMMd(locale).format(local),
    'lll': (local, locale) =>
        '${DateFormat.yMMMd(locale).format(local)} ${DateFormat.jm(locale).format(local)}',
    'llll': (local, locale) =>
        '${DateFormat.yMMMEd(locale).format(local)} ${DateFormat.jm(locale).format(local)}',
  };

  String format(String pattern) {
    final buffer = StringBuffer();
    final chars = pattern.split('');
    var escape = false;
    for (var i = 0; i < chars.length; i++) {
      final char = chars[i];
      if (char == '\\') {
        if (i + 1 < chars.length) {
          buffer.write(chars[++i]);
        }
        continue;
      }
      if (char == '[' && !escape) {
        escape = true;
        continue;
      }
      if (char == ']' && escape) {
        escape = false;
        continue;
      }
      if (escape) {
        buffer.write(char);
        continue;
      }
      final remaining = pattern.substring(i);
      final match = _isoTokenRegex.firstMatch(remaining);
      if (match != null && match.start == 0) {
        final token = match.group(0)!;
        buffer.write(_renderToken(token));
        i += token.length - 1;
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  String _renderToken(String token) {
    final local = _carbon._localDateTimeForFormatting();
    final override = CarbonBase._runIsoFormatOverride(token, _carbon);
    if (override != null) {
      return override;
    }
    final preset = _formatPreset(token);
    if (preset != null) {
      return preset;
    }
    if (token == '[') {
      _literalStack++;
      return '';
    }
    if (token == ']') {
      if (_literalStack > 0) {
        _literalStack--;
      }
      return '';
    }
    final literal = _literalTokenValue(token);
    if (literal != null) {
      return literal;
    }

    switch (token) {
      case 'YYYY':
        return _padYear(_carbon.year);
      case 'YYYYY':
        return _padYear(_carbon.year).padLeft(5, '0');
      case 'YY':
        return (_carbon.year % 100).abs().toString().padLeft(2, '0');
      case 'Q':
        return _quarter.toString();
      case 'Qo':
        return _ordinal(_quarter, 'Q', _carbon.localeCode);
      case 'M':
        return _carbon.month.toString();
      case 'MM':
        return _twoDigits(_carbon.month);
      case 'Mo':
        return _ordinal(_carbon.month, 'M', _carbon.localeCode);
      case 'MMM':
        return _localizedMonthShortName(_carbon.localeCode, _carbon.month);
      case 'MMMM':
        return _localizedMonthLongName(_carbon.localeCode, local);
      case 'MMMM_GEN':
        return _localizedMonthLongName(
          _carbon.localeCode,
          local,
          genitive: true,
        );
      case 'D':
        return _carbon.day.toString();
      case 'DD':
        return _twoDigits(_carbon.day);
      case 'DDD':
      case 'DDDD':
        return token == 'DDD'
            ? _carbon.dayOfYear.toString()
            : _carbon.dayOfYear.toString().padLeft(3, '0');
      case 't':
        return _carbon.daysInMonth.toString();
      case 'Do':
        return _ordinal(_carbon.day, 'D', _carbon.localeCode);
      case 'ddd':
        return _localizedWeekdayShortName(_carbon.localeCode, local.weekday);
      case 'dddd':
        return DateFormat.EEEE(_carbon.localeCode).format(local);
      case 'W':
        return _isoWeek().toString();
      case 'WW':
        return _isoWeek().toString().padLeft(2, '0');
      case 'N':
        return _isoWeekday().toString();
      case 'w':
        return _localeWeek().toString();
      case 'ww':
        return _localeWeek().toString().padLeft(2, '0');
      case 'wo':
        return _ordinal(_localeWeek(), 'w', _carbon.localeCode);
      case 'z':
        return (_carbon.dayOfYear - 1).toString();
      case 'o':
        return _isoWeekYear().toString();
      case 'L':
        return _carbon.isLeapYear() ? '1' : '0';
      case 'g':
        return _localeWeekYear().toString();
      case 'gg':
        return (_localeWeekYear() % 100).abs().toString().padLeft(2, '0');
      case 'ggg':
        return _padYear(_localeWeekYear()).padLeft(3, '0');
      case 'gggg':
        return _padYear(_localeWeekYear());
      case 'ggggg':
        return _padYear(_localeWeekYear()).padLeft(5, '0');
      case 'G':
        return _isoWeekYear().toString();
      case 'GG':
        return (_isoWeekYear() % 100).abs().toString().padLeft(2, '0');
      case 'GGG':
        return _padYear(_isoWeekYear()).padLeft(3, '0');
      case 'GGGG':
        return _padYear(_isoWeekYear());
      case 'GGGGG':
        return _padYear(_isoWeekYear()).padLeft(5, '0');
      case 'H':
        return _carbon.hour.toString();
      case 'HH':
        return _twoDigits(_carbon.hour);
      case 'h':
        final hour = _carbon.hour % 12 == 0 ? 12 : _carbon.hour % 12;
        return hour.toString();
      case 'hh':
        final hour = _carbon.hour % 12 == 0 ? 12 : _carbon.hour % 12;
        return _twoDigits(hour);
      case 'k':
        final hour = _carbon.hour == 0 ? 24 : _carbon.hour;
        return hour.toString();
      case 'kk':
        final hour = _carbon.hour == 0 ? 24 : _carbon.hour;
        return _twoDigits(hour);
      case 'm':
        return _carbon.minute.toString();
      case 'mm':
        return _twoDigits(_carbon.minute);
      case 's':
        return _carbon.second.toString();
      case 'ss':
        return _twoDigits(_carbon.second);
      case 'S':
      case 'SS':
      case 'SSS':
      case 'SSSS':
      case 'SSSSS':
      case 'SSSSSS':
      case 'SSSSSSS':
      case 'SSSSSSSS':
      case 'SSSSSSSSS':
        return _fractional(token.length);
      case 'A':
        return _carbon.hour >= 12 ? 'PM' : 'AM';
      case 'a':
        return _carbon.hour >= 12 ? 'pm' : 'am';
      case 'Z':
        return _carbon._formatOffset(_carbon._currentOffset());
      case 'ZZ':
        return _carbon._formatOffset(_carbon._currentOffset(), compact: true);
      case 'ZZZ':
        return _carbon._currentOffset().inSeconds.toString();
      case 'O':
        return _carbon
            ._formatOffset(_carbon._currentOffset(), compact: true)
            .replaceAll(':', '');
      case 'P':
        return _carbon._formatOffset(_carbon._currentOffset());
      case 'T':
        final snapshot = _carbon._zoneSnapshot();
        return snapshot?.abbreviation ?? 'UTC';
      case 'e':
        return _carbon.timeZoneName ?? 'UTC';
      case 'zz':
        return _carbon.timeZoneName ?? 'UTC';
      case 'X':
        return (_carbon.dateTime.millisecondsSinceEpoch ~/ 1000).toString();
      case 'x':
        return _carbon.dateTime.millisecondsSinceEpoch.toString();
      default:
        return token;
    }
  }

  String? _formatPreset(String token) {
    final overridePattern = _lookupLocaleOverride(token);
    final local = _carbon._localDateTimeForFormatting();
    final locale = _carbon.localeCode;
    if (overridePattern != null) {
      return DateFormat(overridePattern, locale).format(local);
    }

    // Check CarbonLocaleData formats
    final data = CarbonTranslator.matchLocale(locale);
    final formatPattern = data.formats[token];
    if (formatPattern != null) {
      return format(formatPattern);
    }

    final formatter = _presetFormatters[token];
    if (formatter != null) {
      return formatter(local, locale);
    }
    return null;
  }

  String? _literalTokenValue(String token) {
    if (token.startsWith('[') && token.endsWith(']')) {
      return token.substring(1, token.length - 1);
    }
    return null;
  }

  String? _lookupLocaleOverride(String token) {
    for (final candidate in CarbonBase._localeCandidates(_carbon.localeCode)) {
      final overrides = _localePresetOverrides[candidate];
      if (overrides != null && overrides.containsKey(token)) {
        return overrides[token];
      }
    }
    return null;
  }

  int get _quarter => ((_carbon.month - 1) ~/ 3) + 1;

  int _isoWeek() => _isoWeekData().$1;

  int _isoWeekYear() => _isoWeekData().$2;

  int _localeWeek() => _localeWeekData().$1;

  int _localeWeekYear() => _localeWeekData().$2;

  (int, int) _isoWeekData() {
    final isoWeekday = _isoWeekday();
    final dayOfYear = _carbon.dayOfYear;
    var week = ((dayOfYear - isoWeekday + 10) / 7).floor();
    var isoYear = _carbon.year;
    if (week < 1) {
      isoYear -= 1;
      week = _isoWeeksInYear(isoYear);
    } else {
      final weeksInYear = _isoWeeksInYear(isoYear);
      if (week > weeksInYear) {
        isoYear += 1;
        week = 1;
      }
    }
    return (week, isoYear);
  }

  (int, int) _localeWeekData() {
    return _localeWeekDataCache ??= _computeLocaleWeekData();
  }

  (int, int) _computeLocaleWeekData() {
    final startOfWeek = _localeWeekStart();
    final firstWeekDay = _localeFirstWeekDay();
    final local = _carbon._localDateTimeForFormatting();
    final localDate = DateTime.utc(local.year, local.month, local.day);
    final currentStart = _firstWeekStart(local.year, startOfWeek, firstWeekDay);
    final nextStart = _firstWeekStart(
      local.year + 1,
      startOfWeek,
      firstWeekDay,
    );
    var weekYear = local.year;
    if (localDate.isBefore(currentStart)) {
      weekYear -= 1;
    } else if (!localDate.isBefore(nextStart)) {
      weekYear += 1;
    }
    final reference = _firstWeekStart(weekYear, startOfWeek, firstWeekDay);
    final diffDays = localDate.difference(reference).inDays;
    final weekNumber = (diffDays ~/ 7) + 1;
    return (weekNumber, weekYear);
  }

  int _isoWeeksInYear(int year) {
    final dec28 = DateTime.utc(year, 12, 28);
    final dayOfYear = dec28.difference(DateTime.utc(year, 1, 1)).inDays + 1;
    final weekday = dec28.weekday == DateTime.sunday ? 7 : dec28.weekday;
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  int _localeWeekStart() {
    for (final candidate in CarbonBase._localeCandidates(_carbon.localeCode)) {
      final start = kLocaleWeekStartDefaults[candidate];
      if (start != null) {
        return start;
      }
    }
    return _carbon.settings.startOfWeek;
  }

  int _localeFirstWeekDay() {
    for (final candidate in CarbonBase._localeCandidates(_carbon.localeCode)) {
      final day = kLocaleFirstWeekMinDays[candidate];
      if (day != null) {
        return day;
      }
    }
    return 1;
  }

  DateTime _firstWeekStart(int year, int startOfWeek, int firstWeekDay) {
    final base = DateTime.utc(year, 1, 1).add(Duration(days: firstWeekDay - 1));
    return _alignToWeekStart(base, startOfWeek);
  }

  DateTime _alignToWeekStart(DateTime date, int startOfWeek) {
    final normalizedStart = startOfWeek == DateTime.sunday ? 7 : startOfWeek;
    final weekday = date.weekday == DateTime.sunday ? 7 : date.weekday;
    final diff = ((weekday - normalizedStart) + 7) % 7;
    return date.subtract(Duration(days: diff));
  }

  int _isoWeekday() {
    final weekday = _carbon._localDateTimeForFormatting().weekday;
    return weekday == DateTime.sunday ? 7 : weekday;
  }

  String _fractional(int precision) {
    final micros = _fractionalMicroseconds(
      _carbon._localDateTimeForFormatting(),
      reference: _carbon.dateTime,
    );
    final padded = micros.toString().padLeft(6, '0').padRight(9, '0');
    final length = math.min(precision, padded.length);
    return padded.substring(0, length);
  }
}

class _TranslatedFormatConverter {
  _TranslatedFormatConverter(this._pattern);

  final String _pattern;
  String? _lastToken;

  static final RegExp _alpha = RegExp(r'[A-Za-z]');

  static const Map<String, String> _tokenMap = <String, String>{
    'd': 'DD',
    'D': 'ddd',
    'j': 'D',
    'l': 'dddd',
    'N': 'N',
    'w': 'w',
    'z': 'z',
    'W': 'WW',
    'F': 'MMMM',
    'm': 'MM',
    'M': 'MMM',
    'n': 'M',
    't': 't',
    'L': 'L',
    'o': 'o',
    'Y': 'YYYY',
    'y': 'YY',
    'a': 'a',
    'A': 'A',
    'g': 'h',
    'G': 'H',
    'h': 'hh',
    'H': 'HH',
    'i': 'mm',
    's': 'ss',
    'u': 'SSSSSS',
    'v': 'SSS',
    'e': 'e',
    'O': 'ZZ',
    'P': 'Z',
    'T': 'T',
    'Z': 'ZZZ',
    'c': 'YYYY-MM-DD[T]HH:mm:ssZ',
    'r': 'ddd, DD MMM YYYY HH:mm:ss ZZ',
    'U': 'X',
  };

  String toIsoPattern() {
    final buffer = StringBuffer();
    for (var i = 0; i < _pattern.length; i++) {
      final char = _pattern[i];
      if (char == '\\' && i + 1 < _pattern.length) {
        buffer
          ..write('[')
          ..write(_pattern[++i])
          ..write(']');
        continue;
      }
      if (char == 'j' && i + 1 < _pattern.length && _pattern[i + 1] == 'S') {
        buffer.write('Do');
        i++;
        _lastToken = 'S';
        continue;
      }
      if (char == 'F') {
        final token = _needsGenitiveMonth() ? 'MMMM_GEN' : 'MMMM';
        buffer.write(token);
        _lastToken = 'F';
        continue;
      }
      final replacement = _tokenMap[char];
      if (replacement != null) {
        buffer.write(replacement);
        _lastToken = char;
        continue;
      }
      if (_alpha.hasMatch(char)) {
        buffer
          ..write('\\')
          ..write(char);
        _lastToken = char;
      } else {
        buffer
          ..write('[')
          ..write(char)
          ..write(']');
      }
    }
    return buffer.toString();
  }

  bool _needsGenitiveMonth() {
    if (_lastToken == null) {
      return false;
    }
    const candidates = <String>{'d', 'j', 'S', 't', 'z'};
    return candidates.contains(_lastToken);
  }
}

const Map<String, Map<String, String>> _localePresetOverrides = {
  'es': <String, String>{
    'LL': "d 'de' MMMM 'de' y",
    'll': "d 'de' MMM'.' 'de' y",
    'LLL': "d 'de' MMMM 'de' y h:mm a",
    'lll': "d 'de' MMM'.' 'de' y h:mm a",
  },
  'es_es': <String, String>{
    'LL': "d 'de' MMMM 'de' y",
    'll': "d 'de' MMM'.' 'de' y",
    'LLL': "d 'de' MMMM 'de' y h:mm a",
    'lll': "d 'de' MMM'.' 'de' y h:mm a",
  },
  'es_mx': <String, String>{
    'LL': "d 'de' MMMM 'de' y",
    'll': "d 'de' MMM'.' 'de' y",
  },
};

String _ordinal(int value, String period, String locale) {
  final data = CarbonTranslator.matchLocale(locale);
  if (data.ordinal != null) {
    return data.ordinal!(value, period);
  }
  // Default English ordinal logic
  final special = value % 100;
  if (special >= 11 && special <= 13) {
    return '${value}th';
  }
  switch (value % 10) {
    case 1:
      return '${value}st';
    case 2:
      return '${value}nd';
    case 3:
      return '${value}rd';
    default:
      return '${value}th';
  }
}

class _IsoInputParser {
  _IsoInputParser({required this.format, required this.locale, DateTime? base})
    : _base = base ?? clock.now().toUtc(),
      _names = _LocaleNameIndex(locale);

  final String format;
  final String locale;
  final DateTime _base;
  final _LocaleNameIndex _names;

  _IsoParsedComponents parse(String input) {
    var working = format;
    var reset = false;
    if (working.contains('!')) {
      final buffer = StringBuffer();
      for (var i = 0; i < working.length; i++) {
        final char = working.substring(i, i + 1);
        if (char == '!') {
          reset = true;
          continue;
        }
        buffer.write(char);
      }
      working = buffer.toString();
    }

    working = _expandIsoPresetTokens(working, locale);

    final handlers = <_IsoCapture>[];
    final patternBuffer = StringBuffer('^');
    var i = 0;
    while (i < working.length) {
      final char = working.substring(i, i + 1);
      if (char == '\\' && i + 1 < working.length) {
        patternBuffer.write(RegExp.escape(working.substring(i + 1, i + 2)));
        i += 2;
        continue;
      }
      if (char == '[') {
        final closing = working.indexOf(']', i + 1);
        if (closing == -1) {
          throw ArgumentError('Unmatched literal [ in ISO format: $format');
        }
        final literal = working.substring(i + 1, closing);
        patternBuffer.write(RegExp.escape(literal));
        i = closing + 1;
        continue;
      }
      final remaining = working.substring(i);
      final match = _isoTokenRegex.firstMatch(remaining);
      if (match != null && match.start == 0) {
        final token = match.group(0)!;
        final handler = _IsoCapture.fromToken(token, _names);
        if (handler == null) {
          throw ArgumentError('Format $token not supported for creation.');
        }
        handlers.add(handler);
        patternBuffer.write(handler.pattern);
        i += token.length;
        continue;
      }
      patternBuffer.write(RegExp.escape(char));
      i++;
    }
    patternBuffer.write(r'$');

    final regex = RegExp(
      patternBuffer.toString(),
      caseSensitive: false,
      unicode: true,
    );
    final match = regex.firstMatch(input.trim());
    if (match == null) {
      throw ArgumentError('Value "$input" does not match format "$format".');
    }
    final base = reset ? DateTime.utc(1970, 1, 1) : _base;
    final components = _IsoParsedComponents(base);
    var groupIndex = 1;
    for (final handler in handlers) {
      final value = match.group(groupIndex++) ?? '';
      handler.apply(value, components);
    }
    return components;
  }
}

class _IsoCapture {
  const _IsoCapture({required this.pattern, required this.apply});

  final String pattern;
  final void Function(String value, _IsoParsedComponents builder) apply;

  static _IsoCapture? fromToken(String token, _LocaleNameIndex names) {
    switch (token) {
      case 'YYYY':
      case 'YYYYY':
      case 'YYYYYY':
        return _IsoCapture(
          pattern: r'([+-]?\d{4,})',
          apply: (value, builder) => builder.year = int.parse(value),
        );
      case 'YY':
        return _IsoCapture(
          pattern: r'(\d{2})',
          apply: (value, builder) => builder.setTwoDigitYear(int.parse(value)),
        );
      case 'M':
      case 'MM':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.month = int.parse(value),
        );
      case 'MMM':
        return _IsoCapture(
          pattern: names.shortMonthPattern,
          apply: (value, builder) {
            final month = names.shortMonthIndex(value);
            if (month == null) {
              throw ArgumentError(
                'Unknown month "$value" for locale ${names.locale}',
              );
            }
            builder.month = month;
          },
        );
      case 'MMMM':
        return _IsoCapture(
          pattern: names.longMonthPattern,
          apply: (value, builder) {
            final month = names.longMonthIndex(value);
            if (month == null) {
              throw ArgumentError(
                'Unknown month "$value" for locale ${names.locale}',
              );
            }
            builder.month = month;
          },
        );
      case 'ddd':
        return _IsoCapture(
          pattern: names.shortWeekdayPattern,
          apply: (unusedValue, unusedBuilder) {},
        );
      case 'dddd':
        return _IsoCapture(
          pattern: names.longWeekdayPattern,
          apply: (unusedValue, unusedBuilder) {},
        );
      case 'D':
      case 'DD':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.day = int.parse(value),
        );
      case 'Do':
        return _IsoCapture(
          pattern: r'(\d{1,2})(?:st|nd|rd|th|er|e)',
          apply: (value, builder) {
            final match = RegExp(r'\d+').firstMatch(value);
            builder.day = int.parse(match?.group(0) ?? '0');
          },
        );
      case 'H':
      case 'HH':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.hour24 = int.parse(value),
        );
      case 'h':
      case 'hh':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.hour12 = int.parse(value),
        );
      case 'm':
      case 'mm':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.minute = int.parse(value),
        );
      case 's':
      case 'ss':
        return _IsoCapture(
          pattern: r'(\d{1,2})',
          apply: (value, builder) => builder.second = int.parse(value),
        );
      case 'S':
      case 'SS':
      case 'SSS':
      case 'SSSS':
      case 'SSSSS':
      case 'SSSSSS':
      case 'SSSSSSS':
      case 'SSSSSSSS':
      case 'SSSSSSSSS':
        final length = token.length;
        return _IsoCapture(
          pattern: '([0-9]{$length})',
          apply: (value, builder) {
            final normalized = value.length >= 6
                ? value.substring(0, 6)
                : value.padRight(6, '0');
            builder.microsecond = int.parse(normalized);
          },
        );
      case 'A':
      case 'a':
        return _IsoCapture(
          pattern: names.meridiemPattern,
          apply: (value, builder) {
            final isPm = names.isPm(value);
            if (isPm == null) {
              throw ArgumentError(
                'Unknown meridiem "$value" for locale ${names.locale}',
              );
            }
            builder.isPm = isPm;
          },
        );
      case 'zz':
        return _IsoCapture(
          pattern: r'([A-Za-z0-9_\-/+]+)',
          apply: (value, builder) => builder.timeZone = value,
        );
      case 'Z':
      case 'P':
        return _IsoCapture(
          pattern: r'([+-]\d{2}:?\d{2})',
          apply: (value, builder) => builder.timeZone = _normalizeOffset(value),
        );
      case 'ZZ':
      case 'O':
        return _IsoCapture(
          pattern: r'([+-]\d{4})',
          apply: (value, builder) => builder.timeZone = _normalizeOffset(value),
        );
      case 'X':
        return _IsoCapture(
          pattern: r'(\d+)',
          apply: (value, builder) {
            final seconds = int.parse(value);
            final instant = DateTime.fromMillisecondsSinceEpoch(
              seconds * 1000,
              isUtc: true,
            );
            builder.year = instant.year;
            builder.month = instant.month;
            builder.day = instant.day;
            builder.hour24 = instant.hour;
            builder.minute = instant.minute;
            builder.second = instant.second;
          },
        );
      default:
        return null;
    }
  }

  static String _normalizeOffset(String raw) {
    var value = raw.replaceAll(':', '');
    if (!value.startsWith('+') && !value.startsWith('-')) {
      value = '+$value';
    }
    if (value.length < 5) {
      final sign = value.substring(0, 1);
      final digits = value.substring(1).padRight(4, '0');
      value = '$sign$digits';
    }
    final hours = value.substring(1, 3);
    final minutes = value.substring(3, 5);
    final sign = value.substring(0, 1);
    return '$sign$hours:$minutes';
  }
}

class _IsoParsedComponents {
  _IsoParsedComponents(DateTime base)
    : year = base.year,
      month = base.month,
      day = base.day,
      hour = base.hour,
      minute = base.minute,
      second = base.second,
      microsecond = base.microsecond;

  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  int microsecond;
  int? hour24;
  int? hour12;
  bool? isPm;
  String? timeZone;

  void setTwoDigitYear(int value) {
    year = value >= 70 ? 1900 + value : 2000 + value;
  }

  DateTime toUtc(String? overrideZone) {
    final zone = overrideZone ?? timeZone;
    final resolvedHour = hour24 ?? _resolveHour12() ?? hour;
    return CarbonBase._localToUtc(
      year: year,
      month: month,
      day: day,
      hour: resolvedHour,
      minute: minute,
      second: second,
      microsecond: microsecond,
      timeZone: zone,
    );
  }

  int? _resolveHour12() {
    if (hour12 == null) {
      return null;
    }
    var value = hour12! % 12;
    if (isPm == true) {
      value = value == 12 ? 12 : value + 12;
    } else if (isPm == false && value == 12) {
      value = 0;
    }
    return value;
  }
}

class _LocaleNameIndex {
  _LocaleNameIndex(this.locale) {
    _ingestLocale(locale);
    if (_longMonthForms.isEmpty || _longWeekdayForms.isEmpty) {
      _ingestLocale('en');
    }
    if (_meridiemLookup.isEmpty) {
      _meridiemLookup['am'] = false;
      _meridiemLookup['pm'] = true;
    }
  }

  final String locale;
  final Map<String, int> _longMonthLookup = <String, int>{};
  final Map<String, int> _shortMonthLookup = <String, int>{};
  final Map<String, int> _longWeekdayLookup = <String, int>{};
  final Map<String, int> _shortWeekdayLookup = <String, int>{};
  final Map<String, bool> _meridiemLookup = <String, bool>{};
  final Set<String> _longMonthForms = <String>{};
  final Set<String> _shortMonthForms = <String>{};
  final Set<String> _longWeekdayForms = <String>{};
  final Set<String> _shortWeekdayForms = <String>{};

  String get longMonthPattern => _patternFor(_longMonthForms);
  String get shortMonthPattern => _patternFor(_shortMonthForms);
  String get longWeekdayPattern => _patternFor(_longWeekdayForms);
  String get shortWeekdayPattern => _patternFor(_shortWeekdayForms);
  String get meridiemPattern =>
      _patternFor(_meridiemLookup.keys.toSet(), fallback: r'([AaPp]\.?M\.?)');

  int? longMonthIndex(String value) =>
      _longMonthLookup[_normalize(value)] ??
      _shortMonthLookup[_normalize(value)];

  int? shortMonthIndex(String value) =>
      _shortMonthLookup[_normalize(value)] ??
      _longMonthLookup[_normalize(value)];

  bool? isPm(String value) => _meridiemLookup[_normalize(value)];

  void _ingestLocale(String target) {
    try {
      final formatter = DateFormat.yMd(target);
      final symbols = formatter.dateSymbols;
      _ingestList(symbols.MONTHS, _longMonthLookup, _longMonthForms);
      _ingestList(symbols.SHORTMONTHS, _shortMonthLookup, _shortMonthForms);
      _ingestList(symbols.WEEKDAYS, _longWeekdayLookup, _longWeekdayForms);
      _ingestList(
        symbols.SHORTWEEKDAYS,
        _shortWeekdayLookup,
        _shortWeekdayForms,
      );
      final ampms = symbols.AMPMS;
      if (ampms.isNotEmpty) {
        if (ampms.isNotEmpty) {
          _registerMeridiem(ampms[0], false);
        }
        if (ampms.length > 1) {
          _registerMeridiem(ampms[1], true);
        }
      }
    } catch (_) {
      // Locale data not initialized; best-effort fallback.
    }
  }

  void _registerMeridiem(String raw, bool isPm) {
    final normalized = _normalize(raw);
    if (normalized.isEmpty) {
      return;
    }
    _meridiemLookup.putIfAbsent(normalized, () => isPm);
  }

  void _ingestList(
    List<String> source,
    Map<String, int> lookup,
    Set<String> forms,
  ) {
    for (var i = 0; i < source.length; i++) {
      final name = source[i];
      if (name.isEmpty) {
        continue;
      }
      lookup[_normalize(name)] = i + 1;
      forms.add(name);
    }
  }

  String _patternFor(Set<String> forms, {String fallback = r'(.+?)'}) {
    final candidates = forms.where((value) => value.isNotEmpty).toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    if (candidates.isEmpty) {
      return fallback;
    }
    final pattern = candidates.map(RegExp.escape).join('|');
    return '($pattern)';
  }

  String _normalize(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}

/// Extracts microseconds from an ISO 8601 string.
///
/// On web, JavaScript's Date only supports millisecond precision, so
/// DateTime.parse() will truncate microseconds. This function extracts
/// the full microsecond value directly from the string before parsing.
///
/// Returns null if no fractional seconds are found in the input string.
int? extractMicrosecondsFromIsoString(String input) {
  // Match fractional seconds in ISO 8601 format: .123456 or ,123456
  final match = RegExp(r'[.,](\d+)').firstMatch(input);
  if (match == null) return null;

  final fractional = match.group(1)!;
  // Pad to 6 digits (microseconds) or truncate if longer
  if (fractional.length >= 6) {
    return int.parse(fractional.substring(0, 6));
  } else {
    return int.parse(fractional.padRight(6, '0'));
  }
}

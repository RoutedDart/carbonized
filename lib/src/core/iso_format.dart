part of '../carbon.dart';

final class _IsoFormatter {
  _IsoFormatter(this._carbon);

  final CarbonBase _carbon;

  static final RegExp _tokenRegex = RegExp(
    r'LTS|LT|L{1,4}|l{1,4}|Do|Mo|Qo|wo|GGGG|GG|gggg|gg|WW|W|SSSSSSSSS|SSSSSSSS|SSSSSSS|SSSSSS|SSSSS|SSSS|SSS|SS|S|YYYYY|YYYY|YY|Q|MMMM|MMM|MM|M|DDDD|DDD|DD|D|dddd|ddd|dd|d|t|HH|H|hh|h|kk|k|mm|m|ss|s|A|a|w|ww|X|x|Z{1,2}|[A-Za-z]',
  );

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
      final match = _tokenRegex.firstMatch(remaining);
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
    if (_lTokenPatterns.containsKey(token)) {
      final pattern = _lTokenPatterns[token]!;
      return DateFormat(
        pattern,
        _carbon.localeCode,
      ).format(_carbon._localDateTimeForFormatting());
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
        return _ordinal(_quarter, _carbon.localeCode);
      case 'M':
        return _carbon.month.toString();
      case 'MM':
        return _twoDigits(_carbon.month);
      case 'Mo':
        return _ordinal(_carbon.month, _carbon.localeCode);
      case 'MMM':
        return _localizedMonthShortName(_carbon.localeCode, _carbon.month);
      case 'MMMM':
        return DateFormat.MMMM(
          _carbon.localeCode,
        ).format(_carbon._localDateTimeForFormatting());
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
        return _ordinal(_carbon.day, _carbon.localeCode);
      case 'ddd':
        return _localizedWeekdayShortName(
          _carbon.localeCode,
          (_carbon.dayOfWeek + 1),
        );
      case 'dddd':
        return DateFormat.EEEE(
          _carbon.localeCode,
        ).format(_carbon._localDateTimeForFormatting());
      case 'w':
        return _carbon.weekOfYear.toString();
      case 'ww':
        return _carbon.weekOfYear.toString().padLeft(2, '0');
      case 'wo':
        return _ordinal(_carbon.weekOfYear, _carbon.localeCode);
      case 'W':
        return _isoWeek().toString();
      case 'WW':
        return _isoWeek().toString().padLeft(2, '0');
      case 'gggg':
      case 'GGGG':
        return _padYear(_isoWeekYear());
      case 'gg':
      case 'GG':
        return (_isoWeekYear() % 100).abs().toString().padLeft(2, '0');
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
      case 'X':
        return (_carbon.dateTime.millisecondsSinceEpoch ~/ 1000).toString();
      case 'x':
        return _carbon.dateTime.millisecondsSinceEpoch.toString();
      default:
        return token;
    }
  }

  int get _quarter => ((_carbon.month - 1) ~/ 3) + 1;

  int _isoWeek() => _isoWeekData().$1;

  int _isoWeekYear() => _isoWeekData().$2;

  (int, int) _isoWeekData() {
    final local = _carbon._localDateTimeForFormatting();
    final weekday = local.weekday == DateTime.sunday ? 7 : local.weekday;
    final thursday = local.add(Duration(days: 4 - weekday));
    final firstThursday = DateTime.utc(thursday.year, 1, 4);
    final isoWeek = 1 + ((thursday.difference(firstThursday).inDays) ~/ 7);
    return (isoWeek, thursday.year);
  }

  String _fractional(int digits) {
    final micros = _carbon.microsecond.abs().toString().padLeft(6, '0');
    final length = math.min(digits, 6);
    return micros.substring(0, length);
  }
}

const Map<String, String> _lTokenPatterns = <String, String>{
  'LTS': 'h:mm:ss a',
  'LT': 'h:mm a',
  'L': 'MM/dd/yyyy',
  'LL': 'MMMM d, yyyy',
  'LLL': 'MMMM d, yyyy h:mm a',
  'LLLL': 'EEEE, MMMM d, yyyy h:mm a',
  'l': 'M/d/yyyy',
  'll': 'MMM d, yyyy',
  'lll': 'MMM d, yyyy h:mm a',
  'llll': 'EEE, MMM d, yyyy h:mm a',
};

String _ordinal(int value, String locale) {
  if (locale.startsWith('fr')) {
    return value == 1 ? '1er' : '${value}e';
  }
  final mod100 = value % 100;
  final lastDigit = value % 10;
  String suffix;
  if (mod100 >= 11 && mod100 <= 13) {
    suffix = 'th';
  } else if (lastDigit == 1) {
    suffix = 'st';
  } else if (lastDigit == 2) {
    suffix = 'nd';
  } else if (lastDigit == 3) {
    suffix = 'rd';
  } else {
    suffix = 'th';
  }
  return '$value$suffix';
}

class _TranslatedFormatConverter {
  _TranslatedFormatConverter(this.pattern);

  final String pattern;

  String toIsoPattern() {
    final buffer = StringBuffer();
    final chars = pattern.split('');
    for (var i = 0; i < chars.length; i++) {
      final char = chars[i];
      if (char == '\\' && i + 1 < chars.length) {
        buffer.write('\\${chars[++i]}');
        continue;
      }
      if (char == 'j' && i + 1 < chars.length && chars[i + 1] == 'S') {
        buffer.write('Do');
        i++;
        continue;
      }
      buffer.write(_mapChar(char));
    }
    return buffer.toString();
  }

  String _mapChar(String char) {
    switch (char) {
      case 'Y':
        return 'YYYY';
      case 'y':
        return 'YY';
      case 'm':
        return 'MM';
      case 'n':
        return 'M';
      case 'd':
        return 'DD';
      case 'j':
        return 'D';
      case 't':
        return 't';
      case 'H':
        return 'HH';
      case 'h':
        return 'hh';
      case 'g':
        return 'h';
      case 'i':
        return 'mm';
      case 's':
        return 'ss';
      case 'a':
        return 'a';
      case 'A':
        return 'A';
      case 'F':
        return 'MMMM';
      case 'M':
        return 'MMM';
      default:
        return char;
    }
  }
}

part of '../carbon.dart';

bool _carbonDateFormatConfigured = false;

/// Ensures the intl-derived formatter consults Carbon's locale data.
void ensureCarbonDateFormatConfigured() {
  if (_carbonDateFormatConfigured) return;
  configureCarbonCarbonDateFormat(
    symbolsBuilder: _buildCarbonDateSymbols,
    skeletonBuilder: _buildCarbonSkeletons,
    localeExists: _localeExists,
  );
  _carbonDateFormatConfigured = true;
}

// ignore: unused_element
final bool _carbonDateFormatAutoInit = (() {
  ensureCarbonDateFormatConfigured();
  return true;
})();

DateSymbols _buildCarbonDateSymbols(String locale) {
  final CarbonLocaleData data = CarbonTranslator.matchLocale(locale);

  final months = _normalizeList(data.months, _defaultMonths, 12);
  final monthsShort = _normalizeList(data.monthsShort, _defaultMonthsShort, 12);
  final standaloneMonths = _normalizeList(data.monthsStandalone, months, 12);
  final standaloneShortMonths = _normalizeList(
    data.monthsStandalone.isEmpty ? data.monthsShort : data.monthsStandalone,
    monthsShort,
    12,
  );

  final weekdaysSource = data.weekdays.isNotEmpty
      ? data.weekdays
      : _defaultWeekdays;
  final weekdays = _normalizeList(weekdaysSource, _defaultWeekdays, 7);
  final weekdaysShort = _normalizeList(
    data.weekdaysShort,
    _defaultWeekdaysShort,
    7,
  );
  final weekdaysStandalone = weekdays;
  final weekdaysStandaloneShort = weekdaysShort;
  final weekdaysMin = _normalizeList(
    data.weekdaysMin.isNotEmpty ? data.weekdaysMin : weekdaysShort,
    _defaultWeekdaysMin,
    7,
  );
  final narrowWeekdays = _toNarrowList(weekdaysMin, weekdaysShort);

  final monthsStandaloneNarrow = _toNarrowList(
    _normalizeList(data.monthsStandalone, months, 12),
    months,
  );

  final monthsNarrow = _toNarrowList(months, months);

  final ampm = data.meridiem != null
      ? [data.meridiem!(0, 0, false), data.meridiem!(13, 0, false)]
      : _defaultAmPm;

  final zeroDigit = data.numbers['0'];
  final firstDayOfWeek = _normalizeWeekdayIndex(data.firstDayOfWeek);
  final firstWeekCutoff = _clampInclusive(data.dayOfFirstWeekOfYear, 1, 7);

  final lPattern = _convertMomentToIcu(data.formats['L']) ?? 'M/d/y';
  final llPattern = _convertMomentToIcu(data.formats['LL']) ?? 'MMMM d, y';
  final lllPattern =
      _convertMomentToIcu(data.formats['LLL']) ?? 'MMM d, y h:mm a';
  final llllPattern =
      _convertMomentToIcu(data.formats['LLLL']) ?? 'EEEE, MMMM d, y h:mm a';

  final dateFormats = [
    _removeTimePortion(llllPattern),
    _removeTimePortion(llPattern),
    _removeTimePortion(lllPattern),
    lPattern,
  ];

  final lt = _convertMomentToIcu(data.formats['LT']) ?? 'h:mm a';
  final lts = _convertMomentToIcu(data.formats['LTS']) ?? 'h:mm:ss a';

  final timeFormats = ['$lts zzzz', '$lts z', lts, lt];

  return DateSymbols(
    NAME: locale,
    ERAS: const ['BC', 'AD'],
    ERANAMES: const ['Before Christ', 'Anno Domini'],
    NARROWMONTHS: monthsNarrow,
    STANDALONENARROWMONTHS: monthsStandaloneNarrow,
    MONTHS: months,
    STANDALONEMONTHS: standaloneMonths,
    SHORTMONTHS: monthsShort,
    STANDALONESHORTMONTHS: standaloneShortMonths,
    WEEKDAYS: weekdays,
    STANDALONEWEEKDAYS: weekdaysStandalone,
    SHORTWEEKDAYS: weekdaysShort,
    STANDALONESHORTWEEKDAYS: weekdaysStandaloneShort,
    NARROWWEEKDAYS: narrowWeekdays,
    STANDALONENARROWWEEKDAYS: narrowWeekdays,
    SHORTQUARTERS: const ['Q1', 'Q2', 'Q3', 'Q4'],
    QUARTERS: const [
      '1st quarter',
      '2nd quarter',
      '3rd quarter',
      '4th quarter',
    ],
    AMPMS: ampm,
    ZERODIGIT: zeroDigit != null && zeroDigit.length == 1 ? zeroDigit : null,
    DATEFORMATS: dateFormats,
    TIMEFORMATS: timeFormats,
    AVAILABLEFORMATS: _buildCarbonSkeletons(locale),
    FIRSTDAYOFWEEK: firstDayOfWeek,
    WEEKENDRANGE: const [5, 6],
    FIRSTWEEKCUTOFFDAY: firstWeekCutoff,
    DATETIMEFORMATS: const ['{1} {0}', '{1} {0}', '{1} {0}', '{1} {0}'],
  );
}

Map<String, String> _buildCarbonSkeletons(String locale) {
  final CarbonLocaleData data = CarbonTranslator.matchLocale(locale);
  final formats = data.formats;

  final l = _convertMomentToIcu(formats['L']) ?? 'M/d/y';
  final ll = _removeTimePortion(
    _convertMomentToIcu(formats['LL']) ?? 'MMMM d, y',
  );
  final lll = _removeTimePortion(
    _convertMomentToIcu(formats['LLL']) ?? 'MMM d, y',
  );
  final llll = _removeTimePortion(
    _convertMomentToIcu(formats['LLLL']) ?? 'EEEE, MMMM d, y',
  );

  final lt = _convertMomentToIcu(formats['LT']) ?? 'h:mm a';
  final lts = _convertMomentToIcu(formats['LTS']) ?? 'h:mm:ss a';

  final map = <String, String>{
    'd': 'd',
    'E': 'EEE',
    'EEEE': 'EEEE',
    'LLL': lll,
    'LLLL': llll,
    'M': 'M',
    'Md': l,
    'MEd': 'EEE, $l',
    'MMM': 'MMM',
    'MMMd': 'MMM d',
    'MMMEd': 'EEE, MMM d',
    'MMMM': 'MMMM',
    'MMMMd': ll,
    'MMMMEEEEd': llll,
    'QQQ': 'QQQ',
    'QQQQ': 'QQQQ',
    'y': 'y',
    'yM': 'M/y',
    'yMd': l,
    'yMEd': 'EEE, $l',
    'yMMM': 'MMM y',
    'yMMMd': ll,
    'yMMMEd': 'EEE, $ll',
    'yMMMM': ll,
    'yMMMMd': ll,
    'yMMMMEEEEd': llll,
    'yQQQ': 'QQQ y',
    'yQQQQ': 'QQQQ y',
    'H': 'H',
    'Hm': lt.replaceFirst(RegExp(r'[^Hh]+'), 'H:mm'),
    'Hms': lts.replaceFirst(RegExp(r'[^Hh]+'), 'H:mm:ss'),
    'j': lt,
    'jm': lt,
    'jms': lts,
    'm': 'm',
    'ms': 'm:ss',
    's': 's',
  };

  return map;
}

List<String> _normalizeList(
  List<String> source,
  List<String> fallback,
  int expectedLength,
) {
  if (source.length >= expectedLength) {
    return source.take(expectedLength).toList();
  }
  if (source.isNotEmpty) {
    return [
      ...source,
      ...List<String>.filled(expectedLength - source.length, ''),
    ];
  }
  if (fallback.isNotEmpty) {
    if (fallback.length >= expectedLength) {
      return fallback.take(expectedLength).toList();
    }
    return [
      ...fallback,
      ...List<String>.filled(expectedLength - fallback.length, ''),
    ];
  }
  return List<String>.filled(expectedLength, '');
}

List<String> _toNarrowList(List<String> preferred, List<String> secondary) {
  final result = <String>[];
  for (var i = 0; i < preferred.length; i++) {
    final candidate = preferred[i];
    if (candidate.isNotEmpty) {
      result.add(_firstCharacter(candidate));
    } else if (i < secondary.length && secondary[i].isNotEmpty) {
      result.add(_firstCharacter(secondary[i]));
    } else {
      result.add('');
    }
  }
  return result;
}

String _firstCharacter(String input) {
  if (input.isEmpty) return '';
  final iterator = input.runes.iterator;
  return iterator.moveNext() ? String.fromCharCode(iterator.current) : '';
}

int _normalizeWeekdayIndex(int value) {
  final normalized = ((value - 1) % 7 + 7) % 7;
  return normalized;
}

int _clampInclusive(int value, int min, int max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}

String _removeTimePortion(String pattern) {
  return pattern
      .replaceAll(RegExp(r"[ ]*[hHkKmsSaAzZ.:']+[ ]*"), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

String? _convertMomentToIcu(String? pattern) {
  if (pattern == null || pattern.isEmpty) return null;

  final buffer = StringBuffer();
  bool inLiteral = false;

  int index = 0;
  while (index < pattern.length) {
    final remaining = pattern.substring(index);

    if (!inLiteral && remaining.startsWith('[')) {
      inLiteral = true;
      buffer.write("'");
      index++;
      continue;
    }

    if (inLiteral && remaining.startsWith(']')) {
      inLiteral = false;
      buffer.write("'");
      index++;
      continue;
    }

    if (!inLiteral) {
      final match = _momentTokenMappings.firstWhere(
        (entry) => remaining.startsWith(entry.source),
        orElse: () => _TokenMapping('', ''),
      );

      if (match.source.isNotEmpty) {
        buffer.write(match.target);
        index += match.source.length;
        continue;
      }
    }

    final char = pattern[index];
    if (char == "'") {
      buffer.write("''");
    } else {
      buffer.write(char);
    }
    index++;
  }

  if (inLiteral) {
    buffer.write("'");
  }

  final result = buffer.toString().trim();
  return result.isEmpty ? null : result;
}

const _momentTokenMappings = <_TokenMapping>[
  _TokenMapping('YYYY', 'y'),
  _TokenMapping('YY', 'yy'),
  _TokenMapping('MMMM', 'MMMM'),
  _TokenMapping('MMM', 'MMM'),
  _TokenMapping('MM', 'MM'),
  _TokenMapping('M', 'M'),
  _TokenMapping('DD', 'dd'),
  _TokenMapping('D', 'd'),
  _TokenMapping('Do', 'd'),
  _TokenMapping('dddd', 'EEEE'),
  _TokenMapping('ddd', 'EEE'),
  _TokenMapping('dd', 'EE'),
  _TokenMapping('d', 'e'),
  _TokenMapping('A', 'a'),
  _TokenMapping('a', 'a'),
  _TokenMapping('HH', 'HH'),
  _TokenMapping('H', 'H'),
  _TokenMapping('hh', 'hh'),
  _TokenMapping('h', 'h'),
  _TokenMapping('mm', 'mm'),
  _TokenMapping('m', 'm'),
  _TokenMapping('ss', 'ss'),
  _TokenMapping('s', 's'),
];

class _TokenMapping {
  final String source;
  final String target;

  const _TokenMapping(this.source, this.target);
}

const List<String> _defaultMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> _defaultMonthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

const List<String> _defaultWeekdays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

const List<String> _defaultWeekdaysShort = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<String> _defaultWeekdaysMin = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

const List<String> _defaultAmPm = ['AM', 'PM'];

bool _localeExists(String locale) {
  try {
    CarbonTranslator.matchLocale(locale);
  } catch (_) {
    // Swallow errors here; the formatter will fall back to Carbon's internal
    // locale resolution when it actually builds the symbols.
  }
  return true;
}

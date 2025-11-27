// AUTO-GENERATED from PHP Carbon locale: se
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSe = CarbonLocaleData(
  localeCode: 'se',
  translationStrings: {
    'year': '{1}:count jahki|:count jagit',
    'a_year': '{1}okta jahki|:count jagit',
    'y': ':count j.',
    'month': '{1}:count mánnu|:count mánut',
    'a_month': '{1}okta mánnu|:count mánut',
    'm': ':count mán.',
    'week': '{1}:count vahkku|:count vahkku',
    'a_week': '{1}okta vahkku|:count vahkku',
    'w': ':count v.',
    'day': '{1}:count beaivi|:count beaivvit',
    'a_day': '{1}okta beaivi|:count beaivvit',
    'd': ':count b.',
    'hour': '{1}:count diimmu|:count diimmut',
    'a_hour': '{1}okta diimmu|:count diimmut',
    'h': ':count d.',
    'minute': '{1}:count minuhta|:count minuhtat',
    'a_minute': '{1}okta minuhta|:count minuhtat',
    'min': ':count min.',
    'second': '{1}:count sekunddat|:count sekunddat',
    'a_second': '{1}moadde sekunddat|:count sekunddat',
    's': ':count s.',
    'ago': 'maŋit :time',
    'from_now': ':time geažes',
    'diff_yesterday': 'ikte',
    'diff_yesterday_regexp': 'ikte(?:\\s+ti)?',
    'diff_today': 'otne',
    'diff_today_regexp': 'otne(?:\\s+ti)?',
    'diff_tomorrow': 'ihttin',
    'diff_tomorrow_regexp': 'ihttin(?:\\s+ti)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'MMMM D. [b.] YYYY',
    'LLL': 'MMMM D. [b.] YYYY [ti.] HH:mm',
    'LLLL': 'dddd, MMMM D. [b.] YYYY [ti.] HH:mm',
  },
  months: [
    'ođđajagemánnu',
    'guovvamánnu',
    'njukčamánnu',
    'cuoŋománnu',
    'miessemánnu',
    'geassemánnu',
    'suoidnemánnu',
    'borgemánnu',
    'čakčamánnu',
    'golggotmánnu',
    'skábmamánnu',
    'juovlamánnu',
  ],
  monthsShort: [
    'ođđj',
    'guov',
    'njuk',
    'cuo',
    'mies',
    'geas',
    'suoi',
    'borg',
    'čakč',
    'golg',
    'skáb',
    'juov',
  ],
  weekdays: [
    'sotnabeaivi',
    'vuossárga',
    'maŋŋebárga',
    'gaskavahkku',
    'duorastat',
    'bearjadat',
    'lávvardat',
  ],
  weekdaysShort: ['sotn', 'vuos', 'maŋ', 'gask', 'duor', 'bear', 'láv'],
  weekdaysMin: ['s', 'v', 'm', 'g', 'd', 'b', 'L'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[otne ti] LT',
    'nextDay': '[ihttin ti] LT',
    'nextWeek': 'dddd [ti] LT',
    'lastDay': '[ikte ti] LT',
    'lastWeek': '[ovddit] dddd [ti] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ja '],
  meridiem: _meridiem,
);

// Regional variant: se_FI
final CarbonLocaleData localeSeFi = localeSe.copyWith(
  localeCode: 'se_fi',
  weekdays: [
    'sotnabeaivi',
    'mánnodat',
    'disdat',
    'gaskavahkku',
    'duorastat',
    'bearjadat',
    'lávvordat',
  ],
  weekdaysShort: ['so', 'má', 'di', 'ga', 'du', 'be', 'lá'],
  weekdaysMin: ['so', 'má', 'di', 'ga', 'du', 'be', 'lá'],
  monthsShort: [
    'ođđj',
    'guov',
    'njuk',
    'cuoŋ',
    'mies',
    'geas',
    'suoi',
    'borg',
    'čakč',
    'golg',
    'skáb',
    'juov',
  ],
);

// Regional variant: se_NO
final CarbonLocaleData localeSeNo = localeSe.copyWith(localeCode: 'se_no');

// Regional variant: se_SE
final CarbonLocaleData localeSeSe = localeSe.copyWith(localeCode: 'se_se');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'i.b.' : 'e.b.';
}

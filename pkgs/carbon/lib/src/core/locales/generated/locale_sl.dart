// AUTO-GENERATED from PHP Carbon locale: sl
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSl = CarbonLocaleData(
  localeCode: 'sl',
  translationStrings: {
    'year': ':count leto|:count leti|:count leta|:count let',
    'y': ':count leto|:count leti|:count leta|:count let',
    'month': ':count mesec|:count meseca|:count mesece|:count mesecev',
    'm': ':count mes.',
    'week': ':count teden|:count tedna|:count tedne|:count tednov',
    'w': ':count ted.',
    'day': ':count dan|:count dni|:count dni|:count dni',
    'd': ':count dan|:count dni|:count dni|:count dni',
    'hour': ':count ura|:count uri|:count ure|:count ur',
    'h': ':count h',
    'minute': ':count minuta|:count minuti|:count minute|:count minut',
    'min': ':count min.',
    'second': ':count sekunda|:count sekundi|:count sekunde|:count sekund',
    'a_second':
        '{1}nekaj sekund|:count sekunda|:count sekundi|:count sekunde|:count sekund',
    's': ':count s',
    'year_ago': ':count letom|:count letoma|:count leti|:count leti',
    'y_ago': ':count letom|:count letoma|:count leti|:count leti',
    'month_ago': ':count mesecem|:count mesecema|:count meseci|:count meseci',
    'week_ago': ':count tednom|:count tednoma|:count tedni|:count tedni',
    'day_ago': ':count dnem|:count dnevoma|:count dnevi|:count dnevi',
    'd_ago': ':count dnem|:count dnevoma|:count dnevi|:count dnevi',
    'hour_ago': ':count uro|:count urama|:count urami|:count urami',
    'minute_ago':
        ':count minuto|:count minutama|:count minutami|:count minutami',
    'second_ago':
        ':count sekundo|:count sekundama|:count sekundami|:count sekundami',
    'day_from_now': ':count dan|:count dneva|:count dni|:count dni',
    'd_from_now': ':count dan|:count dneva|:count dni|:count dni',
    'hour_from_now': ':count uro|:count uri|:count ure|:count ur',
    'minute_from_now': ':count minuto|:count minuti|:count minute|:count minut',
    'second_from_now':
        ':count sekundo|:count sekundi|:count sekunde|:count sekund',
    'ago': 'pred :time',
    'from_now': 'čez :time',
    'after': ':time kasneje',
    'before': ':time prej',
    'diff_now': 'ravnokar',
    'diff_today': 'danes',
    'diff_today_regexp': 'danes(?:\\s+ob)?',
    'diff_yesterday': 'včeraj',
    'diff_yesterday_regexp': 'včeraj(?:\\s+ob)?',
    'diff_tomorrow': 'jutri',
    'diff_tomorrow_regexp': 'jutri(?:\\s+ob)?',
    'diff_before_yesterday': 'predvčerajšnjim',
    'diff_after_tomorrow': 'pojutrišnjem',
    'period_start_date': 'od :date',
    'period_end_date': 'do :date',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY H:mm',
    'LLLL': 'dddd, D. MMMM YYYY H:mm',
  },
  months: [
    'januar',
    'februar',
    'marec',
    'april',
    'maj',
    'junij',
    'julij',
    'avgust',
    'september',
    'oktober',
    'november',
    'december',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'maj',
    'jun',
    'jul',
    'avg',
    'sep',
    'okt',
    'nov',
    'dec',
  ],
  weekdays: [
    'nedelja',
    'ponedeljek',
    'torek',
    'sreda',
    'četrtek',
    'petek',
    'sobota',
  ],
  weekdaysShort: ['ned', 'pon', 'tor', 'sre', 'čet', 'pet', 'sob'],
  weekdaysMin: ['ne', 'po', 'to', 'sr', 'če', 'pe', 'so'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[danes ob] LT',
    'nextDay': '[jutri ob] LT',
    'nextWeek': 'dddd [ob] LT',
    'lastDay': '[včeraj ob] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' in '],
  periodStartDate: 'od :date',
  periodEndDate: 'do :date',
  meridiem: _meridiem,
);

// Regional variant: sl_SI
final CarbonLocaleData localeSlSi = localeSl.copyWith(localeCode: 'sl_si');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'dopoldan' : 'popoldan';
}

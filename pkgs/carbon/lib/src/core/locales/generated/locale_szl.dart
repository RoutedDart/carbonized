// AUTO-GENERATED from PHP Carbon locale: szl
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSzl = CarbonLocaleData(
  localeCode: 'szl',
  translationStrings: {
    'year': ':count rok',
    'a_year': ':count rok',
    'y': ':count rok',
    'month': ':count mjeśůnc',
    'a_month': ':count mjeśůnc',
    'm': ':count mjeśůnc',
    'week': ':count tydźyń',
    'a_week': ':count tydźyń',
    'w': ':count tydźyń',
    'day': ':count dźyń',
    'a_day': ':count dźyń',
    'd': ':count dźyń',
    'hour': ':count godzina',
    'a_hour': ':count godzina',
    'h': ':count godzina',
    'minute': ':count minuta',
    'a_minute': ':count minuta',
    'min': ':count minuta',
    'second': ':count sekůnda',
    'a_second': ':count sekůnda',
    's': ':count sekůnda',
    'millisecond':
        '{1}:count millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'a_millisecond':
        '{1}a millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'ms': ':countms',
    'microsecond':
        '{1}:count microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'a_microsecond':
        '{1}a microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'µs': ':countµs',
    'ago': ':time ago',
    'from_now': ':time from now',
    'after': ':time after',
    'before': ':time before',
    'diff_now': 'just now',
    'diff_today': 'today',
    'diff_yesterday': 'yesterday',
    'diff_tomorrow': 'tomorrow',
    'diff_before_yesterday': 'before yesterday',
    'diff_after_tomorrow': 'after tomorrow',
    'period_recurrences': '{1}once|{0}:count times|[-Inf,Inf]:count times',
    'period_interval': 'every :interval',
    'period_start_date': 'from :date',
    'period_end_date': 'to :date',
  },
  formats: {
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'DD.MM.YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'styczyń',
    'luty',
    'merc',
    'kwjeciyń',
    'moj',
    'czyrwjyń',
    'lipjyń',
    'siyrpjyń',
    'wrzesiyń',
    'październik',
    'listopad',
    'grudziyń',
  ],
  monthsShort: [
    'sty',
    'lut',
    'mer',
    'kwj',
    'moj',
    'czy',
    'lip',
    'siy',
    'wrz',
    'paź',
    'lis',
    'gru',
  ],
  weekdays: [
    'niydziela',
    'pyńdziŏek',
    'wtŏrek',
    'strzŏda',
    'sztwortek',
    'pjōntek',
    'sobŏta',
  ],
  weekdaysShort: ['niy', 'pyń', 'wtŏ', 'str', 'szt', 'pjō', 'sob'],
  weekdaysMin: ['niy', 'pyń', 'wtŏ', 'str', 'szt', 'pjō', 'sob'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: szl_PL
final CarbonLocaleData localeSzlPl = localeSzl.copyWith(localeCode: 'szl_pl');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

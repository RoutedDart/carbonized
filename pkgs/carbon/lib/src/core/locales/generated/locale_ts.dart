// AUTO-GENERATED from PHP Carbon locale: ts
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTs = CarbonLocaleData(
  localeCode: 'ts',
  translationStrings: {
    'year': 'malembe ya :count',
    'a_year': 'malembe ya :count',
    'y': 'malembe ya :count',
    'month': 'tin’hweti ta :count',
    'a_month': 'tin’hweti ta :count',
    'm': 'tin’hweti ta :count',
    'week': 'mavhiki ya :count',
    'a_week': 'mavhiki ya :count',
    'w': 'mavhiki ya :count',
    'day': 'masiku :count',
    'a_day': 'masiku :count',
    'd': 'masiku :count',
    'hour': 'tiawara ta :count',
    'a_hour': 'tiawara ta :count',
    'h': 'tiawara ta :count',
    'minute': 'timinete ta :count',
    'a_minute': 'timinete ta :count',
    'min': 'timinete ta :count',
    'second': 'tisekoni ta :count',
    'a_second': 'tisekoni ta :count',
    's': 'tisekoni ta :count',
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
    'L': 'DD/MM/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Sunguti',
    'Nyenyenyani',
    'Nyenyankulu',
    'Dzivamisoko',
    'Mudyaxihi',
    'Khotavuxika',
    'Mawuwani',
    'Mhawuri',
    'Ndzhati',
    'Nhlangula',
    'Hukuri',
    'N\'wendzamhala',
  ],
  monthsShort: [
    'Sun',
    'Yan',
    'Kul',
    'Dzi',
    'Mud',
    'Kho',
    'Maw',
    'Mha',
    'Ndz',
    'Nhl',
    'Huk',
    'N\'w',
  ],
  weekdays: [
    'Sonto',
    'Musumbhunuku',
    'Ravumbirhi',
    'Ravunharhu',
    'Ravumune',
    'Ravuntlhanu',
    'Mugqivela',
  ],
  weekdaysShort: ['Son', 'Mus', 'Bir', 'Har', 'Ne', 'Tlh', 'Mug'],
  weekdaysMin: ['Son', 'Mus', 'Bir', 'Har', 'Ne', 'Tlh', 'Mug'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
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

// Regional variant: ts_ZA
final CarbonLocaleData localeTsZa = localeTs.copyWith(localeCode: 'ts_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

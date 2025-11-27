// AUTO-GENERATED from PHP Carbon locale: kab
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKab = CarbonLocaleData(
  localeCode: 'kab',
  translationStrings: {
    'year': ':count n yiseggasen',
    'a_year': ':count n yiseggasen',
    'y': ':count n yiseggasen',
    'month': ':count n wayyuren',
    'a_month': ':count n wayyuren',
    'm': ':count n wayyuren',
    'week': ':count n ledwaṛ',
    'a_week': ':count n ledwaṛ',
    'w': ':count n ledwaṛ',
    'day': ':count n wussan',
    'a_day': ':count n wussan',
    'd': ':count n wussan',
    'hour': ':count n tsaɛtin',
    'a_hour': ':count n tsaɛtin',
    'h': ':count n tsaɛtin',
    'minute': ':count n tedqiqin',
    'a_minute': ':count n tedqiqin',
    'min': ':count n tedqiqin',
    'second': ':count tasdidt',
    'a_second': ':count tasdidt',
    's': ':count tasdidt',
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
    'Yennayer',
    'Fuṛar',
    'Meɣres',
    'Yebrir',
    'Mayyu',
    'Yunyu',
    'Yulyu',
    'ɣuct',
    'Ctembeṛ',
    'Tubeṛ',
    'Wambeṛ',
    'Dujembeṛ',
  ],
  monthsShort: [
    'Yen',
    'Fur',
    'Meɣ',
    'Yeb',
    'May',
    'Yun',
    'Yul',
    'ɣuc',
    'Cte',
    'Tub',
    'Wam',
    'Duj',
  ],
  weekdays: ['Acer', 'Arim', 'Aram', 'Ahad', 'Amhad', 'Sem', 'Sed'],
  weekdaysShort: ['Ace', 'Ari', 'Ara', 'Aha', 'Amh', 'Sem', 'Sed'],
  weekdaysMin: ['Ace', 'Ari', 'Ara', 'Aha', 'Amh', 'Sem', 'Sed'],
  firstDayOfWeek: 6,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  meridiem: _meridiem,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: kab_DZ
final CarbonLocaleData localeKabDz = localeKab.copyWith(localeCode: 'kab_dz');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'FT' : 'MD';
}

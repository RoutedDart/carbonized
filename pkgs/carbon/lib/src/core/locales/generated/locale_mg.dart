// AUTO-GENERATED from PHP Carbon locale: mg
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMg = CarbonLocaleData(
  localeCode: 'mg',
  translationStrings: {
    'year': ':count taona',
    'a_year': ':count taona',
    'y': ':count taona',
    'month': ':count volana',
    'a_month': ':count volana',
    'm': ':count volana',
    'week': ':count herinandro',
    'a_week': ':count herinandro',
    'w': ':count herinandro',
    'day': ':count andro',
    'a_day': ':count andro',
    'd': ':count andro',
    'hour': ':count ora',
    'a_hour': ':count ora',
    'h': ':count ora',
    'minute': ':count minitra',
    'a_minute': ':count minitra',
    'min': ':count minitra',
    'second': ':count segondra',
    'a_second': ':count segondra',
    's': ':count segondra',
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
    'Janoary',
    'Febroary',
    'Martsa',
    'Aprily',
    'Mey',
    'Jona',
    'Jolay',
    'Aogositra',
    'Septambra',
    'Oktobra',
    'Novambra',
    'Desambra',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mey',
    'Jon',
    'Jol',
    'Aog',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ],
  weekdays: [
    'alahady',
    'alatsinainy',
    'talata',
    'alarobia',
    'alakamisy',
    'zoma',
    'sabotsy',
  ],
  weekdaysShort: ['lhd', 'lts', 'tlt', 'lrb', 'lkm', 'zom', 'sab'],
  weekdaysMin: ['lhd', 'lts', 'tlt', 'lrb', 'lkm', 'zom', 'sab'],
  firstDayOfWeek: 1,
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

// Regional variant: mg_MG
final CarbonLocaleData localeMgMg = localeMg.copyWith(localeCode: 'mg_mg');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

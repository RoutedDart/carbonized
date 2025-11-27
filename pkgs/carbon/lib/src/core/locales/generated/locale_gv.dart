// AUTO-GENERATED from PHP Carbon locale: gv
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGv = CarbonLocaleData(
  localeCode: 'gv',
  translationStrings: {
    'year': ':count blein',
    'a_year': ':count blein',
    'y': ':count blein',
    'month': ':count mee',
    'a_month': ':count mee',
    'm': ':count mee',
    'week': ':count shiaghtin',
    'a_week': ':count shiaghtin',
    'w': ':count shiaghtin',
    'day': ':count laa',
    'a_day': ':count laa',
    'd': ':count laa',
    'hour': ':count oor',
    'a_hour': ':count oor',
    'h': ':count oor',
    'minute': ':count feer veg',
    'a_minute': ':count feer veg',
    'min': ':count feer veg',
    'second': ':count derrey',
    'a_second': ':count derrey',
    's': ':count derrey',
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
    'L': 'DD/MM/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Jerrey-geuree',
    'Toshiaght-arree',
    'Mayrnt',
    'Averil',
    'Boaldyn',
    'Mean-souree',
    'Jerrey-souree',
    'Luanistyn',
    'Mean-fouyir',
    'Jerrey-fouyir',
    'Mee Houney',
    'Mee ny Nollick',
  ],
  monthsShort: [
    'J-guer',
    'T-arree',
    'Mayrnt',
    'Avrril',
    'Boaldyn',
    'M-souree',
    'J-souree',
    'Luanistyn',
    'M-fouyir',
    'J-fouyir',
    'M.Houney',
    'M.Nollick',
  ],
  weekdays: [
    'Jedoonee',
    'Jelhein',
    'Jemayrt',
    'Jercean',
    'Jerdein',
    'Jeheiney',
    'Jesarn',
  ],
  weekdaysShort: ['Jed', 'Jel', 'Jem', 'Jerc', 'Jerd', 'Jeh', 'Jes'],
  weekdaysMin: ['Jed', 'Jel', 'Jem', 'Jerc', 'Jerd', 'Jeh', 'Jes'],
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

// Regional variant: gv_GB
final CarbonLocaleData localeGvGb = localeGv.copyWith(localeCode: 'gv_gb');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

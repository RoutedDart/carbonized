// AUTO-GENERATED from PHP Carbon locale: ksh
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKsh = CarbonLocaleData(
  localeCode: 'ksh',
  translationStrings: {
    'year': ':count Johr',
    'a_year': ':count Johr',
    'y': ':count Johr',
    'month': ':count Moohnd',
    'a_month': ':count Moohnd',
    'm': ':count Moohnd',
    'week': ':count woch',
    'a_week': ':count woch',
    'w': ':count woch',
    'day': ':count Daach',
    'a_day': ':count Daach',
    'd': ':count Daach',
    'hour': ':count Uhr',
    'a_hour': ':count Uhr',
    'h': ':count Uhr',
    'minute': ':count Menutt',
    'a_minute': ':count Menutt',
    'min': ':count Menutt',
    'second': ':count Sekůndt',
    'a_second': ':count Sekůndt',
    's': ':count Sekůndt',
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
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'D. M. YYYY',
    'LL': 'D. MMM. YYYY',
    'LLL': 'D. MMMM YYYY HH:mm',
    'LLLL': 'dddd, [dä] D. MMMM YYYY HH:mm',
  },
  months: [
    'Jannewa',
    'Fäbrowa',
    'Määz',
    'Aprell',
    'Mai',
    'Juuni',
    'Juuli',
    'Oujoß',
    'Septämber',
    'Oktohber',
    'Novämber',
    'Dezämber',
  ],
  monthsShort: [
    'Jan',
    'Fäb',
    'Mäz',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Ouj',
    'Säp',
    'Okt',
    'Nov',
    'Dez',
  ],
  weekdays: [
    'Sunndaach',
    'Mohndaach',
    'Dinnsdaach',
    'Metwoch',
    'Dunnersdaach',
    'Friidaach',
    'Samsdaach',
  ],
  weekdaysShort: ['Su.', 'Mo.', 'Di.', 'Me.', 'Du.', 'Fr.', 'Sa.'],
  weekdaysMin: ['Su', 'Mo', 'Di', 'Me', 'Du', 'Fr', 'Sa'],
  firstDayOfWeek: 1,
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

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'v.M.' : 'n.M.';
}

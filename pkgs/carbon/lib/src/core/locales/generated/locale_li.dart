// AUTO-GENERATED from PHP Carbon locale: li
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLi = CarbonLocaleData(
  localeCode: 'li',
  translationStrings: {
    'year': ':count jaor',
    'a_year': ':count jaor',
    'y': ':count jaor',
    'month': ':count maond',
    'a_month': ':count maond',
    'm': ':count maond',
    'week': ':count waek',
    'a_week': ':count waek',
    'w': ':count waek',
    'day': ':count daag',
    'a_day': ':count daag',
    'd': ':count daag',
    'hour': ':count oer',
    'a_hour': ':count oer',
    'h': ':count oer',
    'minute': ':count momênt',
    'a_minute': ':count momênt',
    'min': ':count momênt',
    'second': ':count Secónd',
    'a_second': ':count Secónd',
    's': ':count Secónd',
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
    'jannewarie',
    'fibberwarie',
    'miert',
    'eprèl',
    'meij',
    'junie',
    'julie',
    'augustus',
    'september',
    'oktober',
    'november',
    'desember',
  ],
  monthsShort: [
    'jan',
    'fib',
    'mie',
    'epr',
    'mei',
    'jun',
    'jul',
    'aug',
    'sep',
    'okt',
    'nov',
    'des',
  ],
  weekdays: [
    'zóndig',
    'maondig',
    'daensdig',
    'goonsdig',
    'dónderdig',
    'vriedig',
    'zaoterdig',
  ],
  weekdaysShort: ['zón', 'mao', 'dae', 'goo', 'dón', 'vri', 'zao'],
  weekdaysMin: ['zón', 'mao', 'dae', 'goo', 'dón', 'vri', 'zao'],
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

// Regional variant: li_NL
final CarbonLocaleData localeLiNl = localeLi.copyWith(localeCode: 'li_nl');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

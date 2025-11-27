// AUTO-GENERATED from PHP Carbon locale: mfe
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMfe = CarbonLocaleData(
  localeCode: 'mfe',
  translationStrings: {
    'year': ':count banané',
    'a_year': ':count banané',
    'y': ':count banané',
    'month': ':count mwa',
    'a_month': ':count mwa',
    'm': ':count mwa',
    'week': ':count sémenn',
    'a_week': ':count sémenn',
    'w': ':count sémenn',
    'day': ':count zour',
    'a_day': ':count zour',
    'd': ':count zour',
    'hour': ':count -er-tan',
    'a_hour': ':count -er-tan',
    'h': ':count -er-tan',
    'minute': ':count minitt',
    'a_minute': ':count minitt',
    'min': ':count minitt',
    'second': ':count déziém',
    'a_second': ':count déziém',
    's': ':count déziém',
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
    'zanvie',
    'fevriye',
    'mars',
    'avril',
    'me',
    'zin',
    'zilye',
    'out',
    'septam',
    'oktob',
    'novam',
    'desam',
  ],
  monthsShort: [
    'zan',
    'fev',
    'mar',
    'avr',
    'me',
    'zin',
    'zil',
    'out',
    'sep',
    'okt',
    'nov',
    'des',
  ],
  weekdays: [
    'dimans',
    'lindi',
    'mardi',
    'merkredi',
    'zedi',
    'vandredi',
    'samdi',
  ],
  weekdaysShort: ['dim', 'lin', 'mar', 'mer', 'ze', 'van', 'sam'],
  weekdaysMin: ['dim', 'lin', 'mar', 'mer', 'ze', 'van', 'sam'],
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

// Regional variant: mfe_MU
final CarbonLocaleData localeMfeMu = localeMfe.copyWith(localeCode: 'mfe_mu');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

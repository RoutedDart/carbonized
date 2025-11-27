// AUTO-GENERATED from PHP Carbon locale: ht
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeHt = CarbonLocaleData(
  localeCode: 'ht',
  translationStrings: {
    'year': ':count lane',
    'a_year': ':count lane',
    'y': ':count lane',
    'month': 'mwa :count',
    'a_month': 'mwa :count',
    'm': 'mwa :count',
    'week': 'semèn :count',
    'a_week': 'semèn :count',
    'w': 'semèn :count',
    'day': ':count jou',
    'a_day': ':count jou',
    'd': ':count jou',
    'hour': ':count lè',
    'a_hour': ':count lè',
    'h': ':count lè',
    'minute': ':count minit',
    'a_minute': ':count minit',
    'min': ':count minit',
    'second': ':count segonn',
    'a_second': ':count segonn',
    's': ':count segonn',
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
    'janvye',
    'fevriye',
    'mas',
    'avril',
    'me',
    'jen',
    'jiyè',
    'out',
    'septanm',
    'oktòb',
    'novanm',
    'desanm',
  ],
  monthsShort: [
    'jan',
    'fev',
    'mas',
    'avr',
    'me',
    'jen',
    'jiy',
    'out',
    'sep',
    'okt',
    'nov',
    'des',
  ],
  weekdays: [
    'dimanch',
    'lendi',
    'madi',
    'mèkredi',
    'jedi',
    'vandredi',
    'samdi',
  ],
  weekdaysShort: ['dim', 'len', 'mad', 'mèk', 'jed', 'van', 'sam'],
  weekdaysMin: ['dim', 'len', 'mad', 'mèk', 'jed', 'van', 'sam'],
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

// Regional variant: ht_HT
final CarbonLocaleData localeHtHt = localeHt.copyWith(localeCode: 'ht_ht');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

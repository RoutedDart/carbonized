// AUTO-GENERATED from PHP Carbon locale: wa
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeWa = CarbonLocaleData(
  localeCode: 'wa',
  translationStrings: {
    'year': ':count anêye',
    'a_year': ':count anêye',
    'y': ':count anêye',
    'month': ':count meûs',
    'a_month': ':count meûs',
    'm': ':count meûs',
    'week': ':count samwinne',
    'a_week': ':count samwinne',
    'w': ':count samwinne',
    'day': ':count djoû',
    'a_day': ':count djoû',
    'd': ':count djoû',
    'hour': ':count eure',
    'a_hour': ':count eure',
    'h': ':count eure',
    'minute': ':count munute',
    'a_minute': ':count munute',
    'min': ':count munute',
    'second': ':count Sigonde',
    'a_second': ':count Sigonde',
    's': ':count Sigonde',
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
    'di djanvî',
    'di fevrî',
    'di måss',
    'd’ avri',
    'di may',
    'di djun',
    'di djulete',
    'd’ awousse',
    'di setimbe',
    'd’ octôbe',
    'di nôvimbe',
    'di decimbe',
  ],
  monthsShort: [
    'dja',
    'fev',
    'mås',
    'avr',
    'may',
    'djn',
    'djl',
    'awo',
    'set',
    'oct',
    'nôv',
    'dec',
  ],
  weekdays: [
    'dimegne',
    'londi',
    'mårdi',
    'mierkidi',
    'djudi',
    'vénrdi',
    'semdi',
  ],
  weekdaysShort: ['dim', 'lon', 'mår', 'mie', 'dju', 'vén', 'sem'],
  weekdaysMin: ['dim', 'lon', 'mår', 'mie', 'dju', 'vén', 'sem'],
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

// Regional variant: wa_BE
final CarbonLocaleData localeWaBe = localeWa.copyWith(localeCode: 'wa_be');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

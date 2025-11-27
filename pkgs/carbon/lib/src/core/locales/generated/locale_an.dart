// AUTO-GENERATED from PHP Carbon locale: an
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAn = CarbonLocaleData(
  localeCode: 'an',
  translationStrings: {
    'year': ':count año',
    'a_year': ':count año',
    'y': ':count año',
    'month': ':count mes',
    'a_month': ':count mes',
    'm': ':count mes',
    'week': ':count semana',
    'a_week': ':count semana',
    'w': ':count semana',
    'day': ':count día',
    'a_day': ':count día',
    'd': ':count día',
    'hour': ':count reloch',
    'a_hour': ':count reloch',
    'h': ':count reloch',
    'minute': ':count minuto',
    'a_minute': ':count minuto',
    'min': ':count minuto',
    'second': ':count segundo',
    'a_second': ':count segundo',
    's': ':count segundo',
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
    'chinero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'chunyo',
    'chuliol',
    'agosto',
    'setiembre',
    'octubre',
    'noviembre',
    'aviento',
  ],
  monthsShort: [
    'chi',
    'feb',
    'mar',
    'abr',
    'may',
    'chn',
    'chl',
    'ago',
    'set',
    'oct',
    'nov',
    'avi',
  ],
  weekdays: [
    'domingo',
    'luns',
    'martes',
    'mierques',
    'chueves',
    'viernes',
    'sabado',
  ],
  weekdaysShort: ['dom', 'lun', 'mar', 'mie', 'chu', 'vie', 'sab'],
  weekdaysMin: ['dom', 'lun', 'mar', 'mie', 'chu', 'vie', 'sab'],
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

// Regional variant: an_ES
final CarbonLocaleData localeAnEs = localeAn.copyWith(localeCode: 'an_es');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

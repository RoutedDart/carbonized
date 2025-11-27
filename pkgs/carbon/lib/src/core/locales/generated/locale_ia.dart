// AUTO-GENERATED from PHP Carbon locale: ia
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIa = CarbonLocaleData(
  localeCode: 'ia',
  translationStrings: {
    'year': 'anno :count',
    'a_year': 'anno :count',
    'y': 'anno :count',
    'month': ':count mense',
    'a_month': ':count mense',
    'm': ':count mense',
    'week': ':count septimana',
    'a_week': ':count septimana',
    'w': ':count septimana',
    'day': ':count die',
    'a_day': ':count die',
    'd': ':count die',
    'hour': ':count hora',
    'a_hour': ':count hora',
    'h': ':count hora',
    'minute': ':count minuscule',
    'a_minute': ':count minuscule',
    'min': ':count minuscule',
    'second': ':count secunda',
    'a_second': ':count secunda',
    's': ':count secunda',
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
    'januario',
    'februario',
    'martio',
    'april',
    'maio',
    'junio',
    'julio',
    'augusto',
    'septembre',
    'octobre',
    'novembre',
    'decembre',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'mai',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ],
  weekdays: [
    'dominica',
    'lunedi',
    'martedi',
    'mercuridi',
    'jovedi',
    'venerdi',
    'sabbato',
  ],
  weekdaysShort: ['dom', 'lun', 'mar', 'mer', 'jov', 'ven', 'sab'],
  weekdaysMin: ['dom', 'lun', 'mar', 'mer', 'jov', 'ven', 'sab'],
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

// Regional variant: ia_FR
final CarbonLocaleData localeIaFr = localeIa.copyWith(localeCode: 'ia_fr');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

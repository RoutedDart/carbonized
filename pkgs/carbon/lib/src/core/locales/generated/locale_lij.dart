// AUTO-GENERATED from PHP Carbon locale: lij
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLij = CarbonLocaleData(
  localeCode: 'lij',
  translationStrings: {
    'year': ':count etæ',
    'a_year': ':count etæ',
    'y': ':count etæ',
    'month': ':count meize',
    'a_month': ':count meize',
    'm': ':count meize',
    'week': ':count settemannha',
    'a_week': ':count settemannha',
    'w': ':count settemannha',
    'day': ':count giorno',
    'a_day': ':count giorno',
    'd': ':count giorno',
    'hour': ':count reléuio',
    'a_hour': ':count reléuio',
    'h': ':count reléuio',
    'minute': ':count menûo',
    'a_minute': ':count menûo',
    'min': ':count menûo',
    'second': ':count segondo',
    'a_second': ':count segondo',
    's': ':count segondo',
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
    'zenâ',
    'fevrâ',
    'marzo',
    'avrî',
    'mazzo',
    'zûgno',
    'lûggio',
    'agosto',
    'settembre',
    'ottobre',
    'novembre',
    'dixembre',
  ],
  monthsShort: [
    'zen',
    'fev',
    'mar',
    'arv',
    'maz',
    'zûg',
    'lûg',
    'ago',
    'set',
    'ött',
    'nov',
    'dix',
  ],
  weekdays: [
    'domenega',
    'lûnedì',
    'martedì',
    'mercUrdì',
    'zêggia',
    'venardì',
    'sabbo',
  ],
  weekdaysShort: ['dom', 'lûn', 'mar', 'mer', 'zêu', 'ven', 'sab'],
  weekdaysMin: ['dom', 'lûn', 'mar', 'mer', 'zêu', 'ven', 'sab'],
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

// Regional variant: lij_IT
final CarbonLocaleData localeLijIt = localeLij.copyWith(localeCode: 'lij_it');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

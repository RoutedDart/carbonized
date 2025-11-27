// AUTO-GENERATED from PHP Carbon locale: twq
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTwq = CarbonLocaleData(
  localeCode: 'twq',
  translationStrings: {
    'year': ':count jiiri',
    'a_year': ':count jiiri',
    'y': ':count jiiri',
    'month': ':count alaada',
    'a_month': ':count alaada',
    'm': ':count alaada',
    'week': ':count jirbiiyye',
    'a_week': ':count jirbiiyye',
    'w': ':count jirbiiyye',
    'day': ':count zaari',
    'a_day': ':count zaari',
    'd': ':count zaari',
    'hour': ':count ɲaajin',
    'a_hour': ':count ɲaajin',
    'h': ':count ɲaajin',
    'minute': ':count zarbu',
    'a_minute': ':count zarbu',
    'min': ':count zarbu',
    'second': ':count ihinkante',
    'a_second': ':count ihinkante',
    's': ':count ihinkante',
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
    'L': 'D/M/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'Žanwiye',
    'Feewiriye',
    'Marsi',
    'Awiril',
    'Me',
    'Žuweŋ',
    'Žuyye',
    'Ut',
    'Sektanbur',
    'Oktoobur',
    'Noowanbur',
    'Deesanbur',
  ],
  monthsShort: [
    'Žan',
    'Fee',
    'Mar',
    'Awi',
    'Me',
    'Žuw',
    'Žuy',
    'Ut',
    'Sek',
    'Okt',
    'Noo',
    'Dee',
  ],
  weekdays: [
    'Alhadi',
    'Atinni',
    'Atalaata',
    'Alarba',
    'Alhamiisa',
    'Alzuma',
    'Asibti',
  ],
  weekdaysShort: ['Alh', 'Ati', 'Ata', 'Ala', 'Alm', 'Alz', 'Asi'],
  weekdaysMin: ['Alh', 'Ati', 'Ata', 'Ala', 'Alm', 'Alz', 'Asi'],
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
  return hour < 12 ? 'Subbaahi' : 'Zaarikay b';
}

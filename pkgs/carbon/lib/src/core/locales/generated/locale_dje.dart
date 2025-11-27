// AUTO-GENERATED from PHP Carbon locale: dje
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeDje = CarbonLocaleData(
  localeCode: 'dje',
  translationStrings: {
    'year': ':count hari',
    'a_year': ':count hari',
    'y': ':count hari',
    'month': '{1}:count month|{0}:count months|[-Inf,Inf]:count months',
    'a_month': '{1}a month|{0}:count months|[-Inf,Inf]:count months',
    'm': '{1}:countmo|{0}:countmos|[-Inf,Inf]:countmos',
    'week': ':count alzuma',
    'a_week': ':count alzuma',
    'w': ':count alzuma',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count atinni',
    'a_second': ':count atinni',
    's': ':count atinni',
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
    'LL': 'D MMM, YYYY',
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
    'Alhamisi',
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

// AUTO-GENERATED from PHP Carbon locale: niu
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNiu = CarbonLocaleData(
  localeCode: 'niu',
  translationStrings: {
    'year': ':count tau',
    'a_year': ':count tau',
    'y': ':count tau',
    'month': ':count mahina',
    'a_month': ':count mahina',
    'm': ':count mahina',
    'week': ':count faahi tapu',
    'a_week': ':count faahi tapu',
    'w': ':count faahi tapu',
    'day': ':count aho',
    'a_day': ':count aho',
    'd': ':count aho',
    'hour': ':count e tulā',
    'a_hour': ':count e tulā',
    'h': ':count e tulā',
    'minute': ':count minuti',
    'a_minute': ':count minuti',
    'min': ':count minuti',
    'second': ':count sekone',
    'a_second': ':count sekone',
    's': ':count sekone',
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
    'Ianuali',
    'Fepuali',
    'Masi',
    'Apelila',
    'Me',
    'Iuni',
    'Iulai',
    'Aokuso',
    'Sepetema',
    'Oketopa',
    'Novema',
    'Tesemo',
  ],
  monthsShort: [
    'Ian',
    'Fep',
    'Mas',
    'Ape',
    'Me',
    'Iun',
    'Iul',
    'Aok',
    'Sep',
    'Oke',
    'Nov',
    'Tes',
  ],
  weekdays: [
    'Aho Tapu',
    'Aho Gofua',
    'Aho Ua',
    'Aho Lotu',
    'Aho Tuloto',
    'Aho Falaile',
    'Aho Faiumu',
  ],
  weekdaysShort: ['Tapu', 'Gofua', 'Ua', 'Lotu', 'Tuloto', 'Falaile', 'Faiumu'],
  weekdaysMin: ['Tapu', 'Gofua', 'Ua', 'Lotu', 'Tuloto', 'Falaile', 'Faiumu'],
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

// Regional variant: niu_NU
final CarbonLocaleData localeNiuNu = localeNiu.copyWith(localeCode: 'niu_nu');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

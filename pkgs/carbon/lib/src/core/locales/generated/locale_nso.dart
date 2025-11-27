// AUTO-GENERATED from PHP Carbon locale: nso
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNso = CarbonLocaleData(
  localeCode: 'nso',
  translationStrings: {
    'year': ':count ngwaga',
    'a_year': ':count ngwaga',
    'y': ':count ngwaga',
    'month': ':count Kgwedi',
    'a_month': ':count Kgwedi',
    'm': ':count Kgwedi',
    'week': ':count Beke',
    'a_week': ':count Beke',
    'w': ':count Beke',
    'day': ':count Letšatši',
    'a_day': ':count Letšatši',
    'd': ':count Letšatši',
    'hour': ':count Iri',
    'a_hour': ':count Iri',
    'h': ':count Iri',
    'minute': ':count Motsotso',
    'a_minute': ':count Motsotso',
    'min': ':count Motsotso',
    'second': ':count motsotswana',
    'a_second': ':count motsotswana',
    's': ':count motsotswana',
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
    'Janaware',
    'Febereware',
    'Matšhe',
    'Aprele',
    'Mei',
    'June',
    'Julae',
    'Agostose',
    'Setemere',
    'Oktobere',
    'Nofemere',
    'Disemere',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mat',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Okt',
    'Nof',
    'Dis',
  ],
  weekdays: [
    'LaMorena',
    'Mošupologo',
    'Labobedi',
    'Laboraro',
    'Labone',
    'Labohlano',
    'Mokibelo',
  ],
  weekdaysShort: ['Son', 'Moš', 'Bed', 'Rar', 'Ne', 'Hla', 'Mok'],
  weekdaysMin: ['Son', 'Moš', 'Bed', 'Rar', 'Ne', 'Hla', 'Mok'],
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

// Regional variant: nso_ZA
final CarbonLocaleData localeNsoZa = localeNso.copyWith(localeCode: 'nso_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

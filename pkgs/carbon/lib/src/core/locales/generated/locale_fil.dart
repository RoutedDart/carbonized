// AUTO-GENERATED from PHP Carbon locale: fil
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeFil = CarbonLocaleData(
  localeCode: 'fil',
  translationStrings: {
    'year': ':count taon',
    'a_year': ':count taon',
    'y': ':count taon',
    'month': ':count buwan',
    'a_month': ':count buwan',
    'm': ':count buwan',
    'week': ':count linggo',
    'a_week': ':count linggo',
    'w': ':count linggo',
    'day': ':count araw',
    'a_day': ':count araw',
    'd': ':count araw',
    'hour': ':count oras',
    'a_hour': ':count oras',
    'h': ':count oras',
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
    'ago': ':time ang nakalipas',
    'from_now': 'sa :time',
    'after': ':time pagkatapos',
    'before': ':time bago',
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
    'L': 'MM/DD/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Enero',
    'Pebrero',
    'Marso',
    'Abril',
    'Mayo',
    'Hunyo',
    'Hulyo',
    'Agosto',
    'Setyembre',
    'Oktubre',
    'Nobyembre',
    'Disyembre',
  ],
  monthsShort: [
    'Ene',
    'Peb',
    'Mar',
    'Abr',
    'May',
    'Hun',
    'Hul',
    'Ago',
    'Set',
    'Okt',
    'Nob',
    'Dis',
  ],
  weekdays: [
    'Linggo',
    'Lunes',
    'Martes',
    'Miyerkoles',
    'Huwebes',
    'Biyernes',
    'Sabado',
  ],
  weekdaysShort: ['Lin', 'Lun', 'Mar', 'Miy', 'Huw', 'Biy', 'Sab'],
  weekdaysMin: ['Lin', 'Lun', 'Mar', 'Miy', 'Huw', 'Biy', 'Sab'],
  firstDayOfWeek: 0,
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

// Regional variant: fil_PH
final CarbonLocaleData localeFilPh = localeFil.copyWith(localeCode: 'fil_ph');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'N.U.' : 'N.H.';
}

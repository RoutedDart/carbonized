// AUTO-GENERATED from PHP Carbon locale: tpi
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTpi = CarbonLocaleData(
  localeCode: 'tpi',
  translationStrings: {
    'year': 'yia :count',
    'a_year': 'yia :count',
    'y': 'yia :count',
    'month': ':count mun',
    'a_month': ':count mun',
    'm': ':count mun',
    'week': ':count wik',
    'a_week': ':count wik',
    'w': ':count wik',
    'day': ':count de',
    'a_day': ':count de',
    'd': ':count de',
    'hour': ':count aua',
    'a_hour': ':count aua',
    'h': ':count aua',
    'minute': ':count minit',
    'a_minute': ':count minit',
    'min': ':count minit',
    'second': ':count namba tu',
    'a_second': ':count namba tu',
    's': ':count namba tu',
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
    'Janueri',
    'Februeri',
    'Mas',
    'Epril',
    'Me',
    'Jun',
    'Julai',
    'Ogas',
    'Septemba',
    'Oktoba',
    'Novemba',
    'Desemba',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mas',
    'Epr',
    'Me',
    'Jun',
    'Jul',
    'Oga',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ],
  weekdays: ['Sande', 'Mande', 'Tunde', 'Trinde', 'Fonde', 'Fraide', 'Sarere'],
  weekdaysShort: ['San', 'Man', 'Tun', 'Tri', 'Fon', 'Fra', 'Sar'],
  weekdaysMin: ['San', 'Man', 'Tun', 'Tri', 'Fon', 'Fra', 'Sar'],
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

// Regional variant: tpi_PG
final CarbonLocaleData localeTpiPg = localeTpi.copyWith(localeCode: 'tpi_pg');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'biknait' : 'apinun';
}

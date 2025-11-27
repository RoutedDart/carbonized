// AUTO-GENERATED from PHP Carbon locale: sm
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSm = CarbonLocaleData(
  localeCode: 'sm',
  translationStrings: {
    'year': ':count tausaga',
    'a_year': ':count tausaga',
    'y': ':count tausaga',
    'month': ':count māsina',
    'a_month': ':count māsina',
    'm': ':count māsina',
    'week': ':count vaiaso',
    'a_week': ':count vaiaso',
    'w': ':count vaiaso',
    'day': ':count aso',
    'a_day': ':count aso',
    'd': ':count aso',
    'hour': ':count uati',
    'a_hour': ':count uati',
    'h': ':count uati',
    'minute': ':count itiiti',
    'a_minute': ':count itiiti',
    'min': ':count itiiti',
    'second': ':count lua',
    'a_second': ':count lua',
    's': ':count lua',
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
    'Ianuari',
    'Fepuari',
    'Mati',
    'Aperila',
    'Me',
    'Iuni',
    'Iulai',
    'Auguso',
    'Setema',
    'Oketopa',
    'Novema',
    'Tesema',
  ],
  monthsShort: [
    'Ian',
    'Fep',
    'Mat',
    'Ape',
    'Me',
    'Iun',
    'Iul',
    'Aug',
    'Set',
    'Oke',
    'Nov',
    'Tes',
  ],
  weekdays: [
    'Aso Sa',
    'Aso Gafua',
    'Aso Lua',
    'Aso Lulu',
    'Aso Tofi',
    'Aso Farail',
    'Aso To\'ana\'i',
  ],
  weekdaysShort: [
    'Aso Sa',
    'Aso Gaf',
    'Aso Lua',
    'Aso Lul',
    'Aso Tof',
    'Aso Far',
    'Aso To\'',
  ],
  weekdaysMin: [
    'Aso Sa',
    'Aso Gaf',
    'Aso Lua',
    'Aso Lul',
    'Aso Tof',
    'Aso Far',
    'Aso To\'',
  ],
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

// Regional variant: sm_WS
final CarbonLocaleData localeSmWs = localeSm.copyWith(localeCode: 'sm_ws');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

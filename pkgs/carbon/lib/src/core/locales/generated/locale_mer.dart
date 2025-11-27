// AUTO-GENERATED from PHP Carbon locale: mer
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMer = CarbonLocaleData(
  localeCode: 'mer',
  translationStrings: {
    'year': ':count murume',
    'a_year': ':count murume',
    'y': ':count murume',
    'month': ':count muchaara',
    'a_month': ':count muchaara',
    'm': ':count muchaara',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': ':count monto',
    'a_minute': ':count monto',
    'min': ':count monto',
    'second': ':count gikeno',
    'a_second': ':count gikeno',
    's': ':count gikeno',
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
    'L': 'DD/MM/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Januarĩ',
    'Feburuarĩ',
    'Machi',
    'Ĩpurũ',
    'Mĩĩ',
    'Njuni',
    'Njuraĩ',
    'Agasti',
    'Septemba',
    'Oktũba',
    'Novemba',
    'Dicemba',
  ],
  monthsShort: [
    'JAN',
    'FEB',
    'MAC',
    'ĨPU',
    'MĨĨ',
    'NJU',
    'NJR',
    'AGA',
    'SPT',
    'OKT',
    'NOV',
    'DEC',
  ],
  weekdays: [
    'Kiumia',
    'Muramuko',
    'Wairi',
    'Wethatu',
    'Wena',
    'Wetano',
    'Jumamosi',
  ],
  weekdaysShort: ['KIU', 'MRA', 'WAI', 'WET', 'WEN', 'WTN', 'JUM'],
  weekdaysMin: ['KIU', 'MRA', 'WAI', 'WET', 'WEN', 'WTN', 'JUM'],
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

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'RŨ' : 'ŨG';
}

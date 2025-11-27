// AUTO-GENERATED from PHP Carbon locale: rm
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRm = CarbonLocaleData(
  localeCode: 'rm',
  translationStrings: {
    'year': ':count onn|:count onns',
    'a_year': '{1}a year|{0}:count years|[-Inf,Inf]:count years',
    'y': '{1}:countyr|{0}:countyrs|[-Inf,Inf]:countyrs',
    'month': ':count mais',
    'a_month': '{1}a month|{0}:count months|[-Inf,Inf]:count months',
    'm': '{1}:countmo|{0}:countmos|[-Inf,Inf]:countmos',
    'week': ':count emna|:count emnas',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': ':count di|:count dis',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': ':count oura|:count ouras',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': ':count minuta|:count minutas',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count secunda|:count secundas',
    'a_second': '{0,1}a few seconds|[-Inf,Inf]:count seconds',
    's': ':counts',
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
    'L': 'DD.MM.YYYY',
    'LL': 'Do MMMM YYYY',
    'LLL': 'Do MMMM, HH:mm [Uhr]',
    'LLLL': 'dddd, Do MMMM YYYY, HH:mm [Uhr]',
  },
  months: [
    'schaner',
    'favrer',
    'mars',
    'avrigl',
    'matg',
    'zercladur',
    'fanadur',
    'avust',
    'settember',
    'october',
    'november',
    'december',
  ],
  monthsShort: [
    'schan',
    'favr',
    'mars',
    'avr',
    'matg',
    'zercl',
    'fan',
    'avust',
    'sett',
    'oct',
    'nov',
    'dec',
  ],
  weekdays: [
    'dumengia',
    'glindesdi',
    'mardi',
    'mesemna',
    'gievgia',
    'venderdi',
    'sonda',
  ],
  weekdaysShort: ['du', 'gli', 'ma', 'me', 'gie', 've', 'so'],
  weekdaysMin: ['du', 'gli', 'ma', 'me', 'gie', 've', 'so'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' e '],
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
  return hour < 12 ? 'avantmezdi' : 'suentermezdi';
}

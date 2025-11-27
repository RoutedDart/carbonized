// AUTO-GENERATED from PHP Carbon locale: kea
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKea = CarbonLocaleData(
  localeCode: 'kea',
  translationStrings: {
    'year': ':count otunu',
    'a_year': ':count otunu',
    'y': ':count otunu',
    'month': '{1}:count month|{0}:count months|[-Inf,Inf]:count months',
    'a_month': '{1}a month|{0}:count months|[-Inf,Inf]:count months',
    'm': '{1}:countmo|{0}:countmos|[-Inf,Inf]:countmos',
    'week': ':count día dumingu',
    'a_week': ':count día dumingu',
    'w': ':count día dumingu',
    'day': ':count diâ',
    'a_day': ':count diâ',
    'd': ':count diâ',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': ':count sugundu',
    'a_minute': ':count sugundu',
    'min': ':count sugundu',
    'second': ':count dós',
    'a_second': ':count dós',
    's': ':count dós',
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
    'LLL': 'D [di] MMMM [di] YYYY HH:mm',
    'LLLL': 'dddd, D [di] MMMM [di] YYYY HH:mm',
  },
  months: [
    'Janeru',
    'Febreru',
    'Marsu',
    'Abril',
    'Maiu',
    'Junhu',
    'Julhu',
    'Agostu',
    'Setenbru',
    'Otubru',
    'Nuvenbru',
    'Dizenbru',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Otu',
    'Nuv',
    'Diz',
  ],
  weekdays: [
    'dumingu',
    'sigunda-fera',
    'tersa-fera',
    'kuarta-fera',
    'kinta-fera',
    'sesta-fera',
    'sabadu',
  ],
  weekdaysShort: ['dum', 'sig', 'ter', 'kua', 'kin', 'ses', 'sab'],
  weekdaysMin: ['du', 'si', 'te', 'ku', 'ki', 'se', 'sa'],
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
  return hour < 12 ? 'a' : 'p';
}

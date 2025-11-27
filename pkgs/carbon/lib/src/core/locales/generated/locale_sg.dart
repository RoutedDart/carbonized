// AUTO-GENERATED from PHP Carbon locale: sg
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSg = CarbonLocaleData(
  localeCode: 'sg',
  translationStrings: {
    'year': ':count dā',
    'a_year': ':count dā',
    'y': ':count dā',
    'month': ':count Nze tî ngu',
    'a_month': ':count Nze tî ngu',
    'm': ':count Nze tî ngu',
    'week': ':count bïkua-okü',
    'a_week': ':count bïkua-okü',
    'w': ':count bïkua-okü',
    'day': ':count ziggawâ',
    'a_day': ':count ziggawâ',
    'd': ':count ziggawâ',
    'hour': ':count yângâködörö',
    'a_hour': ':count yângâködörö',
    'h': ':count yângâködörö',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count bïkua-ôko',
    'a_second': ':count bïkua-ôko',
    's': ':count bïkua-ôko',
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
    'Nyenye',
    'Fulundïgi',
    'Mbängü',
    'Ngubùe',
    'Bêläwü',
    'Föndo',
    'Lengua',
    'Kükürü',
    'Mvuka',
    'Ngberere',
    'Nabändüru',
    'Kakauka',
  ],
  monthsShort: [
    'Nye',
    'Ful',
    'Mbä',
    'Ngu',
    'Bêl',
    'Fön',
    'Len',
    'Kük',
    'Mvu',
    'Ngb',
    'Nab',
    'Kak',
  ],
  weekdays: [
    'Bikua-ôko',
    'Bïkua-ûse',
    'Bïkua-ptâ',
    'Bïkua-usïö',
    'Bïkua-okü',
    'Lâpôsö',
    'Lâyenga',
  ],
  weekdaysShort: ['Bk1', 'Bk2', 'Bk3', 'Bk4', 'Bk5', 'Lâp', 'Lây'],
  weekdaysMin: ['Bk1', 'Bk2', 'Bk3', 'Bk4', 'Bk5', 'Lâp', 'Lây'],
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
  return hour < 12 ? 'ND' : 'LK';
}

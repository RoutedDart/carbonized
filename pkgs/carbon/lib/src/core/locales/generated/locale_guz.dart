// AUTO-GENERATED from PHP Carbon locale: guz
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGuz = CarbonLocaleData(
  localeCode: 'guz',
  translationStrings: {
    'year': ':count omwaka',
    'a_year': ':count omwaka',
    'y': ':count omwaka',
    'month': ':count omotunyi',
    'a_month': ':count omotunyi',
    'm': ':count omotunyi',
    'week': ':count isano naibere',
    'a_week': ':count isano naibere',
    'w': ':count isano naibere',
    'day': ':count rituko',
    'a_day': ':count rituko',
    'd': ':count rituko',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count ibere',
    'a_second': ':count ibere',
    's': ':count ibere',
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
    'Chanuari',
    'Feburari',
    'Machi',
    'Apiriri',
    'Mei',
    'Juni',
    'Chulai',
    'Agosti',
    'Septemba',
    'Okitoba',
    'Nobemba',
    'Disemba',
  ],
  monthsShort: [
    'Can',
    'Feb',
    'Mac',
    'Apr',
    'Mei',
    'Jun',
    'Cul',
    'Agt',
    'Sep',
    'Okt',
    'Nob',
    'Dis',
  ],
  weekdays: [
    'Chumapiri',
    'Chumatato',
    'Chumaine',
    'Chumatano',
    'Aramisi',
    'Ichuma',
    'Esabato',
  ],
  weekdaysShort: ['Cpr', 'Ctt', 'Cmn', 'Cmt', 'Ars', 'Icm', 'Est'],
  weekdaysMin: ['Cpr', 'Ctt', 'Cmn', 'Cmt', 'Ars', 'Icm', 'Est'],
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
  return hour < 12 ? 'Ma' : 'Mo';
}

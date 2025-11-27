// AUTO-GENERATED from PHP Carbon locale: hif
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeHif = CarbonLocaleData(
  localeCode: 'hif',
  translationStrings: {
    'year': ':count saal',
    'a_year': ':count saal',
    'y': ':count saal',
    'month': ':count Mahina',
    'a_month': ':count Mahina',
    'm': ':count Mahina',
    'week': ':count Hafta',
    'a_week': ':count Hafta',
    'w': ':count Hafta',
    'day': ':count Din',
    'a_day': ':count Din',
    'd': ':count Din',
    'hour': ':count minit',
    'a_hour': ':count minit',
    'h': ':count minit',
    'minute': ':count Minit',
    'a_minute': ':count Minit',
    'min': ':count Minit',
    'second': ':count Second',
    'a_second': ':count Second',
    's': ':count Second',
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
    'L': 'dddd DD MMM YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ],
  weekdays: [
    'Ravivar',
    'Somvar',
    'Mangalvar',
    'Budhvar',
    'Guruvar',
    'Shukravar',
    'Shanivar',
  ],
  weekdaysShort: ['Ravi', 'Som', 'Mangal', 'Budh', 'Guru', 'Shukra', 'Shani'],
  weekdaysMin: ['Ravi', 'Som', 'Mangal', 'Budh', 'Guru', 'Shukra', 'Shani'],
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

// Regional variant: hif_FJ
final CarbonLocaleData localeHifFj = localeHif.copyWith(localeCode: 'hif_fj');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'Purvahan' : 'Aparaahna';
}

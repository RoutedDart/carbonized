// AUTO-GENERATED from PHP Carbon locale: rn
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRn = CarbonLocaleData(
  localeCode: 'rn',
  translationStrings: {
    'year': 'imyaka :count',
    'a_year': 'imyaka :count',
    'y': 'imyaka :count',
    'month': 'amezi :count',
    'a_month': 'amezi :count',
    'm': 'amezi :count',
    'week': 'indwi :count',
    'a_week': 'indwi :count',
    'w': 'indwi :count',
    'day': 'imisi :count',
    'a_day': 'imisi :count',
    'd': 'imisi :count',
    'hour': 'amasaha :count',
    'a_hour': 'amasaha :count',
    'h': 'amasaha :count',
    'minute': 'iminuta :count',
    'a_minute': 'iminuta :count',
    'min': 'iminuta :count',
    'second': 'inguvu :count',
    'a_second': 'inguvu :count',
    's': 'inguvu :count',
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
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'Nzero',
    'Ruhuhuma',
    'Ntwarante',
    'Ndamukiza',
    'Rusama',
    'Ruheshi',
    'Mukakaro',
    'Nyandagaro',
    'Nyakanga',
    'Gitugutu',
    'Munyonyo',
    'Kigarama',
  ],
  monthsShort: [
    'Mut.',
    'Gas.',
    'Wer.',
    'Mat.',
    'Gic.',
    'Kam.',
    'Nya.',
    'Kan.',
    'Nze.',
    'Ukw.',
    'Ugu.',
    'Uku.',
  ],
  weekdays: [
    'Ku w’indwi',
    'Ku wa mbere',
    'Ku wa kabiri',
    'Ku wa gatatu',
    'Ku wa kane',
    'Ku wa gatanu',
    'Ku wa gatandatu',
  ],
  weekdaysShort: ['cu.', 'mbe.', 'kab.', 'gtu.', 'kan.', 'gnu.', 'gnd.'],
  weekdaysMin: ['cu.', 'mbe.', 'kab.', 'gtu.', 'kan.', 'gnu.', 'gnd.'],
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
  return hour < 12 ? 'Z.MU.' : 'Z.MW.';
}

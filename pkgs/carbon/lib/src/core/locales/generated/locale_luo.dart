// AUTO-GENERATED from PHP Carbon locale: luo
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLuo = CarbonLocaleData(
  localeCode: 'luo',
  translationStrings: {
    'year': 'higni :count',
    'a_year': ':higni :count',
    'y': 'higni :count',
    'month': 'dweche :count',
    'a_month': 'dweche :count',
    'm': 'dweche :count',
    'week': 'jumbe :count',
    'a_week': 'jumbe :count',
    'w': 'jumbe :count',
    'day': 'ndalo :count',
    'a_day': 'ndalo :count',
    'd': 'ndalo :count',
    'hour': 'seche :count',
    'a_hour': 'seche :count',
    'h': 'seche :count',
    'minute': 'dakika :count',
    'a_minute': 'dakika :count',
    'min': 'dakika :count',
    'second': 'nus dakika :count',
    'a_second': 'nus dakika :count',
    's': 'nus dakika :count',
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
    'Dwe mar Achiel',
    'Dwe mar Ariyo',
    'Dwe mar Adek',
    'Dwe mar Ang’wen',
    'Dwe mar Abich',
    'Dwe mar Auchiel',
    'Dwe mar Abiriyo',
    'Dwe mar Aboro',
    'Dwe mar Ochiko',
    'Dwe mar Apar',
    'Dwe mar gi achiel',
    'Dwe mar Apar gi ariyo',
  ],
  monthsShort: [
    'DAC',
    'DAR',
    'DAD',
    'DAN',
    'DAH',
    'DAU',
    'DAO',
    'DAB',
    'DOC',
    'DAP',
    'DGI',
    'DAG',
  ],
  weekdays: [
    'Jumapil',
    'Wuok Tich',
    'Tich Ariyo',
    'Tich Adek',
    'Tich Ang’wen',
    'Tich Abich',
    'Ngeso',
  ],
  weekdaysShort: ['JMP', 'WUT', 'TAR', 'TAD', 'TAN', 'TAB', 'NGS'],
  weekdaysMin: ['JMP', 'WUT', 'TAR', 'TAD', 'TAN', 'TAB', 'NGS'],
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
  return hour < 12 ? 'OD' : 'OT';
}

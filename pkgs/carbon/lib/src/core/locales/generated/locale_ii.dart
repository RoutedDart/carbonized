// AUTO-GENERATED from PHP Carbon locale: ii
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIi = CarbonLocaleData(
  localeCode: 'ii',
  translationStrings: {
    'year': ':count ꒉ',
    'a_year': ':count ꒉ',
    'y': ':count ꒉ',
    'month': ':count ꆪ',
    'a_month': ':count ꆪ',
    'm': ':count ꆪ',
    'week': ':count ꏃ',
    'a_week': ':count ꏃ',
    'w': ':count ꏃ',
    'day': ':count ꏜ',
    'a_day': ':count ꏜ',
    'd': ':count ꏜ',
    'hour': ':count ꄮꈉ',
    'a_hour': ':count ꄮꈉ',
    'h': ':count ꄮꈉ',
    'minute': ':count ꀄꊭ',
    'a_minute': ':count ꀄꊭ',
    'min': ':count ꀄꊭ',
    'second': ':count ꇅ',
    'a_second': ':count ꇅ',
    's': ':count ꇅ',
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
    'LT': 'h:mm a',
    'LTS': 'h:mm:ss a',
    'L': 'YYYY-MM-dd',
    'LL': 'YYYY MMM D',
    'LLL': 'YYYY MMMM D h:mm a',
    'LLLL': 'YYYY MMMM D, dddd h:mm a',
  },
  monthsShort: [
    'ꋍꆪ',
    'ꑍꆪ',
    'ꌕꆪ',
    'ꇖꆪ',
    'ꉬꆪ',
    'ꃘꆪ',
    'ꏃꆪ',
    'ꉆꆪ',
    'ꈬꆪ',
    'ꊰꆪ',
    'ꊰꊪꆪ',
    'ꊰꑋꆪ',
  ],
  weekdays: ['ꑭꆏꑍ', 'ꆏꊂꋍ', 'ꆏꊂꑍ', 'ꆏꊂꌕ', 'ꆏꊂꇖ', 'ꆏꊂꉬ', 'ꆏꊂꃘ'],
  weekdaysShort: ['ꑭꆏ', 'ꆏꋍ', 'ꆏꑍ', 'ꆏꌕ', 'ꆏꇖ', 'ꆏꉬ', 'ꆏꃘ'],
  weekdaysMin: ['ꑭꆏ', 'ꆏꋍ', 'ꆏꑍ', 'ꆏꌕ', 'ꆏꇖ', 'ꆏꉬ', 'ꆏꃘ'],
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
  return hour < 12 ? 'ꎸꄑ' : 'ꁯꋒ';
}

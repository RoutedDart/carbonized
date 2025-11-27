// AUTO-GENERATED from PHP Carbon locale: sat
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSat = CarbonLocaleData(
  localeCode: 'sat',
  translationStrings: {
    'year': ':count ne̲s',
    'a_year': ':count ne̲s',
    'y': ':count ne̲s',
    'month': ':count ńindạ cando',
    'a_month': ':count ńindạ cando',
    'm': ':count ńindạ cando',
    'week': ':count mãhã',
    'a_week': ':count mãhã',
    'w': ':count mãhã',
    'day': ':count ᱫᱤᱱ',
    'a_day': ':count ᱫᱤᱱ',
    'd': ':count ᱫᱤᱱ',
    'hour': ':count ᱥᱳᱱᱚ',
    'a_hour': ':count ᱥᱳᱱᱚ',
    'h': ':count ᱥᱳᱱᱚ',
    'minute': ':count ᱯᱤᱞᱪᱩ',
    'a_minute': ':count ᱯᱤᱞᱪᱩ',
    'min': ':count ᱯᱤᱞᱪᱩ',
    'second': ':count ar',
    'a_second': ':count ar',
    's': ':count ar',
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
    'L': 'D/M/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'जनवरी',
    'फरवरी',
    'मार्च',
    'अप्रेल',
    'मई',
    'जुन',
    'जुलाई',
    'अगस्त',
    'सितम्बर',
    'अखथबर',
    'नवम्बर',
    'दिसम्बर',
  ],
  monthsShort: [
    'जनवरी',
    'फरवरी',
    'मार्च',
    'अप्रेल',
    'मई',
    'जुन',
    'जुलाई',
    'अगस्त',
    'सितम्बर',
    'अखथबर',
    'नवम्बर',
    'दिसम्बर',
  ],
  weekdays: [
    'सिंगेमाँहाँ',
    'ओतेमाँहाँ',
    'बालेमाँहाँ',
    'सागुनमाँहाँ',
    'सारदीमाँहाँ',
    'जारुममाँहाँ',
    'ञुहुममाँहाँ',
  ],
  weekdaysShort: ['सिंगे', 'ओते', 'बाले', 'सागुन', 'सारदी', 'जारुम', 'ञुहुम'],
  weekdaysMin: ['सिंगे', 'ओते', 'बाले', 'सागुन', 'सारदी', 'जारुम', 'ञुहुम'],
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

// Regional variant: sat_IN
final CarbonLocaleData localeSatIn = localeSat.copyWith(localeCode: 'sat_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// AUTO-GENERATED from PHP Carbon locale: tig
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTig = CarbonLocaleData(
  localeCode: 'tig',
  translationStrings: {
    'year': ':count ማይ',
    'a_year': ':count ማይ',
    'y': ':count ማይ',
    'month': ':count ሸምሽ',
    'a_month': ':count ሸምሽ',
    'm': ':count ሸምሽ',
    'week': ':count ሰቡዕ',
    'a_week': ':count ሰቡዕ',
    'w': ':count ሰቡዕ',
    'day': ':count ዎሮ',
    'a_day': ':count ዎሮ',
    'd': ':count ዎሮ',
    'hour': ':count ሰዓት',
    'a_hour': ':count ሰዓት',
    'h': ':count ሰዓት',
    'minute': ':count ካልኣይት',
    'a_minute': ':count ካልኣይት',
    'min': ':count ካልኣይት',
    'second': ':count ካልኣይ',
    'a_second': ':count ካልኣይ',
    's': ':count ካልኣይ',
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
    'L': 'DD/MM/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'ጥሪ',
    'ለካቲት',
    'መጋቢት',
    'ሚያዝያ',
    'ግንቦት',
    'ሰነ',
    'ሓምለ',
    'ነሓሰ',
    'መስከረም',
    'ጥቅምቲ',
    'ሕዳር',
    'ታሕሳስ',
  ],
  monthsShort: [
    'ጥሪ ',
    'ለካቲ',
    'መጋቢ',
    'ሚያዝ',
    'ግንቦ',
    'ሰነ ',
    'ሓምለ',
    'ነሓሰ',
    'መስከ',
    'ጥቅም',
    'ሕዳር',
    'ታሕሳ',
  ],
  weekdays: ['ሰንበት ዓባይ', 'ሰኖ', 'ታላሸኖ', 'ኣረርባዓ', 'ከሚሽ', 'ጅምዓት', 'ሰንበት ንኢሽ'],
  weekdaysShort: ['ሰ//ዓ', 'ሰኖ ', 'ታላሸ', 'ኣረር', 'ከሚሽ', 'ጅምዓ', 'ሰ//ን'],
  weekdaysMin: ['ሰ//ዓ', 'ሰኖ ', 'ታላሸ', 'ኣረር', 'ከሚሽ', 'ጅምዓ', 'ሰ//ን'],
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

// Regional variant: tig_ER
final CarbonLocaleData localeTigEr = localeTig.copyWith(localeCode: 'tig_er');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ቀደም ሰር ምዕል' : 'ሓቆ ሰር ምዕል';
}

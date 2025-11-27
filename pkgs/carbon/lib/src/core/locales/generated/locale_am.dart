// AUTO-GENERATED from PHP Carbon locale: am
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAm = CarbonLocaleData(
  localeCode: 'am',
  translationStrings: {
    'year': ':count አመት',
    'a_year': ':count አመት',
    'y': ':count አመት',
    'month': ':count ወር',
    'a_month': ':count ወር',
    'm': ':count ወር',
    'week': ':count ሳምንት',
    'a_week': ':count ሳምንት',
    'w': ':count ሳምንት',
    'day': ':count ቀን',
    'a_day': ':count ቀን',
    'd': ':count ቀን',
    'hour': ':count ሰዓት',
    'a_hour': ':count ሰዓት',
    'h': ':count ሰዓት',
    'minute': ':count ደቂቃ',
    'a_minute': ':count ደቂቃ',
    'min': ':count ደቂቃ',
    'second': ':count ሴኮንድ',
    'a_second': ':count ሴኮንድ',
    's': ':count ሴኮንድ',
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
    'ago': 'ከ:time በፊት',
    'from_now': 'በ:time ውስጥ',
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
    'ጃንዩወሪ',
    'ፌብሩወሪ',
    'ማርች',
    'ኤፕሪል',
    'ሜይ',
    'ጁን',
    'ጁላይ',
    'ኦገስት',
    'ሴፕቴምበር',
    'ኦክቶበር',
    'ኖቬምበር',
    'ዲሴምበር',
  ],
  monthsShort: [
    'ጃንዩ',
    'ፌብሩ',
    'ማርች',
    'ኤፕረ',
    'ሜይ ',
    'ጁን ',
    'ጁላይ',
    'ኦገስ',
    'ሴፕቴ',
    'ኦክተ',
    'ኖቬም',
    'ዲሴም',
  ],
  weekdays: ['እሑድ', 'ሰኞ', 'ማክሰኞ', 'ረቡዕ', 'ሐሙስ', 'ዓርብ', 'ቅዳሜ'],
  weekdaysShort: ['እሑድ', 'ሰኞ ', 'ማክሰ', 'ረቡዕ', 'ሐሙስ', 'ዓርብ', 'ቅዳሜ'],
  weekdaysMin: ['እሑድ', 'ሰኞ ', 'ማክሰ', 'ረቡዕ', 'ሐሙስ', 'ዓርብ', 'ቅዳሜ'],
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

// Regional variant: am_ET
final CarbonLocaleData localeAmEt = localeAm.copyWith(localeCode: 'am_et');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ጡዋት' : 'ከሰዓት';
}

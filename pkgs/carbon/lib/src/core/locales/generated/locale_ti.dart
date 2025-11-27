// AUTO-GENERATED from PHP Carbon locale: ti
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTi = CarbonLocaleData(
  localeCode: 'ti',
  translationStrings: {
    'year': ':count ዓመት',
    'a_year': ':count ዓመት',
    'y': ':count ዓመት',
    'month': 'ወርሒ :count',
    'a_month': 'ወርሒ :count',
    'm': 'ወርሒ :count',
    'week': ':count ሰሙን',
    'a_week': ':count ሰሙን',
    'w': ':count ሰሙን',
    'day': ':count መዓልቲ',
    'a_day': ':count መዓልቲ',
    'd': ':count መዓልቲ',
    'hour': ':count ሰዓት',
    'a_hour': ':count ሰዓት',
    'h': ':count ሰዓት',
    'minute': ':count ደቒቕ',
    'a_minute': ':count ደቒቕ',
    'min': ':count ደቒቕ',
    'second': ':count ሰከንድ',
    'a_second': ':count ሰከንድ',
    's': ':count ሰከንድ',
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
  weekdays: ['ሰንበት', 'ሰኑይ', 'ሰሉስ', 'ረቡዕ', 'ሓሙስ', 'ዓርቢ', 'ቀዳም'],
  weekdaysShort: ['ሰንበ', 'ሰኑይ', 'ሰሉስ', 'ረቡዕ', 'ሓሙስ', 'ዓርቢ', 'ቀዳም'],
  weekdaysMin: ['ሰንበ', 'ሰኑይ', 'ሰሉስ', 'ረቡዕ', 'ሓሙስ', 'ዓርቢ', 'ቀዳም'],
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

// Regional variant: ti_ER
final CarbonLocaleData localeTiEr = localeTi.copyWith(localeCode: 'ti_er');

// Regional variant: ti_ET
final CarbonLocaleData localeTiEt = localeTi.copyWith(
  localeCode: 'ti_et',
  months: [
    'ጃንዩወሪ',
    'ፌብሩወሪ',
    'ማርች',
    'ኤፕረል',
    'ሜይ',
    'ጁን',
    'ጁላይ',
    'ኦገስት',
    'ሴፕቴምበር',
    'ኦክተውበር',
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
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ንጉሆ ሰዓተ' : 'ድሕር ሰዓት';
}

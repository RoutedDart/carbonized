// AUTO-GENERATED from PHP Carbon locale: gez
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGez = CarbonLocaleData(
  localeCode: 'gez',
  translationStrings: {
    'year': ':count ዓመት',
    'a_year': ':count ዓመት',
    'y': ':count ዓመት',
    'month': ':count ወርሕ',
    'a_month': ':count ወርሕ',
    'm': ':count ወርሕ',
    'week': ':count ሰብዑ',
    'a_week': ':count ሰብዑ',
    'w': ':count ሰብዑ',
    'day': ':count ዕለት',
    'a_day': ':count ዕለት',
    'd': ':count ዕለት',
    'hour': ':count አንትሙ',
    'a_hour': ':count አንትሙ',
    'h': ':count አንትሙ',
    'minute': ':count ንኡስ',
    'a_minute': ':count ንኡስ',
    'min': ':count ንኡስ',
    'second': ':count ካልእ',
    'a_second': ':count ካልእ',
    's': ':count ካልእ',
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
    'ጠሐረ',
    'ከተተ',
    'መገበ',
    'አኀዘ',
    'ግንባት',
    'ሠንየ',
    'ሐመለ',
    'ነሐሰ',
    'ከረመ',
    'ጠቀመ',
    'ኀደረ',
    'ኀሠሠ',
  ],
  monthsShort: [
    'ጠሐረ',
    'ከተተ',
    'መገበ',
    'አኀዘ',
    'ግንባ',
    'ሠንየ',
    'ሐመለ',
    'ነሐሰ',
    'ከረመ',
    'ጠቀመ',
    'ኀደረ',
    'ኀሠሠ',
  ],
  weekdays: ['እኁድ', 'ሰኑይ', 'ሠሉስ', 'ራብዕ', 'ሐሙስ', 'ዓርበ', 'ቀዳሚት'],
  weekdaysShort: ['እኁድ', 'ሰኑይ', 'ሠሉስ', 'ራብዕ', 'ሐሙስ', 'ዓርበ', 'ቀዳሚ'],
  weekdaysMin: ['እኁድ', 'ሰኑይ', 'ሠሉስ', 'ራብዕ', 'ሐሙስ', 'ዓርበ', 'ቀዳሚ'],
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

// Regional variant: gez_ER
final CarbonLocaleData localeGezEr = localeGez.copyWith(localeCode: 'gez_er');

// Regional variant: gez_ET
final CarbonLocaleData localeGezEt = localeGez.copyWith(
  localeCode: 'gez_et',
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
  return hour < 12 ? 'ጽባሕ' : 'ምሴት';
}

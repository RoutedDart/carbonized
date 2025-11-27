// AUTO-GENERATED from PHP Carbon locale: ee
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeEe = CarbonLocaleData(
  localeCode: 'ee',
  translationStrings: {
    'year': 'ƒe :count',
    'a_year': 'ƒe :count',
    'y': 'ƒe :count',
    'month': 'ɣleti :count',
    'a_month': 'ɣleti :count',
    'm': 'ɣleti :count',
    'week': 'kwasiɖa :count',
    'a_week': 'kwasiɖa :count',
    'w': 'kwasiɖa :count',
    'day': 'ŋkeke :count',
    'a_day': 'ŋkeke :count',
    'd': 'ŋkeke :count',
    'hour': 'gaƒoƒo :count',
    'a_hour': 'gaƒoƒo :count',
    'h': 'gaƒoƒo :count',
    'minute': 'miniti :count',
    'a_minute': 'miniti :count',
    'min': 'miniti :count',
    'second': 'sɛkɛnd :count',
    'a_second': 'sɛkɛnd :count',
    's': 'sɛkɛnd :count',
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
    'LT': 'a [ga] h:mm',
    'LTS': 'a [ga] h:mm:ss',
    'L': 'M/D/YYYY',
    'LL': 'MMM D [lia], YYYY',
    'LLL': 'a [ga] h:mm MMMM D [lia] YYYY',
    'LLLL': 'a [ga] h:mm dddd, MMMM D [lia] YYYY',
  },
  months: [
    'dzove',
    'dzodze',
    'tedoxe',
    'afɔfĩe',
    'dama',
    'masa',
    'siamlɔm',
    'deasiamime',
    'anyɔnyɔ',
    'kele',
    'adeɛmekpɔxe',
    'dzome',
  ],
  monthsShort: [
    'dzv',
    'dzd',
    'ted',
    'afɔ',
    'dam',
    'mas',
    'sia',
    'dea',
    'any',
    'kel',
    'ade',
    'dzm',
  ],
  weekdays: ['kɔsiɖa', 'dzoɖa', 'blaɖa', 'kuɖa', 'yawoɖa', 'fiɖa', 'memleɖa'],
  weekdaysShort: ['kɔs', 'dzo', 'bla', 'kuɖ', 'yaw', 'fiɖ', 'mem'],
  weekdaysMin: ['kɔs', 'dzo', 'bla', 'kuɖ', 'yaw', 'fiɖ', 'mem'],
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

// Regional variant: ee_TG
final CarbonLocaleData localeEeTg = localeEe.copyWith(localeCode: 'ee_tg');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ŋ' : 'ɣ';
}

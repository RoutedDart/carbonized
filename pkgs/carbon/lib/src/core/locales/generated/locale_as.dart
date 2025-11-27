// AUTO-GENERATED from PHP Carbon locale: as
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAs = CarbonLocaleData(
  localeCode: 'as',
  translationStrings: {
    'year': ':count বছৰ',
    'a_year': ':count বছৰ',
    'y': ':count বছৰ',
    'month': ':count মাহ',
    'a_month': ':count মাহ',
    'm': ':count মাহ',
    'week': ':count সপ্তাহ',
    'a_week': ':count সপ্তাহ',
    'w': ':count সপ্তাহ',
    'day': ':count বাৰ',
    'a_day': ':count বাৰ',
    'd': ':count বাৰ',
    'hour': ':count ঘণ্টা',
    'a_hour': ':count ঘণ্টা',
    'h': ':count ঘণ্টা',
    'minute': ':count মিনিট',
    'a_minute': ':count মিনিট',
    'min': ':count মিনিট',
    'second': ':count দ্বিতীয়',
    'a_second': ':count দ্বিতীয়',
    's': ':count দ্বিতীয়',
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
    'L': 'D-MM-YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'জানুৱাৰী',
    'ফেব্ৰুৱাৰী',
    'মাৰ্চ',
    'এপ্ৰিল',
    'মে',
    'জুন',
    'জুলাই',
    'আগষ্ট',
    'ছেপ্তেম্বৰ',
    'অক্টোবৰ',
    'নৱেম্বৰ',
    'ডিচেম্বৰ',
  ],
  monthsShort: [
    'জানু',
    'ফেব্ৰু',
    'মাৰ্চ',
    'এপ্ৰিল',
    'মে',
    'জুন',
    'জুলাই',
    'আগ',
    'সেপ্ট',
    'অক্টো',
    'নভে',
    'ডিসে',
  ],
  weekdays: [
    'দেওবাৰ',
    'সোমবাৰ',
    'মঙ্গলবাৰ',
    'বুধবাৰ',
    'বৃহষ্পতিবাৰ',
    'শুক্ৰবাৰ',
    'শনিবাৰ',
  ],
  weekdaysShort: ['দেও', 'সোম', 'মঙ্গল', 'বুধ', 'বৃহষ্পতি', 'শুক্ৰ', 'শনি'],
  weekdaysMin: ['দেও', 'সোম', 'মঙ্গল', 'বুধ', 'বৃহষ্পতি', 'শুক্ৰ', 'শনি'],
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

// Regional variant: as_IN
final CarbonLocaleData localeAsIn = localeAs.copyWith(localeCode: 'as_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'পূৰ্ব্বাহ্ন' : 'অপৰাহ্ন';
}

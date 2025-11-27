// AUTO-GENERATED from PHP Carbon locale: mai
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMai = CarbonLocaleData(
  localeCode: 'mai',
  translationStrings: {
    'year': ':count ऋतु',
    'a_year': ':count ऋतु',
    'y': ':count ऋतु',
    'month': ':count महिना',
    'a_month': ':count महिना',
    'm': ':count महिना',
    'week': ':count श्रेणी:क्यालेन्डर',
    'a_week': ':count श्रेणी:क्यालेन्डर',
    'w': ':count श्रेणी:क्यालेन्डर',
    'day': ':count दिन',
    'a_day': ':count दिन',
    'd': ':count दिन',
    'hour': ':count घण्टा',
    'a_hour': ':count घण्टा',
    'h': ':count घण्टा',
    'minute': ':count समय',
    'a_minute': ':count समय',
    'min': ':count समय',
    'second': '{1}:count second|{0}:count seconds|[-Inf,Inf]:count seconds',
    'a_second': '{0,1}a few seconds|[-Inf,Inf]:count seconds',
    's': ':counts',
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
    'बैसाख',
    'जेठ',
    'अषाढ़',
    'सावोन',
    'भादो',
    'आसिन',
    'कातिक',
    'अगहन',
    'पूस',
    'माघ',
    'फागुन',
    'चैति',
  ],
  monthsShort: [
    'बैसाख',
    'जेठ',
    'अषाढ़',
    'सावोन',
    'भादो',
    'आसिन',
    'कातिक',
    'अगहन',
    'पूस',
    'माघ',
    'फागुन',
    'चैति',
  ],
  weekdays: [
    'रविदिन',
    'सोमदिन',
    'मंगलदिन',
    'बुधदिन',
    'बृहस्पतीदिन',
    'शुक्रदिन',
    'शनीदिन',
  ],
  weekdaysShort: ['रवि', 'सोम', 'मंगल', 'बुध', 'बृहस्पती', 'शुक्र', 'शनी'],
  weekdaysMin: ['रवि', 'सोम', 'मंगल', 'बुध', 'बृहस्पती', 'शुक्र', 'शनी'],
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

// Regional variant: mai_IN
final CarbonLocaleData localeMaiIn = localeMai.copyWith(localeCode: 'mai_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'पूर्वाह्न' : 'अपराह्न';
}

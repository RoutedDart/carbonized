// AUTO-GENERATED from PHP Carbon locale: tcy
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTcy = CarbonLocaleData(
  localeCode: 'tcy',
  translationStrings: {
    'year': ':count ನೀರ್',
    'a_year': ':count ನೀರ್',
    'y': ':count ನೀರ್',
    'month': ':count ಮೀನ್',
    'a_month': ':count ಮೀನ್',
    'm': ':count ಮೀನ್',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': ':count ಸುಗ್ಗಿ',
    'a_day': ':count ಸುಗ್ಗಿ',
    'd': ':count ಸುಗ್ಗಿ',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
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
    'ಜನವರಿ',
    'ಫೆಬ್ರುವರಿ',
    'ಮಾರ್ಚ್',
    'ಏಪ್ರಿಲ್‌‌',
    'ಮೇ',
    'ಜೂನ್',
    'ಜುಲೈ',
    'ಆಗಸ್ಟ್',
    'ಸೆಪ್ಟೆಂಬರ್‌',
    'ಅಕ್ಟೋಬರ್',
    'ನವೆಂಬರ್',
    'ಡಿಸೆಂಬರ್',
  ],
  monthsShort: [
    'ಜ',
    'ಫೆ',
    'ಮಾ',
    'ಏ',
    'ಮೇ',
    'ಜೂ',
    'ಜು',
    'ಆ',
    'ಸೆ',
    'ಅ',
    'ನ',
    'ಡಿ',
  ],
  weekdays: ['ಐಥಾರ', 'ಸೋಮಾರ', 'ಅಂಗರೆ', 'ಬುಧಾರ', 'ಗುರುವಾರ', 'ಶುಕ್ರರ', 'ಶನಿವಾರ'],
  weekdaysShort: ['ಐ', 'ಸೋ', 'ಅಂ', 'ಬು', 'ಗು', 'ಶು', 'ಶ'],
  weekdaysMin: ['ಐ', 'ಸೋ', 'ಅಂ', 'ಬು', 'ಗು', 'ಶು', 'ಶ'],
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

// Regional variant: tcy_IN
final CarbonLocaleData localeTcyIn = localeTcy.copyWith(localeCode: 'tcy_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ಕಾಂಡೆ' : 'ಬಯ್ಯ';
}

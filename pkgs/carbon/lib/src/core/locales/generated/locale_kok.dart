// AUTO-GENERATED from PHP Carbon locale: kok
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKok = CarbonLocaleData(
  localeCode: 'kok',
  translationStrings: {
    'year': ':count वैशाकु',
    'a_year': ':count वैशाकु',
    'y': ':count वैशाकु',
    'month': ':count मैनो',
    'a_month': ':count मैनो',
    'm': ':count मैनो',
    'week': ':count आदित्यवार',
    'a_week': ':count आदित्यवार',
    'w': ':count आदित्यवार',
    'day': ':count दिवसु',
    'a_day': ':count दिवसु',
    'd': ':count दिवसु',
    'hour': ':count घंते',
    'a_hour': ':count घंते',
    'h': ':count घंते',
    'minute': ':count नोंद',
    'a_minute': ':count नोंद',
    'min': ':count नोंद',
    'second': ':count तेंको',
    'a_second': ':count तेंको',
    's': ':count तेंको',
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
    'L': 'D-M-YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'जानेवारी',
    'फेब्रुवारी',
    'मार्च',
    'एप्रिल',
    'मे',
    'जून',
    'जुलै',
    'ओगस्ट',
    'सेप्टेंबर',
    'ओक्टोबर',
    'नोव्हेंबर',
    'डिसेंबर',
  ],
  monthsShort: [
    'जानेवारी',
    'फेब्रुवारी',
    'मार्च',
    'एप्रिल',
    'मे',
    'जून',
    'जुलै',
    'ओगस्ट',
    'सेप्टेंबर',
    'ओक्टोबर',
    'नोव्हेंबर',
    'डिसेंबर',
  ],
  weekdays: [
    'आयतार',
    'सोमार',
    'मंगळवार',
    'बुधवार',
    'बेरेसतार',
    'शुकरार',
    'शेनवार',
  ],
  weekdaysShort: [
    'आयतार',
    'सोमार',
    'मंगळवार',
    'बुधवार',
    'बेरेसतार',
    'शुकरार',
    'शेनवार',
  ],
  weekdaysMin: [
    'आयतार',
    'सोमार',
    'मंगळवार',
    'बुधवार',
    'बेरेसतार',
    'शुकरार',
    'शेनवार',
  ],
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

// Regional variant: kok_IN
final CarbonLocaleData localeKokIn = localeKok.copyWith(localeCode: 'kok_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'म.पू.' : 'म.नं.';
}

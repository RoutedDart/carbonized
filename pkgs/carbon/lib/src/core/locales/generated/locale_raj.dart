// AUTO-GENERATED from PHP Carbon locale: raj
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRaj = CarbonLocaleData(
  localeCode: 'raj',
  translationStrings: {
    'year': ':count आंहू',
    'a_year': ':count आंहू',
    'y': ':count आंहू',
    'month': ':count सूरज',
    'a_month': ':count सूरज',
    'm': ':count सूरज',
    'week': ':count निवाज',
    'a_week': ':count निवाज',
    'w': ':count निवाज',
    'day': ':count अेक',
    'a_day': ':count अेक',
    'd': ':count अेक',
    'hour': ':count दुनियांण',
    'a_hour': ':count दुनियांण',
    'h': ':count दुनियांण',
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
    'जनवरी',
    'फरवरी',
    'मार्च',
    'अप्रैल',
    'मई',
    'जून',
    'जुलाई',
    'अगस्त',
    'सितंबर',
    'अक्टूबर',
    'नवंबर',
    'दिसंबर',
  ],
  monthsShort: [
    'जन',
    'फर',
    'मार्च',
    'अप्रै',
    'मई',
    'जून',
    'जुल',
    'अग',
    'सित',
    'अक्टू',
    'नव',
    'दिस',
  ],
  weekdays: [
    'रविवार',
    'सोमवार',
    'मंगल्लवार',
    'बुधवार',
    'बृहस्पतिवार',
    'शुक्रवार',
    'शनिवार',
  ],
  weekdaysShort: ['रवि', 'सोम', 'मंगल', 'बुध', 'बृहस्पति', 'शुक्र', 'शनि'],
  weekdaysMin: ['रवि', 'सोम', 'मंगल', 'बुध', 'बृहस्पति', 'शुक्र', 'शनि'],
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

// Regional variant: raj_IN
final CarbonLocaleData localeRajIn = localeRaj.copyWith(localeCode: 'raj_in');

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

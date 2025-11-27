// AUTO-GENERATED from PHP Carbon locale: doi
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeDoi = CarbonLocaleData(
  localeCode: 'doi',
  translationStrings: {
    'year': '{1}:count year|{0}:count years|[-Inf,Inf]:count years',
    'a_year': '{1}a year|{0}:count years|[-Inf,Inf]:count years',
    'y': '{1}:countyr|{0}:countyrs|[-Inf,Inf]:countyrs',
    'month': '{1}:count month|{0}:count months|[-Inf,Inf]:count months',
    'a_month': '{1}a month|{0}:count months|[-Inf,Inf]:count months',
    'm': '{1}:countmo|{0}:countmos|[-Inf,Inf]:countmos',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count सङार',
    'a_second': ':count सङार',
    's': ':count सङार',
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
    'एप्रैल',
    'मेई',
    'जून',
    'जूलै',
    'अगस्त',
    'सितंबर',
    'अक्तूबर',
    'नवंबर',
    'दिसंबर',
  ],
  monthsShort: [
    'जनवरी',
    'फरवरी',
    'मार्च',
    'एप्रैल',
    'मेई',
    'जून',
    'जूलै',
    'अगस्त',
    'सितंबर',
    'अक्तूबर',
    'नवंबर',
    'दिसंबर',
  ],
  weekdays: [
    'ऐतबार',
    'सोमबार',
    'मंगलबर',
    'बुधबार',
    'बीरबार',
    'शुक्करबार',
    'श्नीचरबार',
  ],
  weekdaysShort: ['ऐत', 'सोम', 'मंगल', 'बुध', 'बीर', 'शुक्कर', 'श्नीचर'],
  weekdaysMin: ['ऐत', 'सोम', 'मंगल', 'बुध', 'बीर', 'शुक्कर', 'श्नीचर'],
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

// Regional variant: doi_IN
final CarbonLocaleData localeDoiIn = localeDoi.copyWith(localeCode: 'doi_in');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'सञं' : 'सबेर';
}

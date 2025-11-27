// AUTO-GENERATED from PHP Carbon locale: sa
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSa = CarbonLocaleData(
  localeCode: 'sa',
  translationStrings: {
    'year': ':count वर्ष',
    'a_year': ':count वर्ष',
    'y': ':count वर्ष',
    'month': ':count मास',
    'a_month': ':count मास',
    'm': ':count मास',
    'week': ':count सप्ताहः saptahaĥ',
    'a_week': ':count सप्ताहः saptahaĥ',
    'w': ':count सप्ताहः saptahaĥ',
    'day': ':count दिन',
    'a_day': ':count दिन',
    'd': ':count दिन',
    'hour': ':count घण्टा',
    'a_hour': ':count घण्टा',
    'h': ':count घण्टा',
    'minute': ':count होरा',
    'a_minute': ':count होरा',
    'min': ':count होरा',
    'second': ':count द्वितीयः',
    'a_second': ':count द्वितीयः',
    's': ':count द्वितीयः',
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
    'L': 'D-MM-YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'जनवरी',
    'फ़रवरी',
    'मार्च',
    'अप्रेल',
    'मई',
    'जून',
    'जुलाई',
    'अगस्त',
    'सितम्बर',
    'अक्टूबर',
    'नवम्बर',
    'दिसम्बर',
  ],
  monthsShort: [
    'जनवरी',
    'फ़रवरी',
    'मार्च',
    'अप्रेल',
    'मई',
    'जून',
    'जुलाई',
    'अगस्त',
    'सितम्बर',
    'अक्टूबर',
    'नवम्बर',
    'दिसम्बर',
  ],
  weekdays: [
    'रविवासर:',
    'सोमवासर:',
    'मंगलवासर:',
    'बुधवासर:',
    'बृहस्पतिवासरः',
    'शुक्रवासर',
    'शनिवासर:',
  ],
  weekdaysShort: [
    'रविः',
    'सोम:',
    'मंगल:',
    'बुध:',
    'बृहस्पतिः',
    'शुक्र',
    'शनि:',
  ],
  weekdaysMin: ['रविः', 'सोम:', 'मंगल:', 'बुध:', 'बृहस्पतिः', 'शुक्र', 'शनि:'],
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

// Regional variant: sa_IN
final CarbonLocaleData localeSaIn = localeSa.copyWith(localeCode: 'sa_in');

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

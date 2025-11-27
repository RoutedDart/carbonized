// AUTO-GENERATED from PHP Carbon locale: bem
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeBem = CarbonLocaleData(
  localeCode: 'bem',
  translationStrings: {
    'year': 'myaka :count',
    'a_year': 'myaka :count',
    'y': 'myaka :count',
    'month': 'myeshi :count',
    'a_month': 'myeshi :count',
    'm': 'myeshi :count',
    'week': 'umulungu :count',
    'a_week': 'umulungu :count',
    'w': 'umulungu :count',
    'day': 'inshiku :count',
    'a_day': 'inshiku :count',
    'd': 'inshiku :count',
    'hour': 'awala :count',
    'a_hour': 'awala :count',
    'h': 'awala :count',
    'minute': 'miniti :count',
    'a_minute': 'miniti :count',
    'min': 'miniti :count',
    'second': 'sekondi :count',
    'a_second': 'sekondi :count',
    's': 'sekondi :count',
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
    'L': 'MM/DD/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Januari',
    'Februari',
    'Machi',
    'Epreo',
    'Mei',
    'Juni',
    'Julai',
    'Ogasti',
    'Septemba',
    'Oktoba',
    'Novemba',
    'Disemba',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mac',
    'Epr',
    'Mei',
    'Jun',
    'Jul',
    'Oga',
    'Sep',
    'Okt',
    'Nov',
    'Dis',
  ],
  weekdays: [
    'Pa Mulungu',
    'Palichimo',
    'Palichibuli',
    'Palichitatu',
    'Palichine',
    'Palichisano',
    'Pachibelushi',
  ],
  weekdaysShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
  weekdaysMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
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

// Regional variant: bem_ZM
final CarbonLocaleData localeBemZm = localeBem.copyWith(localeCode: 'bem_zm');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'uluchelo' : 'akasuba';
}

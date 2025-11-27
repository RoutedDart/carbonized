// AUTO-GENERATED from PHP Carbon locale: bi
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeBi = CarbonLocaleData(
  localeCode: 'bi',
  translationStrings: {
    'year': ':count seven',
    'a_year': ':count seven',
    'y': ':count seven',
    'month': ':count mi',
    'a_month': ':count mi',
    'm': ':count mi',
    'week': ':count sarede',
    'a_week': ':count sarede',
    'w': ':count sarede',
    'day': ':count betde',
    'a_day': ':count betde',
    'd': ':count betde',
    'hour': ':count klok',
    'a_hour': ':count klok',
    'h': ':count klok',
    'minute': ':count smol',
    'a_minute': ':count smol',
    'min': ':count smol',
    'second': ':count tu',
    'a_second': ':count tu',
    's': ':count tu',
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
    'L': 'dddd DD MMM YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'jenuware',
    'febwari',
    'maj',
    'epril',
    'mei',
    'jun',
    'julae',
    'ogis',
    'septemba',
    'oktoba',
    'novemba',
    'disemba',
  ],
  monthsShort: [
    'jen',
    'feb',
    'maj',
    'epr',
    'mei',
    'jun',
    'jul',
    'ogi',
    'sep',
    'okt',
    'nov',
    'dis',
  ],
  weekdays: ['sande', 'mande', 'maj', 'wota', 'fraede', 'sarede', 'Saturday'],
  weekdaysShort: ['san', 'man', 'maj', 'wot', 'fra', 'sar', 'Sat'],
  weekdaysMin: ['san', 'man', 'maj', 'wot', 'fra', 'sar', 'Sa'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: bi_VU
final CarbonLocaleData localeBiVu = localeBi.copyWith(localeCode: 'bi_vu');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

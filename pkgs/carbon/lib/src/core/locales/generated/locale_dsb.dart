// AUTO-GENERATED from PHP Carbon locale: dsb
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeDsb = CarbonLocaleData(
  localeCode: 'dsb',
  translationStrings: {
    'year': ':count lěto',
    'a_year': ':count lěto',
    'y': ':count lěto',
    'month': ':count mjasec',
    'a_month': ':count mjasec',
    'm': ':count mjasec',
    'week': ':count tyźeń',
    'a_week': ':count tyźeń',
    'w': ':count tyźeń',
    'day': ':count źeń',
    'a_day': ':count źeń',
    'd': ':count źeń',
    'hour': ':count góźina',
    'a_hour': ':count góźina',
    'h': ':count góźina',
    'minute': ':count minuta',
    'a_minute': ':count minuta',
    'min': ':count minuta',
    'second': ':count drugi',
    'a_second': ':count drugi',
    's': ':count drugi',
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
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'DD. MMMM YYYY',
    'LLL': 'DD. MMMM, HH:mm [góź.]',
    'LLLL': 'dddd, DD. MMMM YYYY, HH:mm [góź.]',
  },
  months: [
    'januara',
    'februara',
    'měrca',
    'apryla',
    'maja',
    'junija',
    'julija',
    'awgusta',
    'septembra',
    'oktobra',
    'nowembra',
    'decembra',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Měr',
    'Apr',
    'Maj',
    'Jun',
    'Jul',
    'Awg',
    'Sep',
    'Okt',
    'Now',
    'Dec',
  ],
  weekdays: [
    'Njeźela',
    'Pónjeźele',
    'Wałtora',
    'Srjoda',
    'Stwórtk',
    'Pětk',
    'Sobota',
  ],
  weekdaysShort: ['Nj', 'Pó', 'Wa', 'Sr', 'St', 'Pě', 'So'],
  weekdaysMin: ['Nj', 'Pó', 'Wa', 'Sr', 'St', 'Pě', 'So'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
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

// Regional variant: dsb_DE
final CarbonLocaleData localeDsbDe = localeDsb.copyWith(localeCode: 'dsb_de');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

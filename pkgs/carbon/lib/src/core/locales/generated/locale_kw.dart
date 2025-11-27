// AUTO-GENERATED from PHP Carbon locale: kw
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKw = CarbonLocaleData(
  localeCode: 'kw',
  translationStrings: {
    'year': ':count bledhen',
    'a_year': ':count bledhen',
    'y': ':count bledhen',
    'month': ':count mis',
    'a_month': ':count mis',
    'm': ':count mis',
    'week': ':count seythen',
    'a_week': ':count seythen',
    'w': ':count seythen',
    'day': ':count dydh',
    'a_day': ':count dydh',
    'd': ':count dydh',
    'hour': ':count eur',
    'a_hour': ':count eur',
    'h': ':count eur',
    'minute': ':count mynysen',
    'a_minute': ':count mynysen',
    'min': ':count mynysen',
    'second': ':count pryjwyth',
    'a_second': ':count pryjwyth',
    's': ':count pryjwyth',
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
    'L': 'DD/MM/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'mis Genver',
    'mis Hwevrer',
    'mis Meurth',
    'mis Ebrel',
    'mis Me',
    'mis Metheven',
    'mis Gortheren',
    'mis Est',
    'mis Gwynngala',
    'mis Hedra',
    'mis Du',
    'mis Kevardhu',
  ],
  monthsShort: [
    'Gen',
    'Hwe',
    'Meu',
    'Ebr',
    'Me',
    'Met',
    'Gor',
    'Est',
    'Gwn',
    'Hed',
    'Du',
    'Kev',
  ],
  weekdays: [
    'De Sul',
    'De Lun',
    'De Merth',
    'De Merher',
    'De Yow',
    'De Gwener',
    'De Sadorn',
  ],
  weekdaysShort: ['Sul', 'Lun', 'Mth', 'Mhr', 'Yow', 'Gwe', 'Sad'],
  weekdaysMin: ['Sul', 'Lun', 'Mth', 'Mhr', 'Yow', 'Gwe', 'Sad'],
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

// Regional variant: kw_GB
final CarbonLocaleData localeKwGb = localeKw.copyWith(localeCode: 'kw_gb');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

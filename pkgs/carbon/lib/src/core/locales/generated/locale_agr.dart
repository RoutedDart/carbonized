// AUTO-GENERATED from PHP Carbon locale: agr
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAgr = CarbonLocaleData(
  localeCode: 'agr',
  translationStrings: {
    'year': ':count yaya',
    'a_year': ':count yaya',
    'y': ':count yaya',
    'month': ':count nantu',
    'a_month': ':count nantu',
    'm': ':count nantu',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': ':count nayaim',
    'a_day': ':count nayaim',
    'd': ':count nayaim',
    'hour': ':count kuwiš',
    'a_hour': ':count kuwiš',
    'h': ':count kuwiš',
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
    'L': 'DD/MM/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Petsatin',
    'Kupitin',
    'Uyaitin',
    'Tayutin',
    'Kegketin',
    'Tegmatin',
    'Kuntutin',
    'Yagkujutin',
    'Daiktatin',
    'Ipamtatin',
    'Shinutin',
    'Sakamtin',
  ],
  monthsShort: [
    'Pet',
    'Kup',
    'Uya',
    'Tay',
    'Keg',
    'Teg',
    'Kun',
    'Yag',
    'Dait',
    'Ipam',
    'Shin',
    'Sak',
  ],
  weekdays: [
    'Tuntuamtin',
    'Achutin',
    'Kugkuktin',
    'Saketin',
    'Shimpitin',
    'Imaptin',
    'Bataetin',
  ],
  weekdaysShort: ['Tun', 'Ach', 'Kug', 'Sak', 'Shim', 'Im', 'Bat'],
  weekdaysMin: ['Tun', 'Ach', 'Kug', 'Sak', 'Shim', 'Im', 'Bat'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 7,
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

// Regional variant: agr_PE
final CarbonLocaleData localeAgrPe = localeAgr.copyWith(localeCode: 'agr_pe');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'VM' : 'NM';
}

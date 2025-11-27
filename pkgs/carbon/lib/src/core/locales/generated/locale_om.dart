// AUTO-GENERATED from PHP Carbon locale: om
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeOm = CarbonLocaleData(
  localeCode: 'om',
  translationStrings: {
    'year': 'wggoota :count',
    'a_year': 'wggoota :count',
    'y': 'wggoota :count',
    'month': 'ji’a :count',
    'a_month': 'ji’a :count',
    'm': 'ji’a :count',
    'week': 'torban :count',
    'a_week': 'torban :count',
    'w': 'torban :count',
    'day': 'guyyaa :count',
    'a_day': 'guyyaa :count',
    'd': 'guyyaa :count',
    'hour': 'saʼaatii :count',
    'a_hour': 'saʼaatii :count',
    'h': 'saʼaatii :count',
    'minute': 'daqiiqaa :count',
    'a_minute': 'daqiiqaa :count',
    'min': 'daqiiqaa :count',
    'second': 'sekoondii :count',
    'a_second': 'sekoondii :count',
    's': 'sekoondii :count',
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
    'L': 'DD/MM/YYYY',
    'LL': 'dd-MMM-YYYY',
    'LLL': 'dd MMMM YYYY HH:mm',
    'LLLL': 'dddd, MMMM D, YYYY HH:mm',
  },
  months: [
    'Amajjii',
    'Guraandhala',
    'Bitooteessa',
    'Elba',
    'Caamsa',
    'Waxabajjii',
    'Adooleessa',
    'Hagayya',
    'Fuulbana',
    'Onkololeessa',
    'Sadaasa',
    'Muddee',
  ],
  monthsShort: [
    'Ama',
    'Gur',
    'Bit',
    'Elb',
    'Cam',
    'Wax',
    'Ado',
    'Hag',
    'Ful',
    'Onk',
    'Sad',
    'Mud',
  ],
  weekdays: [
    'Dilbata',
    'Wiixata',
    'Qibxata',
    'Roobii',
    'Kamiisa',
    'Jimaata',
    'Sanbata',
  ],
  weekdaysShort: ['Dil', 'Wix', 'Qib', 'Rob', 'Kam', 'Jim', 'San'],
  weekdaysMin: ['Dil', 'Wix', 'Qib', 'Rob', 'Kam', 'Jim', 'San'],
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

// Regional variant: om_ET
final CarbonLocaleData localeOmEt = localeOm.copyWith(localeCode: 'om_et');

// Regional variant: om_KE
final CarbonLocaleData localeOmKe = localeOm.copyWith(localeCode: 'om_ke');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'WD' : 'WB';
}

// AUTO-GENERATED from PHP Carbon locale: crh
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeCrh = CarbonLocaleData(
  localeCode: 'crh',
  translationStrings: {
    'year': ':count yıl',
    'a_year': ':count yıl',
    'y': ':count yıl',
    'month': ':count ay',
    'a_month': ':count ay',
    'm': ':count ay',
    'week': ':count afta',
    'a_week': ':count afta',
    'w': ':count afta',
    'day': ':count kün',
    'a_day': ':count kün',
    'd': ':count kün',
    'hour': ':count saat',
    'a_hour': ':count saat',
    'h': ':count saat',
    'minute': ':count daqqa',
    'a_minute': ':count daqqa',
    'min': ':count daqqa',
    'second': ':count ekinci',
    'a_second': ':count ekinci',
    's': ':count ekinci',
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
    'L': 'DD.MM.YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Yanvar',
    'Fevral',
    'Mart',
    'Aprel',
    'Mayıs',
    'İyun',
    'İyul',
    'Avgust',
    'Sentâbr',
    'Oktâbr',
    'Noyabr',
    'Dekabr',
  ],
  monthsShort: [
    'Yan',
    'Fev',
    'Mar',
    'Apr',
    'May',
    'İyn',
    'İyl',
    'Avg',
    'Sen',
    'Okt',
    'Noy',
    'Dek',
  ],
  weekdays: [
    'Bazar',
    'Bazarertesi',
    'Salı',
    'Çarşembe',
    'Cumaaqşamı',
    'Cuma',
    'Cumaertesi',
  ],
  weekdaysShort: ['Baz', 'Ber', 'Sal', 'Çar', 'Caq', 'Cum', 'Cer'],
  weekdaysMin: ['Baz', 'Ber', 'Sal', 'Çar', 'Caq', 'Cum', 'Cer'],
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

// Regional variant: crh_UA
final CarbonLocaleData localeCrhUa = localeCrh.copyWith(localeCode: 'crh_ua');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ÜE' : 'ÜS';
}

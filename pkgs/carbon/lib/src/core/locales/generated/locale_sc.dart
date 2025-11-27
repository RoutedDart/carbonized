// AUTO-GENERATED from PHP Carbon locale: sc
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSc = CarbonLocaleData(
  localeCode: 'sc',
  translationStrings: {
    'year': ':count annu',
    'a_year': ':count annu',
    'y': ':count annu',
    'month': ':count mese',
    'a_month': ':count mese',
    'm': ':count mese',
    'week': ':count chida',
    'a_week': ':count chida',
    'w': ':count chida',
    'day': ':count dí',
    'a_day': ':count dí',
    'd': ':count dí',
    'hour': ':count ora',
    'a_hour': ':count ora',
    'h': ':count ora',
    'minute': ':count mementu',
    'a_minute': ':count mementu',
    'min': ':count mementu',
    'second': ':count secundu',
    'a_second': ':count secundu',
    's': ':count secundu',
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
    'L': 'DD. MM. YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Ghennàrgiu',
    'Freàrgiu',
    'Martzu',
    'Abrile',
    'Maju',
    'Làmpadas',
    'Argiolas//Trìulas',
    'Austu',
    'Cabudanni',
    'Santugaine//Ladàmine',
    'Onniasantu//Santandria',
    'Nadale//Idas',
  ],
  monthsShort: [
    'Ghe',
    'Fre',
    'Mar',
    'Abr',
    'Maj',
    'Làm',
    'Arg',
    'Aus',
    'Cab',
    'Lad',
    'Onn',
    'Nad',
  ],
  weekdays: [
    'Domìnigu',
    'Lunis',
    'Martis',
    'Mèrcuris',
    'Giòbia',
    'Chenàbura',
    'Sàbadu',
  ],
  weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mèr', 'Giò', 'Che', 'Sàb'],
  weekdaysMin: ['Dom', 'Lun', 'Mar', 'Mèr', 'Giò', 'Che', 'Sàb'],
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

// Regional variant: sc_IT
final CarbonLocaleData localeScIt = localeSc.copyWith(localeCode: 'sc_it');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// AUTO-GENERATED from PHP Carbon locale: ff
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeFf = CarbonLocaleData(
  localeCode: 'ff',
  translationStrings: {
    'year': ':count baret',
    'a_year': ':count baret',
    'y': ':count baret',
    'month': ':count lewru',
    'a_month': ':count lewru',
    'm': ':count lewru',
    'week': ':count naange',
    'a_week': ':count naange',
    'w': ':count naange',
    'day': ':count dian',
    'a_day': ':count dian',
    'd': ':count dian',
    'hour': ':count montor',
    'a_hour': ':count montor',
    'h': ':count montor',
    'minute': ':count tokossuoum',
    'a_minute': ':count tokossuoum',
    'min': ':count tokossuoum',
    'second': ':count tenen',
    'a_second': ':count tenen',
    's': ':count tenen',
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
    'LL': 'D MMM, YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'siilo',
    'colte',
    'mbooy',
    'seeɗto',
    'duujal',
    'korse',
    'morso',
    'juko',
    'siilto',
    'yarkomaa',
    'jolal',
    'bowte',
  ],
  monthsShort: [
    'sii',
    'col',
    'mbo',
    'see',
    'duu',
    'kor',
    'mor',
    'juk',
    'slt',
    'yar',
    'jol',
    'bow',
  ],
  weekdays: [
    'dewo',
    'aaɓnde',
    'mawbaare',
    'njeslaare',
    'naasaande',
    'mawnde',
    'hoore-biir',
  ],
  weekdaysShort: ['dew', 'aaɓ', 'maw', 'nje', 'naa', 'mwd', 'hbi'],
  weekdaysMin: ['dew', 'aaɓ', 'maw', 'nje', 'naa', 'mwd', 'hbi'],
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

// Regional variant: ff_CM
final CarbonLocaleData localeFfCm = localeFf.copyWith(localeCode: 'ff_cm');

// Regional variant: ff_GN
final CarbonLocaleData localeFfGn = localeFf.copyWith(localeCode: 'ff_gn');

// Regional variant: ff_MR
final CarbonLocaleData localeFfMr = localeFf.copyWith(localeCode: 'ff_mr');

// Regional variant: ff_SN
final CarbonLocaleData localeFfSn = localeFf.copyWith(localeCode: 'ff_sn');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'subaka' : 'kikiiɗe';
}

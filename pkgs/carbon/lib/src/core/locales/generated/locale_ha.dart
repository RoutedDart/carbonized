// AUTO-GENERATED from PHP Carbon locale: ha
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeHa = CarbonLocaleData(
  localeCode: 'ha',
  translationStrings: {
    'year': 'shekara :count',
    'a_year': 'shekara :count',
    'y': 'shekara :count',
    'month': ':count wátàa',
    'a_month': ':count wátàa',
    'm': ':count wátàa',
    'week': ':count mako',
    'a_week': ':count mako',
    'w': ':count mako',
    'day': ':count rana',
    'a_day': ':count rana',
    'd': ':count rana',
    'hour': ':count áwàa',
    'a_hour': ':count áwàa',
    'h': ':count áwàa',
    'minute': 'minti :count',
    'a_minute': 'minti :count',
    'min': 'minti :count',
    'second': ':count ná bíyú',
    'a_second': ':count ná bíyú',
    's': ':count ná bíyú',
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
    'L': 'D/M/YYYY',
    'LL': 'D MMM, YYYY',
    'LLL': 'D MMMM, YYYY HH:mm',
    'LLLL': 'dddd, D MMMM, YYYY HH:mm',
  },
  months: [
    'Janairu',
    'Faburairu',
    'Maris',
    'Afirilu',
    'Mayu',
    'Yuni',
    'Yuli',
    'Agusta',
    'Satumba',
    'Oktoba',
    'Nuwamba',
    'Disamba',
  ],
  monthsShort: [
    'Jan',
    'Fab',
    'Mar',
    'Afi',
    'May',
    'Yun',
    'Yul',
    'Agu',
    'Sat',
    'Okt',
    'Nuw',
    'Dis',
  ],
  weekdays: [
    'Lahadi',
    'Litini',
    'Talata',
    'Laraba',
    'Alhamis',
    'Jumaʼa',
    'Asabar',
  ],
  weekdaysShort: ['Lah', 'Lit', 'Tal', 'Lar', 'Alh', 'Jum', 'Asa'],
  weekdaysMin: ['Lh', 'Li', 'Ta', 'Lr', 'Al', 'Ju', 'As'],
  firstDayOfWeek: 1,
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

// Regional variant: ha_GH
final CarbonLocaleData localeHaGh = localeHa.copyWith(localeCode: 'ha_gh');

// Regional variant: ha_NE
final CarbonLocaleData localeHaNe = localeHa.copyWith(localeCode: 'ha_ne');

// Regional variant: ha_NG
final CarbonLocaleData localeHaNg = localeHa.copyWith(localeCode: 'ha_ng');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

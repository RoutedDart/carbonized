// AUTO-GENERATED from PHP Carbon locale: quz
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeQuz = CarbonLocaleData(
  localeCode: 'quz',
  translationStrings: {
    'year': ':count wata',
    'a_year': ':count wata',
    'y': ':count wata',
    'month': ':count killa',
    'a_month': ':count killa',
    'm': ':count killa',
    'week': ':count simana',
    'a_week': ':count simana',
    'w': ':count simana',
    'day': ':count pʼunchaw',
    'a_day': ':count pʼunchaw',
    'd': ':count pʼunchaw',
    'hour': ':count ura',
    'a_hour': ':count ura',
    'h': ':count ura',
    'minute': ':count uchuy',
    'a_minute': ':count uchuy',
    'min': ':count uchuy',
    'second': ':count iskay ñiqin',
    'a_second': ':count iskay ñiqin',
    's': ':count iskay ñiqin',
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
    'iniru',
    'phiwriru',
    'marsu',
    'awril',
    'mayu',
    'huniyu',
    'huliyu',
    'agustu',
    'siptiyimri',
    'uktuwri',
    'nuwiyimri',
    'tisiyimri',
  ],
  monthsShort: [
    'ini',
    'phi',
    'mar',
    'awr',
    'may',
    'hun',
    'hul',
    'agu',
    'sip',
    'ukt',
    'nuw',
    'tis',
  ],
  weekdays: [
    'tuminku',
    'lunis',
    'martis',
    'miyirkulis',
    'juywis',
    'wiyirnis',
    'sawatu',
  ],
  weekdaysShort: ['tum', 'lun', 'mar', 'miy', 'juy', 'wiy', 'saw'],
  weekdaysMin: ['tum', 'lun', 'mar', 'miy', 'juy', 'wiy', 'saw'],
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

// Regional variant: quz_PE
final CarbonLocaleData localeQuzPe = localeQuz.copyWith(localeCode: 'quz_pe');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

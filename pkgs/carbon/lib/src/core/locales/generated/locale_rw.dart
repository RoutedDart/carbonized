// AUTO-GENERATED from PHP Carbon locale: rw
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRw = CarbonLocaleData(
  localeCode: 'rw',
  translationStrings: {
    'year': 'aka :count',
    'a_year': 'aka :count',
    'y': 'aka :count',
    'month': 'ezi :count',
    'a_month': 'ezi :count',
    'm': 'ezi :count',
    'week': ':count icyumweru',
    'a_week': ':count icyumweru',
    'w': ':count icyumweru',
    'day': ':count nsi',
    'a_day': ':count nsi',
    'd': ':count nsi',
    'hour': 'saha :count',
    'a_hour': 'saha :count',
    'h': 'saha :count',
    'minute': ':count -nzinya',
    'a_minute': ':count -nzinya',
    'min': ':count -nzinya',
    'second': ':count vuna',
    'a_second': ':count vuna',
    's': ':count vuna',
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
    'Mutarama',
    'Gashyantare',
    'Werurwe',
    'Mata',
    'Gicuransi',
    'Kamena',
    'Nyakanga',
    'Kanama',
    'Nzeli',
    'Ukwakira',
    'Ugushyingo',
    'Ukuboza',
  ],
  monthsShort: [
    'Mut',
    'Gas',
    'Wer',
    'Mat',
    'Gic',
    'Kam',
    'Nya',
    'Kan',
    'Nze',
    'Ukw',
    'Ugu',
    'Uku',
  ],
  weekdays: [
    'Ku cyumweru',
    'Kuwa mbere',
    'Kuwa kabiri',
    'Kuwa gatatu',
    'Kuwa kane',
    'Kuwa gatanu',
    'Kuwa gatandatu',
  ],
  weekdaysShort: ['Mwe', 'Mbe', 'Kab', 'Gtu', 'Kan', 'Gnu', 'Gnd'],
  weekdaysMin: ['Mwe', 'Mbe', 'Kab', 'Gtu', 'Kan', 'Gnu', 'Gnd'],
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

// Regional variant: rw_RW
final CarbonLocaleData localeRwRw = localeRw.copyWith(localeCode: 'rw_rw');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

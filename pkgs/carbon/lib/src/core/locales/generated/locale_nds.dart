// AUTO-GENERATED from PHP Carbon locale: nds
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNds = CarbonLocaleData(
  localeCode: 'nds',
  translationStrings: {
    'year': ':count Johr',
    'a_year': '{1}een Johr|:count Johr',
    'y': ':countJ',
    'month': ':count Maand',
    'a_month': '{1}een Maand|:count Maand',
    'm': ':countM',
    'week': ':count Week|:count Weken',
    'a_week': '{1}een Week|:count Week|:count Weken',
    'w': ':countW',
    'day': ':count Dag|:count Daag',
    'a_day': '{1}een Dag|:count Dag|:count Daag',
    'd': ':countD',
    'hour': ':count Stünn|:count Stünnen',
    'a_hour': '{1}een Stünn|:count Stünn|:count Stünnen',
    'h': ':countSt',
    'minute': ':count Minuut|:count Minuten',
    'a_minute': '{1}een Minuut|:count Minuut|:count Minuten',
    'min': ':countm',
    'second': ':count Sekunn|:count Sekunnen',
    'a_second': 'en poor Sekunnen|:count Sekunn|:count Sekunnen',
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
    'ago': 'vör :time',
    'from_now': 'in :time',
    'after': ':time later',
    'before': ':time vörher',
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
    'Jannuaar',
    'Feberwaar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mär',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Dez',
  ],
  weekdays: [
    'Sünndag',
    'Maandag',
    'Dingsdag',
    'Middeweek',
    'Dunnersdag',
    'Freedag',
    'Sünnavend',
  ],
  weekdaysShort: ['Sdag', 'Maan', 'Ding', 'Midd', 'Dunn', 'Free', 'Svd.'],
  weekdaysMin: ['Sd', 'Ma', 'Di', 'Mi', 'Du', 'Fr', 'Sa'],
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

// Regional variant: nds_DE
final CarbonLocaleData localeNdsDe = localeNds.copyWith(localeCode: 'nds_de');

// Regional variant: nds_NL
final CarbonLocaleData localeNdsNl = localeNds.copyWith(
  localeCode: 'nds_nl',
  weekdays: [
    'Sinndag',
    'Mondag',
    'Dingsdag',
    'Meddwäakj',
    'Donnadag',
    'Friedag',
    'Sinnowend',
  ],
  weekdaysShort: ['Sdg', 'Mdg', 'Dsg', 'Mwk', 'Ddg', 'Fdg', 'Swd'],
  weekdaysMin: ['Sdg', 'Mdg', 'Dsg', 'Mwk', 'Ddg', 'Fdg', 'Swd'],
  months: [
    'Jaunuwoa',
    'Februwoa',
    'Moaz',
    'Aprell',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'Septamba',
    'Oktoba',
    'Nowamba',
    'Dezamba',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Moz',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Now',
    'Dez',
  ],
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

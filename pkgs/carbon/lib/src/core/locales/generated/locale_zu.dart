// AUTO-GENERATED from PHP Carbon locale: zu
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeZu = CarbonLocaleData(
  localeCode: 'zu',
  translationStrings: {
    'year': 'kweminyaka engu-:count',
    'a_year': 'kweminyaka engu-:count',
    'y': 'kweminyaka engu-:count',
    'month': 'izinyanga ezingu-:count',
    'a_month': 'izinyanga ezingu-:count',
    'm': 'izinyanga ezingu-:count',
    'week': 'lwamasonto angu-:count',
    'a_week': 'lwamasonto angu-:count',
    'w': 'lwamasonto angu-:count',
    'day': 'ezingaba ngu-:count',
    'a_day': 'ezingaba ngu-:count',
    'd': 'ezingaba ngu-:count',
    'hour': 'amahora angu-:count',
    'a_hour': 'amahora angu-:count',
    'h': 'amahora angu-:count',
    'minute': 'ngemizuzu engu-:count',
    'a_minute': 'ngemizuzu engu-:count',
    'min': 'ngemizuzu engu-:count',
    'second': 'imizuzwana engu-:count',
    'a_second': 'imizuzwana engu-:count',
    's': 'imizuzwana engu-:count',
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
    'L': 'DD/MM/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Januwari',
    'Februwari',
    'Mashi',
    'Ephreli',
    'Meyi',
    'Juni',
    'Julayi',
    'Agasti',
    'Septhemba',
    'Okthoba',
    'Novemba',
    'Disemba',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mas',
    'Eph',
    'Mey',
    'Jun',
    'Jul',
    'Aga',
    'Sep',
    'Okt',
    'Nov',
    'Dis',
  ],
  weekdays: [
    'iSonto',
    'uMsombuluko',
    'uLwesibili',
    'uLwesithathu',
    'uLwesine',
    'uLwesihlanu',
    'uMgqibelo',
  ],
  weekdaysShort: ['Son', 'Mso', 'Bil', 'Tha', 'Sin', 'Hla', 'Mgq'],
  weekdaysMin: ['Son', 'Mso', 'Bil', 'Tha', 'Sin', 'Hla', 'Mgq'],
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

// Regional variant: zu_ZA
final CarbonLocaleData localeZuZa = localeZu.copyWith(localeCode: 'zu_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

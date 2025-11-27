// AUTO-GENERATED from PHP Carbon locale: xh
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeXh = CarbonLocaleData(
  localeCode: 'xh',
  translationStrings: {
    'year': ':count ihlobo',
    'a_year': ':count ihlobo',
    'y': ':count ihlobo',
    'month': ':count inyanga',
    'a_month': ':count inyanga',
    'm': ':count inyanga',
    'week': ':count veki',
    'a_week': ':count veki',
    'w': ':count veki',
    'day': ':count imini',
    'a_day': ':count imini',
    'd': ':count imini',
    'hour': ':count iwotshi',
    'a_hour': ':count iwotshi',
    'h': ':count iwotshi',
    'minute': ':count ingqalelo',
    'a_minute': ':count ingqalelo',
    'min': ':count ingqalelo',
    'second': ':count nceda',
    'a_second': ':count nceda',
    's': ':count nceda',
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
    'eyoMqungu',
    'eyoMdumba',
    'eyoKwindla',
    'uTshazimpuzi',
    'uCanzibe',
    'eyeSilimela',
    'eyeKhala',
    'eyeThupa',
    'eyoMsintsi',
    'eyeDwarha',
    'eyeNkanga',
    'eyoMnga',
  ],
  monthsShort: [
    'Mqu',
    'Mdu',
    'Kwi',
    'Tsh',
    'Can',
    'Sil',
    'Kha',
    'Thu',
    'Msi',
    'Dwa',
    'Nka',
    'Mng',
  ],
  weekdays: [
    'iCawa',
    'uMvulo',
    'lwesiBini',
    'lwesiThathu',
    'ulweSine',
    'lwesiHlanu',
    'uMgqibelo',
  ],
  weekdaysShort: ['Caw', 'Mvu', 'Bin', 'Tha', 'Sin', 'Hla', 'Mgq'],
  weekdaysMin: ['Caw', 'Mvu', 'Bin', 'Tha', 'Sin', 'Hla', 'Mgq'],
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

// Regional variant: xh_ZA
final CarbonLocaleData localeXhZa = localeXh.copyWith(localeCode: 'xh_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

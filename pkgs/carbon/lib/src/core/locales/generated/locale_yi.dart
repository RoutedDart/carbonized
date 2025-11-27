// AUTO-GENERATED from PHP Carbon locale: yi
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeYi = CarbonLocaleData(
  localeCode: 'yi',
  translationStrings: {
    'year': ':count יאר',
    'a_year': ':count יאר',
    'y': ':count יאר',
    'month': ':count חודש',
    'a_month': ':count חודש',
    'm': ':count חודש',
    'week': ':count וואָך',
    'a_week': ':count וואָך',
    'w': ':count וואָך',
    'day': ':count טאָג',
    'a_day': ':count טאָג',
    'd': ':count טאָג',
    'hour': ':count שעה',
    'a_hour': ':count שעה',
    'h': ':count שעה',
    'minute': ':count מינוט',
    'a_minute': ':count מינוט',
    'min': ':count מינוט',
    'second': ':count סעקונדע',
    'a_second': ':count סעקונדע',
    's': ':count סעקונדע',
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
    'יאַנואַר',
    'פֿעברואַר',
    'מערץ',
    'אַפּריל',
    'מיי',
    'יוני',
    'יולי',
    'אויגוסט',
    'סעפּטעמבער',
    'אקטאבער',
    'נאוועמבער',
    'דעצעמבער',
  ],
  monthsShort: [
    'יאַנ',
    'פֿעב',
    'מאַר',
    'אַפּר',
    'מײַ ',
    'יונ',
    'יול',
    'אױג',
    'סעפּ',
    'אָקט',
    'נאָװ',
    'דעצ',
  ],
  weekdays: [
    'זונטיק',
    'מאָנטיק',
    'דינסטיק',
    'מיטװאָך',
    'דאָנערשטיק',
    'פֿרײַטיק',
    'שבת',
  ],
  weekdaysShort: [
    'זונ\'',
    'מאָנ\'',
    'דינ\'',
    'מיט\'',
    'דאָנ\'',
    'פֿרײַ\'',
    'שבת',
  ],
  weekdaysMin: [
    'זונ\'',
    'מאָנ\'',
    'דינ\'',
    'מיט\'',
    'דאָנ\'',
    'פֿרײַ\'',
    'שבת',
  ],
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

// Regional variant: yi_US
final CarbonLocaleData localeYiUs = localeYi.copyWith(localeCode: 'yi_us');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

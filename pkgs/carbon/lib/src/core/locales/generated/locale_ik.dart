// AUTO-GENERATED from PHP Carbon locale: ik
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIk = CarbonLocaleData(
  localeCode: 'ik',
  translationStrings: {
    'year': ':count ukiuq',
    'a_year': ':count ukiuq',
    'y': ':count ukiuq',
    'month': ':count Tatqiat',
    'a_month': ':count Tatqiat',
    'm': ':count Tatqiat',
    'week': ':count tatqiat',
    'a_week': ':count tatqiat',
    'w': ':count tatqiat',
    'day': ':count siqiñiq',
    'a_day': ':count siqiñiq',
    'd': ':count siqiñiq',
    'hour': ':count Siḷa',
    'a_hour': ':count Siḷa',
    'h': ':count Siḷa',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count iġñiq',
    'a_second': ':count iġñiq',
    's': ':count iġñiq',
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
    'Siqiññaatchiaq',
    'Siqiññaasrugruk',
    'Paniqsiqsiivik',
    'Qilġich Tatqiat',
    'Suppivik',
    'Iġñivik',
    'Itchavik',
    'Tiññivik',
    'Amiġaiqsivik',
    'Sikkuvik',
    'Nippivik',
    'Siqiñġiḷaq',
  ],
  monthsShort: [
    'Sñt',
    'Sñs',
    'Pan',
    'Qil',
    'Sup',
    'Iġñ',
    'Itc',
    'Tiñ',
    'Ami',
    'Sik',
    'Nip',
    'Siq',
  ],
  weekdays: [
    'Minġuiqsioiq',
    'Savałłiq',
    'Ilaqtchiioiq',
    'Qitchiioiq',
    'Sisamiioiq',
    'Tallimmiioiq',
    'Maqinġuoiq',
  ],
  weekdaysShort: ['Min', 'Sav', 'Ila', 'Qit', 'Sis', 'Tal', 'Maq'],
  weekdaysMin: ['Min', 'Sav', 'Ila', 'Qit', 'Sis', 'Tal', 'Maq'],
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

// Regional variant: ik_CA
final CarbonLocaleData localeIkCa = localeIk.copyWith(localeCode: 'ik_ca');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

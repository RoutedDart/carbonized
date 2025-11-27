// AUTO-GENERATED from PHP Carbon locale: smn
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSmn = CarbonLocaleData(
  localeCode: 'smn',
  translationStrings: {
    'year': ':count ihe',
    'a_year': ':count ihe',
    'y': ':count ihe',
    'month': ':count mánuppaje',
    'a_month': ':count mánuppaje',
    'm': ':count mánuppaje',
    'week': ':count okko',
    'a_week': ':count okko',
    'w': ':count okko',
    'day': ':count peivi',
    'a_day': ':count peivi',
    'd': ':count peivi',
    'hour': ':count äigi',
    'a_hour': ':count äigi',
    'h': ':count äigi',
    'minute': ':count miinut',
    'a_minute': ':count miinut',
    'min': ':count miinut',
    'second': ':count nubbe',
    'a_second': ':count nubbe',
    's': ':count nubbe',
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
    'LT': 'H.mm',
    'LTS': 'H.mm.ss',
    'L': 'D.M.YYYY',
    'LL': 'MMM D. YYYY',
    'LLL': 'MMMM D. YYYY H.mm',
    'LLLL': 'dddd, MMMM D. YYYY H.mm',
  },
  months: [
    'uđđâivemáánu',
    'kuovâmáánu',
    'njuhčâmáánu',
    'cuáŋuimáánu',
    'vyesimáánu',
    'kesimáánu',
    'syeinimáánu',
    'porgemáánu',
    'čohčâmáánu',
    'roovvâdmáánu',
    'skammâmáánu',
    'juovlâmáánu',
  ],
  monthsShort: [
    'uđiv',
    'kuovâ',
    'njuhčâ',
    'cuáŋui',
    'vyesi',
    'kesi',
    'syeini',
    'porge',
    'čohčâ',
    'roovvâd',
    'skammâ',
    'juovlâ',
  ],
  weekdays: [
    'pasepeeivi',
    'vuossaargâ',
    'majebaargâ',
    'koskoho',
    'tuorâstuv',
    'vástuppeeivi',
    'lávurduv',
  ],
  weekdaysShort: ['pas', 'vuo', 'maj', 'kos', 'tuo', 'vás', 'láv'],
  weekdaysMin: ['pa', 'vu', 'ma', 'ko', 'tu', 'vá', 'lá'],
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

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ip.' : 'ep.';
}

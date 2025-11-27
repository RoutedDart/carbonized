// AUTO-GENERATED from PHP Carbon locale: dua
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeDua = CarbonLocaleData(
  localeCode: 'dua',
  translationStrings: {
    'year': ':count ma mbu',
    'a_year': ':count ma mbu',
    'y': ':count ma mbu',
    'month': ':count myo̱di',
    'a_month': ':count myo̱di',
    'm': ':count myo̱di',
    'week': ':count woki',
    'a_week': ':count woki',
    'w': ':count woki',
    'day': ':count buńa',
    'a_day': ':count buńa',
    'd': ':count buńa',
    'hour': ':count ma awa',
    'a_hour': ':count ma awa',
    'h': ':count ma awa',
    'minute': ':count minuti',
    'a_minute': ':count minuti',
    'min': ':count minuti',
    'second': ':count maba',
    'a_second': ':count maba',
    's': ':count maba',
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
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'dimɔ́di',
    'ŋgɔndɛ',
    'sɔŋɛ',
    'diɓáɓá',
    'emiasele',
    'esɔpɛsɔpɛ',
    'madiɓɛ́díɓɛ́',
    'diŋgindi',
    'nyɛtɛki',
    'mayésɛ́',
    'tiníní',
    'eláŋgɛ́',
  ],
  monthsShort: [
    'di',
    'ŋgɔn',
    'sɔŋ',
    'diɓ',
    'emi',
    'esɔ',
    'mad',
    'diŋ',
    'nyɛt',
    'may',
    'tin',
    'elá',
  ],
  weekdays: ['éti', 'mɔ́sú', 'kwasú', 'mukɔ́sú', 'ŋgisú', 'ɗónɛsú', 'esaɓasú'],
  weekdaysShort: ['ét', 'mɔ́s', 'kwa', 'muk', 'ŋgi', 'ɗón', 'esa'],
  weekdaysMin: ['ét', 'mɔ́s', 'kwa', 'muk', 'ŋgi', 'ɗón', 'esa'],
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
  return hour < 12 ? 'idiɓa' : 'ebyámu';
}

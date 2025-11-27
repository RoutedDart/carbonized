// AUTO-GENERATED from PHP Carbon locale: nus
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNus = CarbonLocaleData(
  localeCode: 'nus',
  translationStrings: {
    'year': ':count jiök',
    'a_year': ':count jiök',
    'y': ':count jiök',
    'month': ':count pay',
    'a_month': ':count pay',
    'm': ':count pay',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': '{1}:count second|{0}:count seconds|[-Inf,Inf]:count seconds',
    'a_second': '{0,1}a few seconds|[-Inf,Inf]:count seconds',
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
    'LT': 'h:mm a',
    'LTS': 'h:mm:ss a',
    'L': 'D/MM/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY h:mm a',
    'LLLL': 'dddd D MMMM YYYY h:mm a',
  },
  months: [
    'Tiop thar pɛt',
    'Pɛt',
    'Duɔ̱ɔ̱ŋ',
    'Guak',
    'Duät',
    'Kornyoot',
    'Pay yie̱tni',
    'Tho̱o̱r',
    'Tɛɛr',
    'Laath',
    'Kur',
    'Tio̱p in di̱i̱t',
  ],
  monthsShort: [
    'Tiop',
    'Pɛt',
    'Duɔ̱ɔ̱',
    'Guak',
    'Duä',
    'Kor',
    'Pay',
    'Thoo',
    'Tɛɛ',
    'Laa',
    'Kur',
    'Tid',
  ],
  weekdays: [
    'Cäŋ kuɔth',
    'Jiec la̱t',
    'Rɛw lätni',
    'Diɔ̱k lätni',
    'Ŋuaan lätni',
    'Dhieec lätni',
    'Bäkɛl lätni',
  ],
  weekdaysShort: ['Cäŋ', 'Jiec', 'Rɛw', 'Diɔ̱k', 'Ŋuaan', 'Dhieec', 'Bäkɛl'],
  weekdaysMin: ['Cäŋ', 'Jiec', 'Rɛw', 'Diɔ̱k', 'Ŋuaan', 'Dhieec', 'Bäkɛl'],
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
  return hour < 12 ? 'RW' : 'TŊ';
}

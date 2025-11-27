// AUTO-GENERATED from PHP Carbon locale: shs
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeShs = CarbonLocaleData(
  localeCode: 'shs',
  translationStrings: {
    'year': ':count sqlélten',
    'a_year': ':count sqlélten',
    'y': ':count sqlélten',
    'month': ':count swewll',
    'a_month': ':count swewll',
    'm': ':count swewll',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': ':count seqwlút',
    'a_hour': ':count seqwlút',
    'h': ':count seqwlút',
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
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'DD/MM/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Pellkwet̓min',
    'Pelctsipwen̓ten',
    'Pellsqépts',
    'Peslléwten',
    'Pell7ell7é7llqten',
    'Pelltspéntsk',
    'Pelltqwelq̓wél̓t',
    'Pellct̓éxel̓cten',
    'Pesqelqlélten',
    'Pesllwélsten',
    'Pellc7ell7é7llcwten̓',
    'Pelltetétq̓em',
  ],
  monthsShort: [
    'Kwe',
    'Tsi',
    'Sqe',
    'Éwt',
    'Ell',
    'Tsp',
    'Tqw',
    'Ct̓é',
    'Qel',
    'Wél',
    'U7l',
    'Tet',
  ],
  weekdays: [
    'Sxetspesq̓t',
    'Spetkesq̓t',
    'Selesq̓t',
    'Skellesq̓t',
    'Smesesq̓t',
    'Stselkstesq̓t',
    'Stqmekstesq̓t',
  ],
  weekdaysShort: ['Sxe', 'Spe', 'Sel', 'Ske', 'Sme', 'Sts', 'Stq'],
  weekdaysMin: ['Sxe', 'Spe', 'Sel', 'Ske', 'Sme', 'Sts', 'Stq'],
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

// Regional variant: shs_CA
final CarbonLocaleData localeShsCa = localeShs.copyWith(localeCode: 'shs_ca');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

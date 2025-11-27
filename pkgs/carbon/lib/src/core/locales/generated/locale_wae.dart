// AUTO-GENERATED from PHP Carbon locale: wae
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeWae = CarbonLocaleData(
  localeCode: 'wae',
  translationStrings: {
    'year': '{1}:count year|{0}:count years|[-Inf,Inf]:count years',
    'a_year': '{1}a year|{0}:count years|[-Inf,Inf]:count years',
    'y': '{1}:countyr|{0}:countyrs|[-Inf,Inf]:countyrs',
    'month': ':count Maano',
    'a_month': ':count Maano',
    'm': ':count Maano',
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
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'YYYY-MM-DD',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Jenner',
    'Hornig',
    'Märze',
    'Abrille',
    'Meije',
    'Bráčet',
    'Heiwet',
    'Öigšte',
    'Herbštmánet',
    'Wímánet',
    'Wintermánet',
    'Chrištmánet',
  ],
  monthsShort: [
    'Jen',
    'Hor',
    'Mär',
    'Abr',
    'Mei',
    'Brá',
    'Hei',
    'Öig',
    'Her',
    'Wím',
    'Win',
    'Chr',
  ],
  weekdays: [
    'Suntag',
    'Mäntag',
    'Zischtag',
    'Mittwuch',
    'Frontag',
    'Fritag',
    'Samschtag',
  ],
  weekdaysShort: ['Sun', 'Män', 'Zis', 'Mit', 'Fro', 'Fri', 'Sam'],
  weekdaysMin: ['Sun', 'Män', 'Zis', 'Mit', 'Fro', 'Fri', 'Sam'],
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

// Regional variant: wae_CH
final CarbonLocaleData localeWaeCh = localeWae.copyWith(localeCode: 'wae_ch');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

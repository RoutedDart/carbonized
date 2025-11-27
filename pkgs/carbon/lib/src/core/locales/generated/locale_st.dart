// AUTO-GENERATED from PHP Carbon locale: st
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSt = CarbonLocaleData(
  localeCode: 'st',
  translationStrings: {
    'year': ':count selemo',
    'a_year': ':count selemo',
    'y': ':count selemo',
    'month': ':count kgwedi',
    'a_month': ':count kgwedi',
    'm': ':count kgwedi',
    'week': ':count Sontaha',
    'a_week': ':count Sontaha',
    'w': ':count Sontaha',
    'day': ':count letsatsi',
    'a_day': ':count letsatsi',
    'd': ':count letsatsi',
    'hour': ':count sešupanako',
    'a_hour': ':count sešupanako',
    'h': ':count sešupanako',
    'minute': ':count menyane',
    'a_minute': ':count menyane',
    'min': ':count menyane',
    'second': ':count thusa',
    'a_second': ':count thusa',
    's': ':count thusa',
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
    'Pherekgong',
    'Hlakola',
    'Tlhakubele',
    'Mmese',
    'Motsheanong',
    'Phupjane',
    'Phupu',
    'Phato',
    'Leotse',
    'Mphalane',
    'Pudungwana',
    'Tshitwe',
  ],
  monthsShort: [
    'Phe',
    'Hla',
    'TlH',
    'Mme',
    'Mot',
    'Jan',
    'Upu',
    'Pha',
    'Leo',
    'Mph',
    'Pud',
    'Tsh',
  ],
  weekdays: [
    'Sontaha',
    'Mantaha',
    'Labobedi',
    'Laboraro',
    'Labone',
    'Labohlano',
    'Moqebelo',
  ],
  weekdaysShort: ['Son', 'Mma', 'Bed', 'Rar', 'Ne', 'Hla', 'Moq'],
  weekdaysMin: ['Son', 'Mma', 'Bed', 'Rar', 'Ne', 'Hla', 'Moq'],
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

// Regional variant: st_ZA
final CarbonLocaleData localeStZa = localeSt.copyWith(localeCode: 'st_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

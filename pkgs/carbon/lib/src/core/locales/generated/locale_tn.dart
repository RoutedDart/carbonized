// AUTO-GENERATED from PHP Carbon locale: tn
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTn = CarbonLocaleData(
  localeCode: 'tn',
  translationStrings: {
    'year': 'dingwaga di le :count',
    'a_year': 'dingwaga di le :count',
    'y': 'dingwaga di le :count',
    'month': 'dikgwedi di le :count',
    'a_month': 'dikgwedi di le :count',
    'm': 'dikgwedi di le :count',
    'week': 'dibeke di le :count',
    'a_week': 'dibeke di le :count',
    'w': 'dibeke di le :count',
    'day': 'malatsi :count',
    'a_day': 'malatsi :count',
    'd': 'malatsi :count',
    'hour': 'diura di le :count',
    'a_hour': 'diura di le :count',
    'h': 'diura di le :count',
    'minute': 'metsotso e le :count',
    'a_minute': 'metsotso e le :count',
    'min': 'metsotso e le :count',
    'second': 'metsotswana e le :count',
    'a_second': 'metsotswana e le :count',
    's': 'metsotswana e le :count',
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
    'Ferikgong',
    'Tlhakole',
    'Mopitlwe',
    'Moranang',
    'Motsheganong',
    'Seetebosigo',
    'Phukwi',
    'Phatwe',
    'Lwetse',
    'Diphalane',
    'Ngwanatsele',
    'Sedimonthole',
  ],
  monthsShort: [
    'Fer',
    'Tlh',
    'Mop',
    'Mor',
    'Mot',
    'See',
    'Phu',
    'Pha',
    'Lwe',
    'Dip',
    'Ngw',
    'Sed',
  ],
  weekdays: [
    'laTshipi',
    'Mosupologo',
    'Labobedi',
    'Laboraro',
    'Labone',
    'Labotlhano',
    'Lamatlhatso',
  ],
  weekdaysShort: ['Tsh', 'Mos', 'Bed', 'Rar', 'Ne', 'Tlh', 'Mat'],
  weekdaysMin: ['Tsh', 'Mos', 'Bed', 'Rar', 'Ne', 'Tlh', 'Mat'],
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

// Regional variant: tn_ZA
final CarbonLocaleData localeTnZa = localeTn.copyWith(localeCode: 'tn_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

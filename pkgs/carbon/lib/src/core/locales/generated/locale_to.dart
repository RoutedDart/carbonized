// AUTO-GENERATED from PHP Carbon locale: to
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTo = CarbonLocaleData(
  localeCode: 'to',
  translationStrings: {
    'year': ':count fitu',
    'a_year': ':count fitu',
    'y': ':count fitu',
    'month': ':count mahina',
    'a_month': ':count mahina',
    'm': ':count mahina',
    'week': ':count Sapate',
    'a_week': ':count Sapate',
    'w': ':count Sapate',
    'day': ':count ʻaho',
    'a_day': ':count ʻaho',
    'd': ':count ʻaho',
    'hour': ':count houa',
    'a_hour': ':count houa',
    'h': ':count houa',
    'minute': ':count miniti',
    'a_minute': ':count miniti',
    'min': ':count miniti',
    'second': ':count sekoni',
    'a_second': ':count sekoni',
    's': ':count sekoni',
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
    'L': 'dddd DD MMM YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Sānuali',
    'Fēpueli',
    'Maʻasi',
    'ʻEpeleli',
    'Mē',
    'Sune',
    'Siulai',
    'ʻAokosi',
    'Sepitema',
    'ʻOkatopa',
    'Nōvema',
    'Tīsema',
  ],
  monthsShort: [
    'Sān',
    'Fēp',
    'Maʻa',
    'ʻEpe',
    'Mē',
    'Sun',
    'Siu',
    'ʻAok',
    'Sep',
    'ʻOka',
    'Nōv',
    'Tīs',
  ],
  weekdays: [
    'Sāpate',
    'Mōnite',
    'Tūsite',
    'Pulelulu',
    'Tuʻapulelulu',
    'Falaite',
    'Tokonaki',
  ],
  weekdaysShort: ['Sāp', 'Mōn', 'Tūs', 'Pul', 'Tuʻa', 'Fal', 'Tok'],
  weekdaysMin: ['Sāp', 'Mōn', 'Tūs', 'Pul', 'Tuʻa', 'Fal', 'Tok'],
  firstDayOfWeek: 0,
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

// Regional variant: to_TO
final CarbonLocaleData localeToTo = localeTo.copyWith(localeCode: 'to_to');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'hengihengi' : 'efiafi';
}

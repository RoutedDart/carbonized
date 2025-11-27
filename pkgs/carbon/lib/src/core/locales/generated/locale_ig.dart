// AUTO-GENERATED from PHP Carbon locale: ig
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIg = CarbonLocaleData(
  localeCode: 'ig',
  translationStrings: {
    'year': 'afo :count',
    'a_year': 'afo :count',
    'y': 'afo :count',
    'month': 'önwa :count',
    'a_month': 'önwa :count',
    'm': 'önwa :count',
    'week': 'izu :count',
    'a_week': 'izu :count',
    'w': 'izu :count',
    'day': 'ụbọchị :count',
    'a_day': 'ụbọchị :count',
    'd': 'ụbọchị :count',
    'hour': 'awa :count',
    'a_hour': 'awa :count',
    'h': 'awa :count',
    'minute': 'minit :count',
    'a_minute': 'minit :count',
    'min': 'minit :count',
    'second': 'sekọnd :count',
    'a_second': 'sekọnd :count',
    's': 'sekọnd :count',
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
    'Jenụwarị',
    'Febrụwarị',
    'Maachị',
    'Eprel',
    'Mee',
    'Juun',
    'Julaị',
    'Ọgọọst',
    'Septemba',
    'Ọktoba',
    'Novemba',
    'Disemba',
  ],
  monthsShort: [
    'Jen',
    'Feb',
    'Maa',
    'Epr',
    'Mee',
    'Juu',
    'Jul',
    'Ọgọ',
    'Sep',
    'Ọkt',
    'Nov',
    'Dis',
  ],
  weekdays: ['sọnde', 'mọnde', 'tuzde', 'wenzde', 'tọsde', 'fraịde', 'satọde'],
  weekdaysShort: ['sọn', 'mọn', 'tuz', 'wen', 'tọs', 'fra', 'sat'],
  weekdaysMin: ['sọn', 'mọn', 'tuz', 'wen', 'tọs', 'fra', 'sat'],
  firstDayOfWeek: 1,
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

// Regional variant: ig_NG
final CarbonLocaleData localeIgNg = localeIg.copyWith(localeCode: 'ig_ng');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

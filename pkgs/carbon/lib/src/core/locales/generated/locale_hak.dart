// AUTO-GENERATED from PHP Carbon locale: hak
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeHak = CarbonLocaleData(
  localeCode: 'hak',
  translationStrings: {
    'year': ':count ngien11',
    'a_year': ':count ngien11',
    'y': ':count ngien11',
    'month': ':count ngie̍t',
    'a_month': ':count ngie̍t',
    'm': ':count ngie̍t',
    'week': ':count lî-pai',
    'a_week': ':count lî-pai',
    'w': ':count lî-pai',
    'day': ':count ngit',
    'a_day': ':count ngit',
    'd': ':count ngit',
    'hour': ':count sṳ̀',
    'a_hour': ':count sṳ̀',
    'h': ':count sṳ̀',
    'minute': ':count fûn',
    'a_minute': ':count fûn',
    'min': ':count fûn',
    'second': ':count miéu',
    'a_second': ':count miéu',
    's': ':count miéu',
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
    'L': 'YYYY年MM月DD日',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    '一月',
    '二月',
    '三月',
    '四月',
    '五月',
    '六月',
    '七月',
    '八月',
    '九月',
    '十月',
    '十一月',
    '十二月',
  ],
  monthsShort: [
    ' 1月',
    ' 2月',
    ' 3月',
    ' 4月',
    ' 5月',
    ' 6月',
    ' 7月',
    ' 8月',
    ' 9月',
    '10月',
    '11月',
    '12月',
  ],
  weekdays: ['禮拜日', '禮拜一', '禮拜二', '禮拜三', '禮拜四', '禮拜五', '禮拜六'],
  weekdaysShort: ['日', '一', '二', '三', '四', '五', '六'],
  weekdaysMin: ['日', '一', '二', '三', '四', '五', '六'],
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

// Regional variant: hak_TW
final CarbonLocaleData localeHakTw = localeHak.copyWith(localeCode: 'hak_tw');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? '上晝' : '下晝';
}

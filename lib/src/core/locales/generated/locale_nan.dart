// AUTO-GENERATED from PHP Carbon locale: nan
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNan = CarbonLocaleData(
  localeCode: 'nan',
  translationStrings: {
    'year': ':count 年',
    'a_year': ':count 年',
    'y': ':count 年',
    'month': ':count goe̍h',
    'a_month': ':count goe̍h',
    'm': ':count goe̍h',
    'week': ':count lé-pài',
    'a_week': ':count lé-pài',
    'w': ':count lé-pài',
    'day': ':count 日',
    'a_day': ':count 日',
    'd': ':count 日',
    'hour': ':count tiám-cheng',
    'a_hour': ':count tiám-cheng',
    'h': ':count tiám-cheng',
    'minute': ':count Hun-cheng',
    'a_minute': ':count Hun-cheng',
    'min': ':count Hun-cheng',
    'second': ':count Bió',
    'a_second': ':count Bió',
    's': ':count Bió',
    'millisecond': '{1}:count millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'a_millisecond': '{1}a millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'ms': ':countms',
    'microsecond': '{1}:count microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'a_microsecond': '{1}a microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
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
  weekdays: [
    '禮拜日',
    '禮拜一',
    '禮拜二',
    '禮拜三',
    '禮拜四',
    '禮拜五',
    '禮拜六',
  ],
  weekdaysShort: [
    '日',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
  ],
  weekdaysMin: [
    '日',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
  ],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  ordinal: _ordinal,
);

// Regional variant: nan_TW
final CarbonLocaleData localeNanTw = localeNan.copyWith(
  localeCode: 'nan_tw',
);


// Auto-generated ordinal function
String _ordinal(int number, String period) {
  var lastDigit;
  lastDigit = number % 10;
    return '${number}${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// AUTO-GENERATED from PHP Carbon locale: lzh
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLzh = CarbonLocaleData(
  localeCode: 'lzh',
  translationStrings: {
    'year': ':count 夏',
    'a_year': ':count 夏',
    'y': ':count 夏',
    'month': ':count 月',
    'a_month': ':count 月',
    'm': ':count 月',
    'week': ':count 星期',
    'a_week': ':count 星期',
    'w': ':count 星期',
    'day': ':count 日(曆法)',
    'a_day': ':count 日(曆法)',
    'd': ':count 日(曆法)',
    'hour': ':count 氧',
    'a_hour': ':count 氧',
    'h': ':count 氧',
    'minute': ':count 點',
    'a_minute': ':count 點',
    'min': ':count 點',
    'second': ':count 楚',
    'a_second': ':count 楚',
    's': ':count 楚',
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
    'L': 'OY[年]MMMMOD[日]',
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
    ' 一 ',
    ' 二 ',
    ' 三 ',
    ' 四 ',
    ' 五 ',
    ' 六 ',
    ' 七 ',
    ' 八 ',
    ' 九 ',
    ' 十 ',
    '十一',
    '十二',
  ],
  weekdays: ['週日', '週一', '週二', '週三', '週四', '週五', '週六'],
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

// Regional variant: lzh_TW
final CarbonLocaleData localeLzhTw = localeLzh.copyWith(localeCode: 'lzh_tw');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? '朝' : '暮';
}

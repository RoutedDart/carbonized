// AUTO-GENERATED from PHP Carbon locale: yue
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeYue = CarbonLocaleData(
  localeCode: 'yue',
  translationStrings: {
    'year': ':count:optional-space年',
    'y': ':count:optional-space年',
    'month': ':count:optional-space個月',
    'm': ':count:optional-space月',
    'week': ':count:optional-space週',
    'w': ':count:optional-space週',
    'day': ':count:optional-space天',
    'd': ':count:optional-space天',
    'hour': ':count:optional-space小時',
    'h': ':count:optional-space小時',
    'minute': ':count:optional-space分鐘',
    'min': ':count:optional-space分鐘',
    'second': ':count:optional-space秒',
    'a_second': '{1}幾秒|[-Inf,Inf]:count:optional-space秒',
    's': ':count:optional-space秒',
    'ago': ':time前',
    'from_now': ':time後',
    'after': ':time後',
    'before': ':time前',
    'diff_now': '現在',
    'diff_today': '今天',
    'diff_yesterday': '昨天',
    'diff_tomorrow': '明天',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'YYYY年MM月DD日 dddd',
    'LL': 'YYYY年M月D日',
    'LLL': 'YYYY年M月D日 HH:mm',
    'LLLL': 'YYYY年M月D日dddd HH:mm',
  },
  months: [
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ],
  monthsShort: [
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ],
  weekdays: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
  weekdaysShort: ['日', '一', '二', '三', '四', '五', '六'],
  weekdaysMin: ['日', '一', '二', '三', '四', '五', '六'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[今天] LT',
    'nextDay': '[明天] LT',
    'nextWeek': '[下]dddd LT',
    'lastDay': '[昨天] LT',
    'lastWeek': '[上]dddd LT',
    'sameElse': 'L',
  },
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: yue_HK
final CarbonLocaleData localeYueHk = localeYue.copyWith(localeCode: 'yue_hk');

// Regional variant: yue_Hans
final CarbonLocaleData localeYueHans = localeYue.copyWith(
  localeCode: 'yue_hans',
  weekdaysShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
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
  calendar: {
    'sameDay': '[今天]LT',
    'nextDay': '[明天]LT',
    'nextWeek': '[下]ddddLT',
    'lastDay': '[昨天]LT',
    'lastWeek': '[上]ddddLT',
    'sameElse': 'L',
  },
);

// Regional variant: yue_Hant
final CarbonLocaleData localeYueHant = localeYue.copyWith(
  localeCode: 'yue_hant',
  weekdaysShort: ['週日', '週一', '週二', '週三', '週四', '週五', '週六'],
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
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return ((period == 'd' || period == 'D' || period == 'DDD'
          ? '$number日'
          : (period == 'M'
                ? '$number月'
                : (period == 'w' || period == 'W' ? '$number周' : number))))
      .toString();
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? '上午' : '下午';
}

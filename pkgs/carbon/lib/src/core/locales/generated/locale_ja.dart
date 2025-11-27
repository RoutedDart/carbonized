// AUTO-GENERATED from PHP Carbon locale: ja
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeJa = CarbonLocaleData(
  localeCode: 'ja',
  translationStrings: {
    'year': ':count年',
    'y': ':count年',
    'month': ':countヶ月',
    'm': ':countヶ月',
    'week': ':count週間',
    'w': ':count週間',
    'day': ':count日',
    'd': ':count日',
    'hour': ':count時間',
    'h': ':count時間',
    'minute': ':count分',
    'min': ':count分',
    'second': ':count秒',
    'a_second': '{1}数秒|[-Inf,Inf]:count秒',
    's': ':count秒',
    'ago': ':time前',
    'from_now': ':time後',
    'after': ':time後',
    'before': ':time前',
    'diff_now': '今',
    'diff_today': '今日',
    'diff_yesterday': '昨日',
    'diff_tomorrow': '明日',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'YYYY/MM/DD',
    'LL': 'YYYY年M月D日',
    'LLL': 'YYYY年M月D日 HH:mm',
    'LLLL': 'YYYY年M月D日 dddd HH:mm',
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
  weekdays: ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
  weekdaysShort: ['日', '月', '火', '水', '木', '金', '土'],
  weekdaysMin: ['日', '月', '火', '水', '木', '金', '土'],
  calendar: {
    'sameDay': '[今日] LT',
    'nextDay': '[明日] LT',
    'lastDay': '[昨日] LT',
    'sameElse': 'L',
  },
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ja_JP
final CarbonLocaleData localeJaJp = localeJa.copyWith(localeCode: 'ja_jp');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return ((period == 'd' || period == 'D' || period == 'DDD'
          ? '$number日'
          : number))
      .toString();
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? '午前' : '午後';
}

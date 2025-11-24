// AUTO-GENERATED from PHP Carbon locale: bg
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeBg = CarbonLocaleData(
  localeCode: 'bg',
  translationStrings: {
    'year': ':count година|:count години',
    'a_year': 'година|:count години',
    'y': ':count година|:count години',
    'month': ':count месец|:count месеца',
    'a_month': 'месец|:count месеца',
    'm': ':count месец|:count месеца',
    'week': ':count седмица|:count седмици',
    'a_week': 'седмица|:count седмици',
    'w': ':count седмица|:count седмици',
    'day': ':count ден|:count дни',
    'a_day': 'ден|:count дни',
    'd': ':count ден|:count дни',
    'hour': ':count час|:count часа',
    'a_hour': 'час|:count часа',
    'h': ':count час|:count часа',
    'minute': ':count минута|:count минути',
    'a_minute': 'минута|:count минути',
    'min': ':count минута|:count минути',
    'second': ':count секунда|:count секунди',
    'a_second': 'няколко секунди|:count секунди',
    's': ':count секунда|:count секунди',
    'ago': 'преди :time',
    'from_now': 'след :time',
    'after': 'след :time',
    'before': 'преди :time',
    'diff_now': 'сега',
    'diff_today': 'Днес',
    'diff_today_regexp': 'Днес(?:\\s+в)?',
    'diff_yesterday': 'вчера',
    'diff_yesterday_regexp': 'Вчера(?:\\s+в)?',
    'diff_tomorrow': 'утре',
    'diff_tomorrow_regexp': 'Утре(?:\\s+в)?',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'D.MM.YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY H:mm',
    'LLLL': 'dddd, D MMMM YYYY H:mm',
  },
  months: [
    'януари',
    'февруари',
    'март',
    'април',
    'май',
    'юни',
    'юли',
    'август',
    'септември',
    'октомври',
    'ноември',
    'декември',
  ],
  monthsShort: [
    'яну',
    'фев',
    'мар',
    'апр',
    'май',
    'юни',
    'юли',
    'авг',
    'сеп',
    'окт',
    'ное',
    'дек',
  ],
  weekdays: [
    'неделя',
    'понеделник',
    'вторник',
    'сряда',
    'четвъртък',
    'петък',
    'събота',
  ],
  weekdaysShort: [
    'нед',
    'пон',
    'вто',
    'сря',
    'чет',
    'пет',
    'съб',
  ],
  weekdaysMin: [
    'нд',
    'пн',
    'вт',
    'ср',
    'чт',
    'пт',
    'сб',
  ],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  ordinal: _ordinal,
);

// Regional variant: bg_BG
final CarbonLocaleData localeBgBg = localeBg.copyWith(
  localeCode: 'bg_bg',
);


// Auto-generated ordinal function
String _ordinal(int number, String period) {
  var lastDigit;
  var last2Digits;
  lastDigit = number % 10;
  last2Digits = number % 100;
    if (number == 0) {
      return '$number-ев';
    }
    if (last2Digits == 0) {
      return '$number-ен';
    }
    if (last2Digits > 10 && last2Digits < 20) {
      return '$number-ти';
    }
    if (lastDigit == 1) {
      return '$number-ви';
    }
    if (lastDigit == 2) {
      return '$number-ри';
    }
    if (lastDigit == 7 || lastDigit == 8) {
      return '$number-ми';
    }
    return '$number-ти';
}

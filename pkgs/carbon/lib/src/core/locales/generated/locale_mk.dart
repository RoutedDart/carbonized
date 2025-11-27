// AUTO-GENERATED from PHP Carbon locale: mk
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMk = CarbonLocaleData(
  localeCode: 'mk',
  translationStrings: {
    'year': ':count година|:count години',
    'a_year': 'година|:count години',
    'y': ':count год.',
    'month': ':count месец|:count месеци',
    'a_month': 'месец|:count месеци',
    'm': ':count месец|:count месеци',
    'week': ':count седмица|:count седмици',
    'a_week': 'седмица|:count седмици',
    'w': ':count седмица|:count седмици',
    'day': ':count ден|:count дена',
    'a_day': 'ден|:count дена',
    'd': ':count ден|:count дена',
    'hour': ':count час|:count часа',
    'a_hour': 'час|:count часа',
    'h': ':count час|:count часа',
    'minute': ':count минута|:count минути',
    'a_minute': 'минута|:count минути',
    'min': ':count мин.',
    'second': ':count секунда|:count секунди',
    'a_second': 'неколку секунди|:count секунди',
    's': ':count сек.',
    'ago': 'пред :time',
    'from_now': 'после :time',
    'after': 'по :time',
    'before': 'пред :time',
    'diff_now': 'сега',
    'diff_today': 'Денес',
    'diff_today_regexp': 'Денес(?:\\s+во)?',
    'diff_yesterday': 'вчера',
    'diff_yesterday_regexp': 'Вчера(?:\\s+во)?',
    'diff_tomorrow': 'утре',
    'diff_tomorrow_regexp': 'Утре(?:\\s+во)?',
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
    'јануари',
    'февруари',
    'март',
    'април',
    'мај',
    'јуни',
    'јули',
    'август',
    'септември',
    'октомври',
    'ноември',
    'декември',
  ],
  monthsShort: [
    'јан',
    'фев',
    'мар',
    'апр',
    'мај',
    'јун',
    'јул',
    'авг',
    'сеп',
    'окт',
    'ное',
    'дек',
  ],
  weekdays: [
    'недела',
    'понеделник',
    'вторник',
    'среда',
    'четврток',
    'петок',
    'сабота',
  ],
  weekdaysShort: ['нед', 'пон', 'вто', 'сре', 'чет', 'пет', 'саб'],
  weekdaysMin: ['нe', 'пo', 'вт', 'ср', 'че', 'пе', 'сa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Денес во] LT',
    'nextDay': '[Утре во] LT',
    'nextWeek': '[Во] dddd [во] LT',
    'lastDay': '[Вчера во] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' и '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: mk_MK
final CarbonLocaleData localeMkMk = localeMk.copyWith(localeCode: 'mk_mk');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  int last2Digits;
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

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'АМ' : 'ПМ';
}

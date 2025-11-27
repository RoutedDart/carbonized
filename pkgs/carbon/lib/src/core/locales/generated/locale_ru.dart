// AUTO-GENERATED from PHP Carbon locale: ru
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRu = CarbonLocaleData(
  localeCode: 'ru',
  translationStrings: {
    'year': ':count год|:count года|:count лет',
    'y': ':count г.|:count г.|:count л.',
    'a_year': '{1}год|:count год|:count года|:count лет',
    'month': ':count месяц|:count месяца|:count месяцев',
    'm': ':count мес.',
    'a_month': '{1}месяц|:count месяц|:count месяца|:count месяцев',
    'week': ':count неделя|:count недели|:count недель',
    'w': ':count нед.',
    'a_week': '{1}неделя|:count неделю|:count недели|:count недель',
    'day': ':count день|:count дня|:count дней',
    'd': ':count д.',
    'a_day': '{1}день|:count день|:count дня|:count дней',
    'hour': ':count час|:count часа|:count часов',
    'h': ':count ч.',
    'a_hour': '{1}час|:count час|:count часа|:count часов',
    'minute': ':count минута|:count минуты|:count минут',
    'min': ':count мин.',
    'a_minute': '{1}минута|:count минута|:count минуты|:count минут',
    'second': ':count секунда|:count секунды|:count секунд',
    's': ':count сек.',
    'a_second':
        '{1}несколько секунд|:count секунду|:count секунды|:count секунд',
    'millisecond':
        '{1}:count миллисекунда|:count миллисекунды|:count миллисекунд',
    'a_millisecond':
        '{1}миллисекунда|:count миллисекунда|:count миллисекунды|:count миллисекунд',
    'ms': ':count мс',
    'microsecond':
        '{1}:count микросекунда|:count микросекунды|:count микросекунд',
    'a_microsecond':
        '{1}микросекунда|:count микросекунда|:count микросекунды|:count микросекунд',
    'ago': ':time назад',
    'from_now': 'через :time',
    'after': ':time после',
    'before': ':time до',
    'diff_now': 'только что',
    'diff_today': 'Сегодня,',
    'diff_today_regexp': 'Сегодня,?(?:\\s+в)?',
    'diff_yesterday': 'вчера',
    'diff_yesterday_regexp': 'Вчера,?(?:\\s+в)?',
    'diff_tomorrow': 'завтра',
    'diff_tomorrow_regexp': 'Завтра,?(?:\\s+в)?',
    'diff_before_yesterday': 'позавчера',
    'diff_after_tomorrow': 'послезавтра',
    'months_regexp': '/(DD?o?\\.?(\\[[^\\[\\]]*\\]|\\s)+MMMM?|L{2,4}|l{2,4})/',
    'weekdays_regexp':
        '/\\[\\s*(В|в)\\s*((?:прошлую|следующую|эту)\\s*)?\\]\\s*dddd/',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D MMMM YYYY г.',
    'LLL': 'D MMMM YYYY г., H:mm',
    'LLLL': 'dddd, D MMMM YYYY г., H:mm',
  },
  months: [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ],
  monthsStandalone: [
    'январь',
    'февраль',
    'март',
    'апрель',
    'май',
    'июнь',
    'июль',
    'август',
    'сентябрь',
    'октябрь',
    'ноябрь',
    'декабрь',
  ],
  monthsShort: [
    'янв',
    'фев',
    'мар',
    'апр',
    'мая',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек',
  ],
  weekdays: [
    'воскресенье',
    'понедельник',
    'вторник',
    'среду',
    'четверг',
    'пятницу',
    'субботу',
  ],
  weekdaysShort: ['вск', 'пнд', 'втр', 'срд', 'чтв', 'птн', 'сбт'],
  weekdaysMin: ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Сегодня, в] LT',
    'nextDay': '[Завтра, в] LT',
    'lastDay': '[Вчера, в] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' и '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ru_BY
final CarbonLocaleData localeRuBy = localeRu.copyWith(localeCode: 'ru_by');

// Regional variant: ru_KG
final CarbonLocaleData localeRuKg = localeRu.copyWith(localeCode: 'ru_kg');

// Regional variant: ru_KZ
final CarbonLocaleData localeRuKz = localeRu.copyWith(localeCode: 'ru_kz');

// Regional variant: ru_MD
final CarbonLocaleData localeRuMd = localeRu.copyWith(localeCode: 'ru_md');

// Regional variant: ru_RU
final CarbonLocaleData localeRuRu = localeRu.copyWith(localeCode: 'ru_ru');

// Regional variant: ru_UA
final CarbonLocaleData localeRuUa = localeRu.copyWith(
  localeCode: 'ru_ua',
  weekdays: [
    'воскресенье',
    'понедельник',
    'вторник',
    'среда',
    'четверг',
    'пятница',
    'суббота',
  ],
  weekdaysShort: ['вск', 'пнд', 'вто', 'срд', 'чтв', 'птн', 'суб'],
  weekdaysMin: ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'су'],
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return ((period == 'M' || period == 'd' || period == 'DDD'
          ? '$number-й'
          : (period == 'D'
                ? '$number-го'
                : (period == 'w' || period == 'W' ? '$number-я' : number))))
      .toString();
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 4) {
    return 'ночи';
  }
  if (hour < 12) {
    return 'утра';
  }
  if (hour < 17) {
    return 'дня';
  }
  return 'вечера';
}

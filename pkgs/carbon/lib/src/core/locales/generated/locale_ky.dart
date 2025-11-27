// AUTO-GENERATED from PHP Carbon locale: ky
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKy = CarbonLocaleData(
  localeCode: 'ky',
  translationStrings: {
    'year': ':count жыл',
    'a_year': '{1}бир жыл|:count жыл',
    'y': ':count жыл',
    'month': ':count ай',
    'a_month': '{1}бир ай|:count ай',
    'm': ':count ай',
    'week': ':count апта',
    'a_week': '{1}бир апта|:count апта',
    'w': ':count апт.',
    'day': ':count күн',
    'a_day': '{1}бир күн|:count күн',
    'd': ':count күн',
    'hour': ':count саат',
    'a_hour': '{1}бир саат|:count саат',
    'h': ':count саат.',
    'minute': ':count мүнөт',
    'a_minute': '{1}бир мүнөт|:count мүнөт',
    'min': ':count мүн.',
    'second': ':count секунд',
    'a_second': '{1}бирнече секунд|:count секунд',
    's': ':count сек.',
    'ago': ':time мурун',
    'from_now': ':time ичинде',
    'diff_now': 'азыр',
    'diff_today': 'Бүгүн',
    'diff_today_regexp': 'Бүгүн(?:\\s+саат)?',
    'diff_yesterday': 'кечээ',
    'diff_yesterday_regexp': 'Кече(?:\\s+саат)?',
    'diff_tomorrow': 'эртең',
    'diff_tomorrow_regexp': 'Эртең(?:\\s+саат)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
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
    'март',
    'апр',
    'май',
    'июнь',
    'июль',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек',
  ],
  weekdays: [
    'Жекшемби',
    'Дүйшөмбү',
    'Шейшемби',
    'Шаршемби',
    'Бейшемби',
    'Жума',
    'Ишемби',
  ],
  weekdaysShort: ['Жек', 'Дүй', 'Шей', 'Шар', 'Бей', 'Жум', 'Ише'],
  weekdaysMin: ['Жк', 'Дй', 'Шй', 'Шр', 'Бй', 'Жм', 'Иш'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Бүгүн саат] LT',
    'nextDay': '[Эртең саат] LT',
    'nextWeek': 'dddd [саат] LT',
    'lastDay': '[Кече саат] LT',
    'lastWeek': '[Өткен аптанын] dddd [күнү] [саат] LT',
    'sameElse': 'L',
  },
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ky_KG
final CarbonLocaleData localeKyKg = localeKy.copyWith(localeCode: 'ky_kg');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  var suffixes = {
    0: '-чү',
    1: '-чи',
    2: '-чи',
    3: '-чү',
    4: '-чү',
    5: '-чи',
    6: '-чы',
    7: '-чи',
    8: '-чи',
    9: '-чу',
    10: '-чу',
    20: '-чы',
    30: '-чу',
    40: '-чы',
    50: '-чү',
    60: '-чы',
    70: '-чи',
    80: '-чи',
    90: '-чу',
    100: '-чү',
  };
  return '$number${suffixes[number] ?? suffixes[number % 10] ?? suffixes[(number >= 100 ? 100 : -1)] ?? ''}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'таңкы' : 'түштөн кийинки';
}

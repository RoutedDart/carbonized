// AUTO-GENERATED from PHP Carbon locale: gl
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGl = CarbonLocaleData(
  localeCode: 'gl',
  translationStrings: {
    'year': ':count ano|:count anos',
    'a_year': 'un ano|:count anos',
    'y': ':count a.',
    'month': ':count mes|:count meses',
    'a_month': 'un mes|:count meses',
    'm': ':count mes.',
    'week': ':count semana|:count semanas',
    'a_week': 'unha semana|:count semanas',
    'w': ':count sem.',
    'day': ':count día|:count días',
    'a_day': 'un día|:count días',
    'd': ':count d.',
    'hour': ':count hora|:count horas',
    'a_hour': 'unha hora|:count horas',
    'h': ':count h.',
    'minute': ':count minuto|:count minutos',
    'a_minute': 'un minuto|:count minutos',
    'min': ':count min.',
    'second': ':count segundo|:count segundos',
    'a_second': 'uns segundos|:count segundos',
    's': ':count seg.',
    'ago': 'hai :time',
    'from_now': 'en :time',
    'diff_now': 'agora',
    'diff_today': 'hoxe',
    'diff_today_regexp': 'hoxe(?:\\s+ás)?',
    'diff_yesterday': 'onte',
    'diff_yesterday_regexp': 'onte(?:\\s+á)?',
    'diff_tomorrow': 'mañá',
    'diff_tomorrow_regexp': 'mañá(?:\\s+ás)?',
    'after': ':time despois',
    'before': ':time antes',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D [de] MMMM [de] YYYY',
    'LLL': 'D [de] MMMM [de] YYYY H:mm',
    'LLLL': 'dddd, D [de] MMMM [de] YYYY H:mm',
  },
  months: [
    'xaneiro',
    'febreiro',
    'marzo',
    'abril',
    'maio',
    'xuño',
    'xullo',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'decembro',
  ],
  monthsShort: [
    'xan.',
    'feb.',
    'mar.',
    'abr.',
    'mai.',
    'xuñ.',
    'xul.',
    'ago.',
    'set.',
    'out.',
    'nov.',
    'dec.',
  ],
  weekdays: [
    'domingo',
    'luns',
    'martes',
    'mércores',
    'xoves',
    'venres',
    'sábado',
  ],
  weekdaysShort: ['dom.', 'lun.', 'mar.', 'mér.', 'xov.', 'ven.', 'sáb.'],
  weekdaysMin: ['do', 'lu', 'ma', 'mé', 'xo', 've', 'sá'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {'sameElse': 'L'},
  listSeparators: [', ', ' e '],
  meridiem: _meridiem,
);

// Regional variant: gl_ES
final CarbonLocaleData localeGlEs = localeGl.copyWith(localeCode: 'gl_es');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'a.m.' : 'p.m.';
}

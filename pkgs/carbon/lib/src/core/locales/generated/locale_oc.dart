// AUTO-GENERATED from PHP Carbon locale: oc
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeOc = CarbonLocaleData(
  localeCode: 'oc',
  translationStrings: {
    'year': ':count an|:count ans',
    'a_year': 'un an|:count ans',
    'y': ':count an|:count ans',
    'month': ':count mes|:count meses',
    'a_month': 'un mes|:count meses',
    'm': ':count mes|:count meses',
    'week': ':count setmana|:count setmanas',
    'a_week': 'una setmana|:count setmanas',
    'w': ':count setmana|:count setmanas',
    'day': ':count jorn|:count jorns',
    'a_day': 'un jorn|:count jorns',
    'd': ':count jorn|:count jorns',
    'hour': ':count ora|:count oras',
    'a_hour': 'una ora|:count oras',
    'h': ':count ora|:count oras',
    'minute': ':count minuta|:count minutas',
    'a_minute': 'una minuta|:count minutas',
    'min': ':count minuta|:count minutas',
    'second': ':count segonda|:count segondas',
    'a_second': 'una segonda|:count segondas',
    's': ':count segonda|:count segondas',
    'ago': 'fa :time',
    'from_now': 'd\'aquí :time',
    'after': ':time aprèp',
    'before': ':time abans',
    'diff_now': 'ara meteis',
    'diff_today': 'Uèi',
    'diff_today_regexp': 'Uèi(?:\\s+a)?',
    'diff_yesterday': 'ièr',
    'diff_yesterday_regexp': 'Ièr(?:\\s+a)?',
    'diff_tomorrow': 'deman',
    'diff_tomorrow_regexp': 'Deman(?:\\s+a)?',
    'diff_before_yesterday': 'ièr delà',
    'diff_after_tomorrow': 'deman passat',
    'period_recurrences': ':count còp|:count còps',
    'period_interval': 'cada :interval',
    'period_start_date': 'de :date',
    'period_end_date': 'fins a :date',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM [de] YYYY',
    'LLL': 'D MMMM [de] YYYY [a] H:mm',
    'LLLL': 'dddd D MMMM [de] YYYY [a] H:mm',
  },
  months: [
    'de genièr',
    'de febrièr',
    'de març',
    'd\'abrial',
    'de mai',
    'de junh',
    'de julhet',
    'd\'agost',
    'de setembre',
    'd’octòbre',
    'de novembre',
    'de decembre',
  ],
  monthsStandalone: [
    'genièr',
    'febrièr',
    'març',
    'abrial',
    'mai',
    'junh',
    'julh',
    'agost',
    'setembre',
    'octòbre',
    'novembre',
    'decembre',
  ],
  monthsShort: [
    'gen.',
    'feb.',
    'març',
    'abr.',
    'mai',
    'junh',
    'julh',
    'ago.',
    'sep.',
    'oct.',
    'nov.',
    'dec.',
  ],
  weekdays: [
    'dimenge',
    'diluns',
    'dimars',
    'dimècres',
    'dijòus',
    'divendres',
    'dissabte',
  ],
  weekdaysShort: ['dg', 'dl', 'dm', 'dc', 'dj', 'dv', 'ds'],
  weekdaysMin: ['dg', 'dl', 'dm', 'dc', 'dj', 'dv', 'ds'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Uèi a] LT',
    'nextDay': '[Deman a] LT',
    'nextWeek': 'dddd [a] LT',
    'lastDay': '[Ièr a] LT',
    'lastWeek': 'dddd [passat a] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' e '],
  periodRecurrences: ':count còp|:count còps',
  periodInterval: 'cada :interval',
  periodStartDate: 'de :date',
  periodEndDate: 'fins a :date',
  ordinal: _ordinal,
);

// Regional variant: oc_FR
final CarbonLocaleData localeOcFr = localeOc.copyWith(localeCode: 'oc_fr');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  String ordinal;
  ordinal = {1: 'èr', 2: 'nd'}[(number).toInt()] ?? 'en';
  if (RegExp(r'/^[wWhHgGis]\$/').hasMatch(period)) {
    ordinal += 'a';
  }
  return '$number$ordinal';
}

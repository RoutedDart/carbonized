// AUTO-GENERATED from PHP Carbon locale: ca
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeCa = CarbonLocaleData(
  localeCode: 'ca',
  translationStrings: {
    'year': ':count any|:count anys',
    'a_year': 'un any|:count anys',
    'y': ':count any|:count anys',
    'month': ':count mes|:count mesos',
    'a_month': 'un mes|:count mesos',
    'm': ':count mes|:count mesos',
    'week': ':count setmana|:count setmanes',
    'a_week': 'una setmana|:count setmanes',
    'w': ':count setmana|:count setmanes',
    'day': ':count dia|:count dies',
    'a_day': 'un dia|:count dies',
    'd': ':count d',
    'hour': ':count hora|:count hores',
    'a_hour': 'una hora|:count hores',
    'h': ':count h',
    'minute': ':count minut|:count minuts',
    'a_minute': 'un minut|:count minuts',
    'min': ':count min',
    'second': ':count segon|:count segons',
    'a_second': 'uns segons|:count segons',
    's': ':count s',
    'ago': 'fa :time',
    'from_now': 'd\'aquí a :time',
    'after': ':time després',
    'before': ':time abans',
    'diff_now': 'ara mateix',
    'diff_today': 'avui',
    'diff_today_regexp': 'avui(?:\\s+a)?(?:\\s+les)?',
    'diff_yesterday': 'ahir',
    'diff_yesterday_regexp': 'ahir(?:\\s+a)?(?:\\s+les)?',
    'diff_tomorrow': 'demà',
    'diff_tomorrow_regexp': 'demà(?:\\s+a)?(?:\\s+les)?',
    'diff_before_yesterday': 'abans d\'ahir',
    'diff_after_tomorrow': 'demà passat',
    'period_recurrences': ':count cop|:count cops',
    'period_interval': 'cada :interval',
    'period_start_date': 'de :date',
    'period_end_date': 'fins a :date',
    'months_regexp': '/(D[oD]?[\\s,]+MMMM?|L{2,4}|l{2,4})/',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM [de] YYYY',
    'LLL': 'D MMMM [de] YYYY [a les] H:mm',
    'LLLL': 'dddd D MMMM [de] YYYY [a les] H:mm',
  },
  months: [
    'de gener',
    'de febrer',
    'de març',
    'd\'abril',
    'de maig',
    'de juny',
    'de juliol',
    'd\'agost',
    'de setembre',
    'd\'octubre',
    'de novembre',
    'de desembre',
  ],
  monthsStandalone: [
    'gener',
    'febrer',
    'març',
    'abril',
    'maig',
    'juny',
    'juliol',
    'agost',
    'setembre',
    'octubre',
    'novembre',
    'desembre',
  ],
  monthsShort: [
    'de gen.',
    'de febr.',
    'de març',
    'd\'abr.',
    'de maig',
    'de juny',
    'de jul.',
    'd\'ag.',
    'de set.',
    'd\'oct.',
    'de nov.',
    'de des.',
  ],
  weekdays: [
    'diumenge',
    'dilluns',
    'dimarts',
    'dimecres',
    'dijous',
    'divendres',
    'dissabte',
  ],
  weekdaysShort: ['dg.', 'dl.', 'dt.', 'dc.', 'dj.', 'dv.', 'ds.'],
  weekdaysMin: ['dg', 'dl', 'dt', 'dc', 'dj', 'dv', 'ds'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {'sameElse': 'L'},
  listSeparators: [', ', ' i '],
  periodRecurrences: ':count cop|:count cops',
  periodInterval: 'cada :interval',
  periodStartDate: 'de :date',
  periodEndDate: 'fins a :date',
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ca_AD
final CarbonLocaleData localeCaAd = localeCa.copyWith(localeCode: 'ca_ad');

// Regional variant: ca_ES
final CarbonLocaleData localeCaEs = localeCa.copyWith(localeCode: 'ca_es');

// Regional variant: ca_ES_Valencia
final CarbonLocaleData localeCaEsValencia = localeCa.copyWith(
  localeCode: 'ca_es_valencia',
);

// Regional variant: ca_FR
final CarbonLocaleData localeCaFr = localeCa.copyWith(localeCode: 'ca_fr');

// Regional variant: ca_IT
final CarbonLocaleData localeCaIt = localeCa.copyWith(localeCode: 'ca_it');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(period == 'w' || period == 'W' ? 'a' : (number == 1 ? 'r' : (number == 2 ? 'n' : (number == 3 ? 'r' : (number == 4 ? 't' : 'è')))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'a. m.' : 'p. m.';
}

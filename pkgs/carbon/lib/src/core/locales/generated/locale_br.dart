// AUTO-GENERATED from PHP Carbon locale: br
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeBr = CarbonLocaleData(
  localeCode: 'br',
  translationStrings: {
    'year': '{1}:count bloaz|{3,4,5,9}:count bloaz|[0,Inf[:count vloaz',
    'a_year': '{1}ur bloaz|{3,4,5,9}:count bloaz|[0,Inf[:count vloaz',
    'month': '{1}:count miz|{2}:count viz|[0,Inf[:count miz',
    'a_month': '{1}ur miz|{2}:count viz|[0,Inf[:count miz',
    'week': ':count sizhun',
    'a_week': '{1}ur sizhun|:count sizhun',
    'day': '{1}:count devezh|{2}:count zevezh|[0,Inf[:count devezh',
    'a_day': '{1}un devezh|{2}:count zevezh|[0,Inf[:count devezh',
    'hour': ':count eur',
    'a_hour': '{1}un eur|:count eur',
    'minute': '{1}:count vunutenn|{2}:count vunutenn|[0,Inf[:count munutenn',
    'a_minute': '{1}ur vunutenn|{2}:count vunutenn|[0,Inf[:count munutenn',
    'second': ':count eilenn',
    'a_second': '{1}un nebeud segondennoù|[0,Inf[:count eilenn',
    'ago': ':time \'zo',
    'from_now': 'a-benn :time',
    'diff_now': 'bremañ',
    'diff_today': 'Hiziv',
    'diff_today_regexp': 'Hiziv(?:\\s+da)?',
    'diff_yesterday': 'decʼh',
    'diff_yesterday_regexp': 'Dec\'h(?:\\s+da)?',
    'diff_tomorrow': 'warcʼhoazh',
    'diff_tomorrow_regexp': 'Warc\'hoazh(?:\\s+da)?',
    'y': ':count bl.',
    'd': ':count d',
    'h': ':count e',
    'min': ':count min',
    's': ':count s',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D [a viz] MMMM YYYY',
    'LLL': 'D [a viz] MMMM YYYY HH:mm',
    'LLLL': 'dddd, D [a viz] MMMM YYYY HH:mm',
  },
  months: [
    'Genver',
    'C\'hwevrer',
    'Meurzh',
    'Ebrel',
    'Mae',
    'Mezheven',
    'Gouere',
    'Eost',
    'Gwengolo',
    'Here',
    'Du',
    'Kerzu',
  ],
  monthsShort: [
    'Gen',
    'C\'hwe',
    'Meu',
    'Ebr',
    'Mae',
    'Eve',
    'Gou',
    'Eos',
    'Gwe',
    'Her',
    'Du',
    'Ker',
  ],
  weekdays: ['Sul', 'Lun', 'Meurzh', 'Merc\'her', 'Yaou', 'Gwener', 'Sadorn'],
  weekdaysShort: ['Sul', 'Lun', 'Meu', 'Mer', 'Yao', 'Gwe', 'Sad'],
  weekdaysMin: ['Su', 'Lu', 'Me', 'Mer', 'Ya', 'Gw', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Hiziv da] LT',
    'nextDay': '[Warc\'hoazh da] LT',
    'nextWeek': 'dddd [da] LT',
    'lastDay': '[Dec\'h da] LT',
    'lastWeek': 'dddd [paset da] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' hag '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: br_FR
final CarbonLocaleData localeBrFr = localeBr.copyWith(localeCode: 'br_fr');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number == 1 ? 'añ' : 'vet')}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'A.M.' : 'G.M.';
}

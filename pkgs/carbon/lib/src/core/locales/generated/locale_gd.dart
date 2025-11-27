// AUTO-GENERATED from PHP Carbon locale: gd
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGd = CarbonLocaleData(
  localeCode: 'gd',
  translationStrings: {
    'year': ':count bliadhna',
    'a_year': '{1}bliadhna|:count bliadhna',
    'y': ':count b.',
    'month': ':count mìosan',
    'a_month': '{1}mìos|:count mìosan',
    'm': ':count ms.',
    'week': ':count seachdainean',
    'a_week': '{1}seachdain|:count seachdainean',
    'w': ':count s.',
    'day': ':count latha',
    'a_day': '{1}latha|:count latha',
    'd': ':count l.',
    'hour': ':count uairean',
    'a_hour': '{1}uair|:count uairean',
    'h': ':count u.',
    'minute': ':count mionaidean',
    'a_minute': '{1}mionaid|:count mionaidean',
    'min': ':count md.',
    'second': ':count diogan',
    'a_second': '{1}beagan diogan|:count diogan',
    's': ':count d.',
    'ago': 'bho chionn :time',
    'from_now': 'ann an :time',
    'diff_yesterday': 'An-dè',
    'diff_yesterday_regexp': 'An-dè(?:\\s+aig)?',
    'diff_today': 'An-diugh',
    'diff_today_regexp': 'An-diugh(?:\\s+aig)?',
    'diff_tomorrow': 'A-màireach',
    'diff_tomorrow_regexp': 'A-màireach(?:\\s+aig)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Am Faoilleach',
    'An Gearran',
    'Am Màrt',
    'An Giblean',
    'An Cèitean',
    'An t-Ògmhios',
    'An t-Iuchar',
    'An Lùnastal',
    'An t-Sultain',
    'An Dàmhair',
    'An t-Samhain',
    'An Dùbhlachd',
  ],
  monthsShort: [
    'Faoi',
    'Gear',
    'Màrt',
    'Gibl',
    'Cèit',
    'Ògmh',
    'Iuch',
    'Lùn',
    'Sult',
    'Dàmh',
    'Samh',
    'Dùbh',
  ],
  weekdays: [
    'Didòmhnaich',
    'Diluain',
    'Dimàirt',
    'Diciadain',
    'Diardaoin',
    'Dihaoine',
    'Disathairne',
  ],
  weekdaysShort: ['Did', 'Dil', 'Dim', 'Dic', 'Dia', 'Dih', 'Dis'],
  weekdaysMin: ['Dò', 'Lu', 'Mà', 'Ci', 'Ar', 'Ha', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[An-diugh aig] LT',
    'nextDay': '[A-màireach aig] LT',
    'nextWeek': 'dddd [aig] LT',
    'lastDay': '[An-dè aig] LT',
    'lastWeek': 'dddd [seo chaidh] [aig] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' agus '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: gd_GB
final CarbonLocaleData localeGdGb = localeGd.copyWith(localeCode: 'gd_gb');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number == 1 ? 'd' : (number % 10 == 2 ? 'na' : 'mh'))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'm' : 'f';
}

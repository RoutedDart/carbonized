// AUTO-GENERATED from PHP Carbon locale: ga
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGa = CarbonLocaleData(
  localeCode: 'ga',
  translationStrings: {
    'year': ':count bliain',
    'a_year': '{1}bliain|:count bliain',
    'y': ':countb',
    'month': ':count mí',
    'a_month': '{1}mí|:count mí',
    'm': ':countm',
    'week': ':count sheachtain',
    'a_week': '{1}sheachtain|:count sheachtain',
    'w': ':countsh',
    'day': ':count lá',
    'a_day': '{1}lá|:count lá',
    'd': ':countl',
    'hour': ':count uair an chloig',
    'a_hour': '{1}uair an chloig|:count uair an chloig',
    'h': ':countu',
    'minute': ':count nóiméad',
    'a_minute': '{1}nóiméad|:count nóiméad',
    'min': ':countn',
    'second': ':count soicind',
    'a_second': '{1}cúpla soicind|:count soicind',
    's': ':countso',
    'ago': ':time ó shin',
    'from_now': 'i :time',
    'after': ':time tar éis',
    'before': ':time roimh',
    'diff_now': 'anois',
    'diff_today': 'Inniu',
    'diff_today_regexp': 'Inniu(?:\\s+ag)?',
    'diff_yesterday': 'inné',
    'diff_yesterday_regexp': 'Inné(?:\\s+aig)?',
    'diff_tomorrow': 'amárach',
    'diff_tomorrow_regexp': 'Amárach(?:\\s+ag)?',
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
    'Eanáir',
    'Feabhra',
    'Márta',
    'Aibreán',
    'Bealtaine',
    'Méitheamh',
    'Iúil',
    'Lúnasa',
    'Meán Fómhair',
    'Deaireadh Fómhair',
    'Samhain',
    'Nollaig',
  ],
  monthsShort: [
    'Eaná',
    'Feab',
    'Márt',
    'Aibr',
    'Beal',
    'Méit',
    'Iúil',
    'Lúna',
    'Meán',
    'Deai',
    'Samh',
    'Noll',
  ],
  weekdays: [
    'Dé Domhnaigh',
    'Dé Luain',
    'Dé Máirt',
    'Dé Céadaoin',
    'Déardaoin',
    'Dé hAoine',
    'Dé Satharn',
  ],
  weekdaysShort: ['Dom', 'Lua', 'Mái', 'Céa', 'Déa', 'hAo', 'Sat'],
  weekdaysMin: ['Do', 'Lu', 'Má', 'Ce', 'Dé', 'hA', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Inniu ag] LT',
    'nextDay': '[Amárach ag] LT',
    'nextWeek': 'dddd [ag] LT',
    'lastDay': '[Inné aig] LT',
    'lastWeek': 'dddd [seo caite] [ag] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' agus '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ga_IE
final CarbonLocaleData localeGaIe = localeGa.copyWith(localeCode: 'ga_ie');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number == 1 ? 'd' : (number % 10 == 2 ? 'na' : 'mh'))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'r.n.' : 'i.n.';
}

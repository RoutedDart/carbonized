// AUTO-GENERATED from PHP Carbon locale: gom
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGom = CarbonLocaleData(
  localeCode: 'gom',
  translationStrings: {
    'year': ':count voros|:count vorsam',
    'y': ':countv',
    'month': ':count mhoino|:count mhoine',
    'm': ':countmh',
    'week': ':count satolleacho|:count satolleache',
    'w': ':countsa|:countsa',
    'day': ':count dis',
    'd': ':countd',
    'hour': ':count hor|:count horam',
    'h': ':counth',
    'minute': ':count minute|:count mintam',
    'min': ':countm',
    'second': ':count second',
    's': ':counts',
    'diff_today': 'Aiz',
    'diff_yesterday': 'Kal',
    'diff_tomorrow': 'Faleam',
  },
  formats: {
    'LT': 'A h:mm [vazta]',
    'LTS': 'A h:mm:ss [vazta]',
    'L': 'DD-MM-YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY A h:mm [vazta]',
    'LLLL': 'dddd, MMMM[achea] Do, YYYY, A h:mm [vazta]',
    'llll': 'ddd, D MMM YYYY, A h:mm [vazta]',
  },
  months: [
    'Janer',
    'Febrer',
    'Mars',
    'Abril',
    'Mai',
    'Jun',
    'Julai',
    'Agost',
    'Setembr',
    'Otubr',
    'Novembr',
    'Dezembr',
  ],
  monthsShort: [
    'Jan.',
    'Feb.',
    'Mars',
    'Abr.',
    'Mai',
    'Jun',
    'Jul.',
    'Ago.',
    'Set.',
    'Otu.',
    'Nov.',
    'Dez.',
  ],
  weekdays: [
    'Aitar',
    'Somar',
    'Mongllar',
    'Budvar',
    'Brestar',
    'Sukrar',
    'Son\'var',
  ],
  weekdaysShort: ['Ait.', 'Som.', 'Mon.', 'Bud.', 'Bre.', 'Suk.', 'Son.'],
  weekdaysMin: ['Ai', 'Sm', 'Mo', 'Bu', 'Br', 'Su', 'Sn'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Aiz] LT',
    'nextDay': '[Faleam] LT',
    'nextWeek': '[Ieta to] dddd[,] LT',
    'lastDay': '[Kal] LT',
    'lastWeek': '[Fatlo] dddd[,] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ani '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: gom_Latn
final CarbonLocaleData localeGomLatn = localeGom.copyWith(
  localeCode: 'gom_latn',
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(period == 'D' ? 'er' : '')}';
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 4) {
    return 'rati';
  }
  if (hour < 12) {
    return 'sokalli';
  }
  if (hour < 16) {
    return 'donparam';
  }
  if (hour < 20) {
    return 'sanje';
  }
  return 'rati';
}

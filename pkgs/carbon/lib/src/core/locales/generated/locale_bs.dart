// AUTO-GENERATED from PHP Carbon locale: bs
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeBs = CarbonLocaleData(
  localeCode: 'bs',
  translationStrings: {
    'year': ':count godina|:count godine|:count godina',
    'y': ':count godina|:count godine|:count godina',
    'month': ':count mjesec|:count mjeseca|:count mjeseci',
    'm': ':count mjesec|:count mjeseca|:count mjeseci',
    'week': ':count sedmica|:count sedmice|:count sedmica',
    'w': ':count sedmica|:count sedmice|:count sedmica',
    'day': ':count dan|:count dana|:count dana',
    'd': ':count dan|:count dana|:count dana',
    'hour': ':count sat|:count sata|:count sati',
    'h': ':count sat|:count sata|:count sati',
    'minute': ':count minut|:count minuta|:count minuta',
    'min': ':count minut|:count minuta|:count minuta',
    'second': ':count sekund|:count sekunda|:count sekundi',
    's': ':count sekund|:count sekunda|:count sekundi',
    'ago': 'prije :time',
    'from_now': 'za :time',
    'after': 'nakon :time',
    'before': ':time ranije',
    'year_ago': ':count godinu|:count godine|:count godina',
    'year_from_now': ':count godinu|:count godine|:count godina',
    'week_ago': ':count sedmicu|:count sedmice|:count sedmica',
    'week_from_now': ':count sedmicu|:count sedmice|:count sedmica',
    'diff_now': 'sada',
    'diff_today': 'danas',
    'diff_today_regexp': 'danas(?:\\s+u)?',
    'diff_yesterday': 'jučer',
    'diff_yesterday_regexp': 'jučer(?:\\s+u)?',
    'diff_tomorrow': 'sutra',
    'diff_tomorrow_regexp': 'sutra(?:\\s+u)?',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY H:mm',
    'LLLL': 'dddd, D. MMMM YYYY H:mm',
  },
  months: [
    'januar',
    'februar',
    'mart',
    'april',
    'maj',
    'juni',
    'juli',
    'august',
    'septembar',
    'oktobar',
    'novembar',
    'decembar',
  ],
  monthsShort: [
    'jan.',
    'feb.',
    'mar.',
    'apr.',
    'maj.',
    'jun.',
    'jul.',
    'aug.',
    'sep.',
    'okt.',
    'nov.',
    'dec.',
  ],
  weekdays: [
    'nedjelja',
    'ponedjeljak',
    'utorak',
    'srijeda',
    'četvrtak',
    'petak',
    'subota',
  ],
  weekdaysShort: ['ned.', 'pon.', 'uto.', 'sri.', 'čet.', 'pet.', 'sub.'],
  weekdaysMin: ['ne', 'po', 'ut', 'sr', 'če', 'pe', 'su'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[danas u] LT',
    'nextDay': '[sutra u] LT',
    'lastDay': '[jučer u] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' i '],
  meridiem: _meridiem,
);

// Regional variant: bs_BA
final CarbonLocaleData localeBsBa = localeBs.copyWith(localeCode: 'bs_ba');

// Regional variant: bs_Cyrl
final CarbonLocaleData localeBsCyrl = localeBs.copyWith(
  localeCode: 'bs_cyrl',
  weekdays: [
    'недјеља',
    'понедјељак',
    'уторак',
    'сриједа',
    'четвртак',
    'петак',
    'субота',
  ],
  weekdaysShort: ['нед', 'пон', 'уто', 'сри', 'чет', 'пет', 'суб'],
  weekdaysMin: ['нед', 'пон', 'уто', 'сри', 'чет', 'пет', 'суб'],
  months: [
    'јануар',
    'фебруар',
    'март',
    'април',
    'мај',
    'јуни',
    'јули',
    'аугуст',
    'септембар',
    'октобар',
    'новембар',
    'децембар',
  ],
  monthsShort: [
    'јан',
    'феб',
    'мар',
    'апр',
    'мај',
    'јун',
    'јул',
    'ауг',
    'сеп',
    'окт',
    'нов',
    'дец',
  ],
);

// Regional variant: bs_Latn
final CarbonLocaleData localeBsLatn = localeBs.copyWith(localeCode: 'bs_latn');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'prijepodne' : 'popodne';
}

// AUTO-GENERATED from PHP Carbon locale: ss
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSs = CarbonLocaleData(
  localeCode: 'ss',
  translationStrings: {
    'year': '{1}umnyaka|:count iminyaka',
    'month': '{1}inyanga|:count tinyanga',
    'week': '{1}:count liviki|:count emaviki',
    'day': '{1}lilanga|:count emalanga',
    'hour': '{1}lihora|:count emahora',
    'minute': '{1}umzuzu|:count emizuzu',
    'second': '{1}emizuzwana lomcane|:count mzuzwana',
    'ago': 'wenteka nga :time',
    'from_now': 'nga :time',
    'diff_yesterday': 'Itolo',
    'diff_yesterday_regexp': 'Itolo(?:\\s+nga)?',
    'diff_today': 'Namuhla',
    'diff_today_regexp': 'Namuhla(?:\\s+nga)?',
    'diff_tomorrow': 'Kusasa',
    'diff_tomorrow_regexp': 'Kusasa(?:\\s+nga)?',
  },
  formats: {
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY h:mm A',
    'LLLL': 'dddd, D MMMM YYYY h:mm A',
  },
  months: [
    'Bhimbidvwane',
    'Indlovana',
    'Indlov\'lenkhulu',
    'Mabasa',
    'Inkhwekhweti',
    'Inhlaba',
    'Kholwane',
    'Ingci',
    'Inyoni',
    'Imphala',
    'Lweti',
    'Ingongoni',
  ],
  monthsShort: [
    'Bhi',
    'Ina',
    'Inu',
    'Mab',
    'Ink',
    'Inh',
    'Kho',
    'Igc',
    'Iny',
    'Imp',
    'Lwe',
    'Igo',
  ],
  weekdays: [
    'Lisontfo',
    'Umsombuluko',
    'Lesibili',
    'Lesitsatfu',
    'Lesine',
    'Lesihlanu',
    'Umgcibelo',
  ],
  weekdaysShort: ['Lis', 'Umb', 'Lsb', 'Les', 'Lsi', 'Lsh', 'Umg'],
  weekdaysMin: ['Li', 'Us', 'Lb', 'Lt', 'Ls', 'Lh', 'Ug'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Namuhla nga] LT',
    'nextDay': '[Kusasa nga] LT',
    'nextWeek': 'dddd [nga] LT',
    'lastDay': '[Itolo nga] LT',
    'lastWeek': 'dddd [leliphelile] [nga] LT',
    'sameElse': 'L',
  },
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ss_ZA
final CarbonLocaleData localeSsZa = localeSs.copyWith(localeCode: 'ss_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'e' : (lastDigit == 1 || lastDigit == 2 ? 'a' : 'e'))}';
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 11) {
    return 'ekuseni';
  }
  if (hour < 15) {
    return 'emini';
  }
  if (hour < 19) {
    return 'entsambama';
  }
  return 'ebusuku';
}

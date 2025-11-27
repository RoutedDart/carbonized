// AUTO-GENERATED from PHP Carbon locale: gsw
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeGsw = CarbonLocaleData(
  localeCode: 'gsw',
  translationStrings: {
    'year': ':count Johr',
    'month': ':count Monet',
    'week': ':count Woche',
    'day': ':count Tag',
    'hour': ':count Schtund',
    'minute': ':count Minute',
    'second': ':count Sekunde',
    'diff_now': 'now',
    'diff_yesterday': 'geschter',
    'diff_tomorrow': 'moorn',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'Do MMMM YYYY',
    'LLL': 'Do MMMM, HH:mm [Uhr]',
    'LLLL': 'dddd, Do MMMM YYYY, HH:mm [Uhr]',
  },
  months: [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'Auguscht',
    'September',
    'Oktober',
    'November',
    'Dezember',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mär',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Dez',
  ],
  weekdays: [
    'Sunntig',
    'Mäntig',
    'Ziischtig',
    'Mittwuch',
    'Dunschtig',
    'Friitig',
    'Samschtig',
  ],
  weekdaysShort: ['Su', 'Mä', 'Zi', 'Mi', 'Du', 'Fr', 'Sa'],
  weekdaysMin: ['Su', 'Mä', 'Zi', 'Mi', 'Du', 'Fr', 'Sa'],
  listSeparators: [', ', ' und '],
  meridiem: _meridiem,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: gsw_CH
final CarbonLocaleData localeGswCh = localeGsw.copyWith(localeCode: 'gsw_ch');

// Regional variant: gsw_FR
final CarbonLocaleData localeGswFr = localeGsw.copyWith(
  localeCode: 'gsw_fr',
  months: [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'Auguscht',
    'Septämber',
    'Oktoober',
    'Novämber',
    'Dezämber',
  ],
);

// Regional variant: gsw_LI
final CarbonLocaleData localeGswLi = localeGsw.copyWith(
  localeCode: 'gsw_li',
  months: [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'Auguscht',
    'Septämber',
    'Oktoober',
    'Novämber',
    'Dezämber',
  ],
);

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'am Vormittag' : 'am Namittag';
}

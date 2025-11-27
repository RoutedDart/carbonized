// AUTO-GENERATED from PHP Carbon locale: lb
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLb = CarbonLocaleData(
  localeCode: 'lb',
  translationStrings: {
    'year': ':count Joer',
    'y': ':countJ',
    'month': ':count Mount|:count Méint',
    'm': ':countMo',
    'week': ':count Woch|:count Wochen',
    'w': ':countWo|:countWo',
    'day': ':count Dag|:count Deeg',
    'd': ':countD',
    'hour': ':count Stonn|:count Stonnen',
    'h': ':countSto',
    'minute': ':count Minutt|:count Minutten',
    'min': ':countM',
    'second': ':count Sekonn|:count Sekonnen',
    's': ':countSek',
    'ago': 'virun :time',
    'from_now': 'an :time',
    'before': ':time virdrun',
    'after': ':time duerno',
    'diff_today': 'Haut',
    'diff_yesterday': 'Gëschter',
    'diff_yesterday_regexp': 'Gëschter(?:\\s+um)?',
    'diff_tomorrow': 'Muer',
    'diff_tomorrow_regexp': 'Muer(?:\\s+um)?',
    'diff_today_regexp': 'Haut(?:\\s+um)?',
  },
  formats: {
    'LT': 'H:mm [Auer]',
    'LTS': 'H:mm:ss [Auer]',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY H:mm [Auer]',
    'LLLL': 'dddd, D. MMMM YYYY H:mm [Auer]',
  },
  months: [
    'Januar',
    'Februar',
    'Mäerz',
    'Abrëll',
    'Mee',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember',
  ],
  monthsShort: [
    'Jan.',
    'Febr.',
    'Mrz.',
    'Abr.',
    'Mee',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sept.',
    'Okt.',
    'Nov.',
    'Dez.',
  ],
  weekdays: [
    'Sonndeg',
    'Méindeg',
    'Dënschdeg',
    'Mëttwoch',
    'Donneschdeg',
    'Freideg',
    'Samschdeg',
  ],
  weekdaysShort: ['So.', 'Mé.', 'Dë.', 'Më.', 'Do.', 'Fr.', 'Sa.'],
  weekdaysMin: ['So', 'Mé', 'Dë', 'Më', 'Do', 'Fr', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Haut um] LT',
    'nextDay': '[Muer um] LT',
    'nextWeek': 'dddd [um] LT',
    'lastDay': '[Gëschter um] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' an '],
  meridiem: _meridiem,
);

// Regional variant: lb_LU
final CarbonLocaleData localeLbLu = localeLb.copyWith(localeCode: 'lb_lu');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'moies' : 'mëttes';
}

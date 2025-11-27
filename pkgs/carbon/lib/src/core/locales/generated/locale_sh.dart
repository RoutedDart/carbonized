// AUTO-GENERATED from PHP Carbon locale: sh
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSh = CarbonLocaleData(
  localeCode: 'sh',
  translationStrings: {
    'diff_now': 'sada',
    'diff_yesterday': 'juče',
    'diff_tomorrow': 'sutra',
    'year': ':count godina|:count godine|:count godina',
    'y': ':count g.',
    'month': ':count mesec|:count meseca|:count meseci',
    'm': ':count m.',
    'week': ':count nedelja|:count nedelje|:count nedelja',
    'w': ':count n.',
    'day': ':count dan|:count dana|:count dana',
    'd': ':count d.',
    'hour': ':count sat|:count sata|:count sati',
    'h': ':count č.',
    'minute': ':count minut|:count minuta|:count minuta',
    'min': ':count min.',
    'second': ':count sekund|:count sekunde|:count sekundi',
    's': ':count s.',
    'ago': 'pre :time',
    'from_now': 'za :time',
    'after': 'nakon :time',
    'before': ':time raniјe',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'DD MMM HH:mm',
    'LLLL': 'MMMM DD, YYYY HH:mm',
  },
  months: [
    'Januar',
    'Februar',
    'Mart',
    'April',
    'Maj',
    'Jun',
    'Jul',
    'Avgust',
    'Septembar',
    'Oktobar',
    'Novembar',
    'Decembar',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Maj',
    'Jun',
    'Jul',
    'Avg',
    'Sep',
    'Okt',
    'Nov',
    'Dec',
  ],
  weekdays: [
    'Nedelja',
    'Ponedeljak',
    'Utorak',
    'Sreda',
    'Četvrtak',
    'Petak',
    'Subota',
  ],
  weekdaysShort: ['Ned', 'Pon', 'Uto', 'Sre', 'Čet', 'Pet', 'Sub'],
  weekdaysMin: ['Ned', 'Pon', 'Uto', 'Sre', 'Čet', 'Pet', 'Sub'],
  listSeparators: [', ', ' i '],
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

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'pre podne' : 'po podne';
}

// AUTO-GENERATED from PHP Carbon locale: af
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAf = CarbonLocaleData(
  localeCode: 'af',
  translationStrings: {
    'year': ':count jaar',
    'a_year': '\'n jaar|:count jaar',
    'y': ':count j.',
    'month': ':count maand|:count maande',
    'a_month': '\'n maand|:count maande',
    'm': ':count maa.',
    'week': ':count week|:count weke',
    'a_week': '\'n week|:count weke',
    'w': ':count w.',
    'day': ':count dag|:count dae',
    'a_day': '\'n dag|:count dae',
    'd': ':count d.',
    'hour': ':count uur',
    'a_hour': '\'n uur|:count uur',
    'h': ':count u.',
    'minute': ':count minuut|:count minute',
    'a_minute': '\'n minuut|:count minute',
    'min': ':count min.',
    'second': ':count sekond|:count sekondes',
    'a_second': '\'n paar sekondes|:count sekondes',
    's': ':count s.',
    'ago': ':time gelede',
    'from_now': 'oor :time',
    'after': ':time na',
    'before': ':time voor',
    'diff_now': 'Nou',
    'diff_today': 'Vandag',
    'diff_today_regexp': 'Vandag(?:\\s+om)?',
    'diff_yesterday': 'Gister',
    'diff_yesterday_regexp': 'Gister(?:\\s+om)?',
    'diff_tomorrow': 'Môre',
    'diff_tomorrow_regexp': 'Môre(?:\\s+om)?',
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
    'Januarie',
    'Februarie',
    'Maart',
    'April',
    'Mei',
    'Junie',
    'Julie',
    'Augustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mrt',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ],
  weekdays: [
    'Sondag',
    'Maandag',
    'Dinsdag',
    'Woensdag',
    'Donderdag',
    'Vrydag',
    'Saterdag',
  ],
  weekdaysShort: ['Son', 'Maa', 'Din', 'Woe', 'Don', 'Vry', 'Sat'],
  weekdaysMin: ['So', 'Ma', 'Di', 'Wo', 'Do', 'Vr', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Vandag om] LT',
    'nextDay': '[Môre om] LT',
    'nextWeek': 'dddd [om] LT',
    'lastDay': '[Gister om] LT',
    'lastWeek': '[Laas] dddd [om] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' en '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: af_NA
final CarbonLocaleData localeAfNa = localeAf.copyWith(
  localeCode: 'af_na',
  weekdaysShort: ['So.', 'Ma.', 'Di.', 'Wo.', 'Do.', 'Vr.', 'Sa.'],
  weekdaysMin: ['So.', 'Ma.', 'Di.', 'Wo.', 'Do.', 'Vr.', 'Sa.'],
  monthsShort: [
    'Jan.',
    'Feb.',
    'Mrt.',
    'Apr.',
    'Mei',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sep.',
    'Okt.',
    'Nov.',
    'Des.',
  ],
);

// Regional variant: af_ZA
final CarbonLocaleData localeAfZa = localeAf.copyWith(localeCode: 'af_za');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number == 1 || number == 8 || number >= 20 ? 'ste' : 'de')}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'VM' : 'NM';
}

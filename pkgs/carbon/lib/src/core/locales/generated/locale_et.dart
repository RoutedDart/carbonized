// AUTO-GENERATED from PHP Carbon locale: et
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeEt = CarbonLocaleData(
  localeCode: 'et',
  translationStrings: {
    'year': ':count aasta|:count aastat',
    'y': ':count a',
    'month': ':count kuu|:count kuud',
    'm': ':count k',
    'week': ':count nädal|:count nädalat',
    'w': ':count näd',
    'day': ':count päev|:count päeva',
    'd': ':count p',
    'hour': ':count tund|:count tundi',
    'h': ':count t',
    'minute': ':count minut|:count minutit',
    'min': ':count min',
    'second': ':count sekund|:count sekundit',
    's': ':count s',
    'ago': ':time tagasi',
    'from_now': ':time pärast',
    'after': ':time pärast',
    'before': ':time enne',
    'year_from_now': ':count aasta',
    'month_from_now': ':count kuu',
    'week_from_now': ':count nädala',
    'day_from_now': ':count päeva',
    'hour_from_now': ':count tunni',
    'minute_from_now': ':count minuti',
    'second_from_now': ':count sekundi',
    'diff_now': 'nüüd',
    'diff_today': 'täna',
    'diff_yesterday': 'eile',
    'diff_tomorrow': 'homme',
    'diff_before_yesterday': 'üleeile',
    'diff_after_tomorrow': 'ülehomme',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY HH:mm',
    'LLLL': 'dddd, D. MMMM YYYY HH:mm',
  },
  months: [
    'jaanuar',
    'veebruar',
    'märts',
    'aprill',
    'mai',
    'juuni',
    'juuli',
    'august',
    'september',
    'oktoober',
    'november',
    'detsember',
  ],
  monthsShort: [
    'jaan',
    'veebr',
    'märts',
    'apr',
    'mai',
    'juuni',
    'juuli',
    'aug',
    'sept',
    'okt',
    'nov',
    'dets',
  ],
  weekdays: [
    'pühapäev',
    'esmaspäev',
    'teisipäev',
    'kolmapäev',
    'neljapäev',
    'reede',
    'laupäev',
  ],
  weekdaysShort: ['P', 'E', 'T', 'K', 'N', 'R', 'L'],
  weekdaysMin: ['P', 'E', 'T', 'K', 'N', 'R', 'L'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[täna] LT',
    'nextDay': '[homme] LT',
    'lastDay': '[eile] LT',
    'nextWeek': 'dddd LT',
    'lastWeek': '[eelmine] dddd LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ja '],
  meridiem: _meridiem,
);

// Regional variant: et_EE
final CarbonLocaleData localeEtEe = localeEt.copyWith(localeCode: 'et_ee');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'enne lõunat' : 'pärast lõunat';
}

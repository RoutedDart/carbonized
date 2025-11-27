// AUTO-GENERATED from PHP Carbon locale: nn
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNn = CarbonLocaleData(
  localeCode: 'nn',
  translationStrings: {
    'year': ':count år',
    'a_year': 'eit år|:count år',
    'y': ':count år',
    'month': ':count månad|:count månader',
    'a_month': 'ein månad|:count månader',
    'm': ':count md',
    'week': ':count veke|:count veker',
    'a_week': 'ei veke|:count veker',
    'w': ':countv',
    'day': ':count dag|:count dagar',
    'a_day': 'ein dag|:count dagar',
    'd': ':countd',
    'hour': ':count time|:count timar',
    'a_hour': 'ein time|:count timar',
    'h': ':countt',
    'minute': ':count minutt',
    'a_minute': 'eit minutt|:count minutt',
    'min': ':countm',
    'second': ':count sekund',
    'a_second': 'nokre sekund|:count sekund',
    's': ':counts',
    'ago': ':time sidan',
    'from_now': 'om :time',
    'after': ':time etter',
    'before': ':time før',
    'diff_today': 'I dag',
    'diff_yesterday': 'I går',
    'diff_yesterday_regexp': 'I går(?:\\s+klokka)?',
    'diff_tomorrow': 'I morgon',
    'diff_tomorrow_regexp': 'I morgon(?:\\s+klokka)?',
    'diff_today_regexp': 'I dag(?:\\s+klokka)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY [kl.] H:mm',
    'LLLL': 'dddd D. MMMM YYYY [kl.] HH:mm',
  },
  months: [
    'januar',
    'februar',
    'mars',
    'april',
    'mai',
    'juni',
    'juli',
    'august',
    'september',
    'oktober',
    'november',
    'desember',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'mai',
    'jun',
    'jul',
    'aug',
    'sep',
    'okt',
    'nov',
    'des',
  ],
  weekdays: [
    'sundag',
    'måndag',
    'tysdag',
    'onsdag',
    'torsdag',
    'fredag',
    'laurdag',
  ],
  weekdaysShort: ['sun', 'mån', 'tys', 'ons', 'tor', 'fre', 'lau'],
  weekdaysMin: ['su', 'må', 'ty', 'on', 'to', 'fr', 'la'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[I dag klokka] LT',
    'nextDay': '[I morgon klokka] LT',
    'nextWeek': 'dddd [klokka] LT',
    'lastDay': '[I går klokka] LT',
    'lastWeek': '[Føregåande] dddd [klokka] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' og '],
  meridiem: _meridiem,
);

// Regional variant: nn_NO
final CarbonLocaleData localeNnNo = localeNn.copyWith(localeCode: 'nn_no');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'f.m.' : 'e.m.';
}

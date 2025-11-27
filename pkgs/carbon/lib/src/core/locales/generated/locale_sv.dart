// AUTO-GENERATED from PHP Carbon locale: sv
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSv = CarbonLocaleData(
  localeCode: 'sv',
  translationStrings: {
    'year': ':count år',
    'a_year': 'ett år|:count år',
    'y': ':count år',
    'month': ':count månad|:count månader',
    'a_month': 'en månad|:count månader',
    'm': ':count mån',
    'week': ':count vecka|:count veckor',
    'a_week': 'en vecka|:count veckor',
    'w': ':count v',
    'day': ':count dag|:count dagar',
    'a_day': 'en dag|:count dagar',
    'd': ':count dgr',
    'hour': ':count timme|:count timmar',
    'a_hour': 'en timme|:count timmar',
    'h': ':count tim',
    'minute': ':count minut|:count minuter',
    'a_minute': 'en minut|:count minuter',
    'min': ':count min',
    'second': ':count sekund|:count sekunder',
    'a_second': 'några sekunder|:count sekunder',
    's': ':count s',
    'ago': 'för :time sedan',
    'from_now': 'om :time',
    'after': ':time efter',
    'before': ':time före',
    'diff_now': 'nu',
    'diff_today': 'I dag',
    'diff_yesterday': 'i går',
    'diff_yesterday_regexp': 'I går',
    'diff_tomorrow': 'i morgon',
    'diff_tomorrow_regexp': 'I morgon',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'YYYY-MM-DD',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY [kl.] HH:mm',
    'LLLL': 'dddd D MMMM YYYY [kl.] HH:mm',
  },
  months: [
    'januari',
    'februari',
    'mars',
    'april',
    'maj',
    'juni',
    'juli',
    'augusti',
    'september',
    'oktober',
    'november',
    'december',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'maj',
    'jun',
    'jul',
    'aug',
    'sep',
    'okt',
    'nov',
    'dec',
  ],
  weekdays: [
    'söndag',
    'måndag',
    'tisdag',
    'onsdag',
    'torsdag',
    'fredag',
    'lördag',
  ],
  weekdaysShort: ['sön', 'mån', 'tis', 'ons', 'tors', 'fre', 'lör'],
  weekdaysMin: ['sö', 'må', 'ti', 'on', 'to', 'fr', 'lö'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[I dag] LT',
    'nextDay': '[I morgon] LT',
    'nextWeek': '[På] dddd LT',
    'lastDay': '[I går] LT',
    'lastWeek': '[I] dddd[s] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' och '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: sv_AX
final CarbonLocaleData localeSvAx = localeSv.copyWith(localeCode: 'sv_ax');

// Regional variant: sv_FI
final CarbonLocaleData localeSvFi = localeSv.copyWith(localeCode: 'sv_fi');

// Regional variant: sv_SE
final CarbonLocaleData localeSvSe = localeSv.copyWith(localeCode: 'sv_se');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'e' : (lastDigit == 1 || lastDigit == 2 ? 'a' : 'e'))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'fm' : 'em';
}

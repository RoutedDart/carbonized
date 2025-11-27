// AUTO-GENERATED from PHP Carbon locale: nl
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNl = CarbonLocaleData(
  localeCode: 'nl',
  translationStrings: {
    'year': ':count jaar|:count jaar',
    'a_year': 'een jaar|:count jaar',
    'y': ':countj',
    'month': ':count maand|:count maanden',
    'a_month': 'een maand|:count maanden',
    'm': ':countmnd',
    'week': ':count week|:count weken',
    'a_week': 'een week|:count weken',
    'w': ':countw',
    'day': ':count dag|:count dagen',
    'a_day': 'een dag|:count dagen',
    'd': ':countd',
    'hour': ':count uur|:count uur',
    'a_hour': 'een uur|:count uur',
    'h': ':countu',
    'minute': ':count minuut|:count minuten',
    'a_minute': 'een minuut|:count minuten',
    'min': ':countmin',
    'second': ':count seconde|:count seconden',
    'a_second': 'een paar seconden|:count seconden',
    's': ':counts',
    'ago': ':time geleden',
    'from_now': 'over :time',
    'after': ':time later',
    'before': ':time eerder',
    'diff_now': 'nu',
    'diff_today': 'vandaag',
    'diff_today_regexp': 'vandaag(?:\\s+om)?',
    'diff_yesterday': 'gisteren',
    'diff_yesterday_regexp': 'gisteren(?:\\s+om)?',
    'diff_tomorrow': 'morgen',
    'diff_tomorrow_regexp': 'morgen(?:\\s+om)?',
    'diff_after_tomorrow': 'overmorgen',
    'diff_before_yesterday': 'eergisteren',
    'period_recurrences': ':count keer',
    'period_start_date': 'van :date',
    'period_end_date': 'tot :date',
    'mmm_suffix': '.',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD-MM-YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'januari',
    'februari',
    'maart',
    'april',
    'mei',
    'juni',
    'juli',
    'augustus',
    'september',
    'oktober',
    'november',
    'december',
  ],
  monthsShort: [
    'jan.',
    'feb.',
    'mrt.',
    'apr.',
    'mei.',
    'jun.',
    'jul.',
    'aug.',
    'sep.',
    'okt.',
    'nov.',
    'dec.',
  ],
  weekdays: [
    'zondag',
    'maandag',
    'dinsdag',
    'woensdag',
    'donderdag',
    'vrijdag',
    'zaterdag',
  ],
  weekdaysShort: ['zo.', 'ma.', 'di.', 'wo.', 'do.', 'vr.', 'za.'],
  weekdaysMin: ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[vandaag om] LT',
    'nextDay': '[morgen om] LT',
    'nextWeek': 'dddd [om] LT',
    'lastDay': '[gisteren om] LT',
    'lastWeek': '[afgelopen] dddd [om] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' en '],
  periodRecurrences: ':count keer',
  periodStartDate: 'van :date',
  periodEndDate: 'tot :date',
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: nl_AW
final CarbonLocaleData localeNlAw = localeNl.copyWith(
  localeCode: 'nl_aw',
  weekdaysShort: ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'],
);

// Regional variant: nl_BE
final CarbonLocaleData localeNlBe = localeNl.copyWith(localeCode: 'nl_be');

// Regional variant: nl_BQ
final CarbonLocaleData localeNlBq = localeNl.copyWith(localeCode: 'nl_bq');

// Regional variant: nl_CW
final CarbonLocaleData localeNlCw = localeNl.copyWith(localeCode: 'nl_cw');

// Regional variant: nl_NL
final CarbonLocaleData localeNlNl = localeNl.copyWith(
  localeCode: 'nl_nl',
  weekdaysShort: ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'],
);

// Regional variant: nl_SR
final CarbonLocaleData localeNlSr = localeNl.copyWith(localeCode: 'nl_sr');

// Regional variant: nl_SX
final CarbonLocaleData localeNlSx = localeNl.copyWith(localeCode: 'nl_sx');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number == 1 || number == 8 || number >= 20 ? 'ste' : 'de')}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? '\'s ochtends' : '\'s middags';
}

// AUTO-GENERATED from PHP Carbon locale: ro
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeRo = CarbonLocaleData(
  localeCode: 'ro',
  translationStrings: {
    'year': ':count an|:count ani|:count ani',
    'a_year': 'un an|:count ani|:count ani',
    'y': ':count a.',
    'month': ':count lună|:count luni|:count luni',
    'a_month': 'o lună|:count luni|:count luni',
    'm': ':count l.',
    'week': ':count săptămână|:count săptămâni|:count săptămâni',
    'a_week': 'o săptămână|:count săptămâni|:count săptămâni',
    'w': ':count săp.',
    'day': ':count zi|:count zile|:count zile',
    'a_day': 'o zi|:count zile|:count zile',
    'd': ':count z.',
    'hour': ':count oră|:count ore|:count ore',
    'a_hour': 'o oră|:count ore|:count ore',
    'h': ':count o.',
    'minute': ':count minut|:count minute|:count minute',
    'a_minute': 'un minut|:count minute|:count minute',
    'min': ':count m.',
    'second': ':count secundă|:count secunde|:count secunde',
    'a_second': 'câteva secunde|:count secunde|:count secunde',
    's': ':count sec.',
    'ago': ':time în urmă',
    'from_now': 'peste :time',
    'after': 'peste :time',
    'before': 'acum :time',
    'diff_now': 'acum',
    'diff_today': 'azi',
    'diff_today_regexp': 'azi(?:\\s+la)?',
    'diff_yesterday': 'ieri',
    'diff_yesterday_regexp': 'ieri(?:\\s+la)?',
    'diff_tomorrow': 'mâine',
    'diff_tomorrow_regexp': 'mâine(?:\\s+la)?',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY H:mm',
    'LLLL': 'dddd, D MMMM YYYY H:mm',
  },
  months: [
    'ianuarie',
    'februarie',
    'martie',
    'aprilie',
    'mai',
    'iunie',
    'iulie',
    'august',
    'septembrie',
    'octombrie',
    'noiembrie',
    'decembrie',
  ],
  monthsShort: [
    'ian.',
    'feb.',
    'mar.',
    'apr.',
    'mai',
    'iun.',
    'iul.',
    'aug.',
    'sept.',
    'oct.',
    'nov.',
    'dec.',
  ],
  weekdays: [
    'duminică',
    'luni',
    'marți',
    'miercuri',
    'joi',
    'vineri',
    'sâmbătă',
  ],
  weekdaysShort: ['dum', 'lun', 'mar', 'mie', 'joi', 'vin', 'sâm'],
  weekdaysMin: ['du', 'lu', 'ma', 'mi', 'jo', 'vi', 'sâ'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[azi la] LT',
    'nextDay': '[mâine la] LT',
    'nextWeek': 'dddd [la] LT',
    'lastDay': '[ieri la] LT',
    'lastWeek': '[fosta] dddd [la] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' și '],
  meridiem: _meridiem,
);

// Regional variant: ro_MD
final CarbonLocaleData localeRoMd = localeRo.copyWith(localeCode: 'ro_md');

// Regional variant: ro_RO
final CarbonLocaleData localeRoRo = localeRo.copyWith(localeCode: 'ro_ro');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'a.m.' : 'p.m.';
}

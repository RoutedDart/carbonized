// AUTO-GENERATED from PHP Carbon locale: fo
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeFo = CarbonLocaleData(
  localeCode: 'fo',
  translationStrings: {
    'year': 'eitt ár|:count ár',
    'y': ':count ár|:count ár',
    'month': 'ein mánaði|:count mánaðir',
    'm': ':count mánaður|:count mánaðir',
    'week': ':count vika|:count vikur',
    'w': ':count vika|:count vikur',
    'day': 'ein dagur|:count dagar',
    'd': ':count dag|:count dagar',
    'hour': 'ein tími|:count tímar',
    'h': ':count tími|:count tímar',
    'minute': 'ein minutt|:count minuttir',
    'min': ':count minutt|:count minuttir',
    'second': 'fá sekund|:count sekundir',
    's': ':count sekund|:count sekundir',
    'ago': ':time síðani',
    'from_now': 'um :time',
    'after': ':time aftaná',
    'before': ':time áðrenn',
    'diff_today': 'Í',
    'diff_yesterday': 'Í',
    'diff_yesterday_regexp': 'Í(?:\\s+gjár)?(?:\\s+kl.)?',
    'diff_tomorrow': 'Í',
    'diff_tomorrow_regexp': 'Í(?:\\s+morgin)?(?:\\s+kl.)?',
    'diff_today_regexp': 'Í(?:\\s+dag)?(?:\\s+kl.)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D. MMMM, YYYY HH:mm',
  },
  months: [
    'januar',
    'februar',
    'mars',
    'apríl',
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
    'sunnudagur',
    'mánadagur',
    'týsdagur',
    'mikudagur',
    'hósdagur',
    'fríggjadagur',
    'leygardagur',
  ],
  weekdaysShort: ['sun', 'mán', 'týs', 'mik', 'hós', 'frí', 'ley'],
  weekdaysMin: ['su', 'má', 'tý', 'mi', 'hó', 'fr', 'le'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Í dag kl.] LT',
    'nextDay': '[Í morgin kl.] LT',
    'nextWeek': 'dddd [kl.] LT',
    'lastDay': '[Í gjár kl.] LT',
    'lastWeek': '[síðstu] dddd [kl] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' og '],
);

// Regional variant: fo_DK
final CarbonLocaleData localeFoDk = localeFo.copyWith(localeCode: 'fo_dk');

// Regional variant: fo_FO
final CarbonLocaleData localeFoFo = localeFo.copyWith(localeCode: 'fo_fo');

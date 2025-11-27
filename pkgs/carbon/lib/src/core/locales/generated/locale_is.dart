// AUTO-GENERATED from PHP Carbon locale: is
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIs = CarbonLocaleData(
  localeCode: 'is',
  translationStrings: {
    'year': '1 ár|:count ár',
    'y': '1 ár|:count ár',
    'month': '1 mánuður|:count mánuðir',
    'm': '1 mánuður|:count mánuðir',
    'week': '1 vika|:count vikur',
    'w': '1 vika|:count vikur',
    'day': '1 dagur|:count dagar',
    'd': '1 dagur|:count dagar',
    'hour': '1 klukkutími|:count klukkutímar',
    'h': '1 klukkutími|:count klukkutímar',
    'minute': '1 mínúta|:count mínútur',
    'min': '1 mínúta|:count mínútur',
    'second': '1 sekúnda|:count sekúndur',
    's': '1 sekúnda|:count sekúndur',
    'ago': ':time síðan',
    'from_now': ':time síðan',
    'after': ':time eftir',
    'before': ':time fyrir',
    'diff_now': 'núna',
    'diff_yesterday': 'í gær',
    'diff_tomorrow': 'á morgun',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM [kl.] HH:mm',
    'LLLL': 'dddd D. MMMM YYYY [kl.] HH:mm',
  },
  months: [
    'janúar',
    'febrúar',
    'mars',
    'apríl',
    'maí',
    'júní',
    'júlí',
    'ágúst',
    'september',
    'október',
    'nóvember',
    'desember',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'maí',
    'jún',
    'júl',
    'ágú',
    'sep',
    'okt',
    'nóv',
    'des',
  ],
  weekdays: [
    'sunnudaginn',
    'mánudaginn',
    'þriðjudaginn',
    'miðvikudaginn',
    'fimmtudaginn',
    'föstudaginn',
    'laugardaginn',
  ],
  weekdaysShort: ['sun', 'mán', 'þri', 'mið', 'fim', 'fös', 'lau'],
  weekdaysMin: ['sun', 'mán', 'þri', 'mið', 'fim', 'fös', 'lau'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  listSeparators: [', ', ' og '],
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

// Regional variant: is_IS
final CarbonLocaleData localeIsIs = localeIs.copyWith(localeCode: 'is_is');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'fh' : 'eh';
}

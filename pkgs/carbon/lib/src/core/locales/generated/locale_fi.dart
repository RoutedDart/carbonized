// AUTO-GENERATED from PHP Carbon locale: fi
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeFi = CarbonLocaleData(
  localeCode: 'fi',
  translationStrings: {
    'year': ':count vuosi|:count vuotta',
    'y': ':count v',
    'month': ':count kuukausi|:count kuukautta',
    'm': ':count kk',
    'week': ':count viikko|:count viikkoa',
    'w': ':count vk',
    'day': ':count päivä|:count päivää',
    'd': ':count pv',
    'hour': ':count tunti|:count tuntia',
    'h': ':count t',
    'minute': ':count minuutti|:count minuuttia',
    'min': ':count min',
    'second': ':count sekunti|:count sekuntia',
    'a_second': 'muutama sekunti|:count sekuntia',
    's': ':count s',
    'ago': ':time sitten',
    'from_now': ':time päästä',
    'year_from_now': ':count vuoden',
    'month_from_now': ':count kuukauden',
    'week_from_now': ':count viikon',
    'day_from_now': ':count päivän',
    'hour_from_now': ':count tunnin',
    'minute_from_now': ':count minuutin',
    'second_from_now': ':count sekunnin',
    'after': ':time sen jälkeen',
    'before': ':time ennen',
    'diff_now': 'nyt',
    'diff_yesterday': 'eilen',
    'diff_tomorrow': 'huomenna',
  },
  formats: {
    'LT': 'HH.mm',
    'LTS': 'HH.mm:ss',
    'L': 'D.M.YYYY',
    'LL': 'dddd D. MMMM[ta] YYYY',
    'll': 'ddd D. MMM YYYY',
    'LLL': 'D.MM. HH.mm',
    'LLLL': 'D. MMMM[ta] YYYY HH.mm',
    'llll': 'D. MMM YY HH.mm',
  },
  months: [
    'tammikuu',
    'helmikuu',
    'maaliskuu',
    'huhtikuu',
    'toukokuu',
    'kesäkuu',
    'heinäkuu',
    'elokuu',
    'syyskuu',
    'lokakuu',
    'marraskuu',
    'joulukuu',
  ],
  monthsShort: [
    'tammi',
    'helmi',
    'maalis',
    'huhti',
    'touko',
    'kesä',
    'heinä',
    'elo',
    'syys',
    'loka',
    'marras',
    'joulu',
  ],
  weekdays: [
    'sunnuntai',
    'maanantai',
    'tiistai',
    'keskiviikko',
    'torstai',
    'perjantai',
    'lauantai',
  ],
  weekdaysShort: ['su', 'ma', 'ti', 'ke', 'to', 'pe', 'la'],
  weekdaysMin: ['su', 'ma', 'ti', 'ke', 'to', 'pe', 'la'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  listSeparators: [', ', ' ja '],
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

// Regional variant: fi_FI
final CarbonLocaleData localeFiFi = localeFi.copyWith(localeCode: 'fi_fi');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'aamupäivä' : 'iltapäivä';
}

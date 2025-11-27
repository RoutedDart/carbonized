// AUTO-GENERATED from PHP Carbon locale: teo
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTeo = CarbonLocaleData(
  localeCode: 'teo',
  translationStrings: {
    'year': ':count வருடம்|:count ஆண்டுகள்',
    'a_year': 'ஒரு வருடம்|:count ஆண்டுகள்',
    'y': ':count வருட.|:count ஆண்.',
    'month': ':count மாதம்|:count மாதங்கள்',
    'a_month': 'ஒரு மாதம்|:count மாதங்கள்',
    'm': ':count மாத.',
    'week': ':count வாரம்|:count வாரங்கள்',
    'a_week': 'ஒரு வாரம்|:count வாரங்கள்',
    'w': ':count வார.',
    'day': ':count நாள்|:count நாட்கள்',
    'a_day': 'ஒரு நாள்|:count நாட்கள்',
    'd': ':count நாள்|:count நாட்.',
    'hour': ':count மணி நேரம்|:count மணி நேரம்',
    'a_hour': 'ஒரு மணி நேரம்|:count மணி நேரம்',
    'h': ':count மணி.',
    'minute': ':count நிமிடம்|:count நிமிடங்கள்',
    'a_minute': 'ஒரு நிமிடம்|:count நிமிடங்கள்',
    'min': ':count நிமி.',
    'second': ':count சில விநாடிகள்|:count விநாடிகள்',
    'a_second': 'ஒரு சில விநாடிகள்|:count விநாடிகள்',
    's': ':count விநா.',
    'ago': ':time முன்',
    'from_now': ':time இல்',
    'before': ':time முன்',
    'after': ':time பின்',
    'diff_now': 'இப்போது',
    'diff_today': 'இன்று',
    'diff_yesterday': 'நேற்று',
    'diff_tomorrow': 'நாளை',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Orara',
    'Omuk',
    'Okwamg’',
    'Odung’el',
    'Omaruk',
    'Omodok’king’ol',
    'Ojola',
    'Opedel',
    'Osokosokoma',
    'Otibar',
    'Olabor',
    'Opoo',
  ],
  monthsShort: [
    'Rar',
    'Muk',
    'Kwa',
    'Dun',
    'Mar',
    'Mod',
    'Jol',
    'Ped',
    'Sok',
    'Tib',
    'Lab',
    'Poo',
  ],
  weekdays: [
    'Nakaejuma',
    'Nakaebarasa',
    'Nakaare',
    'Nakauni',
    'Nakaung’on',
    'Nakakany',
    'Nakasabiti',
  ],
  weekdaysShort: ['Jum', 'Bar', 'Aar', 'Uni', 'Ung', 'Kan', 'Sab'],
  weekdaysMin: ['Jum', 'Bar', 'Aar', 'Uni', 'Ung', 'Kan', 'Sab'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[இன்று] LT',
    'nextDay': '[நாளை] LT',
    'nextWeek': 'dddd, LT',
    'lastDay': '[நேற்று] LT',
    'lastWeek': '[கடந்த வாரம்] dddd, LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' மற்றும் '],
  meridiem: _meridiem,
);

// Regional variant: teo_KE
final CarbonLocaleData localeTeoKe = localeTeo.copyWith(localeCode: 'teo_ke');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'Taparachu' : 'Ebongi';
}

// AUTO-GENERATED from PHP Carbon locale: tr
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeTr = CarbonLocaleData(
  localeCode: 'tr',
  translationStrings: {
    'year': ':count yıl',
    'a_year': '{1}bir yıl|[-Inf,Inf]:count yıl',
    'y': ':county',
    'month': ':count ay',
    'a_month': '{1}bir ay|[-Inf,Inf]:count ay',
    'm': ':countay',
    'week': ':count hafta',
    'a_week': '{1}bir hafta|[-Inf,Inf]:count hafta',
    'w': ':counth',
    'day': ':count gün',
    'a_day': '{1}bir gün|[-Inf,Inf]:count gün',
    'd': ':countg',
    'hour': ':count saat',
    'a_hour': '{1}bir saat|[-Inf,Inf]:count saat',
    'h': ':countsa',
    'minute': ':count dakika',
    'a_minute': '{1}bir dakika|[-Inf,Inf]:count dakika',
    'min': ':countdk',
    'second': ':count saniye',
    'a_second': '{1}birkaç saniye|[-Inf,Inf]:count saniye',
    's': ':countsn',
    'ago': ':time önce',
    'from_now': ':time sonra',
    'after': ':time sonra',
    'before': ':time önce',
    'diff_now': 'şimdi',
    'diff_today': 'bugün',
    'diff_today_regexp': 'bugün(?:\\s+saat)?',
    'diff_yesterday': 'dün',
    'diff_tomorrow': 'yarın',
    'diff_tomorrow_regexp': 'yarın(?:\\s+saat)?',
    'diff_before_yesterday': 'evvelsi gün',
    'diff_after_tomorrow': 'öbür gün',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ],
  monthsShort: [
    'Oca',
    'Şub',
    'Mar',
    'Nis',
    'May',
    'Haz',
    'Tem',
    'Ağu',
    'Eyl',
    'Eki',
    'Kas',
    'Ara',
  ],
  weekdays: [
    'Pazar',
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
  ],
  weekdaysShort: ['Paz', 'Pts', 'Sal', 'Çar', 'Per', 'Cum', 'Cts'],
  weekdaysMin: ['Pz', 'Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[bugün saat] LT',
    'nextDay': '[yarın saat] LT',
    'nextWeek': '[gelecek] dddd [saat] LT',
    'lastDay': '[dün] LT',
    'lastWeek': '[geçen] dddd [saat] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ve '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: tr_CY
final CarbonLocaleData localeTrCy = localeTr.copyWith(
  localeCode: 'tr_cy',
  weekdaysShort: ['Paz', 'Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt'],
  weekdaysMin: ['Pa', 'Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct'],
);

// Regional variant: tr_TR
final CarbonLocaleData localeTrTr = localeTr.copyWith(localeCode: 'tr_tr');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  switch (period) {
    case 'd':
    case 'D':
    case 'Do':
    case 'DD':
      return (number).toString();
    default:
      if (number == 0) {
        return '$number\'ıncı';
      }
      var suffixes = {
        1: '\'inci',
        5: '\'inci',
        8: '\'inci',
        70: '\'inci',
        80: '\'inci',
        2: '\'nci',
        7: '\'nci',
        20: '\'nci',
        50: '\'nci',
        3: '\'üncü',
        4: '\'üncü',
        100: '\'üncü',
        6: '\'ncı',
        9: '\'uncu',
        10: '\'uncu',
        30: '\'uncu',
        60: '\'ıncı',
        90: '\'ıncı',
      };
      lastDigit = number % 10;
      return '$number${suffixes[lastDigit] ?? suffixes[number % 100 - lastDigit] ?? suffixes[(number >= 100 ? 100 : -1)] ?? ''}';
  }
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ÖÖ' : 'ÖS';
}

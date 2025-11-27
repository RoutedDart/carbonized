// AUTO-GENERATED from PHP Carbon locale: jv
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeJv = CarbonLocaleData(
  localeCode: 'jv',
  translationStrings: {
    'year': ':count taun',
    'a_year': '{1}setaun|[-Inf,Inf]:count taun',
    'month': ':count wulan',
    'a_month': '{1}sewulan|[-Inf,Inf]:count wulan',
    'week': ':count minggu',
    'a_week': '{1}sakminggu|[-Inf,Inf]:count minggu',
    'day': ':count dina',
    'a_day': '{1}sedina|[-Inf,Inf]:count dina',
    'hour': ':count jam',
    'a_hour': '{1}setunggal jam|[-Inf,Inf]:count jam',
    'minute': ':count menit',
    'a_minute': '{1}setunggal menit|[-Inf,Inf]:count menit',
    'second': ':count detik',
    'a_second': '{0,1}sawetawis detik|[-Inf,Inf]:count detik',
    'ago': ':time ingkang kepengker',
    'from_now': 'wonten ing :time',
    'diff_today': 'Dinten',
    'diff_yesterday': 'Kala',
    'diff_yesterday_regexp': 'Kala(?:\\s+wingi)?(?:\\s+pukul)?',
    'diff_tomorrow': 'Mbenjang',
    'diff_tomorrow_regexp': 'Mbenjang(?:\\s+pukul)?',
    'diff_today_regexp': 'Dinten(?:\\s+puniko)?(?:\\s+pukul)?',
  },
  formats: {
    'LT': 'HH.mm',
    'LTS': 'HH.mm.ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY [pukul] HH.mm',
    'LLLL': 'dddd, D MMMM YYYY [pukul] HH.mm',
  },
  months: [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'Nopember',
    'Desember',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ags',
    'Sep',
    'Okt',
    'Nop',
    'Des',
  ],
  weekdays: ['Minggu', 'Senen', 'Seloso', 'Rebu', 'Kemis', 'Jemuwah', 'Septu'],
  weekdaysShort: ['Min', 'Sen', 'Sel', 'Reb', 'Kem', 'Jem', 'Sep'],
  weekdaysMin: ['Mg', 'Sn', 'Sl', 'Rb', 'Km', 'Jm', 'Sp'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Dinten puniko pukul] LT',
    'nextDay': '[Mbenjang pukul] LT',
    'nextWeek': 'dddd [pukul] LT',
    'lastDay': '[Kala wingi pukul] LT',
    'lastWeek': 'dddd [kepengker pukul] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' lan '],
  meridiem: _meridiem,
);

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 11) {
    return 'enjing';
  }
  if (hour < 15) {
    return 'siyang';
  }
  if (hour < 19) {
    return 'sonten';
  }
  return 'ndalu';
}

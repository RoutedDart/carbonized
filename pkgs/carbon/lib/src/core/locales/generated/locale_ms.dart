// AUTO-GENERATED from PHP Carbon locale: ms
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMs = CarbonLocaleData(
  localeCode: 'ms',
  translationStrings: {
    'year': ':count tahun',
    'a_year': '{1}setahun|[-Inf,Inf]:count tahun',
    'y': ':count tahun',
    'month': ':count bulan',
    'a_month': '{1}sebulan|[-Inf,Inf]:count bulan',
    'm': ':count bulan',
    'week': ':count minggu',
    'a_week': '{1}seminggu|[-Inf,Inf]:count minggu',
    'w': ':count minggu',
    'day': ':count hari',
    'a_day': '{1}sehari|[-Inf,Inf]:count hari',
    'd': ':count hari',
    'hour': ':count jam',
    'a_hour': '{1}sejam|[-Inf,Inf]:count jam',
    'h': ':count jam',
    'minute': ':count minit',
    'a_minute': '{1}seminit|[-Inf,Inf]:count minit',
    'min': ':count minit',
    'second': ':count saat',
    'a_second': '{1}beberapa saat|[-Inf,Inf]:count saat',
    'millisecond': ':count milisaat',
    'a_millisecond': '{1}semilisaat|[-Inf,Inf]:count milliseconds',
    'microsecond': ':count mikrodetik',
    'a_microsecond': '{1}semikrodetik|[-Inf,Inf]:count mikrodetik',
    's': ':count saat',
    'ago': ':time yang lepas',
    'from_now': ':time dari sekarang',
    'after': ':time kemudian',
    'before': ':time sebelum',
    'diff_now': 'sekarang',
    'diff_today': 'Hari',
    'diff_today_regexp': 'Hari(?:\\s+ini)?(?:\\s+pukul)?',
    'diff_yesterday': 'semalam',
    'diff_yesterday_regexp': 'Semalam(?:\\s+pukul)?',
    'diff_tomorrow': 'esok',
    'diff_tomorrow_regexp': 'Esok(?:\\s+pukul)?',
    'diff_before_yesterday': 'kelmarin',
    'diff_after_tomorrow': 'lusa',
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
    'Mac',
    'April',
    'Mei',
    'Jun',
    'Julai',
    'Ogos',
    'September',
    'Oktober',
    'November',
    'Disember',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mac',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ogs',
    'Sep',
    'Okt',
    'Nov',
    'Dis',
  ],
  weekdays: ['Ahad', 'Isnin', 'Selasa', 'Rabu', 'Khamis', 'Jumaat', 'Sabtu'],
  weekdaysShort: ['Ahd', 'Isn', 'Sel', 'Rab', 'Kha', 'Jum', 'Sab'],
  weekdaysMin: ['Ah', 'Is', 'Sl', 'Rb', 'Km', 'Jm', 'Sb'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Hari ini pukul] LT',
    'nextDay': '[Esok pukul] LT',
    'nextWeek': 'dddd [pukul] LT',
    'lastDay': '[Kelmarin pukul] LT',
    'lastWeek': 'dddd [lepas pukul] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' dan '],
  meridiem: _meridiem,
);

// Regional variant: ms_BN
final CarbonLocaleData localeMsBn = localeMs.copyWith(localeCode: 'ms_bn');

// Regional variant: ms_MY
final CarbonLocaleData localeMsMy = localeMs.copyWith(localeCode: 'ms_my');

// Regional variant: ms_SG
final CarbonLocaleData localeMsSg = localeMs.copyWith(localeCode: 'ms_sg');

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 1) {
    return 'tengah malam';
  }
  if (hour < 12) {
    return 'pagi';
  }
  if (hour < 13) {
    return 'tengah hari';
  }
  if (hour < 19) {
    return 'petang';
  }
  return 'malam';
}

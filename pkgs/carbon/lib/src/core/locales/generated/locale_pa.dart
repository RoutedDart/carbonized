// AUTO-GENERATED from PHP Carbon locale: pa
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localePa = CarbonLocaleData(
  localeCode: 'pa',
  translationStrings: {
    'year': 'ਇੱਕ ਸਾਲ|:count ਸਾਲ',
    'month': 'ਇੱਕ ਮਹੀਨਾ|:count ਮਹੀਨੇ',
    'week': 'ਹਫਤਾ|:count ਹਫ਼ਤੇ',
    'day': 'ਇੱਕ ਦਿਨ|:count ਦਿਨ',
    'hour': 'ਇੱਕ ਘੰਟਾ|:count ਘੰਟੇ',
    'minute': 'ਇਕ ਮਿੰਟ|:count ਮਿੰਟ',
    'second': 'ਕੁਝ ਸਕਿੰਟ|:count ਸਕਿੰਟ',
    'ago': ':time ਪਹਿਲਾਂ',
    'from_now': ':time ਵਿੱਚ',
    'before': ':time ਤੋਂ ਪਹਿਲਾਂ',
    'after': ':time ਤੋਂ ਬਾਅਦ',
    'diff_now': 'ਹੁਣ',
    'diff_today': 'ਅਜ',
    'diff_yesterday': 'ਕਲ',
    'diff_tomorrow': 'ਕਲ',
  },
  formats: {
    'LT': 'A h:mm ਵਜੇ',
    'LTS': 'A h:mm:ss ਵਜੇ',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY, A h:mm ਵਜੇ',
    'LLLL': 'dddd, D MMMM YYYY, A h:mm ਵਜੇ',
  },
  months: [
    'ਜਨਵਰੀ',
    'ਫ਼ਰਵਰੀ',
    'ਮਾਰਚ',
    'ਅਪ੍ਰੈਲ',
    'ਮਈ',
    'ਜੂਨ',
    'ਜੁਲਾਈ',
    'ਅਗਸਤ',
    'ਸਤੰਬਰ',
    'ਅਕਤੂਬਰ',
    'ਨਵੰਬਰ',
    'ਦਸੰਬਰ',
  ],
  monthsShort: [
    'ਜਨਵਰੀ',
    'ਫ਼ਰਵਰੀ',
    'ਮਾਰਚ',
    'ਅਪ੍ਰੈਲ',
    'ਮਈ',
    'ਜੂਨ',
    'ਜੁਲਾਈ',
    'ਅਗਸਤ',
    'ਸਤੰਬਰ',
    'ਅਕਤੂਬਰ',
    'ਨਵੰਬਰ',
    'ਦਸੰਬਰ',
  ],
  weekdays: [
    'ਐਤਵਾਰ',
    'ਸੋਮਵਾਰ',
    'ਮੰਗਲਵਾਰ',
    'ਬੁਧਵਾਰ',
    'ਵੀਰਵਾਰ',
    'ਸ਼ੁੱਕਰਵਾਰ',
    'ਸ਼ਨੀਚਰਵਾਰ',
  ],
  weekdaysShort: ['ਐਤ', 'ਸੋਮ', 'ਮੰਗਲ', 'ਬੁਧ', 'ਵੀਰ', 'ਸ਼ੁਕਰ', 'ਸ਼ਨੀ'],
  weekdaysMin: ['ਐਤ', 'ਸੋਮ', 'ਮੰਗਲ', 'ਬੁਧ', 'ਵੀਰ', 'ਸ਼ੁਕਰ', 'ਸ਼ਨੀ'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[ਅਜ] LT',
    'nextDay': '[ਕਲ] LT',
    'nextWeek': '[ਅਗਲਾ] dddd, LT',
    'lastDay': '[ਕਲ] LT',
    'lastWeek': '[ਪਿਛਲੇ] dddd, LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ਅਤੇ '],
  meridiem: _meridiem,
);

// Regional variant: pa_Arab
final CarbonLocaleData localePaArab = localePa.copyWith(
  localeCode: 'pa_arab',
  weekdays: ['اتوار', 'پیر', 'منگل', 'بُدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  weekdaysShort: ['اتوار', 'پیر', 'منگل', 'بُدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  weekdaysMin: ['اتوار', 'پیر', 'منگل', 'بُدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  months: [
    'جنوری',
    'فروری',
    'مارچ',
    'اپریل',
    'مئ',
    'جون',
    'جولائی',
    'اگست',
    'ستمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  monthsShort: [
    'جنوری',
    'فروری',
    'مارچ',
    'اپریل',
    'مئ',
    'جون',
    'جولائی',
    'اگست',
    'ستمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  calendar: {
    'sameDay': '[آج بوقت] LT',
    'nextDay': '[کل بوقت] LT',
    'nextWeek': 'dddd [بوقت] LT',
    'lastDay': '[گذشتہ روز بوقت] LT',
    'lastWeek': '[گذشتہ] dddd [بوقت] LT',
    'sameElse': 'L',
  },
  listSeparators: ['، ', ' اور '],
);

// Regional variant: pa_Guru
final CarbonLocaleData localePaGuru = localePa.copyWith(
  localeCode: 'pa_guru',
  weekdays: [
    'ਐਤਵਾਰ',
    'ਸੋਮਵਾਰ',
    'ਮੰਗਲਵਾਰ',
    'ਬੁੱਧਵਾਰ',
    'ਵੀਰਵਾਰ',
    'ਸ਼ੁੱਕਰਵਾਰ',
    'ਸ਼ਨਿੱਚਰਵਾਰ',
  ],
  weekdaysShort: ['ਐਤ', 'ਸੋਮ', 'ਮੰਗਲ', 'ਬੁੱਧ', 'ਵੀਰ', 'ਸ਼ੁੱਕਰ', 'ਸ਼ਨਿੱਚਰ'],
  weekdaysMin: ['ਐਤ', 'ਸੋਮ', 'ਮੰਗ', 'ਬੁੱਧ', 'ਵੀਰ', 'ਸ਼ੁੱਕ', 'ਸ਼ਨਿੱ'],
  monthsShort: [
    'ਜਨ',
    'ਫ਼ਰ',
    'ਮਾਰਚ',
    'ਅਪ੍ਰੈ',
    'ਮਈ',
    'ਜੂਨ',
    'ਜੁਲਾ',
    'ਅਗ',
    'ਸਤੰ',
    'ਅਕਤੂ',
    'ਨਵੰ',
    'ਦਸੰ',
  ],
);

// Regional variant: pa_IN
final CarbonLocaleData localePaIn = localePa.copyWith(localeCode: 'pa_in');

// Regional variant: pa_PK
final CarbonLocaleData localePaPk = localePa.copyWith(
  localeCode: 'pa_pk',
  weekdays: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
  weekdaysShort: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
  weekdaysMin: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
  months: [
    'جنوري',
    'فروري',
    'مارچ',
    'اپريل',
    'مٓی',
    'جون',
    'جولاي',
    'اگست',
    'ستمبر',
    'اكتوبر',
    'نومبر',
    'دسمبر',
  ],
  monthsShort: [
    'جنوري',
    'فروري',
    'مارچ',
    'اپريل',
    'مٓی',
    'جون',
    'جولاي',
    'اگست',
    'ستمبر',
    'اكتوبر',
    'نومبر',
    'دسمبر',
  ],
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
);

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 4) {
    return 'ਰਾਤ';
  }
  if (hour < 10) {
    return 'ਸਵੇਰ';
  }
  if (hour < 17) {
    return 'ਦੁਪਹਿਰ';
  }
  if (hour < 20) {
    return 'ਸ਼ਾਮ';
  }
  return 'ਰਾਤ';
}

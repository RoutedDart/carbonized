// AUTO-GENERATED from PHP Carbon locale: az
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAz = CarbonLocaleData(
  localeCode: 'az',
  translationStrings: {
    'year': ':count il',
    'a_year': '{1}bir il|[-Inf,Inf]:count il',
    'y': ':count il',
    'month': ':count ay',
    'a_month': '{1}bir ay|[-Inf,Inf]:count ay',
    'm': ':count ay',
    'week': ':count həftə',
    'a_week': '{1}bir həftə|[-Inf,Inf]:count həftə',
    'w': ':count h.',
    'day': ':count gün',
    'a_day': '{1}bir gün|[-Inf,Inf]:count gün',
    'd': ':count g.',
    'hour': ':count saat',
    'a_hour': '{1}bir saat|[-Inf,Inf]:count saat',
    'h': ':count s.',
    'minute': ':count dəqiqə',
    'a_minute': '{1}bir dəqiqə|[-Inf,Inf]:count dəqiqə',
    'min': ':count d.',
    'second': ':count saniyə',
    'a_second': '{1}birneçə saniyə|[-Inf,Inf]:count saniyə',
    's': ':count san.',
    'ago': ':time əvvəl',
    'from_now': ':time sonra',
    'after': ':time sonra',
    'before': ':time əvvəl',
    'diff_now': 'indi',
    'diff_today': 'bugün',
    'diff_today_regexp': 'bugün(?:\\s+saat)?',
    'diff_yesterday': 'dünən',
    'diff_tomorrow': 'sabah',
    'diff_tomorrow_regexp': 'sabah(?:\\s+saat)?',
    'diff_before_yesterday': 'srağagün',
    'diff_after_tomorrow': 'birisi gün',
    'period_recurrences': ':count dəfədən bir',
    'period_interval': 'hər :interval',
    'period_start_date': ':date tarixindən başlayaraq',
    'period_end_date': ':date tarixinədək',
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
    'yanvar',
    'fevral',
    'mart',
    'aprel',
    'may',
    'iyun',
    'iyul',
    'avqust',
    'sentyabr',
    'oktyabr',
    'noyabr',
    'dekabr',
  ],
  monthsStandalone: [
    'Yanvar',
    'Fevral',
    'Mart',
    'Aprel',
    'May',
    'İyun',
    'İyul',
    'Avqust',
    'Sentyabr',
    'Oktyabr',
    'Noyabr',
    'Dekabr',
  ],
  monthsShort: [
    'yan',
    'fev',
    'mar',
    'apr',
    'may',
    'iyn',
    'iyl',
    'avq',
    'sen',
    'okt',
    'noy',
    'dek',
  ],
  weekdays: [
    'bazar',
    'bazar ertəsi',
    'çərşənbə axşamı',
    'çərşənbə',
    'cümə axşamı',
    'cümə',
    'şənbə',
  ],
  weekdaysShort: ['baz', 'bze', 'çax', 'çər', 'cax', 'cüm', 'şən'],
  weekdaysMin: ['bz', 'be', 'ça', 'çə', 'ca', 'cü', 'şə'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[bugün saat] LT',
    'nextDay': '[sabah saat] LT',
    'nextWeek': '[gələn həftə] dddd [saat] LT',
    'lastDay': '[dünən] LT',
    'lastWeek': '[keçən həftə] dddd [saat] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' və '],
  periodRecurrences: ':count dəfədən bir',
  periodInterval: 'hər :interval',
  periodStartDate: ':date tarixindən başlayaraq',
  periodEndDate: ':date tarixinədək',
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: az_AZ
final CarbonLocaleData localeAzAz = localeAz.copyWith(
  localeCode: 'az_az',
  weekdays: [
    'bazar günü',
    'bazar ertəsi',
    'çərşənbə axşamı',
    'çərşənbə',
    'cümə axşamı',
    'cümə',
    'şənbə',
  ],
  weekdaysShort: ['baz', 'ber', 'çax', 'çər', 'cax', 'cüm', 'şnb'],
  weekdaysMin: ['baz', 'ber', 'çax', 'çər', 'cax', 'cüm', 'şnb'],
  monthsShort: [
    'Yan',
    'Fev',
    'Mar',
    'Apr',
    'May',
    'İyn',
    'İyl',
    'Avq',
    'Sen',
    'Okt',
    'Noy',
    'Dek',
  ],
);

// Regional variant: az_Cyrl
final CarbonLocaleData localeAzCyrl = localeAz.copyWith(
  localeCode: 'az_cyrl',
  weekdays: [
    'базар',
    'базар ертәси',
    'чәршәнбә ахшамы',
    'чәршәнбә',
    'ҹүмә ахшамы',
    'ҹүмә',
    'шәнбә',
  ],
  weekdaysShort: ['Б.', 'Б.Е.', 'Ч.А.', 'Ч.', 'Ҹ.А.', 'Ҹ.', 'Ш.'],
  weekdaysMin: ['Б.', 'Б.Е.', 'Ч.А.', 'Ч.', 'Ҹ.А.', 'Ҹ.', 'Ш.'],
  months: [
    'јанвар',
    'феврал',
    'март',
    'апрел',
    'май',
    'ијун',
    'ијул',
    'август',
    'сентјабр',
    'октјабр',
    'нојабр',
    'декабр',
  ],
  monthsShort: [
    'јан',
    'фев',
    'мар',
    'апр',
    'май',
    'ијн',
    'ијл',
    'авг',
    'сен',
    'окт',
    'ној',
    'дек',
  ],
  monthsStandalone: [
    'Јанвар',
    'Феврал',
    'Март',
    'Апрел',
    'Май',
    'Ијун',
    'Ијул',
    'Август',
    'Сентјабр',
    'Октјабр',
    'Нојабр',
    'Декабр',
  ],
);

// Regional variant: az_IR
final CarbonLocaleData localeAzIr = localeAz.copyWith(
  localeCode: 'az_ir',
  weekdays: [
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چارشنبه',
    'جۆمعه آخشامی',
    'جۆمعه',
    'شنبه',
  ],
  weekdaysShort: [
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چارشنبه',
    'جۆمعه آخشامی',
    'جۆمعه',
    'شنبه',
  ],
  weekdaysMin: [
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چارشنبه',
    'جۆمعه آخشامی',
    'جۆمعه',
    'شنبه',
  ],
  months: [
    'ژانویه',
    'فوریه',
    'مارس',
    'آوریل',
    'مئی',
    'ژوئن',
    'جولای',
    'آقۇست',
    'سپتامبر',
    'اوْکتوْبر',
    'نوْوامبر',
    'دسامبر',
  ],
  monthsShort: [
    'ژانویه',
    'فوریه',
    'مارس',
    'آوریل',
    'مئی',
    'ژوئن',
    'جولای',
    'آقۇست',
    'سپتامبر',
    'اوْکتوْبر',
    'نوْوامبر',
    'دسامبر',
  ],
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
);

// Regional variant: az_Latn
final CarbonLocaleData localeAzLatn = localeAz.copyWith(
  localeCode: 'az_latn',
  weekdaysShort: ['B.', 'B.E.', 'Ç.A.', 'Ç.', 'C.A.', 'C.', 'Ş.'],
  weekdaysMin: ['B.', 'B.E.', 'Ç.A.', 'Ç.', 'C.A.', 'C.', 'Ş.'],
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  if (number == 0) {
    return '$number-ıncı';
  }
  var suffixes = {
    1: '-inci',
    5: '-inci',
    8: '-inci',
    70: '-inci',
    80: '-inci',
    2: '-nci',
    7: '-nci',
    20: '-nci',
    50: '-nci',
    3: '-üncü',
    4: '-üncü',
    100: '-üncü',
    6: '-ncı',
    9: '-uncu',
    10: '-uncu',
    30: '-uncu',
    60: '-ıncı',
    90: '-ıncı',
  };
  lastDigit = number % 10;
  return '$number${suffixes[lastDigit] ?? suffixes[number % 100 - lastDigit] ?? suffixes[(number >= 100 ? 100 : -1)] ?? ''}';
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 4) {
    return 'gecə';
  }
  if (hour < 12) {
    return 'səhər';
  }
  if (hour < 17) {
    return 'gündüz';
  }
  return 'axşam';
}

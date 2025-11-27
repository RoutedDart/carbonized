// AUTO-GENERATED from PHP Carbon locale: hy
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeHy = CarbonLocaleData(
  localeCode: 'hy',
  translationStrings: {
    'year': ':count տարի',
    'a_year': 'տարի|:count տարի',
    'y': ':countտ',
    'month': ':count ամիս',
    'a_month': 'ամիս|:count ամիս',
    'm': ':countամ',
    'week': ':count շաբաթ',
    'a_week': 'շաբաթ|:count շաբաթ',
    'w': ':countշ',
    'day': ':count օր',
    'a_day': 'օր|:count օր',
    'd': ':countօր',
    'hour': ':count ժամ',
    'a_hour': 'ժամ|:count ժամ',
    'h': ':countժ',
    'minute': ':count րոպե',
    'a_minute': 'րոպե|:count րոպե',
    'min': ':countր',
    'second': ':count վայրկյան',
    'a_second': 'մի քանի վայրկյան|:count վայրկյան',
    's': ':countվրկ',
    'ago': ':time առաջ',
    'from_now': ':timeից',
    'after': ':time հետո',
    'before': ':time առաջ',
    'diff_now': 'հիմա',
    'diff_today': 'այսօր',
    'diff_yesterday': 'երեկ',
    'diff_tomorrow': 'վաղը',
    'months_regexp': '/(D[oD]?(\\[[^\\[\\]]*\\]|\\s)+MMMM?|L{2,4}|l{2,4})/',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D MMMM YYYY թ.',
    'LLL': 'D MMMM YYYY թ., HH:mm',
    'LLLL': 'dddd, D MMMM YYYY թ., HH:mm',
  },
  months: [
    'հունվարի',
    'փետրվարի',
    'մարտի',
    'ապրիլի',
    'մայիսի',
    'հունիսի',
    'հուլիսի',
    'օգոստոսի',
    'սեպտեմբերի',
    'հոկտեմբերի',
    'նոյեմբերի',
    'դեկտեմբերի',
  ],
  monthsStandalone: [
    'հունվար',
    'փետրվար',
    'մարտ',
    'ապրիլ',
    'մայիս',
    'հունիս',
    'հուլիս',
    'օգոստոս',
    'սեպտեմբեր',
    'հոկտեմբեր',
    'նոյեմբեր',
    'դեկտեմբեր',
  ],
  monthsShort: [
    'հնվ',
    'փտր',
    'մրտ',
    'ապր',
    'մյս',
    'հնս',
    'հլս',
    'օգս',
    'սպտ',
    'հկտ',
    'նմբ',
    'դկտ',
  ],
  weekdays: [
    'կիրակի',
    'երկուշաբթի',
    'երեքշաբթի',
    'չորեքշաբթի',
    'հինգշաբթի',
    'ուրբաթ',
    'շաբաթ',
  ],
  weekdaysShort: ['կրկ', 'երկ', 'երք', 'չրք', 'հնգ', 'ուրբ', 'շբթ'],
  weekdaysMin: ['կրկ', 'երկ', 'երք', 'չրք', 'հնգ', 'ուրբ', 'շբթ'],
  firstDayOfWeek: 1,
  calendar: {
    'sameDay': '[այսօր] LT',
    'nextDay': '[վաղը] LT',
    'nextWeek': 'dddd [օրը ժամը] LT',
    'lastDay': '[երեկ] LT',
    'lastWeek': '[անցած] dddd [օրը ժամը] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' եւ '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: hy_AM
final CarbonLocaleData localeHyAm = localeHy.copyWith(localeCode: 'hy_am');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return ((period == 'DDD' || period == 'w' || period == 'W' || period == 'DDDo'
          ? '$number${(number == 1 ? '-ին' : '-րդ')}'
          : number))
      .toString();
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 4) {
    return 'գիշերվա';
  }
  if (hour < 12) {
    return 'առավոտվա';
  }
  if (hour < 17) {
    return 'ցերեկվա';
  }
  return 'երեկոյան';
}

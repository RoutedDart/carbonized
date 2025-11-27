// AUTO-GENERATED from PHP Carbon locale: mhr
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMhr = CarbonLocaleData(
  localeCode: 'mhr',
  translationStrings: {
    'year': ':count идалык',
    'a_year': ':count идалык',
    'y': ':count идалык',
    'month': ':count Тылзе',
    'a_month': ':count Тылзе',
    'm': ':count Тылзе',
    'week': ':count арня',
    'a_week': ':count арня',
    'w': ':count арня',
    'day': ':count кече',
    'a_day': ':count кече',
    'd': ':count кече',
    'hour': ':count час',
    'a_hour': ':count час',
    'h': ':count час',
    'minute': ':count минут',
    'a_minute': ':count минут',
    'min': ':count минут',
    'second': ':count кокымшан',
    'a_second': ':count кокымшан',
    's': ':count кокымшан',
    'millisecond':
        '{1}:count millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'a_millisecond':
        '{1}a millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'ms': ':countms',
    'microsecond':
        '{1}:count microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'a_microsecond':
        '{1}a microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'µs': ':countµs',
    'ago': ':time ago',
    'from_now': ':time from now',
    'after': ':time after',
    'before': ':time before',
    'diff_now': 'just now',
    'diff_today': 'today',
    'diff_yesterday': 'yesterday',
    'diff_tomorrow': 'tomorrow',
    'diff_before_yesterday': 'before yesterday',
    'diff_after_tomorrow': 'after tomorrow',
    'period_recurrences': '{1}once|{0}:count times|[-Inf,Inf]:count times',
    'period_interval': 'every :interval',
    'period_start_date': 'from :date',
    'period_end_date': 'to :date',
  },
  formats: {
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'YYYY.MM.DD',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Шорыкйол',
    'Пургыж',
    'Ӱярня',
    'Вӱдшор',
    'Ага',
    'Пеледыш',
    'Сӱрем',
    'Сорла',
    'Идым',
    'Шыжа',
    'Кылме',
    'Теле',
  ],
  monthsShort: [
    'Шрк',
    'Пгж',
    'Ӱрн',
    'Вшр',
    'Ага',
    'Пдш',
    'Срм',
    'Срл',
    'Идм',
    'Шыж',
    'Клм',
    'Тел',
  ],
  weekdays: [
    'Рушарня',
    'Шочмо',
    'Кушкыжмо',
    'Вӱргече',
    'Изарня',
    'Кугарня',
    'Шуматкече',
  ],
  weekdaysShort: ['Ршр', 'Шчм', 'Кжм', 'Вгч', 'Изр', 'Кгр', 'Шмт'],
  weekdaysMin: ['Ршр', 'Шчм', 'Кжм', 'Вгч', 'Изр', 'Кгр', 'Шмт'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: mhr_RU
final CarbonLocaleData localeMhrRu = localeMhr.copyWith(localeCode: 'mhr_ru');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

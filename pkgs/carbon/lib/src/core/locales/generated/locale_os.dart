// AUTO-GENERATED from PHP Carbon locale: os
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeOs = CarbonLocaleData(
  localeCode: 'os',
  translationStrings: {
    'year': ':count аз',
    'a_year': ':count аз',
    'y': ':count аз',
    'month': ':count мӕй',
    'a_month': ':count мӕй',
    'm': ':count мӕй',
    'week': ':count къуыри',
    'a_week': ':count къуыри',
    'w': ':count къуыри',
    'day': ':count бон',
    'a_day': ':count бон',
    'd': ':count бон',
    'hour': ':count сахат',
    'a_hour': ':count сахат',
    'h': ':count сахат',
    'minute': ':count гыццыл',
    'a_minute': ':count гыццыл',
    'min': ':count гыццыл',
    'second': ':count æндæр',
    'a_second': ':count æндæр',
    's': ':count æндæр',
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
    'L': 'DD.MM.YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'январы',
    'февралы',
    'мартъийы',
    'апрелы',
    'майы',
    'июны',
    'июлы',
    'августы',
    'сентябры',
    'октябры',
    'ноябры',
    'декабры',
  ],
  monthsShort: [
    'Янв',
    'Фев',
    'Мар',
    'Апр',
    'Май',
    'Июн',
    'Июл',
    'Авг',
    'Сен',
    'Окт',
    'Ноя',
    'Дек',
  ],
  weekdays: [
    'Хуыцаубон',
    'Къуырисæр',
    'Дыццæг',
    'Æртыццæг',
    'Цыппæрæм',
    'Майрæмбон',
    'Сабат',
  ],
  weekdaysShort: ['Хцб', 'Крс', 'Дцг', 'Æрт', 'Цпр', 'Мрб', 'Сбт'],
  weekdaysMin: ['Хцб', 'Крс', 'Дцг', 'Æрт', 'Цпр', 'Мрб', 'Сбт'],
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

// Regional variant: os_RU
final CarbonLocaleData localeOsRu = localeOs.copyWith(localeCode: 'os_ru');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// AUTO-GENERATED from PHP Carbon locale: ce
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeCe = CarbonLocaleData(
  localeCode: 'ce',
  translationStrings: {
    'year': ':count шо',
    'a_year': ':count шо',
    'y': ':count шо',
    'month': ':count бутт',
    'a_month': ':count бутт',
    'm': ':count бутт',
    'week': ':count кӏира',
    'a_week': ':count кӏира',
    'w': ':count кӏира',
    'day': ':count де',
    'a_day': ':count де',
    'd': ':count де',
    'hour': ':count сахьт',
    'a_hour': ':count сахьт',
    'h': ':count сахьт',
    'minute': ':count минот',
    'a_minute': ':count минот',
    'min': ':count минот',
    'second': ':count секунд',
    'a_second': ':count секунд',
    's': ':count секунд',
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
    'L': 'YYYY.DD.MM',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ],
  monthsShort: [
    'янв',
    'фев',
    'мар',
    'апр',
    'май',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек',
  ],
  weekdays: [
    'КӀиранан де',
    'Оршотан де',
    'Шинарин де',
    'Кхаарин де',
    'Еарин де',
    'ПӀераскан де',
    'Шот де',
  ],
  weekdaysShort: ['КӀ', 'Ор', 'Ши', 'Кх', 'Еа', 'ПӀ', 'Шо'],
  weekdaysMin: ['КӀ', 'Ор', 'Ши', 'Кх', 'Еа', 'ПӀ', 'Шо'],
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

// Regional variant: ce_RU
final CarbonLocaleData localeCeRu = localeCe.copyWith(localeCode: 'ce_ru');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

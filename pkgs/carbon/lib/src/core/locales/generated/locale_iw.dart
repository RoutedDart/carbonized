// AUTO-GENERATED from PHP Carbon locale: iw
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIw = CarbonLocaleData(
  localeCode: 'iw',
  translationStrings: {
    'year': ':count שנה',
    'a_year': ':count שנה',
    'y': ':count שנה',
    'month': ':count חודש',
    'a_month': ':count חודש',
    'm': ':count חודש',
    'week': ':count שבוע',
    'a_week': ':count שבוע',
    'w': ':count שבוע',
    'day': ':count יום',
    'a_day': ':count יום',
    'd': ':count יום',
    'hour': ':count שעה',
    'a_hour': ':count שעה',
    'h': ':count שעה',
    'minute': ':count דקה',
    'a_minute': ':count דקה',
    'min': ':count דקה',
    'second': ':count שניה',
    'a_second': ':count שניה',
    's': ':count שניה',
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
    'ago': 'לפני :time',
    'from_now': 'בעוד :time',
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
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'D.M.YYYY',
    'LL': 'D בMMM YYYY',
    'LLL': 'D בMMMM YYYY H:mm',
    'LLLL': 'dddd, D בMMMM YYYY H:mm',
  },
  months: [
    'ינואר',
    'פברואר',
    'מרץ',
    'אפריל',
    'מאי',
    'יוני',
    'יולי',
    'אוגוסט',
    'ספטמבר',
    'אוקטובר',
    'נובמבר',
    'דצמבר',
  ],
  monthsShort: [
    'ינו׳',
    'פבר׳',
    'מרץ',
    'אפר׳',
    'מאי',
    'יוני',
    'יולי',
    'אוג׳',
    'ספט׳',
    'אוק׳',
    'נוב׳',
    'דצמ׳',
  ],
  weekdays: [
    'יום ראשון',
    'יום שני',
    'יום שלישי',
    'יום רביעי',
    'יום חמישי',
    'יום שישי',
    'יום שבת',
  ],
  weekdaysShort: [
    'יום א׳',
    'יום ב׳',
    'יום ג׳',
    'יום ד׳',
    'יום ה׳',
    'יום ו׳',
    'שבת',
  ],
  weekdaysMin: ['א׳', 'ב׳', 'ג׳', 'ד׳', 'ה׳', 'ו׳', 'ש׳'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  meridiem: _meridiem,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'לפנה״צ' : 'אחה״צ';
}

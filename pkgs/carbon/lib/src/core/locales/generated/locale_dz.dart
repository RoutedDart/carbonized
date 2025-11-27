// AUTO-GENERATED from PHP Carbon locale: dz
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeDz = CarbonLocaleData(
  localeCode: 'dz',
  translationStrings: {
    'year': ':count ཆརཔ',
    'a_year': ':count ཆརཔ',
    'y': ':count ཆརཔ',
    'month': ':count ཟླ་བ',
    'a_month': ':count ཟླ་བ',
    'm': ':count ཟླ་བ',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': ':count ཉི',
    'a_day': ':count ཉི',
    'd': ':count ཉི',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count ཆ',
    'a_second': ':count ཆ',
    's': ':count ཆ',
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
    'L': 'པསྱི་ལོYYཟལMMཚེསDD',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'ཟླ་བ་དང་པ་',
    'ཟླ་བ་གཉིས་པ་',
    'ཟླ་བ་གསུམ་པ་',
    'ཟླ་བ་བཞི་པ་',
    'ཟླ་བ་ལྔ་ཕ་',
    'ཟླ་བ་དྲུག་པ་',
    'ཟླ་བ་བདུནཔ་',
    'ཟླ་བ་བརྒྱད་པ་',
    'ཟླ་བ་དགུ་པ་',
    'ཟླ་བ་བཅུ་པ་',
    'ཟླ་བ་བཅུ་གཅིག་པ་',
    'ཟླ་བ་བཅུ་གཉིས་པ་',
  ],
  monthsShort: [
    'ཟླ་༡',
    'ཟླ་༢',
    'ཟླ་༣',
    'ཟླ་༤',
    'ཟླ་༥',
    'ཟླ་༦',
    'ཟླ་༧',
    'ཟླ་༨',
    'ཟླ་༩',
    'ཟླ་༡༠',
    'ཟླ་༡༡',
    'ཟླ་༡༢',
  ],
  weekdays: [
    'གཟའ་ཟླ་བ་',
    'གཟའ་མིག་དམར་',
    'གཟའ་ལྷག་ཕ་',
    'གཟའ་པུར་བུ་',
    'གཟའ་པ་སངས་',
    'གཟའ་སྤེན་ཕ་',
    'གཟའ་ཉི་མ་',
  ],
  weekdaysShort: ['ཟླ་', 'མིར་', 'ལྷག་', 'པུར་', 'སངས་', 'སྤེན་', 'ཉི་'],
  weekdaysMin: ['ཟླ་', 'མིར་', 'ལྷག་', 'པུར་', 'སངས་', 'སྤེན་', 'ཉི་'],
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

// Regional variant: dz_BT
final CarbonLocaleData localeDzBt = localeDz.copyWith(localeCode: 'dz_bt');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ངས་ཆ' : 'ཕྱི་ཆ';
}

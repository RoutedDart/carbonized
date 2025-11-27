// AUTO-GENERATED from PHP Carbon locale: shn
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeShn = CarbonLocaleData(
  localeCode: 'shn',
  translationStrings: {
    'year': ':count ပီ',
    'a_year': ':count ပီ',
    'y': ':count ပီ',
    'month': ':count လိူၼ်',
    'a_month': ':count လိူၼ်',
    'm': ':count လိူၼ်',
    'week': ':count ဝၼ်း',
    'a_week': ':count ဝၼ်း',
    'w': ':count ဝၼ်း',
    'day': ':count ກາງວັນ',
    'a_day': ':count ກາງວັນ',
    'd': ':count ກາງວັນ',
    'hour': ':count ຕີ',
    'a_hour': ':count ຕີ',
    'h': ':count ຕີ',
    'minute': ':count ເດັກ',
    'a_minute': ':count ເດັກ',
    'min': ':count ເດັກ',
    'second': ':count ဢိုၼ်ႇ',
    'a_second': ':count ဢိုၼ်ႇ',
    's': ':count ဢိုၼ်ႇ',
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
    'L': 'OY MMM OD dddd',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'လိူၼ်ၵမ်',
    'လိူၼ်သၢမ်',
    'လိူၼ်သီ',
    'လိူၼ်ႁႃႈ',
    'လိူၼ်ႁူၵ်း',
    'လိူၼ်ၸဵတ်း',
    'လိူၼ်ပႅတ်ႇ',
    'လိူၼ်ၵဝ်ႈ',
    'လိူၼ်သိပ်း',
    'လိူၼ်သိပ်းဢိတ်း',
    'လိူၼ်သိပ်းဢိတ်းသွင်',
    'လိူၼ်ၸဵင်',
  ],
  monthsShort: [
    'လိူၼ်ၵမ်',
    'လိူၼ်သၢမ်',
    'လိူၼ်သီ',
    'လိူၼ်ႁႃႈ',
    'လိူၼ်ႁူၵ်း',
    'လိူၼ်ၸဵတ်း',
    'လိူၼ်ပႅတ်ႇ',
    'လိူၼ်ၵဝ်ႈ',
    'လိူၼ်သိပ်း',
    'လိူၼ်သိပ်းဢိတ်း',
    'လိူၼ်သိပ်းဢိတ်းသွင်',
    'လိူၼ်ၸဵင်',
  ],
  weekdays: [
    'ဝၼ်းဢႃးတိတ်ႉ',
    'ဝၼ်းၸၼ်',
    'ဝၼ်း​ဢၢင်း​ၵၢၼ်း',
    'ဝၼ်းပူတ်ႉ',
    'ဝၼ်းၽတ်း',
    'ဝၼ်းသုၵ်း',
    'ဝၼ်းသဝ်',
  ],
  weekdaysShort: ['တိတ့်', 'ၸၼ်', 'ၵၢၼ်း', 'ပုတ့်', 'ၽတ်း', 'သုၵ်း', 'သဝ်'],
  weekdaysMin: ['တိတ့်', 'ၸၼ်', 'ၵၢၼ်း', 'ပုတ့်', 'ၽတ်း', 'သုၵ်း', 'သဝ်'],
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

// Regional variant: shn_MM
final CarbonLocaleData localeShnMm = localeShn.copyWith(localeCode: 'shn_mm');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ၵၢင်ၼႂ်' : 'တၢမ်းၶမ်ႈ';
}

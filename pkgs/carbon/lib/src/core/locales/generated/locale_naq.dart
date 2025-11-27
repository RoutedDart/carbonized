// AUTO-GENERATED from PHP Carbon locale: naq
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNaq = CarbonLocaleData(
  localeCode: 'naq',
  translationStrings: {
    'year': ':count kurigu',
    'a_year': ':count kurigu',
    'y': ':count kurigu',
    'month': ':count ǁaub',
    'a_month': ':count ǁaub',
    'm': ':count ǁaub',
    'week': ':count hû',
    'a_week': ':count hû',
    'w': ':count hû',
    'day': ':count ǀhobas',
    'a_day': ':count ǀhobas',
    'd': ':count ǀhobas',
    'hour': ':count ǂgaes',
    'a_hour': ':count ǂgaes',
    'h': ':count ǂgaes',
    'minute': ':count minutga',
    'a_minute': ':count minutga',
    'min': ':count minutga',
    'second': '{1}:count second|{0}:count seconds|[-Inf,Inf]:count seconds',
    'a_second': '{0,1}a few seconds|[-Inf,Inf]:count seconds',
    's': ':counts',
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
    'LT': 'h:mm a',
    'LTS': 'h:mm:ss a',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY h:mm a',
    'LLLL': 'dddd, D MMMM YYYY h:mm a',
  },
  months: [
    'ǃKhanni',
    'ǃKhanǀgôab',
    'ǀKhuuǁkhâb',
    'ǃHôaǂkhaib',
    'ǃKhaitsâb',
    'Gamaǀaeb',
    'ǂKhoesaob',
    'Aoǁkhuumûǁkhâb',
    'Taraǀkhuumûǁkhâb',
    'ǂNûǁnâiseb',
    'ǀHooǂgaeb',
    'Hôasoreǁkhâb',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ],
  weekdays: [
    'Sontaxtsees',
    'Mantaxtsees',
    'Denstaxtsees',
    'Wunstaxtsees',
    'Dondertaxtsees',
    'Fraitaxtsees',
    'Satertaxtsees',
  ],
  weekdaysShort: ['Son', 'Ma', 'De', 'Wu', 'Do', 'Fr', 'Sat'],
  weekdaysMin: ['Son', 'Ma', 'De', 'Wu', 'Do', 'Fr', 'Sat'],
  firstDayOfWeek: 1,
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
  return hour < 12 ? 'ǁgoagas' : 'ǃuias';
}

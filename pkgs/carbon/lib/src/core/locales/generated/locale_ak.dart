// AUTO-GENERATED from PHP Carbon locale: ak
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAk = CarbonLocaleData(
  localeCode: 'ak',
  translationStrings: {
    'year': ':count afe',
    'a_year': ':count afe',
    'y': ':count afe',
    'month': ':count bosume',
    'a_month': ':count bosume',
    'm': ':count bosume',
    'week': '{1}:count week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'a_week': '{1}a week|{0}:count weeks|[-Inf,Inf]:count weeks',
    'w': ':countw',
    'day': ':count ɛda',
    'a_day': ':count ɛda',
    'd': ':count ɛda',
    'hour': '{1}:count hour|{0}:count hours|[-Inf,Inf]:count hours',
    'a_hour': '{1}an hour|{0}:count hours|[-Inf,Inf]:count hours',
    'h': ':counth',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
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
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'YYYY/MM/DD',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Sanda-Ɔpɛpɔn',
    'Kwakwar-Ɔgyefuo',
    'Ebɔw-Ɔbenem',
    'Ebɔbira-Oforisuo',
    'Esusow Aketseaba-Kɔtɔnimba',
    'Obirade-Ayɛwohomumu',
    'Ayɛwoho-Kitawonsa',
    'Difuu-Ɔsandaa',
    'Fankwa-Ɛbɔ',
    'Ɔbɛsɛ-Ahinime',
    'Ɔberɛfɛw-Obubuo',
    'Mumu-Ɔpɛnimba',
  ],
  monthsShort: [
    'S-Ɔ',
    'K-Ɔ',
    'E-Ɔ',
    'E-O',
    'E-K',
    'O-A',
    'A-K',
    'D-Ɔ',
    'F-Ɛ',
    'Ɔ-A',
    'Ɔ-O',
    'M-Ɔ',
  ],
  weekdays: [
    'Kwesida',
    'Dwowda',
    'Benada',
    'Wukuda',
    'Yawda',
    'Fida',
    'Memeneda',
  ],
  weekdaysShort: ['Kwe', 'Dwo', 'Ben', 'Wuk', 'Yaw', 'Fia', 'Mem'],
  weekdaysMin: ['Kwe', 'Dwo', 'Ben', 'Wuk', 'Yaw', 'Fia', 'Mem'],
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

// Regional variant: ak_GH
final CarbonLocaleData localeAkGh = localeAk.copyWith(localeCode: 'ak_gh');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'AN' : 'EW';
}

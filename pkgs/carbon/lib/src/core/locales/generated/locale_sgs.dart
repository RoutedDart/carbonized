// AUTO-GENERATED from PHP Carbon locale: sgs
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSgs = CarbonLocaleData(
  localeCode: 'sgs',
  translationStrings: {
    'year': ':count metā',
    'a_year': ':count metā',
    'y': ':count metā',
    'month': ':count mienou',
    'a_month': ':count mienou',
    'm': ':count mienou',
    'week': ':count nedielė',
    'a_week': ':count nedielė',
    'w': ':count nedielė',
    'day': ':count dīna',
    'a_day': ':count dīna',
    'd': ':count dīna',
    'hour': ':count adīna',
    'a_hour': ':count adīna',
    'h': ':count adīna',
    'minute': ':count mažos',
    'a_minute': ':count mažos',
    'min': ':count mažos',
    'second': ':count Sekondė',
    'a_second': ':count Sekondė',
    's': ':count Sekondė',
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
    'sausė',
    'vasarė',
    'kuova',
    'balondė',
    'gegožės',
    'bėrželė',
    'lëpas',
    'rogpjūtė',
    'siejės',
    'spalė',
    'lapkrėstė',
    'grůdė',
  ],
  monthsShort: [
    'Sau',
    'Vas',
    'Kuo',
    'Bal',
    'Geg',
    'Bėr',
    'Lëp',
    'Rgp',
    'Sie',
    'Spa',
    'Lap',
    'Grd',
  ],
  weekdays: [
    'nedielės dëna',
    'panedielis',
    'oterninks',
    'sereda',
    'četvergs',
    'petnīčė',
    'sobata',
  ],
  weekdaysShort: ['Nd', 'Pn', 'Ot', 'Sr', 'Čt', 'Pt', 'Sb'],
  weekdaysMin: ['Nd', 'Pn', 'Ot', 'Sr', 'Čt', 'Pt', 'Sb'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
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

// Regional variant: sgs_LT
final CarbonLocaleData localeSgsLt = localeSgs.copyWith(localeCode: 'sgs_lt');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

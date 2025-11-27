// AUTO-GENERATED from PHP Carbon locale: lg
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLg = CarbonLocaleData(
  localeCode: 'lg',
  translationStrings: {
    'year': ':count mwaaka',
    'a_year': ':count mwaaka',
    'y': ':count mwaaka',
    'month': ':count njuba',
    'a_month': ':count njuba',
    'm': ':count njuba',
    'week': ':count sabbiiti',
    'a_week': ':count sabbiiti',
    'w': ':count sabbiiti',
    'day': ':count lunaku',
    'a_day': ':count lunaku',
    'd': ':count lunaku',
    'hour': 'saawa :count',
    'a_hour': 'saawa :count',
    'h': 'saawa :count',
    'minute': 'ddakiika :count',
    'a_minute': 'ddakiika :count',
    'min': 'ddakiika :count',
    'second': ':count kyʼokubiri',
    'a_second': ':count kyʼokubiri',
    's': ':count kyʼokubiri',
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
    'L': 'DD/MM/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Janwaliyo',
    'Febwaliyo',
    'Marisi',
    'Apuli',
    'Maayi',
    'Juuni',
    'Julaayi',
    'Agusito',
    'Sebuttemba',
    'Okitobba',
    'Novemba',
    'Desemba',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Apu',
    'Maa',
    'Juu',
    'Jul',
    'Agu',
    'Seb',
    'Oki',
    'Nov',
    'Des',
  ],
  weekdays: [
    'Sabiiti',
    'Balaza',
    'Lwakubiri',
    'Lwakusatu',
    'Lwakuna',
    'Lwakutaano',
    'Lwamukaaga',
  ],
  weekdaysShort: ['Sab', 'Bal', 'Lw2', 'Lw3', 'Lw4', 'Lw5', 'Lw6'],
  weekdaysMin: ['Sab', 'Bal', 'Lw2', 'Lw3', 'Lw4', 'Lw5', 'Lw6'],
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

// Regional variant: lg_UG
final CarbonLocaleData localeLgUg = localeLg.copyWith(localeCode: 'lg_ug');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// AUTO-GENERATED from PHP Carbon locale: so
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSo = CarbonLocaleData(
  localeCode: 'so',
  translationStrings: {
    'year': ':count sanad|:count sanadood',
    'a_year': 'sanad|:count sanadood',
    'y': '{1}:countsn|{0}:countsns|[-Inf,Inf]:countsn',
    'month': ':count bil|:count bilood',
    'a_month': 'bil|:count bilood',
    'm': ':countbil',
    'week': ':count isbuuc',
    'a_week': 'isbuuc|:count isbuuc',
    'w': ':countis',
    'day': ':count maalin|:count maalmood',
    'a_day': 'maalin|:count maalmood',
    'd': ':countml',
    'hour': ':count saac',
    'a_hour': 'saacad|:count saac',
    'h': ':countsc',
    'minute': ':count daqiiqo',
    'a_minute': 'daqiiqo|:count daqiiqo',
    'min': ':countdq',
    'second': ':count ilbidhiqsi',
    'a_second': 'xooga ilbidhiqsiyo|:count ilbidhiqsi',
    's': ':countil',
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
    'ago': ':time kahor',
    'from_now': ':time gudahood',
    'after': ':time kedib',
    'before': ':time kahor',
    'diff_now': 'hada',
    'diff_today': 'maanta',
    'diff_yesterday': 'shalayto',
    'diff_tomorrow': 'beri',
    'diff_before_yesterday': 'doraato',
    'diff_after_tomorrow': 'saadanbe',
    'period_recurrences': 'mar|:count jeer',
    'period_interval': ':interval kasta',
    'period_start_date': 'laga bilaabo :date',
    'period_end_date': 'ilaa :date',
    'diff_today_regexp': 'maanta(?:\\s+markay\\s+(?:tahay|ahayd))?',
    'diff_yesterday_regexp': 'shalayto(?:\\s+markay\\s+ahayd)?',
    'diff_tomorrow_regexp': 'beri(?:\\s+markay\\s+tahay)?',
  },
  formats: {
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'DD/MM/YYYY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'Janaayo',
    'Febraayo',
    'Abriil',
    'Maajo',
    'Juun',
    'Luuliyo',
    'Agoosto',
    'Sebteembar',
    'Oktoobar',
    'Nofeembar',
    'Diseembar',
    'December',
  ],
  monthsShort: [
    'Jan',
    'Feb',
    'Mar',
    'Abr',
    'Mjo',
    'Jun',
    'Lyo',
    'Agt',
    'Seb',
    'Okt',
    'Nof',
    'Dis',
  ],
  weekdays: [
    'Axad',
    'Isniin',
    'Talaada',
    'Arbaca',
    'Khamiis',
    'Jimce',
    'Sabti',
  ],
  weekdaysShort: ['Axd', 'Isn', 'Tal', 'Arb', 'Kha', 'Jim', 'Sbt'],
  weekdaysMin: ['Ax', 'Is', 'Ta', 'Ar', 'Kh', 'Ji', 'Sa'],
  firstDayOfWeek: 6,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[Maanta markay tahay] LT',
    'nextDay': '[Beri markay tahay] LT',
    'nextWeek': 'dddd [markay tahay] LT',
    'lastDay': '[Shalay markay ahayd] LT',
    'lastWeek': '[Hore] dddd [Markay ahayd] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' and '],
  periodRecurrences: 'mar|:count jeer',
  periodInterval: ':interval kasta',
  periodStartDate: 'laga bilaabo :date',
  periodEndDate: 'ilaa :date',
  ordinal: _ordinal,
);

// Regional variant: so_DJ
final CarbonLocaleData localeSoDj = localeSo.copyWith(localeCode: 'so_dj');

// Regional variant: so_ET
final CarbonLocaleData localeSoEt = localeSo.copyWith(localeCode: 'so_et');

// Regional variant: so_KE
final CarbonLocaleData localeSoKe = localeSo.copyWith(localeCode: 'so_ke');

// Regional variant: so_SO
final CarbonLocaleData localeSoSo = localeSo.copyWith(localeCode: 'so_so');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

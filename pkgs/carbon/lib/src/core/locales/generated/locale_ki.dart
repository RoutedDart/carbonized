// AUTO-GENERATED from PHP Carbon locale: ki
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKi = CarbonLocaleData(
  localeCode: 'ki',
  translationStrings: {
    'year': ':count mĩaka',
    'a_year': ':count mĩaka',
    'y': ':count mĩaka',
    'month': ':count mweri',
    'a_month': ':count mweri',
    'm': ':count mweri',
    'week': ':count kiumia',
    'a_week': ':count kiumia',
    'w': ':count kiumia',
    'day': ':count mũthenya',
    'a_day': ':count mũthenya',
    'd': ':count mũthenya',
    'hour': ':count thaa',
    'a_hour': ':count thaa',
    'h': ':count thaa',
    'minute': ':count mundu',
    'a_minute': ':count mundu',
    'min': ':count mundu',
    'second': ':count igego',
    'a_second': ':count igego',
    's': ':count igego',
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
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Njenuarĩ',
    'Mwere wa kerĩ',
    'Mwere wa gatatũ',
    'Mwere wa kana',
    'Mwere wa gatano',
    'Mwere wa gatandatũ',
    'Mwere wa mũgwanja',
    'Mwere wa kanana',
    'Mwere wa kenda',
    'Mwere wa ikũmi',
    'Mwere wa ikũmi na ũmwe',
    'Ndithemba',
  ],
  monthsShort: [
    'JEN',
    'WKR',
    'WGT',
    'WKN',
    'WTN',
    'WTD',
    'WMJ',
    'WNN',
    'WKD',
    'WIK',
    'WMW',
    'DIT',
  ],
  weekdays: [
    'Kiumia',
    'Njumatatũ',
    'Njumaine',
    'Njumatana',
    'Aramithi',
    'Njumaa',
    'Njumamothi',
  ],
  weekdaysShort: ['KMA', 'NTT', 'NMN', 'NMT', 'ART', 'NMA', 'NMM'],
  weekdaysMin: ['KMA', 'NTT', 'NMN', 'NMT', 'ART', 'NMA', 'NMM'],
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
  return hour < 12 ? 'Kiroko' : 'Hwaĩ-inĩ';
}

// AUTO-GENERATED from PHP Carbon locale: mas
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMas = CarbonLocaleData(
  localeCode: 'mas',
  translationStrings: {
    'year': ':count olameyu',
    'a_year': ':count olameyu',
    'y': ':count olameyu',
    'month': ':count olapa',
    'a_month': ':count olapa',
    'm': ':count olapa',
    'week': ':count engolongeare orwiki',
    'a_week': ':count engolongeare orwiki',
    'w': ':count engolongeare orwiki',
    'day': ':count enkolongʼ',
    'a_day': ':count enkolongʼ',
    'd': ':count enkolongʼ',
    'hour': ':count esahabu',
    'a_hour': ':count esahabu',
    'h': ':count esahabu',
    'minute': '{1}:count minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'a_minute': '{1}a minute|{0}:count minutes|[-Inf,Inf]:count minutes',
    'min': ':countm',
    'second': ':count are',
    'a_second': ':count are',
    's': ':count are',
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
    'Oladalʉ́',
    'Arát',
    'Ɔɛnɨ́ɔɨŋɔk',
    'Olodoyíóríê inkókúâ',
    'Oloilépūnyīē inkókúâ',
    'Kújúɔrɔk',
    'Mórusásin',
    'Ɔlɔ́ɨ́bɔ́rárɛ',
    'Kúshîn',
    'Olgísan',
    'Pʉshʉ́ka',
    'Ntʉ́ŋʉ́s',
  ],
  monthsShort: [
    'Dal',
    'Ará',
    'Ɔɛn',
    'Doy',
    'Lép',
    'Rok',
    'Sás',
    'Bɔ́r',
    'Kús',
    'Gís',
    'Shʉ́',
    'Ntʉ́',
  ],
  weekdays: [
    'Jumapílí',
    'Jumatátu',
    'Jumane',
    'Jumatánɔ',
    'Alaámisi',
    'Jumáa',
    'Jumamósi',
  ],
  weekdaysShort: ['Jpi', 'Jtt', 'Jnn', 'Jtn', 'Alh', 'Iju', 'Jmo'],
  weekdaysMin: ['Jpi', 'Jtt', 'Jnn', 'Jtn', 'Alh', 'Iju', 'Jmo'],
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

// Regional variant: mas_TZ
final CarbonLocaleData localeMasTz = localeMas.copyWith(localeCode: 'mas_tz');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'Ɛnkakɛnyá' : 'Ɛndámâ';
}

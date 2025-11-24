// AUTO-GENERATED from PHP Carbon locale: ks
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKs = CarbonLocaleData(
  localeCode: 'ks',
  translationStrings: {
    'year': ':count آب',
    'a_year': ':count آب',
    'y': ':count آب',
    'month': ':count रान्',
    'a_month': ':count रान्',
    'm': ':count रान्',
    'week': ':count آتھٕوار',
    'a_week': ':count آتھٕوار',
    'w': ':count آتھٕوار',
    'day': '{1}:count day|{0}:count days|[-Inf,Inf]:count days',
    'a_day': '{1}a day|{0}:count days|[-Inf,Inf]:count days',
    'd': ':countd',
    'hour': ':count سۄن',
    'a_hour': ':count سۄن',
    'h': ':count سۄن',
    'minute': ':count فَن',
    'a_minute': ':count فَن',
    'min': ':count فَن',
    'second': ':count दोʼयुम',
    'a_second': ':count दोʼयुम',
    's': ':count दोʼयुम',
    'millisecond': '{1}:count millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'a_millisecond': '{1}a millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'ms': ':countms',
    'microsecond': '{1}:count microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'a_microsecond': '{1}a microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
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
    'L': 'M/D/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'جنؤری',
    'فرؤری',
    'مارٕچ',
    'اپریل',
    'میٔ',
    'جوٗن',
    'جوٗلایی',
    'اگست',
    'ستمبر',
    'اکتوٗبر',
    'نومبر',
    'دسمبر',
  ],
  monthsShort: [
    'جنؤری',
    'فرؤری',
    'مارٕچ',
    'اپریل',
    'میٔ',
    'جوٗن',
    'جوٗلایی',
    'اگست',
    'ستمبر',
    'اکتوٗبر',
    'نومبر',
    'دسمبر',
  ],
  weekdays: [
    'آتهوار',
    'ژءندروار',
    'بوءںوار',
    'بودهوار',
    'برىسوار',
    'جمع',
    'بٹوار',
  ],
  weekdaysShort: [
    'آتهوار',
    'ژءنتروار',
    'بوءںوار',
    'بودهوار',
    'برىسوار',
    'جمع',
    'بٹوار',
  ],
  weekdaysMin: [
    'آتهوار',
    'ژءنتروار',
    'بوءںوار',
    'بودهوار',
    'برىسوار',
    'جمع',
    'بٹوار',
  ],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  ordinal: _ordinal,
);

// Regional variant: ks_IN
final CarbonLocaleData localeKsIn = localeKs.copyWith(
  localeCode: 'ks_in',
);


// Auto-generated ordinal function
String _ordinal(int number, String period) {
  var lastDigit;
  lastDigit = number % 10;
    return '${number}${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

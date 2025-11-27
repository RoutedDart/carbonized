// AUTO-GENERATED from PHP Carbon locale: ur
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeUr = CarbonLocaleData(
  localeCode: 'ur',
  translationStrings: {
    'year': ':count سال',
    'a_year': 'ایک سال|:count سال',
    'month': ':count ماہ',
    'a_month': 'ایک ماہ|:count ماہ',
    'week': ':count ہفتے',
    'day': ':count دن',
    'a_day': 'ایک دن|:count دن',
    'hour': ':count گھنٹے',
    'a_hour': 'ایک گھنٹہ|:count گھنٹے',
    'minute': ':count منٹ',
    'a_minute': 'ایک منٹ|:count منٹ',
    'second': ':count سیکنڈ',
    'a_second': 'چند سیکنڈ|:count سیکنڈ',
    'ago': ':time قبل',
    'from_now': ':time بعد',
    'after': ':time بعد',
    'before': ':time پہلے',
    'diff_now': 'اب',
    'diff_today': 'آج',
    'diff_today_regexp': 'آج(?:\\s+بوقت)?',
    'diff_yesterday': 'گزشتہ کل',
    'diff_yesterday_regexp': 'گذشتہ(?:\\s+روز)?(?:\\s+بوقت)?',
    'diff_tomorrow': 'آئندہ کل',
    'diff_tomorrow_regexp': 'کل(?:\\s+بوقت)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd، D MMMM YYYY HH:mm',
  },
  months: [
    'جنوری',
    'فروری',
    'مارچ',
    'اپریل',
    'مئی',
    'جون',
    'جولائی',
    'اگست',
    'ستمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  monthsShort: [
    'جنوری',
    'فروری',
    'مارچ',
    'اپریل',
    'مئی',
    'جون',
    'جولائی',
    'اگست',
    'ستمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  weekdays: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  weekdaysShort: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  weekdaysMin: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'ہفتہ'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[آج بوقت] LT',
    'nextDay': '[کل بوقت] LT',
    'nextWeek': 'dddd [بوقت] LT',
    'lastDay': '[گذشتہ روز بوقت] LT',
    'lastWeek': '[گذشتہ] dddd [بوقت] LT',
    'sameElse': 'L',
  },
  listSeparators: ['، ', ' اور '],
  meridiem: _meridiem,
);

// Regional variant: ur_IN
final CarbonLocaleData localeUrIn = localeUr.copyWith(
  localeCode: 'ur_in',
  weekdays: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'سنیچر'],
  weekdaysShort: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'سنیچر'],
  weekdaysMin: ['اتوار', 'پیر', 'منگل', 'بدھ', 'جمعرات', 'جمعہ', 'سنیچر'],
);

// Regional variant: ur_PK
final CarbonLocaleData localeUrPk = localeUr.copyWith(
  localeCode: 'ur_pk',
  weekdays: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
  weekdaysShort: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
  weekdaysMin: ['اتوار', 'پير', 'منگل', 'بدھ', 'جمعرات', 'جمعه', 'هفته'],
);

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'صبح' : 'شام';
}

// AUTO-GENERATED from PHP Carbon locale: fa
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeFa = CarbonLocaleData(
  localeCode: 'fa',
  translationStrings: {
    'year': ':count سال',
    'a_year': 'یک سال|:count سال',
    'y': ':count سال',
    'month': ':count ماه',
    'a_month': 'یک ماه|:count ماه',
    'm': ':count ماه',
    'week': ':count هفته',
    'a_week': 'یک هفته|:count هفته',
    'w': ':count هفته',
    'day': ':count روز',
    'a_day': 'یک روز|:count روز',
    'd': ':count روز',
    'hour': ':count ساعت',
    'a_hour': 'یک ساعت|:count ساعت',
    'h': ':count ساعت',
    'minute': ':count دقیقه',
    'a_minute': 'یک دقیقه|:count دقیقه',
    'min': ':count دقیقه',
    'second': ':count ثانیه',
    's': ':count ثانیه',
    'ago': ':time پیش',
    'from_now': ':time دیگر',
    'after': ':time پس از',
    'before': ':time پیش از',
    'diff_now': 'اکنون',
    'diff_today': 'امروز',
    'diff_today_regexp': 'امروز(?:\\s+ساعت)?',
    'diff_yesterday': 'دیروز',
    'diff_yesterday_regexp': 'دیروز(?:\\s+ساعت)?',
    'diff_tomorrow': 'فردا',
    'diff_tomorrow_regexp': 'فردا(?:\\s+ساعت)?',
  },
  formats: {
    'LT': 'OH:Om',
    'LTS': 'OH:Om:Os',
    'L': 'OD/OM/OY',
    'LL': 'OD MMMM OY',
    'LLL': 'OD MMMM OY OH:Om',
    'LLLL': 'dddd, OD MMMM OY OH:Om',
  },
  months: [
    'ژانویه',
    'فوریه',
    'مارس',
    'آوریل',
    'مه',
    'ژوئن',
    'ژوئیه',
    'اوت',
    'سپتامبر',
    'اکتبر',
    'نوامبر',
    'دسامبر',
  ],
  monthsShort: [
    'ژانویه',
    'فوریه',
    'مارس',
    'آوریل',
    'مه',
    'ژوئن',
    'ژوئیه',
    'اوت',
    'سپتامبر',
    'اکتبر',
    'نوامبر',
    'دسامبر',
  ],
  weekdays: [
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
    'شنبه',
  ],
  weekdaysShort: [
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
    'شنبه',
  ],
  weekdaysMin: ['ی', 'د', 'س', 'چ', 'پ', 'ج', 'ش'],
  firstDayOfWeek: 6,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[امروز ساعت] LT',
    'nextDay': '[فردا ساعت] LT',
    'nextWeek': 'dddd [ساعت] LT',
    'lastDay': '[دیروز ساعت] LT',
    'lastWeek': 'dddd [پیش] [ساعت] LT',
    'sameElse': 'L',
  },
  listSeparators: ['، ', ' و '],
  meridiem: _meridiem,
);

// Regional variant: fa_AF
final CarbonLocaleData localeFaAf = localeFa.copyWith(localeCode: 'fa_af');

// Regional variant: fa_IR
final CarbonLocaleData localeFaIr = localeFa.copyWith(localeCode: 'fa_ir');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'قبل از ظهر' : 'بعد از ظهر';
}

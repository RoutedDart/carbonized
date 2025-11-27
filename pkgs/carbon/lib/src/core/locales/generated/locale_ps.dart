// AUTO-GENERATED from PHP Carbon locale: ps
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localePs = CarbonLocaleData(
  localeCode: 'ps',
  translationStrings: {
    'year': ':count کال|:count کاله',
    'y': ':countکال|:countکاله',
    'month': ':count مياشت|:count مياشتي',
    'm': ':countمياشت|:countمياشتي',
    'week': ':count اونۍ|:count اونۍ',
    'w': ':countاونۍ|:countاونۍ',
    'day': ':count ورځ|:count ورځي',
    'd': ':countورځ|:countورځي',
    'hour': ':count ساعت|:count ساعته',
    'h': ':countساعت|:countساعته',
    'minute': ':count دقيقه|:count دقيقې',
    'min': ':countدقيقه|:countدقيقې',
    'second': ':count ثانيه|:count ثانيې',
    's': ':countثانيه|:countثانيې',
    'ago': ':time دمخه',
    'from_now': ':time له اوس څخه',
    'after': ':time وروسته',
    'before': ':time دمخه',
  },
  formats: {
    'LT': 'H:mm',
    'LTS': 'H:mm:ss',
    'L': 'YYYY/M/d',
    'LL': 'YYYY MMM D',
    'LLL': 'د YYYY د MMMM D H:mm',
    'LLLL': 'dddd د YYYY د MMMM D H:mm',
  },
  months: [
    'جنوري',
    'فبروري',
    'مارچ',
    'اپریل',
    'مۍ',
    'جون',
    'جولای',
    'اگست',
    'سېپتمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  monthsStandalone: [
    'جنوري',
    'فېبروري',
    'مارچ',
    'اپریل',
    'مۍ',
    'جون',
    'جولای',
    'اگست',
    'سپتمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  monthsShort: [
    'جنوري',
    'فبروري',
    'مارچ',
    'اپریل',
    'مۍ',
    'جون',
    'جولای',
    'اگست',
    'سېپتمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ],
  weekdays: ['اتوار', 'ګل', 'نهه', 'شورو', 'زيارت', 'جمعه', 'خالي'],
  weekdaysShort: ['ا', 'ګ', 'ن', 'ش', 'ز', 'ج', 'خ'],
  weekdaysMin: ['ا', 'ګ', 'ن', 'ش', 'ز', 'ج', 'خ'],
  firstDayOfWeek: 6,
  listSeparators: ['، ', ' او '],
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

// Regional variant: ps_AF
final CarbonLocaleData localePsAf = localePs.copyWith(localeCode: 'ps_af');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'غ.م.' : 'غ.و.';
}

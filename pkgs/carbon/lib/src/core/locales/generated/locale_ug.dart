// AUTO-GENERATED from PHP Carbon locale: ug
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeUg = CarbonLocaleData(
  localeCode: 'ug',
  translationStrings: {
    'year': '{1}بىر يىل|:count يىل',
    'month': '{1}بىر ئاي|:count ئاي',
    'week': '{1}بىر ھەپتە|:count ھەپتە',
    'day': '{1}بىر كۈن|:count كۈن',
    'hour': '{1}بىر سائەت|:count سائەت',
    'minute': '{1}بىر مىنۇت|:count مىنۇت',
    'second': '{1}نەچچە سېكونت|:count سېكونت',
    'ago': ':time بۇرۇن',
    'from_now': ':time كېيىن',
    'diff_today': 'بۈگۈن',
    'diff_yesterday': 'تۆنۈگۈن',
    'diff_tomorrow': 'ئەتە',
    'diff_tomorrow_regexp': 'ئەتە(?:\\s+سائەت)?',
    'diff_today_regexp': 'بۈگۈن(?:\\s+سائەت)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'YYYY-MM-DD',
    'LL': 'YYYY-يىلىM-ئاينىڭD-كۈنى',
    'LLL': 'YYYY-يىلىM-ئاينىڭD-كۈنى، HH:mm',
    'LLLL': 'dddd، YYYY-يىلىM-ئاينىڭD-كۈنى، HH:mm',
  },
  months: [
    'يانۋار',
    'فېۋرال',
    'مارت',
    'ئاپرېل',
    'ماي',
    'ئىيۇن',
    'ئىيۇل',
    'ئاۋغۇست',
    'سېنتەبىر',
    'ئۆكتەبىر',
    'نويابىر',
    'دېكابىر',
  ],
  monthsShort: [
    'يانۋار',
    'فېۋرال',
    'مارت',
    'ئاپرېل',
    'ماي',
    'ئىيۇن',
    'ئىيۇل',
    'ئاۋغۇست',
    'سېنتەبىر',
    'ئۆكتەبىر',
    'نويابىر',
    'دېكابىر',
  ],
  weekdays: [
    'يەكشەنبە',
    'دۈشەنبە',
    'سەيشەنبە',
    'چارشەنبە',
    'پەيشەنبە',
    'جۈمە',
    'شەنبە',
  ],
  weekdaysShort: ['يە', 'دۈ', 'سە', 'چا', 'پە', 'جۈ', 'شە'],
  weekdaysMin: ['يە', 'دۈ', 'سە', 'چا', 'پە', 'جۈ', 'شە'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[بۈگۈن سائەت] LT',
    'nextDay': '[ئەتە سائەت] LT',
    'nextWeek': '[كېلەركى] dddd [سائەت] LT',
    'lastDay': '[تۆنۈگۈن] LT',
    'lastWeek': '[ئالدىنقى] dddd [سائەت] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' ۋە '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ug_CN
final CarbonLocaleData localeUgCn = localeUg.copyWith(localeCode: 'ug_cn');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return ((period == 'd' || period == 'D' || period == 'DDD'
          ? '$number-كۈنى'
          : (period == 'w' || period == 'W' ? '$number-ھەپتە' : number)))
      .toString();
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  num time;
  time = hour * 100 + minute;
  if (time < 600) {
    return 'يېرىم كېچە';
  }
  if (time < 900) {
    return 'سەھەر';
  }
  if (time < 1130) {
    return 'چۈشتىن بۇرۇن';
  }
  if (time < 1230) {
    return 'چۈش';
  }
  if (time < 1800) {
    return 'چۈشتىن كېيىن';
  }
  return 'كەچ';
}

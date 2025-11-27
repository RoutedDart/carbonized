// AUTO-GENERATED from PHP Carbon locale: cy
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeCy = CarbonLocaleData(
  localeCode: 'cy',
  translationStrings: {
    'year': '{1}:count flwyddyn|[-Inf,Inf]:count flynedd',
    'a_year': '{1}blwyddyn|[-Inf,Inf]:count flynedd',
    'y': ':countbl',
    'month': ':count mis',
    'a_month': '{1}mis|[-Inf,Inf]:count mis',
    'm': ':countmi',
    'week': ':count wythnos',
    'a_week': '{1}wythnos|[-Inf,Inf]:count wythnos',
    'w': ':countw',
    'day': ':count diwrnod',
    'a_day': '{1}diwrnod|[-Inf,Inf]:count diwrnod',
    'd': ':countd',
    'hour': ':count awr',
    'a_hour': '{1}awr|[-Inf,Inf]:count awr',
    'h': ':counth',
    'minute': ':count munud',
    'a_minute': '{1}munud|[-Inf,Inf]:count munud',
    'min': ':countm',
    'second': ':count eiliad',
    'a_second': '{0,1}ychydig eiliadau|[-Inf,Inf]:count eiliad',
    's': ':counts',
    'ago': ':time yn ôl',
    'from_now': 'mewn :time',
    'after': ':time ar ôl',
    'before': ':time o\'r blaen',
    'diff_now': 'nawr',
    'diff_today': 'Heddiw',
    'diff_today_regexp': 'Heddiw(?:\\s+am)?',
    'diff_yesterday': 'ddoe',
    'diff_yesterday_regexp': 'Ddoe(?:\\s+am)?',
    'diff_tomorrow': 'yfory',
    'diff_tomorrow_regexp': 'Yfory(?:\\s+am)?',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd, D MMMM YYYY HH:mm',
  },
  months: [
    'Ionawr',
    'Chwefror',
    'Mawrth',
    'Ebrill',
    'Mai',
    'Mehefin',
    'Gorffennaf',
    'Awst',
    'Medi',
    'Hydref',
    'Tachwedd',
    'Rhagfyr',
  ],
  monthsShort: [
    'Ion',
    'Chwe',
    'Maw',
    'Ebr',
    'Mai',
    'Meh',
    'Gor',
    'Aws',
    'Med',
    'Hyd',
    'Tach',
    'Rhag',
  ],
  weekdays: [
    'Dydd Sul',
    'Dydd Llun',
    'Dydd Mawrth',
    'Dydd Mercher',
    'Dydd Iau',
    'Dydd Gwener',
    'Dydd Sadwrn',
  ],
  weekdaysShort: ['Sul', 'Llun', 'Maw', 'Mer', 'Iau', 'Gwe', 'Sad'],
  weekdaysMin: ['Su', 'Ll', 'Ma', 'Me', 'Ia', 'Gw', 'Sa'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Heddiw am] LT',
    'nextDay': '[Yfory am] LT',
    'nextWeek': 'dddd [am] LT',
    'lastDay': '[Ddoe am] LT',
    'lastWeek': 'dddd [diwethaf am] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' a '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: cy_GB
final CarbonLocaleData localeCyGb = localeCy.copyWith(localeCode: 'cy_gb');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  return '$number${(number > 20 ? (([40, 50, 60, 80, 100]).contains((number).toInt()) ? 'fed' : 'ain') : ['', 'af', 'il', 'ydd', 'ydd', 'ed', 'ed', 'ed', 'fed', 'fed', 'fed', 'eg', 'fed', 'eg', 'eg', 'fed', 'eg', 'eg', 'fed', 'eg', 'fed'][number])}';
}

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'yb' : 'yh';
}

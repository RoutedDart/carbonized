// AUTO-GENERATED from PHP Carbon locale: my
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeMy = CarbonLocaleData(
  localeCode: 'my',
  translationStrings: {
    'year': ':count နှစ်',
    'a_year': '{1}တစ်နှစ်|[-Inf,Inf]:count နှစ်',
    'y': ':count နှစ်',
    'month': ':count လ',
    'a_month': '{1}တစ်လ|[-Inf,Inf]:count လ',
    'm': ':count လ',
    'week': ':count ပတ်',
    'w': ':count ပတ်',
    'day': ':count ရက်',
    'a_day': '{1}တစ်ရက်|[-Inf,Inf]:count ရက်',
    'd': ':count ရက်',
    'hour': ':count နာရီ',
    'a_hour': '{1}တစ်နာရီ|[-Inf,Inf]:count နာရီ',
    'h': ':count နာရီ',
    'minute': ':count မိနစ်',
    'a_minute': '{1}တစ်မိနစ်|[-Inf,Inf]:count မိနစ်',
    'min': ':count မိနစ်',
    'second': ':count စက္ကန့်',
    'a_second': '{0,1}စက္ကန်.အနည်းငယ်|[-Inf,Inf]:count စက္ကန့်',
    's': ':count စက္ကန့်',
    'ago': 'လွန်ခဲ့သော :time က',
    'from_now': 'လာမည့် :time မှာ',
    'after': ':time ကြာပြီးနောက်',
    'before': ':time မတိုင်ခင်',
    'diff_now': 'အခုလေးတင်',
    'diff_today': 'ယနေ.',
    'diff_yesterday': 'မနေ့က',
    'diff_yesterday_regexp': 'မနေ.က',
    'diff_tomorrow': 'မနက်ဖြန်',
    'diff_before_yesterday': 'တမြန်နေ့က',
    'diff_after_tomorrow': 'တဘက်ခါ',
    'period_recurrences': ':count ကြိမ်',
  },
  formats: {
    'LT': 'Oh:Om A',
    'LTS': 'Oh:Om:Os A',
    'L': 'OD/OM/OY',
    'LL': 'OD MMMM OY',
    'LLL': 'OD MMMM OY Oh:Om A',
    'LLLL': 'dddd OD MMMM OY Oh:Om A',
  },
  months: [
    'ဇန်နဝါရီ',
    'ဖေဖော်ဝါရီ',
    'မတ်',
    'ဧပြီ',
    'မေ',
    'ဇွန်',
    'ဇူလိုင်',
    'သြဂုတ်',
    'စက်တင်ဘာ',
    'အောက်တိုဘာ',
    'နိုဝင်ဘာ',
    'ဒီဇင်ဘာ',
  ],
  monthsShort: [
    'ဇန်',
    'ဖေ',
    'မတ်',
    'ပြီ',
    'မေ',
    'ဇွန်',
    'လိုင်',
    'သြ',
    'စက်',
    'အောက်',
    'နို',
    'ဒီ',
  ],
  weekdays: [
    'တနင်္ဂနွေ',
    'တနင်္လာ',
    'အင်္ဂါ',
    'ဗုဒ္ဓဟူး',
    'ကြာသပတေး',
    'သောကြာ',
    'စနေ',
  ],
  weekdaysShort: ['နွေ', 'လာ', 'ဂါ', 'ဟူး', 'ကြာ', 'သော', 'နေ'],
  weekdaysMin: ['နွေ', 'လာ', 'ဂါ', 'ဟူး', 'ကြာ', 'သော', 'နေ'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[ယနေ.] LT [မှာ]',
    'nextDay': '[မနက်ဖြန်] LT [မှာ]',
    'nextWeek': 'dddd LT [မှာ]',
    'lastDay': '[မနေ.က] LT [မှာ]',
    'lastWeek': '[ပြီးခဲ့သော] dddd LT [မှာ]',
    'sameElse': 'L',
  },
  periodRecurrences: ':count ကြိမ်',
  meridiem: _meridiem,
);

// Regional variant: my_MM
final CarbonLocaleData localeMyMm = localeMy.copyWith(localeCode: 'my_mm');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'နံနက်' : 'ညနေ';
}

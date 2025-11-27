// AUTO-GENERATED from PHP Carbon locale: ka
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKa = CarbonLocaleData(
  localeCode: 'ka',
  translationStrings: {
    'year': ':count წელი',
    'y': ':count წელი',
    'a_year': '{1}წელი|[-Inf,Inf]:count წელი',
    'month': ':count თვე',
    'm': ':count თვე',
    'a_month': '{1}თვე|[-Inf,Inf]:count თვე',
    'week': ':count კვირა',
    'w': ':count კვირა',
    'a_week': '{1}კვირა|[-Inf,Inf]:count კვირა',
    'day': ':count დღე',
    'd': ':count დღე',
    'a_day': '{1}დღე|[-Inf,Inf]:count დღე',
    'hour': ':count საათი',
    'h': ':count საათი',
    'a_hour': '{1}საათი|[-Inf,Inf]:count საათი',
    'minute': ':count წუთი',
    'min': ':count წუთი',
    'a_minute': '{1}წუთი|[-Inf,Inf]:count წუთი',
    'second': ':count წამი',
    's': ':count წამი',
    'a_second': '{1}რამდენიმე წამი|[-Inf,Inf]:count წამი',
    'ago': ':time წინ',
    'from_now': ':time',
    'after': ':time შემდეგ',
    'before': ':time ადრე',
    'diff_now': 'ახლა',
    'diff_today': 'დღეს',
    'diff_yesterday': 'გუშინ',
    'diff_tomorrow': 'ხვალ',
    'months_regexp': '/(D[oD]?(\\[[^\\[\\]]*\\]|\\s)+MMMM?|L{2,4}|l{2,4})/',
    'weekdays_regexp': '/^([^d].*|.*[^d])\$/',
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
    'იანვარი',
    'თებერვალი',
    'მარტი',
    'აპრილი',
    'მაისი',
    'ივნისი',
    'ივლისი',
    'აგვისტო',
    'სექტემბერი',
    'ოქტომბერი',
    'ნოემბერი',
    'დეკემბერი',
  ],
  monthsStandalone: [
    'იანვარს',
    'თებერვალს',
    'მარტს',
    'აპრილს',
    'მაისს',
    'ივნისს',
    'ივლისს',
    'აგვისტოს',
    'სექტემბერს',
    'ოქტომბერს',
    'ნოემბერს',
    'დეკემბერს',
  ],
  monthsShort: [
    'იან',
    'თებ',
    'მარ',
    'აპრ',
    'მაი',
    'ივნ',
    'ივლ',
    'აგვ',
    'სექ',
    'ოქტ',
    'ნოე',
    'დეკ',
  ],
  weekdays: [
    'კვირას',
    'ორშაბათს',
    'სამშაბათს',
    'ოთხშაბათს',
    'ხუთშაბათს',
    'პარასკევს',
    'შაბათს',
  ],
  weekdaysShort: ['კვი', 'ორშ', 'სამ', 'ოთხ', 'ხუთ', 'პარ', 'შაბ'],
  weekdaysMin: ['კვ', 'ორ', 'სა', 'ოთ', 'ხუ', 'პა', 'შა'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[დღეს], LT[-ზე]',
    'nextDay': '[ხვალ], LT[-ზე]',
    'lastDay': '[გუშინ], LT[-ზე]',
    'lastWeek': '[წინა] dddd, LT-ზე',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' და '],
  ordinal: _ordinal,
  meridiem: _meridiem,
);

// Regional variant: ka_GE
final CarbonLocaleData localeKaGe = localeKa.copyWith(localeCode: 'ka_ge');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  if (number == 0) {
    return (number).toString();
  }
  if (number == 1) {
    return '$number-ლი';
  }
  if (number < 20 || number <= 100 && number % 20 == 0 || number % 100 == 0) {
    return 'მე-$number';
  }
  return '$number-ე';
}

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour >= 4) {
    if (hour < 11) {
      return 'დილის';
    }
    if (hour < 16) {
      return 'შუადღის';
    }
    if (hour < 22) {
      return 'საღამოს';
    }
  }
  return 'ღამის';
}

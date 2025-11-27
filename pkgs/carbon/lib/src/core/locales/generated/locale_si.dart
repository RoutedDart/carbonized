// AUTO-GENERATED from PHP Carbon locale: si
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeSi = CarbonLocaleData(
  localeCode: 'si',
  translationStrings: {
    'year': '{1}වසර 1|වසර :count',
    'a_year': '{1}වසරක්|වසර :count',
    'month': '{1}මාස 1|මාස :count',
    'a_month': '{1}මාසය|මාස :count',
    'week': '{1}සති 1|සති :count',
    'a_week': '{1}සතියක්|සති :count',
    'day': '{1}දින 1|දින :count',
    'a_day': '{1}දිනක්|දින :count',
    'hour': '{1}පැය 1|පැය :count',
    'a_hour': '{1}පැයක්|පැය :count',
    'minute': '{1}මිනිත්තු 1|මිනිත්තු :count',
    'a_minute': '{1}මිනිත්තුවක්|මිනිත්තු :count',
    'second': '{1}තත්පර 1|තත්පර :count',
    'a_second': '{1}තත්පර කිහිපයකට|තත්පර :count',
    'ago': ':time කට පෙර',
    'from_now': ':time කින්',
    'before': ':time කට පෙර',
    'after': ':time කින්',
    'diff_now': 'දැන්',
    'diff_today': 'අද',
    'diff_yesterday': 'ඊයේ',
    'diff_tomorrow': 'හෙට',
  },
  formats: {
    'LT': 'a h:mm',
    'LTS': 'a h:mm:ss',
    'L': 'YYYY/MM/DD',
    'LL': 'YYYY MMMM D',
    'LLL': 'YYYY MMMM D, a h:mm',
    'LLLL': 'YYYY MMMM D [වැනි] dddd, a h:mm:ss',
  },
  months: [
    'ජනවාරි',
    'පෙබරවාරි',
    'මාර්තු',
    'අප්‍රේල්',
    'මැයි',
    'ජූනි',
    'ජූලි',
    'අගෝස්තු',
    'සැප්තැම්බර්',
    'ඔක්තෝබර්',
    'නොවැම්බර්',
    'දෙසැම්බර්',
  ],
  monthsShort: [
    'ජන',
    'පෙබ',
    'මාර්',
    'අප්',
    'මැයි',
    'ජූනි',
    'ජූලි',
    'අගෝ',
    'සැප්',
    'ඔක්',
    'නොවැ',
    'දෙසැ',
  ],
  weekdays: [
    'ඉරිදා',
    'සඳුදා',
    'අඟහරුවාදා',
    'බදාදා',
    'බ්‍රහස්පතින්දා',
    'සිකුරාදා',
    'සෙනසුරාදා',
  ],
  weekdaysShort: ['ඉරි', 'සඳු', 'අඟ', 'බදා', 'බ්‍රහ', 'සිකු', 'සෙන'],
  weekdaysMin: ['ඉ', 'ස', 'අ', 'බ', 'බ්‍ර', 'සි', 'සෙ'],
  firstDayOfWeek: 1,
  calendar: {
    'sameDay': '[අද] LT[ට]',
    'nextDay': '[හෙට] LT[ට]',
    'nextWeek': 'dddd LT[ට]',
    'lastDay': '[ඊයේ] LT[ට]',
    'lastWeek': '[පසුගිය] dddd LT[ට]',
    'sameElse': 'L',
  },
  meridiem: _meridiem,
);

// Regional variant: si_LK
final CarbonLocaleData localeSiLk = localeSi.copyWith(localeCode: 'si_lk');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'පෙර වරු' : 'පස් වරු';
}

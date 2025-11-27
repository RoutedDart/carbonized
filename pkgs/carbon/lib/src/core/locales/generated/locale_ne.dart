// AUTO-GENERATED from PHP Carbon locale: ne
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeNe = CarbonLocaleData(
  localeCode: 'ne',
  translationStrings: {
    'year': 'एक बर्ष|:count बर्ष',
    'y': ':count वर्ष',
    'month': 'एक महिना|:count महिना',
    'm': ':count महिना',
    'week': ':count हप्ता',
    'w': ':count हप्ता',
    'day': 'एक दिन|:count दिन',
    'd': ':count दिन',
    'hour': 'एक घण्टा|:count घण्टा',
    'h': ':count घण्टा',
    'minute': 'एक मिनेट|:count मिनेट',
    'min': ':count मिनेट',
    'second': 'केही क्षण|:count सेकेण्ड',
    's': ':count सेकेण्ड',
    'ago': ':time अगाडि',
    'from_now': ':timeमा',
    'after': ':time पछि',
    'before': ':time अघि',
    'diff_now': 'अहिले',
    'diff_today': 'आज',
    'diff_yesterday': 'हिजो',
    'diff_tomorrow': 'भोलि',
  },
  formats: {
    'LT': 'Aको h:mm बजे',
    'LTS': 'Aको h:mm:ss बजे',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY, Aको h:mm बजे',
    'LLLL': 'dddd, D MMMM YYYY, Aको h:mm बजे',
  },
  months: [
    'जनवरी',
    'फेब्रुवरी',
    'मार्च',
    'अप्रिल',
    'मई',
    'जुन',
    'जुलाई',
    'अगष्ट',
    'सेप्टेम्बर',
    'अक्टोबर',
    'नोभेम्बर',
    'डिसेम्बर',
  ],
  monthsShort: [
    'जन.',
    'फेब्रु.',
    'मार्च',
    'अप्रि.',
    'मई',
    'जुन',
    'जुलाई.',
    'अग.',
    'सेप्ट.',
    'अक्टो.',
    'नोभे.',
    'डिसे.',
  ],
  weekdays: [
    'आइतबार',
    'सोमबार',
    'मङ्गलबार',
    'बुधबार',
    'बिहिबार',
    'शुक्रबार',
    'शनिबार',
  ],
  weekdaysShort: ['आइत.', 'सोम.', 'मङ्गल.', 'बुध.', 'बिहि.', 'शुक्र.', 'शनि.'],
  weekdaysMin: ['आ.', 'सो.', 'मं.', 'बु.', 'बि.', 'शु.', 'श.'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[आज] LT',
    'nextDay': '[भोलि] LT',
    'nextWeek': '[आउँदो] dddd[,] LT',
    'lastDay': '[हिजो] LT',
    'lastWeek': '[गएको] dddd[,] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' र '],
  meridiem: _meridiem,
);

// Regional variant: ne_IN
final CarbonLocaleData localeNeIn = localeNe.copyWith(
  localeCode: 'ne_in',
  months: [
    'जनवरी',
    'फेब्रुअरी',
    'मार्च',
    'अप्रिल',
    'मे',
    'जुन',
    'जुलाई',
    'अगस्ट',
    'सेप्टेम्बर',
    'अक्टोबर',
    'नोभेम्बर',
    'डिसेम्बर',
  ],
  monthsShort: [
    'जनवरी',
    'फेब्रुअरी',
    'मार्च',
    'अप्रिल',
    'मे',
    'जुन',
    'जुलाई',
    'अगस्ट',
    'सेप्टेम्बर',
    'अक्टोबर',
    'नोभेम्बर',
    'डिसेम्बर',
  ],
);

// Regional variant: ne_NP
final CarbonLocaleData localeNeNp = localeNe.copyWith(localeCode: 'ne_np');

// Auto-generated meridiem function
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  if (hour < 3) {
    return 'राति';
  }
  if (hour < 12) {
    return 'बिहान';
  }
  if (hour < 16) {
    return 'दिउँसो';
  }
  if (hour < 20) {
    return 'साँझ';
  }
  return 'राति';
}

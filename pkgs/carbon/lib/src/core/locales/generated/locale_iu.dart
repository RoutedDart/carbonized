// AUTO-GENERATED from PHP Carbon locale: iu
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeIu = CarbonLocaleData(
  localeCode: 'iu',
  translationStrings: {
    'year': ':count ᐅᑭᐅᖅ',
    'a_year': ':count ᐅᑭᐅᖅ',
    'y': ':count ᐅᑭᐅᖅ',
    'month': ':count qaammat',
    'a_month': ':count qaammat',
    'm': ':count qaammat',
    'week': ':count sapaatip akunnera',
    'a_week': ':count sapaatip akunnera',
    'w': ':count sapaatip akunnera',
    'day': ':count ulloq',
    'a_day': ':count ulloq',
    'd': ':count ulloq',
    'hour': ':count ikarraq',
    'a_hour': ':count ikarraq',
    'h': ':count ikarraq',
    'minute': ':count titiqqaralaaq',
    'a_minute': ':count titiqqaralaaq',
    'min': ':count titiqqaralaaq',
    'second': ':count marluk',
    'a_second': ':count marluk',
    's': ':count marluk',
    'millisecond':
        '{1}:count millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'a_millisecond':
        '{1}a millisecond|{0}:count milliseconds|[-Inf,Inf]:count milliseconds',
    'ms': ':countms',
    'microsecond':
        '{1}:count microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
    'a_microsecond':
        '{1}a microsecond|{0}:count microseconds|[-Inf,Inf]:count microseconds',
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
    'L': 'MM/DD/YY',
    'LL': 'MMMM D, YYYY',
    'LLL': 'MMMM D, YYYY h:mm A',
    'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  },
  months: [
    'ᔮᓄᐊᓕ',
    'ᕕᕗᐊᓕ',
    'ᒪᔅᓯ',
    'ᐃᐳᓗ',
    'ᒪᐃ',
    'ᔪᓂ',
    'ᔪᓚᐃ',
    'ᐊᒋᓯ',
    'ᓯᑎᕙ',
    'ᐊᑦᑐᕙ',
    'ᓄᕕᕙ',
    'ᑎᓯᕝᕙ',
  ],
  monthsShort: [
    'ᔮᓄ',
    'ᕕᕗ',
    'ᒪᔅ',
    'ᐃᐳ',
    'ᒪᐃ',
    'ᔪᓂ',
    'ᔪᓚ',
    'ᐊᒋ',
    'ᓯᑎ',
    'ᐊᑦ',
    'ᓄᕕ',
    'ᑎᓯ',
  ],
  weekdays: [
    'ᓈᑦᑎᖑᔭᕐᕕᒃ',
    'ᓇᒡᒐᔾᔭᐅ',
    'ᓇᒡᒐᔾᔭᐅᓕᖅᑭᑦ',
    'ᐱᖓᓲᓕᖅᓯᐅᑦ',
    'ᕿᑎᖅᑰᑦ',
    'ᐅᓪᓗᕈᓘᑐᐃᓇᖅ',
    'ᓯᕙᑖᕕᒃ',
  ],
  weekdaysShort: ['ᓈ', 'ᓇ', 'ᓕ', 'ᐱ', 'ᕿ', 'ᐅ', 'ᓯ'],
  weekdaysMin: ['ᓈ', 'ᓇ', 'ᓕ', 'ᐱ', 'ᕿ', 'ᐅ', 'ᓯ'],
  firstDayOfWeek: 0,
  dayOfFirstWeekOfYear: 1,
  listSeparators: [', ', ' and '],
  periodRecurrences: '{1}once|{0}:count times|[-Inf,Inf]:count times',
  periodInterval: 'every :interval',
  periodStartDate: 'from :date',
  periodEndDate: 'to :date',
  ordinal: _ordinal,
  calendar: {
    'sameDay': '[Today at] LT',
    'nextDay': '[Tomorrow at] LT',
    'nextWeek': 'dddd [at] LT',
    'lastDay': '[Yesterday at] LT',
    'lastWeek': '[Last] dddd [at] LT',
    'sameElse': 'L',
  },
);

// Regional variant: iu_CA
final CarbonLocaleData localeIuCa = localeIu.copyWith(localeCode: 'iu_ca');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

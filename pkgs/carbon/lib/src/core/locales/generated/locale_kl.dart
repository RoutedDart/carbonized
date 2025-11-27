// AUTO-GENERATED from PHP Carbon locale: kl
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeKl = CarbonLocaleData(
  localeCode: 'kl',
  translationStrings: {
    'year': '{1}ukioq :count|{0}:count ukiut|[-Inf,Inf]ukiut :count',
    'a_year': '{1}ukioq|{0}:count ukiut|[-Inf,Inf]ukiut :count',
    'y': '{1}:countyr|{0}:countyrs|[-Inf,Inf]:countyrs',
    'month': '{1}qaammat :count|{0}:count qaammatit|[-Inf,Inf]qaammatit :count',
    'a_month': '{1}qaammat|{0}:count qaammatit|[-Inf,Inf]qaammatit :count',
    'm': '{1}:countmo|{0}:countmos|[-Inf,Inf]:countmos',
    'week': '{1}:count sap. ak.|{0}:count sap. ak.|[-Inf,Inf]:count sap. ak.',
    'a_week': '{1}a sap. ak.|{0}:count sap. ak.|[-Inf,Inf]:count sap. ak.',
    'w': ':countw',
    'day': '{1}:count ulloq|{0}:count ullut|[-Inf,Inf]:count ullut',
    'a_day': '{1}a ulloq|{0}:count ullut|[-Inf,Inf]:count ullut',
    'd': ':countd',
    'hour': '{1}:count tiimi|{0}:count tiimit|[-Inf,Inf]:count tiimit',
    'a_hour': '{1}tiimi|{0}:count tiimit|[-Inf,Inf]:count tiimit',
    'h': ':counth',
    'minute': '{1}:count minutsi|{0}:count minutsit|[-Inf,Inf]:count minutsit',
    'a_minute': '{1}a minutsi|{0}:count minutsit|[-Inf,Inf]:count minutsit',
    'min': ':countm',
    'second': '{1}:count sikunti|{0}:count sikuntit|[-Inf,Inf]:count sikuntit',
    'a_second': '{1}sikunti|{0}:count sikuntit|[-Inf,Inf]:count sikuntit',
    's': ':counts',
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
    'ago': ':time matuma siorna',
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
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD.MM.YYYY',
    'LL': 'D. MMMM YYYY',
    'LLL': 'D. MMMM YYYY HH:mm',
    'LLLL': 'dddd [d.] D. MMMM YYYY [kl.] HH:mm',
  },
  months: [
    'januaarip',
    'februaarip',
    'marsip',
    'apriilip',
    'maajip',
    'juunip',
    'juulip',
    'aggustip',
    'septembarip',
    'oktobarip',
    'novembarip',
    'decembarip',
  ],
  monthsShort: [
    'jan',
    'feb',
    'mar',
    'apr',
    'maj',
    'jun',
    'jul',
    'aug',
    'sep',
    'okt',
    'nov',
    'dec',
  ],
  weekdays: [
    'sapaat',
    'ataasinngorneq',
    'marlunngorneq',
    'pingasunngorneq',
    'sisamanngorneq',
    'tallimanngorneq',
    'arfininngorneq',
  ],
  weekdaysShort: ['sap', 'ata', 'mar', 'pin', 'sis', 'tal', 'arf'],
  weekdaysMin: ['sap', 'ata', 'mar', 'pin', 'sis', 'tal', 'arf'],
  firstDayOfWeek: 1,
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

// Regional variant: kl_GL
final CarbonLocaleData localeKlGl = localeKl.copyWith(localeCode: 'kl_gl');

// Auto-generated ordinal function
String _ordinal(int number, String period) {
  int lastDigit;
  lastDigit = number % 10;
  return '$number${(number % 100 ~/ 10 == 1 ? 'th' : (lastDigit == 1 ? 'st' : (lastDigit == 2 ? 'nd' : (lastDigit == 3 ? 'rd' : 'th'))))}';
}

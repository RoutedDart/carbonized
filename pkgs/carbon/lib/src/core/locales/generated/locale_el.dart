// AUTO-GENERATED from PHP Carbon locale: el
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeEl = CarbonLocaleData(
  localeCode: 'el',
  translationStrings: {
    'year': ':count χρόνος|:count χρόνια',
    'a_year': 'ένας χρόνος|:count χρόνια',
    'y': ':count χρ.',
    'month': ':count μήνας|:count μήνες',
    'a_month': 'ένας μήνας|:count μήνες',
    'm': ':count μήν.',
    'week': ':count εβδομάδα|:count εβδομάδες',
    'a_week': 'μια εβδομάδα|:count εβδομάδες',
    'w': ':count εβδ.',
    'day': ':count μέρα|:count μέρες',
    'a_day': 'μία μέρα|:count μέρες',
    'd': ':count μέρ.',
    'hour': ':count ώρα|:count ώρες',
    'a_hour': 'μία ώρα|:count ώρες',
    'h': ':count ώρα|:count ώρες',
    'minute': ':count λεπτό|:count λεπτά',
    'a_minute': 'ένα λεπτό|:count λεπτά',
    'min': ':count λεπ.',
    'second': ':count δευτερόλεπτο|:count δευτερόλεπτα',
    'a_second': 'λίγα δευτερόλεπτα|:count δευτερόλεπτα',
    's': ':count δευ.',
    'ago': 'πριν :time',
    'from_now': 'σε :time',
    'after': ':time μετά',
    'before': ':time πριν',
    'diff_now': 'τώρα',
    'diff_today': 'Σήμερα',
    'diff_today_regexp': 'Σήμερα(?:\\s+{})?',
    'diff_yesterday': 'χθες',
    'diff_yesterday_regexp': 'Χθες(?:\\s+{})?',
    'diff_tomorrow': 'αύριο',
    'diff_tomorrow_regexp': 'Αύριο(?:\\s+{})?',
    'months_regexp': '/(D[oD]?[\\s,]+MMMM|L{2,4}|l{2,4})/',
  },
  formats: {
    'LT': 'h:mm A',
    'LTS': 'h:mm:ss A',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY h:mm A',
    'LLLL': 'dddd, D MMMM YYYY h:mm A',
  },
  months: [
    'Ιανουαρίου',
    'Φεβρουαρίου',
    'Μαρτίου',
    'Απριλίου',
    'Μαΐου',
    'Ιουνίου',
    'Ιουλίου',
    'Αυγούστου',
    'Σεπτεμβρίου',
    'Οκτωβρίου',
    'Νοεμβρίου',
    'Δεκεμβρίου',
  ],
  monthsStandalone: [
    'Ιανουάριος',
    'Φεβρουάριος',
    'Μάρτιος',
    'Απρίλιος',
    'Μάιος',
    'Ιούνιος',
    'Ιούλιος',
    'Αύγουστος',
    'Σεπτέμβριος',
    'Οκτώβριος',
    'Νοέμβριος',
    'Δεκέμβριος',
  ],
  monthsShort: [
    'Ιαν',
    'Φεβ',
    'Μαρ',
    'Απρ',
    'Μαϊ',
    'Ιουν',
    'Ιουλ',
    'Αυγ',
    'Σεπ',
    'Οκτ',
    'Νοε',
    'Δεκ',
  ],
  weekdays: [
    'Κυριακή',
    'Δευτέρα',
    'Τρίτη',
    'Τετάρτη',
    'Πέμπτη',
    'Παρασκευή',
    'Σάββατο',
  ],
  weekdaysShort: ['Κυρ', 'Δευ', 'Τρι', 'Τετ', 'Πεμ', 'Παρ', 'Σαβ'],
  weekdaysMin: ['Κυ', 'Δε', 'Τρ', 'Τε', 'Πε', 'Πα', 'Σα'],
  firstDayOfWeek: 1,
  dayOfFirstWeekOfYear: 4,
  calendar: {
    'sameDay': '[Σήμερα {}] LT',
    'nextDay': '[Αύριο {}] LT',
    'nextWeek': 'dddd [{}] LT',
    'lastDay': '[Χθες {}] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', ' και '],
  meridiem: _meridiem,
);

// Regional variant: el_CY
final CarbonLocaleData localeElCy = localeEl.copyWith(localeCode: 'el_cy');

// Regional variant: el_GR
final CarbonLocaleData localeElGr = localeEl.copyWith(localeCode: 'el_gr');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ΠΜ' : 'ΜΜ';
}

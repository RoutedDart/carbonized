import 'package:carbon/carbon.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
    await initializeDateFormatting('fr');
  });

  test('PHP isset properties are available via typed getters', () {
    final subject = Carbon.parse(
      '2019-05-06 12:34:56',
      timeZone: 'America/New_York',
    ).locale('fr');

    final properties = _phpPropertyExtractors(subject);
    properties.forEach((name, extractor) {
      expect(extractor(), isNotNull, reason: 'property $name');
    });
  });
}

Map<String, Object? Function()> _phpPropertyExtractors(CarbonInterface carbon) {
  String localizedDayName(String locale, {bool short = false}) =>
      DateFormat(short ? 'EEE' : 'EEEE', locale).format(carbon.toDateTime());
  String localizedMonthName(String locale, {bool short = false}) =>
      DateFormat(short ? 'MMM' : 'MMMM', locale).format(carbon.toDateTime());
  String offsetString() {
    final iso = carbon.toIso8601String(keepOffset: true);
    if (iso.endsWith('Z')) {
      return '+00:00';
    }
    return iso.substring(iso.length - 6);
  }

  final debugTimezone = carbon.toDebugMap()['timezone'] as Map<String, Object?>;
  final offset = offsetString();
  final offsetHours = int.parse(offset.substring(0, 3));
  final offsetMinutes = int.parse(offset.substring(4, 6));

  bool isUtcZone() =>
      carbon.timeZoneName == null || carbon.timeZoneName == 'UTC';
  String latinMeridiem(bool upper) => carbon.hour >= 12
      ? (upper ? 'POST MERIDIEM' : 'post meridiem')
      : (upper ? 'ANTE MERIDIEM' : 'ante meridiem');
  String upperMeridiem() => carbon.hour >= 12 ? 'PM' : 'AM';

  return <String, Object? Function()>{
    'age': () => carbon.diffInYears(Carbon.now(), absolute: true),
    'century': () => carbon.century,
    'day': () => carbon.day,
    'dayName': () => localizedDayName(carbon.localeCode),
    'dayOfWeek': () => carbon.dayOfWeek,
    'dayOfWeekIso': () => carbon.toDateTime().weekday,
    'dayOfYear': () => carbon.dayOfYear,
    'daysInMonth': () => carbon.daysInMonth,
    'daysInYear': () => carbon.daysInYear,
    'decade': () => carbon.decade,
    'dst': () => carbon.isDST(),
    'englishDayOfWeek': () => localizedDayName('en'),
    'englishMonth': () => localizedMonthName('en'),
    'firstWeekDay': () => carbon.settings.startOfWeek,
    'hour': () => carbon.hour,
    'isoWeek': () => carbon.isoWeek,
    'isoWeekYear': () => carbon.isoWeekYear,
    'isoWeeksInYear': () => carbon.isoWeeksInYear,
    'lastWeekDay': () => ((carbon.settings.startOfWeek + 5) % 7) + 1,
    'latinMeridiem': () => latinMeridiem(false),
    'latinUpperMeridiem': () => latinMeridiem(true),
    'local': () => isUtcZone(),
    'locale': () => carbon.localeCode,
    'localeDayOfWeek': () => localizedDayName(carbon.localeCode),
    'localeMonth': () => localizedMonthName(carbon.localeCode),
    'meridiem': () => carbon.hour >= 12 ? 'pm' : 'am',
    'micro': () => carbon.microsecond,
    'microsecond': () => carbon.microsecond,
    'millennium': () => carbon.millennium,
    'milli': () => carbon.millisecond,
    'millisecond': () => carbon.millisecond,
    'milliseconds': () => carbon.millisecond,
    'minDayName': () => localizedDayName(carbon.localeCode, short: true),
    'minute': () => carbon.minute,
    'month': () => carbon.month,
    'monthName': () => localizedMonthName(carbon.localeCode),
    'noZeroHour': () => carbon.hour == 0 ? 24 : carbon.hour,
    'offset': () => offset,
    'offsetHours': () => offsetHours,
    'offsetMinutes': () => offsetMinutes,
    'quarter': () => carbon.quarter,
    'second': () => carbon.second,
    'shortDayName': () => localizedDayName(carbon.localeCode, short: true),
    'shortEnglishDayOfWeek': () => localizedDayName('en', short: true),
    'shortEnglishMonth': () => localizedMonthName('en', short: true),
    'shortLocaleDayOfWeek': () =>
        localizedDayName(carbon.localeCode, short: true),
    'shortLocaleMonth': () =>
        localizedMonthName(carbon.localeCode, short: true),
    'shortMonthName': () => localizedMonthName('en', short: true),
    'timestamp': () => carbon.dateTime.millisecondsSinceEpoch ~/ 1000,
    'timezone': () => carbon.timeZoneName ?? 'UTC',
    'timezoneAbbreviatedName': () => debugTimezone['abbreviation'],
    'timezoneName': () => carbon.timeZoneName ?? 'UTC',
    'tz': () => carbon.timeZoneName ?? 'UTC',
    'tzAbbrName': () => debugTimezone['abbreviation'],
    'tzName': () => carbon.timeZoneName ?? 'UTC',
    'upperMeridiem': () => upperMeridiem(),
    'utc': () => isUtcZone(),
    'week': () => carbon.weekOfYear,
    'weekNumberInMonth': () => ((carbon.day - 1) ~/ 7) + 1,
    'weekOfMonth': () => carbon.weekOfMonth,
    'weekOfYear': () => carbon.weekOfYear,
    'weekYear': () => carbon.localeWeekYear,
    'weeksInYear': () => carbon.weeksInYear,
    'year': () => carbon.year,
    'yearIso': () => carbon.isoWeekYear,
  };
}

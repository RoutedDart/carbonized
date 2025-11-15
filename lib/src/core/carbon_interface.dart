part of '../carbon.dart';

abstract class CarbonInterface implements Comparable<CarbonInterface> {
  DateTime get dateTime;
  String get localeCode;
  String? get timeZoneName;
  CarbonSettings get settings;

  CarbonInterface copyWith({
    DateTime? dateTime,
    String? locale,
    String? timeZone,
    CarbonSettings? settings,
  });

  CarbonInterface locale(String locale);
  CarbonInterface tz(String zoneName);
  CarbonInterface toUtc();
  CarbonInterface toLocal();

  CarbonInterface add(Duration duration);
  CarbonInterface subtract([dynamic value, dynamic unit]);
  CarbonInterface sub([dynamic value, dynamic unit]);
  CarbonInterface addDays(int days);
  CarbonInterface addWeeks(int weeks);
  CarbonInterface addWeekdays(int weekdays);
  CarbonInterface addWeekday([int amount = 1]);
  CarbonInterface addMonths(int months);
  CarbonInterface addYears(int years);
  CarbonInterface subWeekdays(int weekdays);
  CarbonInterface subWeekday([int amount = 1]);
  CarbonInterface nextWeekday();
  CarbonInterface previousWeekday();
  CarbonInterface nextWeekendDay();
  CarbonInterface previousWeekendDay();

  CarbonInterface startOfDay();
  CarbonInterface endOfDay();
  CarbonInterface startOfWeek();
  CarbonInterface endOfWeek();
  CarbonInterface startOfMonth();
  CarbonInterface endOfMonth();
  CarbonInterface firstOfMonth([dynamic weekday]);
  CarbonInterface lastOfMonth([dynamic weekday]);
  CarbonInterface? nthOfMonth(int nth, [dynamic weekday]);
  CarbonInterface startOfYear();
  CarbonInterface endOfYear();
  CarbonInterface firstOfYear([dynamic weekday]);
  CarbonInterface lastOfYear([dynamic weekday]);
  CarbonInterface? nthOfYear(int nth, [dynamic weekday]);
  CarbonInterface firstOfQuarter([dynamic weekday]);
  CarbonInterface lastOfQuarter([dynamic weekday]);
  CarbonInterface? nthOfQuarter(int nth, [dynamic weekday]);
  CarbonInterface startOfHour();
  CarbonInterface endOfHour();
  CarbonInterface startOfMinute();
  CarbonInterface endOfMinute();
  CarbonInterface startOfSecond();
  CarbonInterface endOfSecond();
  CarbonInterface startOfQuarter();
  CarbonInterface endOfQuarter();
  CarbonInterface startOfDecade();
  CarbonInterface endOfDecade();
  CarbonInterface startOfCentury();
  CarbonInterface endOfCentury();
  CarbonInterface startOfMillennium();
  CarbonInterface endOfMillennium();
  CarbonInterface midDay();
  CarbonInterface startOf(dynamic unit);
  CarbonInterface endOf(dynamic unit);
  CarbonInterface average([dynamic other]);
  CarbonInterface modify(String expression);
  CarbonInterface relative(String expression);
  CarbonInterface next([dynamic weekday]);
  CarbonInterface previous([dynamic weekday]);
  CarbonInterface addRealSeconds(num value);
  CarbonInterface subRealSeconds(num value);
  CarbonInterface addRealMinutes(num value);
  CarbonInterface subRealMinutes(num value);
  CarbonInterface addRealHours(num value);
  CarbonInterface subRealHours(num value);
  CarbonInterface addRealDays(num value);
  CarbonInterface subRealDays(num value);
  CarbonInterface addRealWeeks(num value);
  CarbonInterface subRealWeeks(num value);
  CarbonInterface addRealMonths(num value);
  CarbonInterface subRealMonths(num value);
  CarbonInterface addRealQuarters(num value);
  CarbonInterface subRealQuarters(num value);
  CarbonInterface addRealYears(num value);
  CarbonInterface subRealYears(num value);
  CarbonInterface addRealDecades(num value);
  CarbonInterface subRealDecades(num value);
  CarbonInterface addRealCenturies(num value);
  CarbonInterface subRealCenturies(num value);
  CarbonInterface addRealMillennia(num value);
  CarbonInterface subRealMillennia(num value);

  bool eq(dynamic other);
  bool equalTo(dynamic other);
  bool ne(dynamic other);
  bool notEqualTo(dynamic other);
  bool gt(dynamic other);
  bool greaterThan(dynamic other);
  bool gte(dynamic other);
  bool greaterThanOrEqual(dynamic other);
  bool lt(dynamic other);
  bool lessThan(dynamic other);
  bool lte(dynamic other);
  bool lessThanOrEqual(dynamic other);
  bool between(dynamic start, dynamic end, {bool inclusive = true});
  bool betweenIncluded(dynamic start, dynamic end);
  bool betweenExcluded(dynamic start, dynamic end);

  bool isBefore(CarbonInterface other);
  bool isAfter(CarbonInterface other);
  bool isSameDay(CarbonInterface other);
  bool isBetween(
    CarbonInterface start,
    CarbonInterface end, {
    bool inclusive = true,
  });
  bool isWeekday();
  bool isWeekend();
  bool isYesterday();
  bool isToday();
  bool isTomorrow();
  bool isFuture();
  bool isPast();
  bool isNowOrFuture();
  bool isNowOrPast();
  bool isLeapYear();
  CarbonInterface min([dynamic other]);
  CarbonInterface minimum([dynamic other]);
  CarbonInterface max([dynamic other]);
  CarbonInterface maximum([dynamic other]);
  CarbonInterface closest(dynamic date1, dynamic date2);
  CarbonInterface farthest(dynamic date1, dynamic date2);
  bool isBirthday([dynamic comparison]);
  bool isCurrentMicro();
  bool isCurrentMicrosecond();
  bool isCurrentMilli();
  bool isCurrentMillisecond();
  bool isCurrentSecond();
  bool isCurrentMinute();
  bool isCurrentHour();
  bool isCurrentDay();
  bool isCurrentWeek();
  bool isCurrentMonth();
  bool isCurrentQuarter();
  bool isCurrentYear();
  bool isCurrentDecade();
  bool isCurrentCentury();
  bool isCurrentMillennium();
  bool isNextMicro();
  bool isNextMicrosecond();
  bool isNextMilli();
  bool isNextMillisecond();
  bool isNextSecond();
  bool isNextMinute();
  bool isNextHour();
  bool isNextDay();
  bool isNextWeek();
  bool isNextMonth();
  bool isNextQuarter();
  bool isNextYear();
  bool isNextDecade();
  bool isNextCentury();
  bool isNextMillennium();
  bool isLastMicro();
  bool isLastMicrosecond();
  bool isLastMilli();
  bool isLastMillisecond();
  bool isLastSecond();
  bool isLastMinute();
  bool isLastHour();
  bool isLastDay();
  bool isLastWeek();
  bool isLastMonth();
  bool isLastQuarter();
  bool isLastYear();
  bool isLastDecade();
  bool isLastCentury();
  bool isLastMillennium();
  bool isSameMicro([CarbonInterface? other]);
  bool isSameMicrosecond([CarbonInterface? other]);
  bool isSameMilli([CarbonInterface? other]);
  bool isSameMillisecond([CarbonInterface? other]);
  bool isSameSecond([CarbonInterface? other]);
  bool isSameMinute([CarbonInterface? other]);
  bool isSameHour([CarbonInterface? other]);
  bool isSameWeek([CarbonInterface? other]);
  bool isSameMonth([CarbonInterface? other]);
  bool isSameQuarter([CarbonInterface? other]);
  bool isSameYear([CarbonInterface? other]);
  bool isSameDecade([CarbonInterface? other]);
  bool isSameCentury([CarbonInterface? other]);
  bool isSameMillennium([CarbonInterface? other]);
  bool isMonday();
  bool isTuesday();
  bool isWednesday();
  bool isThursday();
  bool isFriday();
  bool isSaturday();
  bool isSunday();
  bool isDST();
  bool get isLocal;
  bool get isUtc;
  bool get isValid;
  bool get isMutable;

  Duration diff(CarbonInterface other);
  int diffInDays(CarbonInterface other, {bool absolute = true});
  int diffInHours(CarbonInterface other, {bool absolute = true});
  int diffInMinutes(CarbonInterface other, {bool absolute = true});
  int diffInSeconds(CarbonInterface other, {bool absolute = true});
  int diffInWeeks(CarbonInterface other, {bool absolute = true});
  int diffInMonths(CarbonInterface other, {bool absolute = true});
  int diffInQuarters(CarbonInterface other, {bool absolute = true});
  int diffInYears(CarbonInterface other, {bool absolute = true});
  int diffInDecades(CarbonInterface other, {bool absolute = true});
  int diffInCenturies(CarbonInterface other, {bool absolute = true});
  int diffInMillennia(CarbonInterface other, {bool absolute = true});
  int diffInDaysFloored(CarbonInterface other);
  double diffInUTCMicros([dynamic date, bool absolute = true]);
  double diffInUTCMicroseconds([dynamic date, bool absolute = true]);
  double diffInUTCMillis([dynamic date, bool absolute = true]);
  double diffInUTCMilliseconds([dynamic date, bool absolute = true]);
  double diffInUTCSeconds([dynamic date, bool absolute = true]);
  double diffInUTCMinutes([dynamic date, bool absolute = true]);
  double diffInUTCHours([dynamic date, bool absolute = true]);
  double diffInUTCDays([dynamic date, bool absolute = true]);
  double diffInUTCWeeks([dynamic date, bool absolute = true]);
  double diffInUTCMonths([dynamic date, bool absolute = true]);
  double diffInUTCQuarters([dynamic date, bool absolute = true]);
  double diffInUTCYears([dynamic date, bool absolute = true]);
  double diffInUTCDecades([dynamic date, bool absolute = true]);
  double diffInUTCCenturies([dynamic date, bool absolute = true]);
  double diffInUTCMillennia([dynamic date, bool absolute = true]);

  String format(String pattern, {String? locale});
  String toIso8601String({bool keepOffset = false});
  String toIso8601ZuluString();
  String toISOString({bool keepOffset = false});
  String toJsonString();
  String toDateString();
  String toTimeString();
  String toDateTimeString();
  String toDateTimeLocalString([String precision = 'second']);
  DateTime toDateTime();
  DateTime toDate();
  DateTime toDateTimeImmutable();
  String toFormattedDateString();
  String toDayDateTimeString();
  String toFormattedDayDateString();
  String toAtomString();
  String toCookieString();
  String isoFormat(String pattern);
  String translatedFormat(String pattern);
  Map<String, Object?> toDebugMap();
  String toRfc822String();
  String toRfc850String();
  String toRfc1036String();
  String toRfc1123String();
  String toRfc2822String();
  String toRfc3339String({bool extended = false});
  String toRssString();
  String toW3cString();
  String toRfc7231String();
  String diffForHumans({CarbonInterface? reference, String? locale});
  String longAbsoluteDiffForHumans([CarbonInterface? other]);
  String longRelativeDiffForHumans([CarbonInterface? other]);
  String longRelativeToNowDiffForHumans();
  String longRelativeToOtherDiffForHumans(CarbonInterface other);
  int toEpochMilliseconds();

  int get year;
  CarbonInterface setYear(int year);
  CarbonInterface years(int year);
  CarbonInterface setMonths(int month);
  CarbonInterface setMonth(int month);
  CarbonInterface setDay(int day);
  CarbonInterface setDays(int day);
  CarbonInterface setQuarter(int quarter);
  CarbonInterface setDayOfWeek(int weekday);
  int get day;
  int get days;
  int get dayOfWeek;
  int get dayOfMonth;
  int get dayOfYear;
  int get dayOfQuarter;
  int get dayOfDecade;
  int get dayOfCentury;
  int get dayOfMillennium;
  int get quarter;
  int get decade;
  int get century;
  int get millennium;
  int get daysInWeek;
  int get daysInMonth;
  int get daysInQuarter;
  int get daysInYear;
  int get daysInDecade;
  int get daysInCentury;
  int get daysInMillennium;
  CarbonInterface setMinutes(int minute);
  CarbonInterface setMinute(int minute);
  CarbonInterface setSeconds(int second);
  CarbonInterface setSecond(int second);
  CarbonInterface setYears(int year);
  CarbonInterface setHour(int hour);
  CarbonInterface setHours(int hour);
  int get hour;
  int get hours;
  int get hourOfDay;
  int get hourOfWeek;
  int get hourOfMonth;
  int get hourOfQuarter;
  int get hourOfYear;
  int get hourOfDecade;
  int get hourOfCentury;
  int get hourOfMillennium;
  int get hoursInDay;
  int get hoursInWeek;
  int get hoursInMonth;
  int get hoursInQuarter;
  int get hoursInYear;
  int get hoursInDecade;
  int get hoursInCentury;
  int get hoursInMillennium;
  CarbonInterface setMicro(int microsecond);
  CarbonInterface setMicros(int microsecond);
  CarbonInterface setMicrosecond(int microsecond);
  CarbonInterface setMicroseconds(int microsecond);
  CarbonInterface setMilli(int millisecond);
  CarbonInterface setMillis(int millisecond);
  CarbonInterface setMillisecond(int millisecond);
  CarbonInterface setMilliseconds(int millisecond);
  CarbonInterface setDate(int year, [int? month, int? day]);
  CarbonInterface setTime(
    int hour, [
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]);
  int get micro;
  int get micros;
  int get microsecond;
  int get microseconds;
  int get microsecondOfMillisecond;
  int get microsecondOfSecond;
  int get microsecondOfMinute;
  int get microsecondOfHour;
  int get microsecondOfDay;
  int get microsecondOfWeek;
  int get microsecondOfMonth;
  int get microsecondOfQuarter;
  int get microsecondOfYear;
  int get microsecondOfDecade;
  int get microsecondOfCentury;
  int get microsecondOfMillennium;
  int get microsecondsInMillisecond;
  int get microsecondsInSecond;
  int get microsecondsInMinute;
  int get microsecondsInHour;
  int get microsecondsInDay;
  int get microsecondsInWeek;
  int get microsecondsInMonth;
  int get microsecondsInQuarter;
  int get microsecondsInYear;
  int get microsecondsInDecade;
  int get microsecondsInCentury;
  int get microsecondsInMillennium;
  CarbonPeriod microsecondsUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod microsUntil([dynamic endDate, num factor = 1]);
  int get milli;
  int get millis;
  int get millisecond;
  int get milliseconds;
  int get millisecondOfSecond;
  int get millisecondOfMinute;
  int get millisecondOfHour;
  int get millisecondOfDay;
  int get millisecondOfWeek;
  int get millisecondOfMonth;
  int get millisecondOfQuarter;
  int get millisecondOfYear;
  int get millisecondOfDecade;
  int get millisecondOfCentury;
  int get millisecondOfMillennium;
  int get millisecondsInSecond;
  int get millisecondsInMinute;
  int get millisecondsInHour;
  int get millisecondsInDay;
  int get millisecondsInWeek;
  int get millisecondsInMonth;
  int get millisecondsInQuarter;
  int get millisecondsInYear;
  int get millisecondsInDecade;
  int get millisecondsInCentury;
  int get millisecondsInMillennium;
  CarbonPeriod millisecondsUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod millisUntil([dynamic endDate, num factor = 1]);
  int get yearOfCentury;
  int get yearOfDecade;
  int get yearOfMillennium;
  int get yearsInCentury;
  int get yearsInDecade;
  int get yearsInMillennium;
  int get centuryOfMillennium;
  int get centuriesInMillennium;
  CarbonPeriod centuriesUntil([dynamic endDate, num factor = 1]);
  int get decadeOfCentury;
  int get decadeOfMillennium;
  int get decadesInCentury;
  int get decadesInMillennium;
  CarbonPeriod decadesUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod millenniaUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod yearsUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod monthsUntil([dynamic endDate, num factor = 1]);
  int get months;
  int get month;
  int get monthOfYear;
  int get monthOfQuarter;
  int get monthOfDecade;
  int get monthOfCentury;
  int get monthOfMillennium;
  int get monthsInYear;
  int get monthsInDecade;
  int get monthsInCentury;
  int get monthsInMillennium;
  int get monthsInQuarter;
  int get weekOfYear;
  int get weekOfMonth;
  int get weekOfQuarter;
  int get weekOfDecade;
  int get weekOfCentury;
  int get weekOfMillennium;
  int get weeksInMonth;
  int get weeksInQuarter;
  int get weeksInYear;
  int get weeksInDecade;
  int get weeksInCentury;
  int get weeksInMillennium;
  CarbonPeriod weeksUntil([dynamic endDate, num factor = 1]);
  int get quarterOfYear;
  int get quarterOfDecade;
  int get quarterOfCentury;
  int get quarterOfMillennium;
  int get quartersInYear;
  int get quartersInDecade;
  int get quartersInCentury;
  int get quartersInMillennium;
  CarbonPeriod quartersUntil([dynamic endDate, num factor = 1]);
  int get secondsInMinute;
  int get secondsInHour;
  int get secondsInDay;
  int get secondsInWeek;
  int get secondsInMonth;
  int get secondsInQuarter;
  int get secondsInYear;
  int get secondsInDecade;
  int get secondsInCentury;
  int get secondsInMillennium;
  CarbonPeriod secondsUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod daysUntil([dynamic endDate, num factor = 1]);
  CarbonPeriod hoursUntil([dynamic endDate, num factor = 1]);
  int get second;
  int get minute;
  int get minutes;
  int get minuteOfHour;
  int get minuteOfDay;
  int get minuteOfWeek;
  int get minuteOfMonth;
  int get minuteOfQuarter;
  int get minuteOfYear;
  int get minuteOfDecade;
  int get minuteOfCentury;
  int get minuteOfMillennium;
  int get minutesInHour;
  int get minutesInDay;
  int get minutesInWeek;
  int get minutesInMonth;
  int get minutesInQuarter;
  int get minutesInYear;
  int get minutesInDecade;
  int get minutesInCentury;
  int get minutesInMillennium;
  CarbonPeriod minutesUntil([dynamic endDate, num factor = 1]);
  int get seconds;
  int get secondOfMinute;
  int get secondOfHour;
  int get secondOfDay;
  int get secondOfWeek;
  int get secondOfMonth;
  int get secondOfQuarter;
  int get secondOfYear;
  int get secondOfDecade;
  int get secondOfCentury;
  int get secondOfMillennium;
  String shortAbsoluteDiffForHumans([CarbonInterface? other]);
  String shortRelativeDiffForHumans([CarbonInterface? other]);
  String shortRelativeToNowDiffForHumans();
  String shortRelativeToOtherDiffForHumans(CarbonInterface other);
  CarbonInterface roundSeconds({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundSecond({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilSeconds({double precision = 1});
  CarbonInterface ceilSecond({double precision = 1});
  CarbonInterface floorSeconds({double precision = 1});
  CarbonInterface floorSecond({double precision = 1});
  CarbonInterface roundMinutes({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundMinute({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilMinutes({double precision = 1});
  CarbonInterface ceilMinute({double precision = 1});
  CarbonInterface floorMinutes({double precision = 1});
  CarbonInterface floorMinute({double precision = 1});
  CarbonInterface roundMonths({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundMonth({double precision = 1, String function = 'round'});
  CarbonInterface ceilMonths({double precision = 1});
  CarbonInterface ceilMonth({double precision = 1});
  CarbonInterface floorMonths({double precision = 1});
  CarbonInterface floorMonth({double precision = 1});
  CarbonInterface roundQuarters({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundQuarter({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilQuarters({double precision = 1});
  CarbonInterface ceilQuarter({double precision = 1});
  CarbonInterface floorQuarters({double precision = 1});
  CarbonInterface floorQuarter({double precision = 1});
  CarbonInterface roundYears({double precision = 1, String function = 'round'});
  CarbonInterface roundYear({double precision = 1, String function = 'round'});
  CarbonInterface ceilYears({double precision = 1});
  CarbonInterface ceilYear({double precision = 1});
  CarbonInterface floorYears({double precision = 1});
  CarbonInterface floorYear({double precision = 1});
  CarbonInterface roundHours({double precision = 1, String function = 'round'});
  CarbonInterface roundHour({double precision = 1, String function = 'round'});
  CarbonInterface ceilHours({double precision = 1});
  CarbonInterface ceilHour({double precision = 1});
  CarbonInterface floorHours({double precision = 1});
  CarbonInterface floorHour({double precision = 1});
  CarbonInterface roundDecades({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundDecade({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilDecades({double precision = 1});
  CarbonInterface ceilDecade({double precision = 1});
  CarbonInterface floorDecades({double precision = 1});
  CarbonInterface floorDecade({double precision = 1});
  CarbonInterface roundMillennia({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundMillennium({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilMillennia({double precision = 1});
  CarbonInterface ceilMillennium({double precision = 1});
  CarbonInterface floorMillennia({double precision = 1});
  CarbonInterface floorMillennium({double precision = 1});
  CarbonInterface roundMilliseconds({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundMillisecond({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilMilliseconds({double precision = 1});
  CarbonInterface ceilMillisecond({double precision = 1});
  CarbonInterface floorMilliseconds({double precision = 1});
  CarbonInterface floorMillisecond({double precision = 1});
  CarbonInterface roundMicroseconds({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundMicrosecond({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilMicroseconds({double precision = 1});
  CarbonInterface ceilMicrosecond({double precision = 1});
  CarbonInterface floorMicroseconds({double precision = 1});
  CarbonInterface floorMicrosecond({double precision = 1});
  CarbonInterface roundDays({double precision = 1, String function = 'round'});
  CarbonInterface roundDay({double precision = 1, String function = 'round'});
  CarbonInterface ceilDays({double precision = 1});
  CarbonInterface ceilDay({double precision = 1});
  CarbonInterface floorDays({double precision = 1});
  CarbonInterface floorDay({double precision = 1});
  double secondsSinceMidnight();
  double secondsUntilEndOfDay();
  CarbonInterface roundCenturies({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface roundCentury({
    double precision = 1,
    String function = 'round',
  });
  CarbonInterface ceilCenturies({double precision = 1});
  CarbonInterface ceilCentury({double precision = 1});
  CarbonInterface floorCenturies({double precision = 1});
  CarbonInterface floorCentury({double precision = 1});

  Map<String, dynamic> toJson();
  Map<String, dynamic> toArray();
  CarbonComponents toObject();
  CarbonImmutable toImmutable();
  Carbon toMutable();
}

extension CarbonLocaleAlias on CarbonInterface {
  CarbonInterface setLocale(String locale) => this.locale(locale);
}

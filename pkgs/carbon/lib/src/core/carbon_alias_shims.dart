/// Supplies extension-based alias wrappers so any [CarbonInterface] instance
/// can call the PHP-style helpers such as `addDay()` and `subYear()`.
///
/// ```dart
/// final payday = Carbon.now().addDay();
/// ```
part of '../carbon.dart';

/// Adds the PHP-style alias methods (`addDay`, `subMonth`, etc.) to any
/// [CarbonInterface]. Each alias simply forwards to the canonical method so
/// mixin users get the familiar Carbon API surface.
extension CarbonAliasShims on CarbonInterface {
  CarbonInterface addDay([int amount = 1]) => addDays(amount);

  CarbonInterface subDay([int amount = 1]) => addDays(-amount);

  CarbonInterface subDays(int amount) => addDays(-amount);

  CarbonInterface addWeek([int amount = 1]) => addWeeks(amount);

  CarbonInterface subWeek([int amount = 1]) => addWeeks(-amount);

  CarbonInterface subWeeks(int amount) => addWeeks(-amount);

  CarbonInterface addMonth([int amount = 1]) => addMonths(amount);

  CarbonInterface subMonth([int amount = 1]) => addMonths(-amount);

  CarbonInterface subMonths(int amount) => addMonths(-amount);

  CarbonInterface addYear([int amount = 1]) => addYears(amount);

  CarbonInterface subYear([int amount = 1]) => addYears(-amount);

  CarbonInterface subYears(int amount) => addYears(-amount);

  CarbonInterface addQuarter([int amount = 1]) => addMonths(amount * 3);

  CarbonInterface addQuarters(int amount) => addMonths(amount * 3);

  CarbonInterface subQuarter([int amount = 1]) => addMonths(-amount * 3);

  CarbonInterface subQuarters(int amount) => addMonths(-amount * 3);

  CarbonInterface addDecade([int amount = 1]) => addYears(amount * 10);

  CarbonInterface addDecades(int amount) => addYears(amount * 10);

  CarbonInterface subDecade([int amount = 1]) => addYears(-amount * 10);

  CarbonInterface subDecades(int amount) => addYears(-amount * 10);

  CarbonInterface addCentury([int amount = 1]) => addYears(amount * 100);

  CarbonInterface addCenturies(int amount) => addYears(amount * 100);

  CarbonInterface subCentury([int amount = 1]) => addYears(-amount * 100);

  CarbonInterface subCenturies(int amount) => addYears(-amount * 100);

  CarbonInterface addMillennium([int amount = 1]) => addYears(amount * 1000);

  CarbonInterface addMillennia(int amount) => addYears(amount * 1000);

  CarbonInterface subMillennium([int amount = 1]) => addYears(-amount * 1000);

  CarbonInterface subMillennia(int amount) => addYears(-amount * 1000);

  CarbonInterface addHour([int amount = 1]) => add(Duration(hours: amount));

  CarbonInterface addHours(int amount) => add(Duration(hours: amount));

  CarbonInterface subHour([int amount = 1]) => add(Duration(hours: -amount));

  CarbonInterface subHours(int amount) => add(Duration(hours: -amount));

  CarbonInterface addMinute([int amount = 1]) => add(Duration(minutes: amount));

  CarbonInterface addMinutes(int amount) => add(Duration(minutes: amount));

  CarbonInterface subMinute([int amount = 1]) =>
      add(Duration(minutes: -amount));

  CarbonInterface subMinutes(int amount) => add(Duration(minutes: -amount));

  CarbonInterface addSecond([int amount = 1]) => add(Duration(seconds: amount));

  CarbonInterface addSeconds(int amount) => add(Duration(seconds: amount));

  CarbonInterface subSecond([int amount = 1]) =>
      add(Duration(seconds: -amount));

  CarbonInterface subSeconds(int amount) => add(Duration(seconds: -amount));

  CarbonInterface addMillisecond([int amount = 1]) =>
      add(Duration(milliseconds: amount));

  CarbonInterface addMilliseconds(int amount) =>
      add(Duration(milliseconds: amount));

  CarbonInterface subMillisecond([int amount = 1]) =>
      add(Duration(milliseconds: -amount));

  CarbonInterface subMilliseconds(int amount) =>
      add(Duration(milliseconds: -amount));

  CarbonInterface addMicrosecond([int amount = 1]) =>
      add(Duration(microseconds: amount));

  CarbonInterface addMicroseconds(int amount) =>
      add(Duration(microseconds: amount));

  CarbonInterface subMicrosecond([int amount = 1]) =>
      add(Duration(microseconds: -amount));

  CarbonInterface subMicroseconds(int amount) =>
      add(Duration(microseconds: -amount));

  CarbonInterface addMonthNoOverflow([int amount = 1]) =>
      (this as dynamic).addMonthNoOverflow(amount);

  CarbonInterface addMonthsNoOverflow(int amount) =>
      (this as dynamic).addMonthsNoOverflow(amount);

  CarbonInterface addMonthWithOverflow([int amount = 1]) =>
      (this as dynamic).addMonthWithOverflow(amount);

  CarbonInterface addMonthsWithOverflow(int amount) =>
      (this as dynamic).addMonthsWithOverflow(amount);

  CarbonInterface subMonthNoOverflow([int amount = 1]) =>
      (this as dynamic).subMonthNoOverflow(amount);

  CarbonInterface subMonthsNoOverflow(int amount) =>
      (this as dynamic).subMonthsNoOverflow(amount);

  CarbonInterface subMonthWithOverflow([int amount = 1]) =>
      (this as dynamic).subMonthWithOverflow(amount);

  CarbonInterface subMonthsWithOverflow(int amount) =>
      (this as dynamic).subMonthsWithOverflow(amount);

  CarbonInterface addYearNoOverflow([int amount = 1]) =>
      (this as dynamic).addYearNoOverflow(amount);

  CarbonInterface addYearsNoOverflow(int amount) =>
      (this as dynamic).addYearsNoOverflow(amount);

  CarbonInterface addYearWithOverflow([int amount = 1]) =>
      (this as dynamic).addYearWithOverflow(amount);

  CarbonInterface addYearsWithOverflow(int amount) =>
      (this as dynamic).addYearsWithOverflow(amount);

  CarbonInterface subYearNoOverflow([int amount = 1]) =>
      (this as dynamic).subYearNoOverflow(amount);

  CarbonInterface subYearsNoOverflow(int amount) =>
      (this as dynamic).subYearsNoOverflow(amount);

  CarbonInterface subYearWithOverflow([int amount = 1]) =>
      (this as dynamic).subYearWithOverflow(amount);

  CarbonInterface subYearsWithOverflow(int amount) =>
      (this as dynamic).subYearsWithOverflow(amount);

  CarbonInterface addDecadeNoOverflow([int amount = 1]) =>
      (this as dynamic).addDecadeNoOverflow(amount);

  CarbonInterface addDecadeWithOverflow([int amount = 1]) =>
      (this as dynamic).addDecadeWithOverflow(amount);

  CarbonInterface addDecadesNoOverflow(int amount) =>
      (this as dynamic).addDecadesNoOverflow(amount);

  CarbonInterface addDecadesWithOverflow(int amount) =>
      (this as dynamic).addDecadesWithOverflow(amount);

  CarbonInterface addCenturyNoOverflow([int amount = 1]) =>
      (this as dynamic).addCenturyNoOverflow(amount);

  CarbonInterface addCenturyWithOverflow([int amount = 1]) =>
      (this as dynamic).addCenturyWithOverflow(amount);

  CarbonInterface addMillenniumNoOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniumNoOverflow(amount);

  CarbonInterface addMillenniumWithOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniumWithOverflow(amount);

  // Generated add/sub alias wrappers for CarbonInterface parity
  CarbonInterface addCenturiesNoOverflow([int amount = 1]) =>
      (this as dynamic).addCenturiesNoOverflow(amount);

  CarbonInterface addCenturiesWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addCenturiesWithNoOverflow(amount);

  CarbonInterface addCenturiesWithOverflow([int amount = 1]) =>
      (this as dynamic).addCenturiesWithOverflow(amount);

  CarbonInterface addCenturiesWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addCenturiesWithoutOverflow(amount);

  CarbonInterface addCenturyWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addCenturyWithNoOverflow(amount);

  CarbonInterface addCenturyWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addCenturyWithoutOverflow(amount);

  CarbonInterface addDecadeWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addDecadeWithNoOverflow(amount);

  CarbonInterface addDecadeWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addDecadeWithoutOverflow(amount);

  CarbonInterface addDecadesWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addDecadesWithNoOverflow(amount);

  CarbonInterface addDecadesWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addDecadesWithoutOverflow(amount);

  CarbonInterface addMicro([int amount = 1]) =>
      (this as dynamic).addMicro(amount);

  CarbonInterface addMicros([int amount = 1]) =>
      (this as dynamic).addMicros(amount);

  CarbonInterface addMillenniaNoOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniaNoOverflow(amount);

  CarbonInterface addMillenniaWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniaWithNoOverflow(amount);

  CarbonInterface addMillenniaWithOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniaWithOverflow(amount);

  CarbonInterface addMillenniaWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniaWithoutOverflow(amount);

  CarbonInterface addMillenniumWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniumWithNoOverflow(amount);

  CarbonInterface addMillenniumWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addMillenniumWithoutOverflow(amount);

  CarbonInterface addMilli([int amount = 1]) =>
      (this as dynamic).addMilli(amount);

  CarbonInterface addMillis([int amount = 1]) =>
      (this as dynamic).addMillis(amount);

  CarbonInterface addMonthWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addMonthWithNoOverflow(amount);

  CarbonInterface addMonthWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addMonthWithoutOverflow(amount);

  CarbonInterface addMonthsWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addMonthsWithNoOverflow(amount);

  CarbonInterface addMonthsWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addMonthsWithoutOverflow(amount);

  CarbonInterface addQuarterNoOverflow([int amount = 1]) =>
      (this as dynamic).addQuarterNoOverflow(amount);

  CarbonInterface addQuarterWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addQuarterWithNoOverflow(amount);

  CarbonInterface addQuarterWithOverflow([int amount = 1]) =>
      (this as dynamic).addQuarterWithOverflow(amount);

  CarbonInterface addQuarterWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addQuarterWithoutOverflow(amount);

  CarbonInterface addQuartersNoOverflow([int amount = 1]) =>
      (this as dynamic).addQuartersNoOverflow(amount);

  CarbonInterface addQuartersWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addQuartersWithNoOverflow(amount);

  CarbonInterface addQuartersWithOverflow([int amount = 1]) =>
      (this as dynamic).addQuartersWithOverflow(amount);

  CarbonInterface addQuartersWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addQuartersWithoutOverflow(amount);

  CarbonInterface addUTCCenturies([int amount = 1]) =>
      (this as dynamic).addUTCCenturies(amount);

  CarbonInterface addUTCCentury([int amount = 1]) =>
      (this as dynamic).addUTCCentury(amount);

  CarbonInterface addUTCDay([int amount = 1]) =>
      (this as dynamic).addUTCDay(amount);

  CarbonInterface addUTCDays([int amount = 1]) =>
      (this as dynamic).addUTCDays(amount);

  CarbonInterface addUTCDecade([int amount = 1]) =>
      (this as dynamic).addUTCDecade(amount);

  CarbonInterface addUTCDecades([int amount = 1]) =>
      (this as dynamic).addUTCDecades(amount);

  CarbonInterface addUTCHour([int amount = 1]) =>
      (this as dynamic).addUTCHour(amount);

  CarbonInterface addUTCHours([int amount = 1]) =>
      (this as dynamic).addUTCHours(amount);

  CarbonInterface addUTCMicro([int amount = 1]) =>
      (this as dynamic).addUTCMicro(amount);

  CarbonInterface addUTCMicros([int amount = 1]) =>
      (this as dynamic).addUTCMicros(amount);

  CarbonInterface addUTCMicrosecond([int amount = 1]) =>
      (this as dynamic).addUTCMicrosecond(amount);

  CarbonInterface addUTCMicroseconds([int amount = 1]) =>
      (this as dynamic).addUTCMicroseconds(amount);

  CarbonInterface addUTCMillennia([int amount = 1]) =>
      (this as dynamic).addUTCMillennia(amount);

  CarbonInterface addUTCMillennium([int amount = 1]) =>
      (this as dynamic).addUTCMillennium(amount);

  CarbonInterface addUTCMilli([int amount = 1]) =>
      (this as dynamic).addUTCMilli(amount);

  CarbonInterface addUTCMillis([int amount = 1]) =>
      (this as dynamic).addUTCMillis(amount);

  CarbonInterface addUTCMillisecond([int amount = 1]) =>
      (this as dynamic).addUTCMillisecond(amount);

  CarbonInterface addUTCMilliseconds([int amount = 1]) =>
      (this as dynamic).addUTCMilliseconds(amount);

  CarbonInterface addUTCMinute([int amount = 1]) =>
      (this as dynamic).addUTCMinute(amount);

  CarbonInterface addUTCMinutes([int amount = 1]) =>
      (this as dynamic).addUTCMinutes(amount);

  CarbonInterface addUTCMonth([int amount = 1]) =>
      (this as dynamic).addUTCMonth(amount);

  CarbonInterface addUTCMonths([int amount = 1]) =>
      (this as dynamic).addUTCMonths(amount);

  CarbonInterface addUTCQuarter([int amount = 1]) =>
      (this as dynamic).addUTCQuarter(amount);

  CarbonInterface addUTCQuarters([int amount = 1]) =>
      (this as dynamic).addUTCQuarters(amount);

  CarbonInterface addUTCSecond([int amount = 1]) =>
      (this as dynamic).addUTCSecond(amount);

  CarbonInterface addUTCSeconds([int amount = 1]) =>
      (this as dynamic).addUTCSeconds(amount);

  CarbonInterface addUTCWeek([int amount = 1]) =>
      (this as dynamic).addUTCWeek(amount);

  CarbonInterface addUTCWeeks([int amount = 1]) =>
      (this as dynamic).addUTCWeeks(amount);

  CarbonInterface addUTCYear([int amount = 1]) =>
      (this as dynamic).addUTCYear(amount);

  CarbonInterface addUTCYears([int amount = 1]) =>
      (this as dynamic).addUTCYears(amount);

  CarbonInterface addYearWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addYearWithNoOverflow(amount);

  CarbonInterface addYearWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addYearWithoutOverflow(amount);

  CarbonInterface addYearsWithNoOverflow([int amount = 1]) =>
      (this as dynamic).addYearsWithNoOverflow(amount);

  CarbonInterface addYearsWithoutOverflow([int amount = 1]) =>
      (this as dynamic).addYearsWithoutOverflow(amount);

  CarbonInterface subCenturiesNoOverflow([int amount = 1]) =>
      (this as dynamic).subCenturiesNoOverflow(amount);

  CarbonInterface subCenturiesWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subCenturiesWithNoOverflow(amount);

  CarbonInterface subCenturiesWithOverflow([int amount = 1]) =>
      (this as dynamic).subCenturiesWithOverflow(amount);

  CarbonInterface subCenturiesWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subCenturiesWithoutOverflow(amount);

  CarbonInterface subCenturyNoOverflow([int amount = 1]) =>
      (this as dynamic).subCenturyNoOverflow(amount);

  CarbonInterface subCenturyWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subCenturyWithNoOverflow(amount);

  CarbonInterface subCenturyWithOverflow([int amount = 1]) =>
      (this as dynamic).subCenturyWithOverflow(amount);

  CarbonInterface subCenturyWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subCenturyWithoutOverflow(amount);

  CarbonInterface subDecadeNoOverflow([int amount = 1]) =>
      (this as dynamic).subDecadeNoOverflow(amount);

  CarbonInterface subDecadeWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subDecadeWithNoOverflow(amount);

  CarbonInterface subDecadeWithOverflow([int amount = 1]) =>
      (this as dynamic).subDecadeWithOverflow(amount);

  CarbonInterface subDecadeWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subDecadeWithoutOverflow(amount);

  CarbonInterface subDecadesNoOverflow([int amount = 1]) =>
      (this as dynamic).subDecadesNoOverflow(amount);

  CarbonInterface subDecadesWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subDecadesWithNoOverflow(amount);

  CarbonInterface subDecadesWithOverflow([int amount = 1]) =>
      (this as dynamic).subDecadesWithOverflow(amount);

  CarbonInterface subDecadesWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subDecadesWithoutOverflow(amount);

  CarbonInterface subMicro([int amount = 1]) =>
      (this as dynamic).subMicro(amount);

  CarbonInterface subMicros([int amount = 1]) =>
      (this as dynamic).subMicros(amount);

  CarbonInterface subMillenniaNoOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniaNoOverflow(amount);

  CarbonInterface subMillenniaWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniaWithNoOverflow(amount);

  CarbonInterface subMillenniaWithOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniaWithOverflow(amount);

  CarbonInterface subMillenniaWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniaWithoutOverflow(amount);

  CarbonInterface subMillenniumNoOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniumNoOverflow(amount);

  CarbonInterface subMillenniumWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniumWithNoOverflow(amount);

  CarbonInterface subMillenniumWithOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniumWithOverflow(amount);

  CarbonInterface subMillenniumWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subMillenniumWithoutOverflow(amount);

  CarbonInterface subMilli([int amount = 1]) =>
      (this as dynamic).subMilli(amount);

  CarbonInterface subMillis([int amount = 1]) =>
      (this as dynamic).subMillis(amount);

  CarbonInterface subMonthWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subMonthWithNoOverflow(amount);

  CarbonInterface subMonthWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subMonthWithoutOverflow(amount);

  CarbonInterface subMonthsWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subMonthsWithNoOverflow(amount);

  CarbonInterface subMonthsWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subMonthsWithoutOverflow(amount);

  CarbonInterface subQuarterNoOverflow([int amount = 1]) =>
      (this as dynamic).subQuarterNoOverflow(amount);

  CarbonInterface subQuarterWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subQuarterWithNoOverflow(amount);

  CarbonInterface subQuarterWithOverflow([int amount = 1]) =>
      (this as dynamic).subQuarterWithOverflow(amount);

  CarbonInterface subQuarterWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subQuarterWithoutOverflow(amount);

  CarbonInterface subQuartersNoOverflow([int amount = 1]) =>
      (this as dynamic).subQuartersNoOverflow(amount);

  CarbonInterface subQuartersWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subQuartersWithNoOverflow(amount);

  CarbonInterface subQuartersWithOverflow([int amount = 1]) =>
      (this as dynamic).subQuartersWithOverflow(amount);

  CarbonInterface subQuartersWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subQuartersWithoutOverflow(amount);

  CarbonInterface subUTCCenturies([int amount = 1]) =>
      (this as dynamic).subUTCCenturies(amount);

  CarbonInterface subUTCCentury([int amount = 1]) =>
      (this as dynamic).subUTCCentury(amount);

  CarbonInterface subUTCDay([int amount = 1]) =>
      (this as dynamic).subUTCDay(amount);

  CarbonInterface subUTCDays([int amount = 1]) =>
      (this as dynamic).subUTCDays(amount);

  CarbonInterface subUTCDecade([int amount = 1]) =>
      (this as dynamic).subUTCDecade(amount);

  CarbonInterface subUTCDecades([int amount = 1]) =>
      (this as dynamic).subUTCDecades(amount);

  CarbonInterface subUTCHour([int amount = 1]) =>
      (this as dynamic).subUTCHour(amount);

  CarbonInterface subUTCHours([int amount = 1]) =>
      (this as dynamic).subUTCHours(amount);

  CarbonInterface subUTCMicro([int amount = 1]) =>
      (this as dynamic).subUTCMicro(amount);

  CarbonInterface subUTCMicros([int amount = 1]) =>
      (this as dynamic).subUTCMicros(amount);

  CarbonInterface subUTCMicrosecond([int amount = 1]) =>
      (this as dynamic).subUTCMicrosecond(amount);

  CarbonInterface subUTCMicroseconds([int amount = 1]) =>
      (this as dynamic).subUTCMicroseconds(amount);

  CarbonInterface subUTCMillennia([int amount = 1]) =>
      (this as dynamic).subUTCMillennia(amount);

  CarbonInterface subUTCMillennium([int amount = 1]) =>
      (this as dynamic).subUTCMillennium(amount);

  CarbonInterface subUTCMilli([int amount = 1]) =>
      (this as dynamic).subUTCMilli(amount);

  CarbonInterface subUTCMillis([int amount = 1]) =>
      (this as dynamic).subUTCMillis(amount);

  CarbonInterface subUTCMillisecond([int amount = 1]) =>
      (this as dynamic).subUTCMillisecond(amount);

  CarbonInterface subUTCMilliseconds([int amount = 1]) =>
      (this as dynamic).subUTCMilliseconds(amount);

  CarbonInterface subUTCMinute([int amount = 1]) =>
      (this as dynamic).subUTCMinute(amount);

  CarbonInterface subUTCMinutes([int amount = 1]) =>
      (this as dynamic).subUTCMinutes(amount);

  CarbonInterface subUTCMonth([int amount = 1]) =>
      (this as dynamic).subUTCMonth(amount);

  CarbonInterface subUTCMonths([int amount = 1]) =>
      (this as dynamic).subUTCMonths(amount);

  CarbonInterface subUTCQuarter([int amount = 1]) =>
      (this as dynamic).subUTCQuarter(amount);

  CarbonInterface subUTCQuarters([int amount = 1]) =>
      (this as dynamic).subUTCQuarters(amount);

  CarbonInterface subUTCSecond([int amount = 1]) =>
      (this as dynamic).subUTCSecond(amount);

  CarbonInterface subUTCSeconds([int amount = 1]) =>
      (this as dynamic).subUTCSeconds(amount);

  CarbonInterface subUTCWeek([int amount = 1]) =>
      (this as dynamic).subUTCWeek(amount);

  CarbonInterface subUTCWeeks([int amount = 1]) =>
      (this as dynamic).subUTCWeeks(amount);

  CarbonInterface subUTCYear([int amount = 1]) =>
      (this as dynamic).subUTCYear(amount);

  CarbonInterface subUTCYears([int amount = 1]) =>
      (this as dynamic).subUTCYears(amount);

  CarbonInterface subYearWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subYearWithNoOverflow(amount);

  CarbonInterface subYearWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subYearWithoutOverflow(amount);

  CarbonInterface subYearsWithNoOverflow([int amount = 1]) =>
      (this as dynamic).subYearsWithNoOverflow(amount);

  CarbonInterface subYearsWithoutOverflow([int amount = 1]) =>
      (this as dynamic).subYearsWithoutOverflow(amount);
}

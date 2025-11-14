part of '../carbon.dart';

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

  CarbonInterface subHour([int amount = 1]) => add(Duration(hours: -amount));

  CarbonInterface subHours(int amount) => add(Duration(hours: -amount));

  CarbonInterface addMinute([int amount = 1]) => add(Duration(minutes: amount));

  CarbonInterface subMinute([int amount = 1]) => add(Duration(minutes: -amount));

  CarbonInterface subMinutes(int amount) => add(Duration(minutes: -amount));

  CarbonInterface addSecond([int amount = 1]) => add(Duration(seconds: amount));

  CarbonInterface subSecond([int amount = 1]) => add(Duration(seconds: -amount));

  CarbonInterface subSeconds(int amount) => add(Duration(seconds: -amount));

  CarbonInterface addMillisecond([int amount = 1]) =>
      add(Duration(milliseconds: amount));

  CarbonInterface subMillisecond([int amount = 1]) =>
      add(Duration(milliseconds: -amount));

  CarbonInterface subMilliseconds(int amount) =>
      add(Duration(milliseconds: -amount));

  CarbonInterface addMicrosecond([int amount = 1]) =>
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

  CarbonInterface addWeekday() => (this as dynamic).addWeekday();

  CarbonInterface addWeekdays(int amount) =>
      (this as dynamic).addWeekdays(amount);

  CarbonInterface subWeekday() => (this as dynamic).subWeekday();

  CarbonInterface subWeekdays(int amount) =>
      (this as dynamic).subWeekdays(amount);
}

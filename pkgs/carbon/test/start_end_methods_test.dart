import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon start/end helpers', () {
    test('startOfDay and endOfDay reset boundaries', () {
      final CarbonInterface value = Carbon.create(
        year: 2025,
        month: 11,
        day: 14,
        hour: 18,
        minute: 45,
        second: 12,
        millisecond: 456,
        microsecond: 789,
      );

      final start = value.copyWith().startOfDay();
      expect(start.hour, 0);
      expect(start.minute, 0);
      expect(start.second, 0);
      expect(start.microsecond, 0);

      final end = value.copyWith().endOfDay();
      expect(end.hour, 23);
      expect(end.minute, 59);
      expect(end.second, 59);
      expect(end.microsecond, 999999);
    });

    test('start/end of hour/minute/second trim the smaller units', () {
      final CarbonInterface sample = Carbon.create(
        year: 2030,
        month: 6,
        day: 10,
        hour: 12,
        minute: 34,
        second: 56,
        millisecond: 789,
        microsecond: 123,
      );

      expect(sample.copyWith().startOfHour().minute, 0);
      expect(sample.copyWith().endOfHour().minute, 59);
      expect(sample.copyWith().endOfHour().microsecond, 999999);

      expect(sample.copyWith().startOfMinute().second, 0);
      expect(sample.copyWith().endOfMinute().second, 59);

      expect(sample.copyWith().startOfSecond().microsecond, 0);
      expect(sample.copyWith().endOfSecond().microsecond, 999999);
    });

    test('start/end of week honor custom startOfWeek setting', () {
      final CarbonInterface date = Carbon.create(
        year: 2025,
        month: 11,
        day: 12,
        settings: const CarbonSettings(startOfWeek: DateTime.sunday),
      );

      final weekStart = date.copyWith().startOfWeek();
      expect(weekStart.dayOfWeek, DateTime.sunday % 7);
      expect(weekStart.day, 9);

      final weekEnd = date.copyWith().endOfWeek();
      expect(weekEnd.day, 15);
      expect(weekEnd.hour, 23);
      expect(weekEnd.minute, 59);
      expect(weekEnd.microsecond, 999999);
    });

    test('start/end of month and quarter land on correct calendar days', () {
      final CarbonInterface jan = Carbon.create(year: 2024, month: 1, day: 31);
      final startMonth = jan.copyWith().startOfMonth();
      expect(startMonth.day, 1);
      final endMonth = jan.copyWith().endOfMonth();
      expect(endMonth.day, 31);
      expect(endMonth.hour, 23);

      final CarbonInterface may = Carbon.create(year: 2024, month: 5, day: 18);
      final startQuarter = may.copyWith().startOfQuarter();
      expect(startQuarter.month, 4);
      expect(startQuarter.day, 1);

      final endQuarter = may.copyWith().endOfQuarter();
      expect(endQuarter.month, 6);
      expect(endQuarter.day, 30);
      expect(endQuarter.minute, 59);
    });

    test('start/end of decade/century/millennium clamp year ranges', () {
      final CarbonInterface sample = Carbon.create(
        year: 2099,
        month: 12,
        day: 15,
      );

      final startDecade = sample.copyWith().startOfDecade();
      expect(startDecade.year, 2090);
      final endDecade = sample.copyWith().endOfDecade();
      expect(endDecade.year, 2099);
      expect(endDecade.month, 12);

      final startCentury = sample.copyWith().startOfCentury();
      expect(startCentury.year, 2001);
      final endCentury = sample.copyWith().endOfCentury();
      expect(endCentury.year, 2100);
      expect(endCentury.day, 31);

      final startMillennium = sample.copyWith().startOfMillennium();
      expect(startMillennium.year, 2001);
      final endMillennium = sample.copyWith().endOfMillennium();
      expect(endMillennium.year, 3000);
      expect(endMillennium.month, 12);
      expect(endMillennium.day, 31);
    });

    test('midDay sets the time to noon', () {
      final CarbonInterface date = Carbon.create(
        year: 2024,
        month: 7,
        day: 4,
        hour: 8,
      );
      final mid = date.copyWith().midDay();
      expect(mid.hour, 12);
      expect(mid.minute, 0);
    });

    test('startOf/endOf dynamic helpers accept strings and enums', () {
      final CarbonInterface date = Carbon.create(
        year: 2022,
        month: 10,
        day: 18,
        hour: 9,
        minute: 45,
      );

      expect(date.copyWith().startOf('day').hour, 0);
      expect(date.copyWith().endOf('Months').day, 31);

      final enumStart = date.copyWith().startOf(CarbonUnit.quarter);
      expect(enumStart.month, 10);

      final enumEnd = date.copyWith().endOf(CarbonUnit.week);
      expect(enumEnd.dayOfWeek, DateTime.sunday % 7);
      expect(enumEnd.microsecond, 999999);

      expect(
        () => date.copyWith().startOf('microsecond'),
        throwsA(isA<CarbonUnknownUnitException>()),
      );
    });

    test('average finds the midpoint between two instants', () {
      final CarbonInterface earlier = Carbon.create(
        year: 2000,
        month: 1,
        day: 1,
      );
      final CarbonInterface later = Carbon.create(year: 2000, month: 1, day: 3);

      final midpoint = earlier.copyWith().average(later);
      expect(midpoint.year, 2000);
      expect(midpoint.month, 1);
      expect(midpoint.day, 2);
      expect(midpoint.hour, 0);
    });
  });
}

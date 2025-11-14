import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.add - days', () {
    test('addDays with positive value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 31).addDays(1);
      expect(date.day, 1);
      expect(date.month, 6);
    });

    test('addDays with zero', () {
      final date = Carbon.create(year: 1975, month: 5, day: 31).addDays(0);
      expect(date.day, 31);
      expect(date.month, 5);
    });

    test('addDays with negative value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 31).addDays(-1);
      expect(date.day, 30);
    });

    test('addDay adds one day', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 5, day: 31);
      final date = carbon.addDay();
      expect(date.day, 1);
      expect(date.month, 6);
    });

    test('addDay with explicit count', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 5, day: 10);
      final date = carbon.addDay(2);
      expect(date.day, 12);
    });

    test('addDays across month boundaries', () {
      final date = Carbon.create(year: 2020, month: 1, day: 30).addDays(5);
      expect(date.day, 4);
      expect(date.month, 2);
    });
  });

  group('Carbon.sub - days', () {
    test('subDays with positive value', () {
      final date = Carbon.create(year: 1975, month: 6, day: 1).subDays(1);
      expect(date.day, 31);
      expect(date.month, 5);
    });

    test('subDays with zero', () {
      final date = Carbon.create(year: 1975, month: 6, day: 1).subDays(0);
      expect(date.day, 1);
      expect(date.month, 6);
    });

    test('subDays with negative value', () {
      final date = Carbon.create(year: 1975, month: 6, day: 1).subDays(-1);
      expect(date.day, 2);
    });

    test('subDay subtracts one day', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 6, day: 1);
      final date = carbon.subDay();
      expect(date.day, 31);
      expect(date.month, 5);
    });
  });

  group('Carbon.add - weeks', () {
    test('addWeeks with positive value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 21).addWeeks(1);
      expect(date.day, 28);
    });

    test('addWeeks with zero', () {
      final date = Carbon.create(year: 1975, month: 5, day: 21).addWeeks(0);
      expect(date.day, 21);
    });

    test('addWeeks with negative value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 21).addWeeks(-1);
      expect(date.day, 14);
    });

    test('addWeek adds one week', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 5, day: 21);
      final date = carbon.addWeek();
      expect(date.day, 28);
    });

    test('addWeek with explicit count', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 5, day: 21);
      final date = carbon.addWeek(2);
      expect(date.day, 4);
      expect(date.month, 6);
    });

    test('addWeeks across month boundaries', () {
      final date = Carbon.create(year: 2020, month: 1, day: 25).addWeeks(2);
      expect(date.day, 8);
      expect(date.month, 2);
    });
  });

  group('Carbon.sub - weeks', () {
    test('subWeeks with positive value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 28).subWeeks(1);
      expect(date.day, 21);
    });

    test('subWeeks with zero', () {
      final date = Carbon.create(year: 1975, month: 5, day: 28).subWeeks(0);
      expect(date.day, 28);
    });

    test('subWeeks with negative value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 28).subWeeks(-1);
      expect(date.day, 4);
      expect(date.month, 6);
    });

    test('subWeek subtracts one week', () {
      final CarbonInterface carbon = Carbon.create(year: 1975, month: 5, day: 28);
      final date = carbon.subWeek();
      expect(date.day, 21);
    });
  });

  group('Carbon.add - weekdays', () {
    test('addWeekdays with positive value skips weekends', () {
      // 2012-01-04 is Wednesday
      final CarbonInterface carbon = Carbon.create(
        year: 2012,
        month: 1,
        day: 4,
        hour: 13,
        minute: 2,
        second: 1,
      );
      final date = carbon.addWeekdays(9);
      expect(date.day, 17);
      expect(date.hour, 13);
      expect(date.minute, 2);
      expect(date.second, 1);
    });

    test('addWeekdays with zero', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 4);
      final date = carbon.addWeekdays(0);
      expect(date.day, 4);
    });

    test('addWeekdays with negative value', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 31);
      final date = carbon.addWeekdays(-9);
      expect(date.day, 18);
    });

    test('addWeekday adds one weekday', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 6);
      final date = carbon.addWeekday();
      expect(date.day, 9);
    });

    test('addWeekday skips weekend', () {
      // 2012-01-07 is Saturday
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 7);
      final date = carbon.addWeekday();
      expect(date.day, 9); // Skip to Monday
    });
  });

  group('Carbon.sub - weekdays', () {
    test('subWeekdays with positive value skips weekends', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 31);
      final date = carbon.subWeekdays(9);
      expect(date.day, 18);
    });

    test('subWeekdays with zero', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 31);
      final date = carbon.subWeekdays(0);
      expect(date.day, 31);
    });

    test('subWeekdays with negative value', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 4);
      final date = carbon.subWeekdays(-9);
      expect(date.day, 17);
    });

    test('subWeekday subtracts one weekday', () {
      final CarbonInterface carbon = Carbon.create(year: 2012, month: 1, day: 6);
      final date = carbon.subWeekday();
      expect(date.day, 5);
    });
  });
}

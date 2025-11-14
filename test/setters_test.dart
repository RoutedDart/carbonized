import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon setters - basic units', () {
    test('setYear updates the year', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      final result = date.setYear(2021);
      expect(result.year, 2021);
      expect(result.month, 3);
      expect(result.day, 15);
    });

    test('setMonth updates the month', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      final result = date.setMonth(5);
      expect(result.year, 2020);
      expect(result.month, 5);
      expect(result.day, 15);
    });

    test('setDay updates the day', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      final result = date.setDay(20);
      expect(result.year, 2020);
      expect(result.month, 3);
      expect(result.day, 20);
    });

    test('setHour updates the hour', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15, hour: 10, minute: 30);
      final result = date.setHour(14);
      expect(result.hour, 14);
      expect(result.minute, 30);
    });

    test('setMinute updates the minute', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15, hour: 14, minute: 30);
      final result = date.setMinute(45);
      expect(result.hour, 14);
      expect(result.minute, 45);
    });

    test('setSecond updates the second', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15, hour: 14, minute: 30, second: 30);
      final result = date.setSecond(45);
      expect(result.second, 45);
      expect(result.minute, 30);
    });

    test('setMillisecond updates millisecond', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15, hour: 14, minute: 30, second: 30, millisecond: 100, microsecond: 0);
      final result = date.setMillisecond(500);
      expect(result.millisecond, 500);
    });

    test('setMicrosecond updates microsecond', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15, hour: 14, minute: 30, second: 30, millisecond: 100, microsecond: 500);
      final result = date.setMicrosecond(750000);
      expect(result.microsecond, 750000);
    });
  });

  group('Carbon setters - date components', () {
    test('setQuarter updates to correct month', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      
      final q1 = date.setQuarter(1);
      expect(q1.month, 1);
      
      final q2 = date.setQuarter(2);
      expect(q2.month, 4);
      
      final q3 = date.setQuarter(3);
      expect(q3.month, 7);
      
      final q4 = date.setQuarter(4);
      expect(q4.month, 10);
    });

    test('setDayOfWeek updates to specific day', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15); // Sunday
      final result = date.setDayOfWeek(1); // Monday
      expect(result.dayOfWeek, 1);
    });
  });

  group('Carbon setters - boundary handling', () {
    test('setDay handles month boundaries', () {
      final date = Carbon.create(year: 2020, month: 1, day: 31);
      final result = date.setDay(30);
      expect(result.day, 30);
    });

    test('setMonth with day adjustment honors overflow settings', () {
      final overflow = Carbon.create(year: 2020, month: 1, day: 31);
      final resultOverflow = overflow.setMonth(2);
      expect(resultOverflow.month, 3, reason: 'Default overflow should carry into March');

      final clamped = Carbon.fromDateTime(
        DateTime.utc(2020, 1, 31),
        settings: const CarbonSettings(monthOverflow: false),
      );
      final resultClamped = clamped.setMonth(2);
      expect(resultClamped.month, 2);
      expect(resultClamped.day, 29);
    });

    test('setYear handles leap year', () {
      final date = Carbon.create(year: 2020, month: 2, day: 29);
      final result = date.setYear(2021);
      // Should handle leap year boundary
      expect(result.year, 2021);
    });
  });

  group('Carbon fluent setters - chaining', () {
    test('multiple setters can be chained', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1);
      final result = date
          .setYear(2021)
          .setMonth(3)
          .setDay(15)
          .setHour(14)
          .setMinute(30);

      expect(result.year, 2021);
      expect(result.month, 3);
      expect(result.day, 15);
      expect(result.hour, 14);
      expect(result.minute, 30);
    });

    test('setters work with add methods', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1)
          .setMonth(6)
          .addMonths(3);

      expect(date.month, 9);
      expect(date.year, 2020);
    });
  });

  group('Carbon composite setters', () {
    test('setDate sets year month day together', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1, hour: 14, minute: 30);
      final result = date.setDate(2021, 3, 15);

      expect(result.year, 2021);
      expect(result.month, 3);
      expect(result.day, 15);
      expect(result.hour, 14);
      expect(result.minute, 30);
    });

    test('setTime sets hour minute second together', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      final result = date.setTime(14, 30, 45);

      expect(result.year, 2020);
      expect(result.month, 3);
      expect(result.day, 15);
      expect(result.hour, 14);
      expect(result.minute, 30);
      expect(result.second, 45);
    });
  });

  group('Carbon immutability with setters', () {
    test('setter returns new instance', () {
      final original = Carbon.create(year: 2020, month: 3, day: 15).toImmutable();
      final modified = original.setYear(2021);

      expect(original.year, 2020);
      expect(modified.year, 2021);
      expect(original != modified, true);
    });

    test('original unchanged after multiple setters', () {
      final original = Carbon.create(year: 2020, month: 3, day: 15).toImmutable();
      final _ = original
          .setYear(2021)
          .setMonth(6)
          .setDay(20);

      expect(original.year, 2020);
      expect(original.month, 3);
      expect(original.day, 15);
    });
  });

  group('Carbon validation with setters', () {
    test('setMonth with valid range', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1);
      expect(() => date.setMonth(1), returnsNormally);
      expect(() => date.setMonth(12), returnsNormally);
    });

    test('setDay with valid range', () {
      final date = Carbon.create(year: 2020, month: 3, day: 1);
      expect(() => date.setDay(1), returnsNormally);
      expect(() => date.setDay(31), returnsNormally);
    });

    test('setHour with valid range', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1);
      expect(() => date.setHour(0), returnsNormally);
      expect(() => date.setHour(23), returnsNormally);
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.is predicates', () {
    test('detects weekdays and weekends', () {
      final weekday = Carbon.create(year: 2025, month: 11, day: 14); // Friday
      final weekend = Carbon.create(year: 2025, month: 11, day: 15); // Saturday

      expect(weekday.isWeekday(), isTrue);
      expect(weekday.isWeekend(), isFalse);
      expect(weekend.isWeekend(), isTrue);
      expect(weekend.isWeekday(), isFalse);
    });

    test('yesterday, today, and tomorrow align with clock.now', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 9)), () {
        final today = Carbon.now();
        final yesterday = Carbon.create(
          year: 2025,
          month: 11,
          day: 13,
          hour: 23,
        );
        final tomorrow = Carbon.create(year: 2025, month: 11, day: 15);

        expect(today.isToday(), isTrue);
        expect(today.isYesterday(), isFalse);
        expect(today.isTomorrow(), isFalse);

        expect(yesterday.isYesterday(), isTrue);
        expect(yesterday.isToday(), isFalse);

        expect(tomorrow.isTomorrow(), isTrue);
        expect(tomorrow.isToday(), isFalse);
      });
    });

    test('future and past rely on the current instant', () {
      withClock(Clock.fixed(DateTime.utc(2030, 1, 1, 12)), () {
        final future = Carbon.create(
          year: 2030,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 5,
        );
        final past = Carbon.create(
          year: 2030,
          month: 1,
          day: 1,
          hour: 11,
          minute: 59,
          second: 55,
        );

        expect(future.isFuture(), isTrue);
        expect(future.isPast(), isFalse);

        expect(past.isPast(), isTrue);
        expect(past.isFuture(), isFalse);
      });
    });

    test('now-or-future and now-or-past treat equality as true', () {
      withClock(Clock.fixed(DateTime.utc(2040, 6, 1, 0, 0, 1)), () {
        final now = Carbon.create(
          year: 2040,
          month: 6,
          day: 1,
          hour: 0,
          minute: 0,
          second: 1,
        );
        final later = Carbon.create(
          year: 2040,
          month: 6,
          day: 1,
          hour: 0,
          minute: 0,
          second: 2,
        );
        final earlier = Carbon.create(
          year: 2040,
          month: 6,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
        );

        expect(now.isNowOrFuture(), isTrue);
        expect(now.isNowOrPast(), isTrue);
        expect(later.isNowOrFuture(), isTrue);
        expect(later.isNowOrPast(), isFalse);
        expect(earlier.isNowOrPast(), isTrue);
        expect(earlier.isNowOrFuture(), isFalse);
      });
    });

    test('identifies leap years', () {
      final leapYear = Carbon.create(year: 2024, month: 2, day: 1);
      final commonYear = Carbon.create(year: 2025, month: 2, day: 1);

      expect(leapYear.isLeapYear(), isTrue);
      expect(commonYear.isLeapYear(), isFalse);
    });
  });
}

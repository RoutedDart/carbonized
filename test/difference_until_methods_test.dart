import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

int periodSpan(Iterable<Carbon> period) => period.length - 1;

void main() {
  group('Carbon.difference - basic units', () {
    test('diffInYears between dates', () {
      final date1 = Carbon.create(year: 2020, month: 1, day: 1);
      final date2 = Carbon.create(year: 2023, month: 1, day: 1);
      expect(date2.diffInYears(date1), 3);
    });

    test('diffInMonths between dates', () {
      final date1 = Carbon.create(year: 2020, month: 1, day: 1);
      final date2 = Carbon.create(year: 2020, month: 5, day: 1);
      expect(date2.diffInMonths(date1), 4);
    });

    test('diffInWeeks between dates', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 1);
      final date2 = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date2.diffInWeeks(date1), 2);
    });

    test('diffInDays between dates', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15);
      final date2 = Carbon.create(year: 2020, month: 3, day: 20);
      expect(date2.diffInDays(date1), 5);
    });

    test('diffInHours between dates', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15, hour: 10);
      final date2 = Carbon.create(year: 2020, month: 3, day: 15, hour: 14);
      expect(date2.diffInHours(date1), 4);
    });

    test('diffInMinutes between dates', () {
      final date1 = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 30,
      );
      final date2 = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 45,
      );
      expect(date2.diffInMinutes(date1), 15);
    });

    test('diffInSeconds between dates', () {
      final date1 = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 35,
        second: 30,
      );
      final date2 = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 35,
        second: 42,
      );
      expect(date2.diffInSeconds(date1), 12);
    });
  });

  group('Carbon.difference - absolute values', () {
    test('diffInDays is absolute regardless of direction', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15);
      final date2 = Carbon.create(year: 2020, month: 3, day: 20);

      expect(date2.diffInDays(date1), 5);
      expect(date1.diffInDays(date2), 5);
    });

    test('diffInYears handles negative differences', () {
      final date1 = Carbon.create(year: 2020, month: 1, day: 1);
      final date2 = Carbon.create(year: 2023, month: 1, day: 1);

      expect(date1.diffInYears(date2), 3);
    });
  });

  group('Carbon.until/ago methods', () {
    final baseDate = Carbon.create(year: 2020, month: 3, day: 15);

    test('yearsUntil calculates years to target', () {
      final target = Carbon.create(year: 2025, month: 3, day: 15);
      expect(periodSpan(baseDate.yearsUntil(target)), 5);
    });

    test('monthsUntil calculates months to target', () {
      final target = Carbon.create(year: 2020, month: 8, day: 15);
      expect(periodSpan(baseDate.monthsUntil(target)), 5);
    });

    test('weeksUntil calculates weeks to target', () {
      final target = Carbon.create(year: 2020, month: 4, day: 12);
      expect(periodSpan(baseDate.weeksUntil(target)), 4);
    });

    test('daysUntil calculates days to target', () {
      final target = Carbon.create(year: 2020, month: 3, day: 20);
      expect(periodSpan(baseDate.daysUntil(target)), 5);
    });

    test('hoursUntil calculates hours to target', () {
      final base = Carbon.create(year: 2020, month: 3, day: 15, hour: 10);
      final target = Carbon.create(year: 2020, month: 3, day: 15, hour: 14);
      expect(periodSpan(base.hoursUntil(target)), 4);
    });

    test('minutesUntil calculates minutes to target', () {
      final base = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 30,
      );
      final target = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 45,
      );
      expect(periodSpan(base.minutesUntil(target)), 15);
    });

    test('secondsUntil calculates seconds to target', () {
      final base = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 35,
        second: 30,
      );
      final target = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 35,
        second: 42,
      );
      expect(periodSpan(base.secondsUntil(target)), 12);
    });
  });

  group('Carbon difference - large units', () {
    test('diffInQuarters between dates', () {
      final date1 = Carbon.create(year: 2020, month: 1, day: 1);
      final date2 = Carbon.create(year: 2020, month: 10, day: 1);
      expect(date2.diffInQuarters(date1), 3);
    });

    test('diffInDecades between dates', () {
      final date1 = Carbon.create(year: 1970, month: 1, day: 1);
      final date2 = Carbon.create(year: 2000, month: 1, day: 1);
      expect(date2.diffInDecades(date1), 3);
    });

    test('diffInCenturies between dates', () {
      final date1 = Carbon.create(year: 1900, month: 1, day: 1);
      final date2 = Carbon.create(year: 2100, month: 1, day: 1);
      expect(date2.diffInCenturies(date1), 2);
    });

    test('diffInMillennia between dates', () {
      final date1 = Carbon.create(year: 1000, month: 1, day: 1);
      final date2 = Carbon.create(year: 3000, month: 1, day: 1);
      expect(date2.diffInMillennia(date1), 2);
    });
  });

  group('Carbon difference - fractional', () {
    test('diffInDaysFloored returns integer days', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15);
      final date2 = Carbon.create(year: 2020, month: 3, day: 20, hour: 12);
      expect(date2.diffInDaysFloored(date1), 5);
    });

    test('diffInHours handles partial hours', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15, hour: 10);
      final date2 = Carbon.create(
        year: 2020,
        month: 3,
        day: 15,
        hour: 14,
        minute: 30,
      );
      expect(date2.diffInHours(date1) >= 4, true);
    });
  });

  group('Carbon distance between methods', () {
    test('distance in months between two dates', () {
      final date1 = Carbon.create(year: 2020, month: 1, day: 31);
      final date2 = Carbon.create(year: 2020, month: 4, day: 30);
      expect(date2.diffInMonths(date1) >= 2, true);
    });

    test('distance accounts for same period across years', () {
      final date1 = Carbon.create(year: 2020, month: 3, day: 15);
      final date2 = Carbon.create(year: 2021, month: 3, day: 15);
      expect(date2.diffInYears(date1), 1);
    });
  });
}

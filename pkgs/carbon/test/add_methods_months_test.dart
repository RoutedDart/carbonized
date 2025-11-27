import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.add - months', () {
    test('addMonths with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 31).addMonths(1);
      expect(date.month, 3);
      expect(date.day, 3);
    });

    test('addMonths with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 31).addMonths(0);
      expect(date.month, 1);
    });

    test('addMonths with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 31).addMonths(-1);
      expect(date.month, 12);
      expect(date.day, 31);
      expect(date.year, 1974);
    });

    test('addMonth adds one month', () {
      final CarbonInterface carbon = Carbon.create(
        year: 1975,
        month: 1,
        day: 31,
      );
      final date = carbon.addMonth();
      expect(date.month, 3);
      expect(date.day, 3);
    });

    group('month overflow handling - no overflow', () {
      test(
        'addMonthNoOverflow preserves last day when target month is shorter',
        () {
          final CarbonInterface date = Carbon.create(
            year: 2016,
            month: 1,
            day: 31,
          );
          final result = date.addMonthNoOverflow(1);
          expect(result.month, 2);
          expect(result.day, 29); // 2016 is a leap year
        },
      );

      test('addMonthNoOverflow with -2', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 1,
          day: 31,
        );
        final result = date.addMonthNoOverflow(-2);
        expect(result.year, 2015);
        expect(result.month, 11);
        expect(result.day, 30); // November has 30 days
      });

      test('addMonthsNoOverflow with multiple months', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 1,
          day: 31,
        );
        final result = date.addMonthsNoOverflow(2);
        expect(result.month, 3);
        expect(result.day, 31);
      });
    });

    group('month overflow handling - with overflow', () {
      test(
        'addMonthWithOverflow carries over when target month is shorter',
        () {
          final CarbonInterface date = Carbon.create(
            year: 2016,
            month: 1,
            day: 31,
          );
          final result = date.addMonthWithOverflow(1);
          expect(result.month, 3);
          expect(result.day, 2); // Overflow from Feb 31 -> Mar 2
        },
      );

      test('addMonthWithOverflow with -2', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 1,
          day: 31,
        );
        final result = date.addMonthWithOverflow(-2);
        expect(result.year, 2015);
        expect(result.month, 12);
        expect(result.day, 1); // Overflow from Nov 31 -> Dec 1
      });

      test('addMonthsWithOverflow with multiple months', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 1,
          day: 31,
        );
        final result = date.addMonthsWithOverflow(2);
        expect(result.month, 3);
        expect(result.day, 31);
      });
    });
  });

  group('Carbon.sub - months', () {
    test('subMonths with positive value', () {
      final date = Carbon.create(year: 1975, month: 3, day: 31).subMonths(1);
      expect(date.month, 3);
      expect(date.day, 3);
    });

    test('subMonths with zero', () {
      final date = Carbon.create(year: 1975, month: 3, day: 31).subMonths(0);
      expect(date.month, 3);
    });

    test('subMonths with negative value', () {
      final date = Carbon.create(year: 1975, month: 3, day: 31).subMonths(-1);
      expect(date.month, 5);
      expect(date.day, 1);
      expect(date.year, 1975);
    });

    test('subMonth subtracts one month', () {
      final CarbonInterface carbon = Carbon.create(
        year: 1975,
        month: 3,
        day: 31,
      );
      final date = carbon.subMonth();
      expect(date.month, 3);
      expect(date.day, 3);
    });

    group('month overflow handling - no overflow', () {
      test(
        'subMonthNoOverflow preserves last day when target month is shorter',
        () {
          final CarbonInterface date = Carbon.create(
            year: 2016,
            month: 3,
            day: 31,
          );
          final result = date.subMonthNoOverflow(1);
          expect(result.month, 2);
          expect(result.day, 29); // 2016 is a leap year
        },
      );

      test('subMonthsNoOverflow with multiple months', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 3,
          day: 31,
        );
        final result = date.subMonthsNoOverflow(2);
        expect(result.month, 1);
        expect(result.day, 31);
      });
    });

    group('month overflow handling - with overflow', () {
      test(
        'subMonthWithOverflow carries over when target month is shorter',
        () {
          final CarbonInterface date = Carbon.create(
            year: 2016,
            month: 3,
            day: 31,
          );
          final result = date.subMonthWithOverflow(1);
          expect(result.month, 3);
          expect(result.day, 2); // Overflow from Feb 31 -> Mar 2
        },
      );

      test('subMonthsWithOverflow with multiple months', () {
        final CarbonInterface date = Carbon.create(
          year: 2016,
          month: 3,
          day: 31,
        );
        final result = date.subMonthsWithOverflow(2);
        expect(result.month, 1);
        expect(result.day, 31);
      });
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.add - years', () {
    test('addYears with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addYears(1);
      expect(date.year, 1976);
    });

    test('addYears with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addYears(0);
      expect(date.year, 1975);
    });

    test('addYears with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addYears(-1);
      expect(date.year, 1974);
    });

    test('addYear adds one year', () {
      final CarbonInterface carbon = Carbon.create(
        year: 1975,
        month: 1,
        day: 1,
      );
      final result = carbon.addYear();
      expect(result.year, 1976);
    });

    test('addYear with explicit count', () {
      final CarbonInterface carbon = Carbon.create(
        year: 1975,
        month: 1,
        day: 1,
      );
      final result = carbon.addYear(2);
      expect(result.year, 1977);
    });

    group('year overflow handling', () {
      test('addYearNoOverflow preserves day on leap year boundary', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.addYearNoOverflow();
        expect(result.year, 2017);
        expect(result.month, 2);
        expect(result.day, 28);
      });

      test('addYearWithOverflow overflows day on leap year boundary', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.addYearWithOverflow();
        expect(result.year, 2017);
        expect(result.month, 3);
        expect(result.day, 1);
      });

      test('addYearsNoOverflow with multiple years', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.addYearsNoOverflow(2);
        expect(result.year, 2018);
        expect(result.month, 2);
        expect(result.day, 28);
      });

      test('addYearsWithOverflow with multiple years', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.addYearsWithOverflow(2);
        expect(result.year, 2018);
        expect(result.month, 3);
        expect(result.day, 1);
      });
    });
  });

  group('Carbon.sub - years', () {
    test('subYears with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subYears(1);
      expect(date.year, 1974);
    });

    test('subYears with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subYears(0);
      expect(date.year, 1975);
    });

    test('subYears with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subYears(-1);
      expect(date.year, 1976);
    });

    test('subYear subtracts one year', () {
      final CarbonInterface carbon = Carbon.create(
        year: 1975,
        month: 1,
        day: 1,
      );
      final result = carbon.subYear();
      expect(result.year, 1974);
    });

    group('year overflow handling', () {
      test('subYearNoOverflow preserves day on leap year boundary', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.subYearNoOverflow();
        expect(result.year, 2015);
        expect(result.month, 2);
        expect(result.day, 28);
      });

      test('subYearWithOverflow overflows day on leap year boundary', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.subYearWithOverflow();
        expect(result.year, 2015);
        expect(result.month, 3);
        expect(result.day, 1);
      });

      test('subYearsNoOverflow with multiple years', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.subYearsNoOverflow(2);
        expect(result.year, 2014);
        expect(result.month, 2);
        expect(result.day, 28);
      });

      test('subYearsWithOverflow with multiple years', () {
        final CarbonInterface carbon = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        );
        final result = carbon.subYearsWithOverflow(2);
        expect(result.year, 2014);
        expect(result.month, 3);
        expect(result.day, 1);
      });
    });
  });
}

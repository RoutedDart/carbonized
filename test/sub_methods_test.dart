import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('sub method', () {
    test('sub handles numeric + unit order', () {
      final carbon = Carbon.parse('1975-01-01');
      carbon.sub(2, 'years');
      expect(carbon.year, 1973);
    });

    test('sub handles swapped order', () {
      final carbon = Carbon.parse('1975-01-01');
      carbon.sub('year', 2);
      expect(carbon.year, 1973);
    });

    test('sub handles string expressions', () {
      final carbon = Carbon.parse('1975-01-01');
      carbon.sub('2 years');
      expect(carbon.year, 1973);
    });

    test('subtract still accepts Duration', () {
      final carbon = Carbon.parse('1975-01-10');
      carbon.subtract(const Duration(days: 2));
      expect(carbon.day, 8);
    });

    test('subtract accepts CarbonUnit enum', () {
      final carbon = Carbon.parse('1975-01-01');
      carbon.subtract(2, CarbonUnit.year);
      expect(carbon.year, 1973);
    });

    test('sub accepts CarbonInterval', () {
      final carbon = Carbon.parse('2020-06-08');
      carbon.sub(CarbonInterval.weeks(1));
      expect(carbon.toIso8601String().substring(0, 10), '2020-06-01');
    });

    test('sub applies CarbonInterval month and day components', () {
      final carbon = Carbon.parse('2020-07-16');
      final interval = CarbonInterval.fromComponents(months: 1, days: 5);
      final result = carbon.sub(interval);
      expect(identical(result, carbon), isTrue);
      expect(carbon.toIso8601String().substring(0, 10), '2020-06-11');
    });

    test('sub accepts callback', () {
      final carbon = Carbon.parse('1975-01-01');
      carbon.sub((DateTime date, bool negated) {
        expect(negated, isTrue);
        return date.subtract(const Duration(days: 2));
      });
      expect(carbon.day, 30);
    });

    test('subMonthWithOverflow spans multiple months', () {
      final carbon = Carbon.parse('2016-03-31');
      final result = carbon.subMonthsWithOverflow(2);
      expect(result.month, 1);
      expect(result.day, 31);
    });

    test('subMonthsWithOverflow handles negatives', () {
      final carbon = Carbon.parse('2016-03-31');
      final result = carbon.subMonthsWithOverflow(-1);
      expect(result.month, 5);
      expect(result.day, 1);
    });

    test('subMonthNoOverflow respects overflow rules', () {
      final carbon = Carbon.parse('2011-04-30');
      carbon.subMonthNoOverflow(2);
      expect(carbon.month, 2);
      expect(carbon.day, 28);
    });

    test('subYears handles positive, zero, and negative values', () {
      expect(
        Carbon.create(year: 1975, month: 1, day: 1).subYears(1).year,
        1974,
      );
      expect(
        Carbon.create(year: 1975, month: 1, day: 1).subYears(0).year,
        1975,
      );
      expect(
        Carbon.create(year: 1975, month: 1, day: 1).subYears(-1).year,
        1976,
      );
    });

    test('subMonths handles positive, zero, and negative values', () {
      expect(
        Carbon.create(year: 1975, month: 1, day: 1).subMonths(1).month,
        12,
      );
      expect(Carbon.create(year: 1975, month: 1, day: 1).subMonths(0).month, 1);
      expect(
        Carbon.create(year: 1975, month: 1, day: 1).subMonths(-1).month,
        2,
      );
    });

    test('subWeeks handles positive, zero, and negative values', () {
      expect(Carbon.create(year: 1975, month: 5, day: 21).subWeeks(1).day, 14);
      expect(Carbon.create(year: 1975, month: 5, day: 21).subWeeks(0).day, 21);
      expect(Carbon.create(year: 1975, month: 5, day: 21).subWeeks(-1).day, 28);
    });

    test('subDays handles positive, zero, and negative values', () {
      expect(Carbon.create(year: 1975, month: 5, day: 1).subDays(1).day, 30);
      expect(Carbon.create(year: 1975, month: 5, day: 1).subDays(0).day, 1);
      expect(Carbon.create(year: 1975, month: 5, day: 1).subDays(-1).day, 2);
    });

    test('subWeekdays handles positive, zero, and negative values', () {
      expect(
        Carbon.create(year: 2012, month: 1, day: 4).subWeekdays(9).day,
        22,
      );
      expect(Carbon.create(year: 2012, month: 1, day: 4).subWeekdays(0).day, 4);
      expect(
        Carbon.create(year: 2012, month: 1, day: 31).subWeekdays(-9).day,
        13,
      );
    });

    test('subWeekday during weekend lands on previous workday', () {
      final value = Carbon.create(year: 2012, month: 1, day: 8).subWeekday();
      expect(value.day, 6);
    });

    test('subHours handles positive, zero, and negative values', () {
      expect(
        Carbon.create(year: 1970, month: 1, day: 1, hour: 0).subHours(1).hour,
        23,
      );
      expect(
        Carbon.create(year: 1970, month: 1, day: 1, hour: 0).subHours(0).hour,
        0,
      );
      expect(
        Carbon.create(year: 1970, month: 1, day: 1, hour: 0).subHours(-1).hour,
        1,
      );
    });

    test('subMinutes handles positive, zero, and negative values', () {
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
        ).subMinutes(1).minute,
        59,
      );
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
        ).subMinutes(0).minute,
        0,
      );
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
        ).subMinutes(-1).minute,
        1,
      );
    });

    test('subSeconds handles positive, zero, and negative values', () {
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
        ).subSeconds(1).second,
        59,
      );
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
        ).subSeconds(0).second,
        0,
      );
      expect(
        Carbon.create(
          year: 1970,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
        ).subSeconds(-1).second,
        1,
      );
    });

    test('subYear accepts an explicit amount argument', () {
      final result = Carbon.create(year: 1975, month: 1, day: 1).subYear(2);
      expect(result.year, 1973);
    });

    test('subMonth accepts explicit amount argument', () {
      final result = Carbon.create(year: 1975, month: 5, day: 1).subMonth(2);
      expect(result.month, 3);
    });

    test('subDay accepts explicit amount argument', () {
      final result = Carbon.create(year: 1975, month: 5, day: 10).subDay(2);
      expect(result.day, 8);
    });

    test('subHour accepts explicit amount argument', () {
      final result = Carbon.create(
        year: 1970,
        month: 1,
        day: 1,
        hour: 0,
      ).subHour(2);
      expect(result.hour, 22);
    });

    test('subMinute accepts explicit amount argument', () {
      final result = Carbon.create(
        year: 1970,
        month: 1,
        day: 1,
        hour: 0,
        minute: 0,
      ).subMinute(2);
      expect(result.minute, 58);
    });

    test('subSecond accepts explicit amount argument', () {
      final result = Carbon.create(
        year: 1970,
        month: 1,
        day: 1,
        hour: 0,
        minute: 0,
        second: 0,
      ).subSecond(2);
      expect(result.second, 58);
    });
  });
}

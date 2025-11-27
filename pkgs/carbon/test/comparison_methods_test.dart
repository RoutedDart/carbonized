import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon comparison helpers', () {
    group('equality predicates', () {
      test('eq returns true for identical instants', () {
        final CarbonInterface left = Carbon.create(
          year: 2025,
          month: 1,
          day: 1,
          hour: 8,
        );
        final CarbonInterface right = Carbon.create(
          year: 2025,
          month: 1,
          day: 1,
          hour: 8,
        );
        expect(left.eq(right), isTrue);
        expect(left.equalTo('2025-01-01T08:00:00Z'), isTrue);
      });

      test('ne returns true when instants differ', () {
        final CarbonInterface left = Carbon.create(
          year: 2025,
          month: 1,
          day: 1,
          hour: 8,
        );
        final CarbonInterface right = Carbon.create(
          year: 2025,
          month: 1,
          day: 2,
          hour: 8,
        );
        expect(left.ne(right), isTrue);
        expect(left.notEqualTo('2025-01-02T08:00:00Z'), isTrue);
        expect(left.ne('2025-01-01T08:00:00Z'), isFalse);
      });
    });

    group('inequality predicates', () {
      test('gt/gte honor inclusive boundaries', () {
        final CarbonInterface base = Carbon.create(
          year: 2025,
          month: 6,
          day: 10,
          hour: 12,
        );
        final CarbonInterface earlier = Carbon.create(
          year: 2025,
          month: 6,
          day: 9,
          hour: 12,
        );
        final CarbonInterface same = Carbon.create(
          year: 2025,
          month: 6,
          day: 10,
          hour: 12,
        );

        expect(base.gt(earlier), isTrue);
        expect(base.greaterThan(earlier), isTrue);
        expect(base.gte(same), isTrue);
        expect(base.greaterThanOrEqual(same), isTrue);
        expect(base.gt('2025-06-11T12:00:00Z'), isFalse);
      });

      test('lt/lte honor inclusive boundaries', () {
        final CarbonInterface base = Carbon.create(
          year: 2025,
          month: 6,
          day: 10,
          hour: 12,
        );
        final CarbonInterface later = Carbon.create(
          year: 2025,
          month: 6,
          day: 11,
          hour: 12,
        );
        final CarbonInterface same = Carbon.create(
          year: 2025,
          month: 6,
          day: 10,
          hour: 12,
        );

        expect(base.lt(later), isTrue);
        expect(base.lessThan(later), isTrue);
        expect(base.lte(same), isTrue);
        expect(base.lessThanOrEqual(same), isTrue);
        expect(base.lt('2025-06-09T12:00:00Z'), isFalse);
      });
    });

    group('expressive alias coverage', () {
      test('isAfter matches greaterThan semantics across offsets', () {
        final CarbonInterface left = Carbon.parse(
          '2000-01-01T12:00:00Z',
        ).tz('+02:00');
        final CarbonInterface right = Carbon.parse(
          '2000-01-01T09:00:01Z',
        ).tz('-03:00');

        expect(left.isAfter(right), isTrue);
        expect(left.greaterThan(right), isTrue);
        expect(right.isAfter(left), isFalse);
      });

      test('isBefore mirrors lessThan semantics', () {
        final CarbonInterface base = Carbon.parse(
          '2000-01-01T12:00:00Z',
        ).tz('+02:00');
        final CarbonInterface later = Carbon.parse('2000-01-01T13:00:00Z');

        expect(base.isBefore(later), isTrue);
        expect(base.lessThan(later), isTrue);
        expect(later.isBefore(base), isFalse);
      });
    });

    group('between helpers', () {
      test('between inclusive defaults to true when inside range', () {
        final CarbonInterface target = Carbon.create(
          year: 2000,
          month: 1,
          day: 15,
          hour: 17,
          minute: 20,
        );
        final CarbonInterface start = Carbon.create(
          year: 2000,
          month: 1,
          day: 1,
        );
        final CarbonInterface end = Carbon.create(
          year: 2000,
          month: 1,
          day: 31,
          hour: 23,
          minute: 59,
        );

        expect(target.between(start, end), isTrue);
        expect(target.betweenIncluded(start, end), isTrue);
        expect(target.betweenExcluded(start, end), isTrue);
      });

      test('between evaluates swapped boundaries and exclusivity', () {
        final CarbonInterface target = Carbon.create(
          year: 2000,
          month: 1,
          day: 15,
          hour: 17,
          minute: 20,
        );

        expect(
          target.between('2000-01-31T23:59:59Z', '2000-01-01T00:00:00Z'),
          isTrue,
        );
        expect(
          target.betweenExcluded(
            '2000-01-15T00:00:00Z',
            '2000-01-15T00:00:00Z',
          ),
          isFalse,
        );
        final CarbonInterface midnight = Carbon.create(
          year: 2000,
          month: 1,
          day: 15,
        );
        expect(
          midnight.betweenIncluded(
            '2000-01-15T00:00:00Z',
            '2000-01-15T00:00:00Z',
          ),
          isTrue,
        );
      });
    });

    group('min/max helpers', () {
      test('min defaults to now when no comparison is provided', () {
        withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 12, 0)), () {
          final CarbonInterface future = Carbon.create(
            year: 2026,
            month: 1,
            day: 1,
          );
          final result = future.min();
          expect(result.year, 2025);
          expect(result.month, 11);
          expect(result.day, 14);
        });
      });

      test('max chooses the later instant', () {
        final CarbonInterface base = Carbon.create(
          year: 2030,
          month: 1,
          day: 1,
        );
        final CarbonInterface earlier = Carbon.create(
          year: 2029,
          month: 12,
          day: 31,
        );
        final CarbonInterface later = Carbon.create(
          year: 2035,
          month: 6,
          day: 30,
        );

        expect(base.max(earlier).year, 2030);
        expect(base.max(later).year, 2035);
        expect(base.maximum('2035-06-30T00:00:00Z').year, 2035);
      });
    });

    group('closest and farthest', () {
      test('closest picks the nearest candidate', () {
        final CarbonInterface instance = Carbon.create(
          year: 2015,
          month: 5,
          day: 28,
          hour: 12,
        );
        final CarbonInterface dt1 = Carbon.create(
          year: 2015,
          month: 5,
          day: 28,
          hour: 11,
        );
        final CarbonInterface dt2 = Carbon.create(
          year: 2015,
          month: 5,
          day: 28,
          hour: 14,
        );

        final closest = instance.closest(dt1, dt2);
        expect(closest.year, dt1.year);
        expect(closest.hour, dt1.hour);
      });

      test('farthest favors the most distant timestamp', () {
        final CarbonInterface base = Carbon.parse(
          '2018-10-11T20:59:06.500000Z',
        );
        final CarbonInterface closer = Carbon.parse(
          '2018-10-11T20:59:06.600000Z',
        );
        final CarbonInterface farther = Carbon.parse(
          '2018-10-11T20:59:06.300000Z',
        );

        final farthest = base.farthest(closer, farther);
        expect(farthest.second, 6);
        expect(farthest.millisecond, 300);
      });
    });

    group('birthday detection', () {
      test('isBirthday defaults to today via clock.now', () {
        withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 9, 0)), () {
          final CarbonInterface birthday = Carbon.create(
            year: 2000,
            month: 11,
            day: 14,
          );
          expect(birthday.isBirthday(), isTrue);

          final CarbonInterface almost = Carbon.create(
            year: 2000,
            month: 11,
            day: 13,
          );
          expect(almost.isBirthday(), isFalse);
        });
      });

      test('isBirthday compares month/day with provided reference', () {
        final CarbonInterface reference = Carbon.create(
          year: 1990,
          month: 4,
          day: 23,
        );
        final CarbonInterface candidate = Carbon.create(
          year: 2024,
          month: 4,
          day: 23,
        );
        final CarbonInterface other = Carbon.create(
          year: 2024,
          month: 4,
          day: 22,
        );

        expect(candidate.isBirthday(reference), isTrue);
        expect(other.isBirthday(reference), isFalse);
      });
    });
  });
}

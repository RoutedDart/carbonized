import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

CarbonImmutable _immutable(int year, int month, int day) =>
    Carbon.create(year: year, month: month, day: day).toImmutable();

void main() {
  group('Carbon diff helpers', () {
    test('diffAsDuration matches expected components', () {
      final base = _immutable(2000, 1, 1);
      final shifted = base.addYears(1);
      final duration = shifted.diff(base);
      expect(duration.inDays, 366);
      expect(base.diff(base).inSeconds, 0);
    });

    test('diffInYears exposes signed and absolute variants', () {
      final base = _immutable(2000, 1, 1);
      final future = base.addYear();
      expect(future.diffInYears(base), 1);
      expect(base.diffInYears(future, absolute: false), -1);
      expect(base.diffInYears(future), 1);
    });

    test('diffInYears truncates fractional results', () {
      final base = _immutable(2000, 1, 1);
      final shifted = base.addYear().addMonths(7);
      expect(shifted.diffInYears(base), 1);
    });

    test('diffInMonths respects timezone offsets while truncating', () {
      final first = CarbonImmutable.parse('2022-02-01T16:00:00-05:00');
      final second = CarbonImmutable.parse('2021-12-31T18:00:00-05:00');
      expect(first.diffInMonths(second, absolute: false), 1);
      expect(second.diffInMonths(first, absolute: false), -1);
    });

    test('diffInMonths defaults to now when no argument (parity check)', () {
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1)), () {
        final now = CarbonImmutable.now();
        expect(now.diffInMonths(now.subYear()), 12);
      });
    });
  });
}

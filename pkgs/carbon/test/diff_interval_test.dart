import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  CarbonInterface applyInterval(CarbonInterface base, CarbonInterval interval) {
    final clone = base.copy();
    if (interval.monthSpan != 0) {
      clone.addMonths(interval.monthSpan);
    }
    if (interval.microseconds != 0) {
      clone.add(Duration(microseconds: interval.microseconds));
    }
    return clone;
  }

  group('diffAsCarbonInterval', () {
    test('absolute flag returns signed results when requested', () {
      final base = Carbon.parse('2012-01-15T12:00:00Z');
      final earlier = base.copy()
        ..subYears(2)
        ..subMonths(1)
        ..subDays(3)
        ..subHours(6);

      final signed = base.diffAsCarbonInterval(earlier, absolute: false);
      expect(signed.monthSpan, lessThan(0));
      expect(signed.microseconds, lessThan(0));
      final roundTrip = applyInterval(base, signed);
      expect(roundTrip.toIso8601String(), earlier.toIso8601String());

      final absolute = base.diffAsCarbonInterval(earlier);
      expect(absolute.monthSpan, greaterThan(0));
      expect(absolute.microseconds, greaterThan(0));
      final rebuilt = applyInterval(earlier, absolute);
      expect(rebuilt.toIso8601String(), base.toIso8601String());
    });
  });

  group('diffAsDateInterval', () {
    test('absolute true returns positive Duration', () {
      final start = Carbon.parse('2020-01-01T00:00:00Z');
      final later = start.copy()
        ..addDays(1)
        ..addHours(5);
      final negative = start.diffAsDateInterval(later, absolute: false);
      expect(negative.isNegative, isTrue);
      final absolute = start.diffAsDateInterval(later, absolute: true);
      expect(absolute.isNegative, isFalse);
      expect(absolute.inHours, 29);
    });
  });

  group('diffInUnit', () {
    const epsilon = 1e-9;

    test('handles string units with fractional outputs', () {
      final start = Carbon.parse('2000-01-15T00:00:00Z');
      final end = Carbon.parse('2000-02-24T00:00:00Z');
      expect(start.diffInUnit('months', end), closeTo(1.310344827586, epsilon));
      expect(
        end.diffInUnit('hours', start, absolute: false),
        closeTo(-960, epsilon),
      );
    });

    test('accepts CarbonUnit enum values', () {
      final start = Carbon.parse('2000-01-01T00:00:00Z');
      final end = start.copy()
        ..addYears(1)
        ..addMonths(2)
        ..addDays(5)
        ..addHours(12);
      expect(
        start.diffInUnit(CarbonUnit.year, end),
        closeTo(1.1767123287671, epsilon),
      );
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

CarbonInterface _immutable(String iso) => CarbonImmutable.parse(iso);

void main() {
  group('Overflow alias coverage', () {
    test('addMonthWithoutOverflow clamps to available days', () {
      final date = _immutable('2020-01-31T00:00:00Z');
      final shifted = date.addMonthWithoutOverflow(1);
      expect(shifted.toIso8601String(), '2020-02-29T00:00:00.000Z');
    });

    test('addMonthWithOverflow carries extra days', () {
      final date = _immutable('2020-01-31T00:00:00Z');
      final shifted = date.addMonthWithOverflow(1);
      expect(shifted.toIso8601String(), '2020-03-02T00:00:00.000Z');
    });

    test('addYearsWithoutOverflow honors leap day loss', () {
      final date = _immutable('2020-02-29T00:00:00Z');
      final shifted = date.addYearsWithoutOverflow(1);
      expect(shifted.toIso8601String(), '2021-02-28T00:00:00.000Z');
    });

    test('addCenturyWithOverflow spills into March 2100', () {
      final date = _immutable('2000-02-29T00:00:00Z');
      final shifted = date.addCenturyWithOverflow();
      expect(shifted.toIso8601String(), '2100-03-01T00:00:00.000Z');
    });

    test('addMillenniaWithoutOverflow clamps when millennium drops leap day', () {
      final date = _immutable('2000-02-29T00:00:00Z');
      final shifted = date.addMillenniaWithoutOverflow(1);
      expect(shifted.toIso8601String(), '3000-02-28T00:00:00.000Z');
    });
  });

  group('UTC alias coverage', () {
    test('addUTCDays shifts by the requested number of days', () {
      final date = _immutable('2030-05-01T00:00:00Z');
      final shifted = date.addUTCDays(2);
      expect(shifted.toIso8601String(), '2030-05-03T00:00:00.000Z');
    });

    test('subUTCHours subtracts hours in UTC space', () {
      final date = _immutable('2030-05-01T10:00:00Z');
      final shifted = date.subUTCHours(3);
      expect(shifted.toIso8601String(), '2030-05-01T07:00:00.000Z');
    });

    test('addUTCMillis mirrors millisecond helpers', () {
      final date = _immutable('2030-05-01T00:00:00Z');
      final shifted = date.addUTCMillis(5);
      expect(
        shifted.dateTime.microsecondsSinceEpoch - date.dateTime.microsecondsSinceEpoch,
        5000,
      );
    });

    test('addUTCMicroseconds increments by the requested microseconds', () {
      final date = _immutable('2030-05-01T00:00:00Z');
      final shifted = date.addUTCMicroseconds(250);
      expect(
        shifted.dateTime.microsecondsSinceEpoch - date.dateTime.microsecondsSinceEpoch,
        250,
      );
    });

    test('subUTCMicroseconds decrements by the requested microseconds', () {
      final date = _immutable('2030-05-01T00:00:00Z');
      final shifted = date.subUTCMicroseconds(1);
      expect(
        date.dateTime.microsecondsSinceEpoch - shifted.dateTime.microsecondsSinceEpoch,
        1,
      );
    });
  });
}

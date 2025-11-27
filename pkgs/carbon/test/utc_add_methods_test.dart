import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon UTC add/sub helpers', () {
    test('addUTCDays shifts by whole days', () {
      final date = Carbon.create(year: 2025, month: 1, day: 1);
      final result = (date as dynamic).addUTCDays(2);
      expect(result.toIso8601String(), '2025-01-03T00:00:00.000Z');
    });

    test('subUTCHours subtracts hours without timezone drift', () {
      final date = Carbon.create(year: 2025, month: 1, day: 1, hour: 10);
      final result = (date as dynamic).subUTCHours(3);
      expect(result.toIso8601String(), '2025-01-01T07:00:00.000Z');
    });

    test('addUTCMillis increments millisecond precision', () {
      final date = CarbonImmutable.parse('2025-01-01T00:00:00Z');
      final result = (date as dynamic).addUTCMillis(5);
      expect(
        result.dateTime.microsecondsSinceEpoch -
            date.dateTime.microsecondsSinceEpoch,
        5000,
      );
    });

    test('addUTCMicroseconds increments micro precision', () {
      final date = CarbonImmutable.parse('2025-01-01T00:00:00Z');
      final result = (date as dynamic).addUTCMicroseconds(250);
      expect(
        result.dateTime.microsecondsSinceEpoch -
            date.dateTime.microsecondsSinceEpoch,
        250,
      );
    });
  });
}

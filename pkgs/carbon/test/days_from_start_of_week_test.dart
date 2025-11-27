import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('getDaysFromStartOfWeek / setDaysFromStartOfWeek', () {
    setUp(() {
      Carbon.setLocale('en');
    });

    test('uses settings start of week when none provided', () {
      final date = Carbon.parse('2024-06-05T00:00:00Z'); // Wednesday
      expect(date.getDaysFromStartOfWeek(), 2);

      final start = date.copy()..setDaysFromStartOfWeek(0);
      expect(start.toIso8601String(), '2024-06-03T00:00:00.000Z');
    });

    test('accepts custom weekday inputs', () {
      final date = Carbon.parse('2024-06-05T00:00:00Z');
      expect(date.getDaysFromStartOfWeek('sunday'), 3);
      expect(date.getDaysFromStartOfWeek(DateTime.saturday), 4);

      final customStart = date.copy()..setDaysFromStartOfWeek(2, 'sunday');
      expect(customStart.toIso8601String(), '2024-06-04T00:00:00.000Z');
    });

    test('works for immutable instances', () {
      final immutable = CarbonImmutable.parse('2024-06-05T00:00:00Z');
      final shifted = immutable.setDaysFromStartOfWeek(1, 'sunday');

      expect(shifted, isA<CarbonImmutable>());
      expect(shifted.toIso8601String(), '2024-06-03T00:00:00.000Z');
    });
  });
}

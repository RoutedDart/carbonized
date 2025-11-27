import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  group('shiftTimezone', () {
    test('reinterprets local time in the target zone', () {
      final base = Carbon.parse('2024-11-10T00:00:00Z', timeZone: 'UTC');
      final shifted = base.copy().shiftTimezone('Asia/Tokyo');

      expect(shifted.timeZoneName, 'Asia/Tokyo');
      expect(
        shifted.toIso8601String(keepOffset: true),
        '2024-11-10T00:00:00.000+09:00',
      );
      expect(shifted.toUtc().toIso8601String(), '2024-11-09T15:00:00.000Z');
    });

    test('differs from tz projection', () {
      final base = Carbon.parse('2024-11-10T00:00:00Z', timeZone: 'UTC');
      final projected = base.copy().tz('Asia/Tokyo');
      final shifted = base.copy().shiftTimezone('Asia/Tokyo');

      expect(
        projected.toIso8601String(keepOffset: true),
        '2024-11-10T09:00:00.000+09:00',
      );
      expect(
        shifted.toIso8601String(keepOffset: true),
        '2024-11-10T00:00:00.000+09:00',
      );
    });

    test('supports immutable instances', () {
      final base = CarbonImmutable.parse(
        '2024-01-15T12:00:00Z',
        timeZone: 'UTC',
      );
      final shifted = base.shiftTimezone('America/New_York');

      expect(shifted, isA<CarbonImmutable>());
      expect(
        shifted.toIso8601String(keepOffset: true),
        '2024-01-15T12:00:00.000-05:00',
      );
    });
  });
}

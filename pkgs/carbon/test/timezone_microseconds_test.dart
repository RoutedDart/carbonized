import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  group('Timezone microsecond handling', () {
    test('parses microseconds correctly with named timezone', () {
      // This was the original failing case from docs/conversion_examples.dart
      // The bug was that microseconds were being double-counted in _assignLocalTimezone
      final result = Carbon.parse(
        '2019-02-01T03:45:27.612584',
        timeZone: 'Europe/Paris',
      );

      expect(result.microsecond, 612584);
      expect(result.millisecond, 612);
      expect(result.timeZoneName, 'Europe/Paris');
    });

    test('handles large microsecond values without overflow', () {
      final result = Carbon.parse(
        '2019-02-01T03:45:27.999999',
        timeZone: 'America/New_York',
      );

      expect(result.microsecond, 999999);
      expect(result.millisecond, 999);
      expect(result.timeZoneName, 'America/New_York');
    });

    test('handles zero microseconds with timezone', () {
      final result = Carbon.parse(
        '2019-02-01T03:45:27.000000',
        timeZone: 'Asia/Tokyo',
      );

      expect(result.microsecond, 0);
      expect(result.millisecond, 0);
      expect(result.timeZoneName, 'Asia/Tokyo');
    });

    test('handles partial microsecond precision with timezone', () {
      final result = Carbon.parse('2019-02-01T03:45:27.5', timeZone: 'UTC');

      expect(result.microsecond, 500000);
      expect(result.millisecond, 500);
    });

    test('preserves microseconds when converting between timezones', () {
      final original = Carbon.parse(
        '2019-02-01T03:45:27.123456Z',
        timeZone: 'UTC',
      );

      final converted = original.tz('Europe/London');

      expect(converted.microsecond, 123456);
      expect(converted.millisecond, 123);
    });

    test('carbonize preserves base timezone', () {
      final base = Carbon.parse(
        '2019-02-01T03:45:27.612584',
        timeZone: 'Europe/Paris',
      );

      final result = base.carbonize('2019-03-21');

      expect(result.timeZoneName, 'Europe/Paris');
      expect(result.year, 2019);
      expect(result.month, 3);
    });

    test('fixed offset timezones work with microseconds', () {
      final result = Carbon.parse(
        '2019-02-01T03:45:27.500000',
        timeZone: '+05:30',
      );

      expect(result.microsecond, 500000);
      expect(result.millisecond, 500);
      expect(result.timeZoneName, '+05:30');
    });

    test('negative fixed offset timezones work with microseconds', () {
      final result = Carbon.parse(
        '2019-02-01T03:45:27.750000',
        timeZone: '-04:00',
      );

      expect(result.microsecond, 750000);
      expect(result.millisecond, 750);
      expect(result.timeZoneName, '-04:00');
    });

    test('microseconds do not overflow when setting timezone', () {
      // Regression test: ensure microseconds are not double-counted
      // by adding millisecond*1000 to an already-calculated microsecond value
      final carbon = Carbon.parse('2019-01-01T12:00:00.999999Z');
      final withTz = carbon.tz('America/Los_Angeles');

      expect(withTz.microsecond, 999999);
      expect(withTz.millisecond, 999);
    });

    test('createFromFormat handles microseconds with timezone', () {
      final result = Carbon.createFromFormat(
        'Y-m-d H:i:s.u',
        '2019-02-01 03:45:27.123456',
        timeZone: 'Europe/Paris',
      );

      expect(result.microsecond, 123456);
      expect(result.millisecond, 123);
      expect(result.timeZoneName, 'Europe/Paris');
    });

    test('docs example case runs without RangeError', () {
      // This is the exact code from docs/conversion_examples.dart that was failing
      expect(
        () => Carbon.parse(
          '2019-02-01T03:45:27.612584',
          timeZone: 'Europe/Paris',
        ),
        returnsNormally,
      );
    });

    test('millisecond boundaries are respected with timezones', () {
      // Test the edge case where microseconds = 999 (not 999999)
      final result = Carbon.parse(
        '2019-02-01T03:45:27.000999',
        timeZone: 'UTC',
      );

      expect(result.microsecond, 999);
      expect(result.millisecond, 0);
    });
  });
}

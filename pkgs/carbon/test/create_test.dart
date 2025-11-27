import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.useStrictMode(true);
    Carbon.resetTimeMachineSupport();
  });

  group('php-style create', () {
    test('defaults to zero date when no args provided', () {
      final result = Carbon.createFromDateTime();
      expect(result, isNotNull);
      expect(result!.toIso8601String(), '0000-01-01T00:00:00.000Z');
    });

    test('explicit null values reuse now components', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 9, 45, 30)), () {
        final result = Carbon.createFromDateTime(
          null,
          null,
          null,
          null,
          null,
          null,
        );
        expect(result, isNotNull);
        expect(result!.year, 2025);
        expect(result.month, 11);
        expect(result.day, 16);
        expect(result.hour, 9);
        expect(result.minute, 45);
        expect(result.second, 30);
      });
    });

    test('wraps overflowing units the same as PHP', () {
      final result = Carbon.createFromDateTime(2011, 1, 40, 0, 0, 61);
      expect(result, isNotNull);
      final value = result!;
      expect(value.year, 2011);
      expect(value.month, 2);
      expect(value.day, 9);
      expect(value.minute, 1);
      expect(value.second, 1);
    });

    test(
      'string input treats second argument as timezone when applicable',
      () async {
        await Carbon.configureTimeMachine(testing: true);
        final result = Carbon.createFromDateTime(
          '2020-01-05 12:00:00',
          'America/New_York',
        );
        expect(result, isNotNull);
        expect(result!.timeZoneName, 'America/New_York');
        expect(
          result.toIso8601String(keepOffset: true),
          '2020-01-05T12:00:00.000-05:00',
        );
      },
    );

    test('explicit timezone parameter overrides month hint', () async {
      await Carbon.configureTimeMachine(testing: true);
      final result = Carbon.createFromDateTime(
        2024,
        5,
        1,
        10,
        30,
        0,
        'Europe/Paris',
      );
      expect(result, isNotNull);
      expect(result!.timeZoneName, 'Europe/Paris');
      expect(
        result.toIso8601String(keepOffset: true),
        '2024-05-01T10:30:00.000+02:00',
      );
    });

    test('invalid values throw in strict mode but return null otherwise', () {
      expect(() => Carbon.createFromDateTime(null, -5), throwsRangeError);
      Carbon.useStrictMode(false);
      final result = Carbon.createFromDateTime(null, -5);
      expect(result, isNull);
      Carbon.useStrictMode(true);
    });
  });

  group('Carbon.make helper', () {
    test('returns parsed value for strings', () {
      final value = Carbon.make('2024-08-01T05:00:00Z');
      expect(value, isNotNull);
      expect(value!.year, 2024);
    });

    test('returns clone for DateTime', () {
      final source = DateTime.utc(2025, 1, 1, 3);
      final value = Carbon.make(source);
      expect(value, isNotNull);
      expect(value!.toIso8601String(), '2025-01-01T03:00:00.000Z');
    });

    test('returns null for unsupported input', () {
      expect(Carbon.make(42), isNull);
    });
  });
}

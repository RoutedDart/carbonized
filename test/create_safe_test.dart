import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  group('Carbon.createSafe', () {
    setUp(() => Carbon.useStrictMode(true));

    test('throws on invalid day when strict mode enabled', () {
      expect(
        () => Carbon.createSafe(2024, 2, 30),
        throwsA(isA<CarbonInvalidDateException>()),
      );
    });

    test('returns null when strict mode disabled', () {
      Carbon.useStrictMode(false);
      final result = Carbon.createSafe(2024, 2, 30);
      expect(result, isNull);
      expect(Carbon.isStrictModeEnabled(), isFalse);
    });

    test(
      'returns null for invalid timezone date when strict mode disabled',
      () {
        Carbon.useStrictMode(false);
        final value = Carbon.createSafe(
          2024,
          2,
          30,
          null,
          null,
          null,
          0,
          'Europe/Paris',
        );
        expect(value, isNull);
      },
    );

    test('preserves timezone when values are valid', () {
      final result = Carbon.createSafe(
        2025,
        3,
        15,
        9,
        30,
        0,
        0,
        'Europe/Paris',
      );
      expect(result, isNotNull);
      expect(result!.timeZoneName, 'Europe/Paris');
      expect(result.dateTime, DateTime.utc(2025, 3, 15, 8, 30));
    });

    test('falls back to current components when null provided', () {
      withClock(Clock.fixed(DateTime.utc(2030, 6, 10, 12, 0)), () {
        final value = Carbon.createSafe(null, null, null, 8, 15, 0)!;
        expect(value.year, 2030);
        expect(value.month, 6);
        expect(value.day, 10);
        expect(value.hour, 8);
        expect(value.minute, 15);
        expect(value.second, 0);
      });
    });
  });

  group('Carbon.createStrict', () {
    setUp(() => Carbon.useStrictMode(false));

    test('createStrict enables strict mode temporarily', () {
      expect(Carbon.isStrictModeEnabled(), isFalse);
      final value = Carbon.createStrict(2024, 5, 10);
      expect(value.year, 2024);
      expect(Carbon.isStrictModeEnabled(), isFalse);
    });

    test('createStrict rethrows validation errors', () {
      expect(
        () => Carbon.createStrict(2024, 2, 30),
        throwsA(isA<CarbonInvalidDateException>()),
      );
      expect(Carbon.isStrictModeEnabled(), isFalse);
    });
  });
}

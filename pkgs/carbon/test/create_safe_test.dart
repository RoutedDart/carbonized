import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

Matcher _invalidField(String field, Object value) =>
    isA<CarbonInvalidDateException>()
        .having((e) => e.field, 'field', field)
        .having((e) => e.value, 'value', value);

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  group('Carbon.createSafe', () {
    setUp(() => Carbon.useStrictMode(true));

    test('CarbonInvalidDateException exposes metadata', () {
      CarbonInvalidDateException? exception;
      try {
        Carbon.createSafe(0);
      } on CarbonInvalidDateException catch (err) {
        exception = err;
      }
      final captured = exception;
      expect(captured, isNotNull);
      expect(captured?.field, 'year');
      expect(captured?.value, 0);
    });

    test('seconds must be within range', () {
      expect(
        () => Carbon.createSafe(null, null, null, null, null, -1),
        throwsA(_invalidField('second', -1)),
      );
      expect(
        () => Carbon.createSafe(null, null, null, null, null, 60),
        throwsA(_invalidField('second', 60)),
      );
    });

    test('minutes must be within range', () {
      expect(
        () => Carbon.createSafe(null, null, null, null, -1),
        throwsA(_invalidField('minute', -1)),
      );
      expect(
        () => Carbon.createSafe(null, null, null, null, 60, 25),
        throwsA(_invalidField('minute', 60)),
      );
    });

    test('hours must be within range', () {
      expect(
        () => Carbon.createSafe(null, null, null, -6),
        throwsA(_invalidField('hour', -6)),
      );
      expect(
        () => Carbon.createSafe(null, null, null, 25, 16, 15),
        throwsA(_invalidField('hour', 25)),
      );
    });

    test('days must exist within month boundaries', () {
      expect(
        () => Carbon.createSafe(null, null, -5),
        throwsA(_invalidField('day', -5)),
      );
      expect(
        () => Carbon.createSafe(null, null, 32),
        throwsA(_invalidField('day', 32)),
      );
      expect(
        () => Carbon.createSafe(2016, 4, 31),
        throwsA(_invalidField('day', 31)),
      );
    });

    test('February rules respect leap years', () {
      expect(
        () => Carbon.createSafe(2016, 2, 30),
        throwsA(_invalidField('day', 30)),
      );
      expect(
        () => Carbon.createSafe(2015, 2, 29),
        throwsA(_invalidField('day', 29)),
      );
      expect(Carbon.createSafe(2016, 2, 29)!.day, 29);
      expect(Carbon.createSafe(2015, 2, 28)!.day, 28);
    });

    test('months and years must be within range', () {
      expect(
        () => Carbon.createSafe(null, -4),
        throwsA(_invalidField('month', -4)),
      );
      expect(
        () => Carbon.createSafe(null, 13),
        throwsA(_invalidField('month', 13)),
      );
      expect(() => Carbon.createSafe(0), throwsA(_invalidField('year', 0)));
      expect(() => Carbon.createSafe(-5), throwsA(_invalidField('year', -5)));
      expect(
        () => Carbon.createSafe(10000),
        throwsA(_invalidField('year', 10000)),
      );
    });

    test('invalid DST gaps surface as hour validation failures', () {
      expect(
        () => Carbon.createSafe(2014, 3, 30, 1, 30, 0, 0, 'Europe/London'),
        throwsA(_invalidField('hour', 1)),
      );
      final midnight = Carbon.createSafe(
        2014,
        3,
        30,
        0,
        30,
        0,
        0,
        'Europe/London',
      );
      final twoAm = Carbon.createSafe(
        2014,
        3,
        30,
        2,
        30,
        0,
        0,
        'Europe/London',
      );
      final utcGap = Carbon.createSafe(2014, 3, 30, 1, 30, 0, 0, 'UTC');
      expect(midnight?.toIso8601String(), '2014-03-30T00:30:00.000Z');
      expect(twoAm?.toIso8601String(), '2014-03-30T01:30:00.000Z');
      expect(utcGap?.toIso8601String(), '2014-03-30T01:30:00.000Z');
    });

    test('returns null when strict mode disabled', () {
      Carbon.useStrictMode(false);
      expect(Carbon.createSafe(2024, 2, 30), isNull);
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
        throwsA(_invalidField('day', 30)),
      );
      expect(Carbon.isStrictModeEnabled(), isFalse);
    });

    test('createStrict respects component ranges', () {
      expect(
        () => Carbon.createStrict(null, 9001),
        throwsA(_invalidField('month', 9001)),
      );
      expect(
        () => Carbon.createStrict(null, null, null, null, null, -1),
        throwsA(_invalidField('second', -1)),
      );
      expect(Carbon.isStrictModeEnabled(), isFalse);
    });
  });
}

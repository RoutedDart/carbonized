import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  setUp(() {
    Carbon.setTestNow(null);
  });

  tearDown(() {
    Carbon.setTestNow(null);
  });

  group('createFromTime', () {
    test('uses the mocked clock when components are null', () {
      withClock(Clock.fixed(DateTime.utc(2011, 1, 1, 12, 13, 14)), () {
        final value = Carbon.createFromTime(null, null, null);
        expect(value.toIso8601String(), '2011-01-01T12:13:14.000Z');
      });
    });

    test('applies provided hour/minute/second on today\'s date', () {
      withClock(Clock.fixed(DateTime.utc(2030, 1, 5, 6, 30)), () {
        final result = Carbon.createFromTime(23, 5, 21, 123456);
        expect(result.year, 2030);
        expect(result.month, 1);
        expect(result.day, 5);
        expect(result.hour, 23);
        expect(result.minute, 5);
        expect(result.second, 21);
        expect(result.microsecond, 123456);
      });
    });

    test('derives the base day in the provided timezone', () {
      withClock(Clock.fixed(DateTime.utc(2024, 1, 1, 22, 0)), () {
        final value = Carbon.createFromTime(2, 0, 0, 0, '+04:00');
        expect(value.timeZoneName, '+04:00');
        expect(
          value.toIso8601String(keepOffset: true),
          '2024-01-02T02:00:00.000+04:00',
        );
      });
    });

    test('inherits locale from the active mocked instance', () {
      final reference = Carbon.parse('2020-01-01 00:00:00').locale('ru');
      Carbon.setTestNow(reference);
      final value = Carbon.createFromTime(1);
      expect(value.localeCode, 'ru');
    });

    test('rejects seconds above 99', () {
      expect(() => Carbon.createFromTime(1, 2, 120), throwsRangeError);
    });
  });
}

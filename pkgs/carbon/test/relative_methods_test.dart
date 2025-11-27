import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  group('Carbon relative helpers', () {
    test('relative returns new instance', () {
      final original = Carbon.parse('2025-01-01');
      final clone = original.relative('+3 days');
      expect(original.day, 1);
      expect(clone.day, 4);
    });

    test('next/previous operate independently', () {
      final next = Carbon.parse('2025-01-01').next('monday');
      expect(next.day, 6);
      final previous = Carbon.parse('2025-01-01').previous('monday');
      expect(previous.day, 30);
    });
  });

  group('Day-relative measurements', () {
    test('secondsSinceMidnight matches PHP scenarios', () {
      expect(Carbon.today().secondsSinceMidnight(), closeTo(0, 1e-9));
      expect(
        Carbon.today().addSeconds(30).secondsSinceMidnight(),
        closeTo(30, 1e-9),
      );
      expect(
        Carbon.today().addDays(1).secondsSinceMidnight(),
        closeTo(0, 1e-9),
      );
      expect(
        Carbon.today().addDays(1).addSeconds(120).secondsSinceMidnight(),
        closeTo(120, 1e-9),
      );
      expect(
        Carbon.today().addMonths(3).addSeconds(42).secondsSinceMidnight(),
        closeTo(42, 1e-9),
      );
    });

    test('secondsSinceMidnight handles fractional seconds', () {
      final carbon = Carbon.parse('2025-02-10T12:34:56.789123Z');
      expect(carbon.secondsSinceMidnight(), closeTo(45296.789123, 1e-9));
    });

    test('secondsUntilEndOfDay mirrors PHP checks', () {
      final end = Carbon.today().endOfDay();
      expect(end.secondsUntilEndOfDay(), closeTo(0, 1e-6));
      expect(
        end.copy().subSeconds(60).secondsUntilEndOfDay(),
        closeTo(60, 1e-6),
      );
      final custom = Carbon.parse('2014-10-24T12:34:56Z');
      expect(custom.secondsUntilEndOfDay(), closeTo(41103.999999, 1e-5));
      final midnight = Carbon.parse('2014-10-24T00:00:00Z');
      expect(midnight.secondsUntilEndOfDay(), closeTo(86399.999999, 1e-5));
    });

    test('secondsUntilEndOfDay complements secondsSinceMidnight', () {
      final carbon = Carbon.parse('2025-02-10T12:34:56.789123Z');
      final remaining = carbon.secondsUntilEndOfDay();
      final sum = carbon.secondsSinceMidnight() + remaining;
      expect(sum, closeTo(86400, 1e-6));
    });
  });

  group('Time keyword navigation', () {
    setUp(() {
      Carbon.setTestNow('2019-06-02T13:27:09.816752Z');
    });

    tearDown(() {
      Carbon.setTestNow(null);
    });

    test('next/previous accept explicit times of day', () {
      final next2pm = Carbon.now().next('2pm');
      expect(next2pm.toIso8601String(), '2019-06-02T14:00:00.000Z');

      final previous2pm = Carbon.now().previous('2pm');
      expect(previous2pm.toIso8601String(), '2019-06-01T14:00:00.000Z');

      final nextNineAm = Carbon.now().next('9am');
      expect(nextNineAm.toIso8601String(), '2019-06-03T09:00:00.000Z');

      final next24Hour = Carbon.now().next('14h');
      expect(next24Hour.toIso8601String(), '2019-06-02T14:00:00.000Z');
    });

    test(
      'Carbon.parse understands time tokens with next/previous prefixes',
      () {
        expect(
          Carbon.parse('next 2pm').toIso8601String(),
          '2019-06-02T14:00:00.000Z',
        );
        expect(
          Carbon.parse('previous 2pm').toIso8601String(),
          '2019-06-01T14:00:00.000Z',
        );
        expect(
          Carbon.parse('next 9am').toIso8601String(),
          '2019-06-03T09:00:00.000Z',
        );
      },
    );

    test('after/before keywords map to whole-day jumps', () {
      expect(
        Carbon.parse('after tomorrow').toIso8601String(),
        '2019-06-04T00:00:00.000Z',
      );
      expect(
        Carbon.parse('before yesterday').toIso8601String(),
        '2019-05-31T00:00:00.000Z',
      );

      final base = Carbon.parse('2000-01-25');
      expect(
        base.relative('after tomorrow').toIso8601String(),
        '2000-01-27T00:00:00.000Z',
      );
      expect(
        base.relative('before yesterday').toIso8601String(),
        '2000-01-23T00:00:00.000Z',
      );
    });

    test('Carbon.parse relative string honors explicit timezone', () {
      final parsed = Carbon.parse('next 2pm', timeZone: 'America/Toronto');
      expect(parsed.timeZoneName, 'America/Toronto');
      expect(parsed.dateTime, DateTime.utc(2019, 6, 2, 18));
    });
  });
}

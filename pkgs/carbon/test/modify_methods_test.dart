import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.modify', () {
    setUpAll(() async {
      await Carbon.configureTimeMachine();
    });

    test('supports signed durations', () {
      final value = Carbon.parse('2025-01-01');
      value.modify('+2 weeks');
      expect(value.day, 15);
    });

    test('supports next/previous keywords', () {
      final result = Carbon.parse('2025-01-01').modify('next monday');
      expect(result.day, 6);
    });

    test('change aliases modify semantics', () {
      final value = Carbon.parse('2000-01-25');
      final delta = value.change('after tomorrow');
      expect(identical(value, delta), isTrue);
      expect(value.toIso8601String(), '2000-01-27T00:00:00.000Z');
    });

    test('throws on unsupported tokens', () {
      expect(() => Carbon.now().modify('foo'), throwsArgumentError);
      expect(() => Carbon.now().change('foo'), throwsArgumentError);
    });
  });

  group('Real-unit helpers', () {
    setUpAll(() async {
      await Carbon.configureTimeMachine();
    });

    test('addRealHour skips DST gaps', () async {
      withClock(Clock.fixed(DateTime.utc(2014, 3, 30)), () {
        final carbon = Carbon.createFromTime(0, 59, 0, 0, 'Europe/London');
        carbon.addRealHours(1);
        expect(carbon.dateTime, DateTime.utc(2014, 3, 30, 1, 59));
        carbon.subRealHours(1);
        expect(carbon.dateTime, DateTime.utc(2014, 3, 30, 0, 59));
      });
    });

    test('diffInReal units return fractional values', () {
      final start = Carbon.parse('2020-01-01T00:00:00Z');
      final end = start.copy().addMinutes(90);

      expect(start.diffInRealHours(end), closeTo(1.5, 1e-9));
      expect(start.diffInRealMinutes(end), closeTo(90, 1e-9));
      expect(start.diffInRealSeconds(end), closeTo(5400, 1e-6));
      expect(start.diffInRealMilliseconds(end), closeTo(5.4e6, 1e-3));
      expect(start.diffInRealMicroseconds(end), closeTo(5.4e9, 1));

      expect(start.diffInRealHours(end, absolute: false), closeTo(-1.5, 1e-9));
    });

    test('diffInRealHours reflects DST gaps', () {
      final base = Carbon.parse(
        '2014-03-30T00:00:00',
        timeZone: 'Europe/London',
      );
      final shifted = base.copy().addHours(24);
      final expected =
          (shifted.dateTime.difference(base.dateTime).inMicroseconds /
          Duration.microsecondsPerHour);
      expect(base.diffInRealHours(shifted), closeTo(expected, 1e-9));
    });
  });
}

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

    test('throws on unsupported tokens', () {
      expect(() => Carbon.now().modify('foo'), throwsArgumentError);
    });
  });

  group('Real-unit helpers', () {
    setUpAll(() async {
      await Carbon.configureTimeMachine();
    });

    test('addRealHour skips DST gaps', () async {
      withClock(Clock.fixed(DateTime.utc(2014, 3, 30)), () {
        final carbon = Carbon.createFromTime(
          0,
          59,
          0,
          0,
          'Europe/London',
        );
        carbon.addRealHours(1);
        expect(carbon.dateTime, DateTime.utc(2014, 3, 30, 1, 59));
        carbon.subRealHours(1);
        expect(carbon.dateTime, DateTime.utc(2014, 3, 30, 0, 59));
      });
    });
  });
}

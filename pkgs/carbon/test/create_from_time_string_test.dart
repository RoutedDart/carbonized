import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  tearDownAll(Carbon.resetTimeMachineSupport);

  group('Carbon.createFromTimeString', () {
    test('parses hour and minute only', () {
      withClock(Clock.fixed(DateTime.utc(2040, 2, 1)), () {
        final result = Carbon.createFromTimeString('08:30');
        expect(result.hour, 8);
        expect(result.minute, 30);
        expect(result.second, 0);
        expect(result.microsecond, 0);
      });
    });

    test('parses seconds when present', () {
      withClock(Clock.fixed(DateTime.utc(2040, 2, 1)), () {
        final result = Carbon.createFromTimeString('08:30:15');
        expect(result.second, 15);
        expect(result.microsecond, 0);
      });
    });

    test('parses fractional seconds into microseconds', () {
      withClock(Clock.fixed(DateTime.utc(2040, 2, 1)), () {
        final result = Carbon.createFromTimeString('08:30:15.123456');
        expect(result.microsecond, 123456);
      });
    });

    test('accepts timezone names for localized creation', () async {
      final result = Carbon.createFromTimeString(
        '12:20:30',
        timeZone: 'Europe/London',
      );
      expect(result.timeZoneName, 'Europe/London');
      expect(result.hour, 12);
      expect(result.minute, 20);
      expect(result.second, 30);
    });

    test('throws FormatException for invalid input', () {
      expect(
        () => Carbon.createFromTimeString('invalid'),
        throwsFormatException,
      );
    });
  });
}

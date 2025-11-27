import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('timezone-aware creation without provider', () {
    setUp(() => Carbon.resetTimeMachineSupport());

    test('fixed offset strings convert to UTC', () {
      final CarbonInterface result = Carbon.createFromDate(2024, 1, 1, '+0530');
      expect(result.dateTime, DateTime.utc(2023, 12, 31, 18, 30));
      expect(result.timeZoneName, '+0530');
    });

    test('named zones throw until configureTimeMachine is called', () {
      expect(
        () => Carbon.createFromDate(2024, 1, 1, 'Europe/Paris'),
        throwsStateError,
      );
    });

    test('timestamp helpers reject named zones without provider', () {
      expect(
        () => Carbon.createFromTimestamp(0, timeZone: 'Europe/Paris'),
        throwsStateError,
      );
    });
  });

  group('timezone-aware creation with provider', () {
    setUpAll(() async {
      await Carbon.configureTimeMachine();
    });

    test('local components convert through Time Machine', () async {
      final CarbonInterface value = Carbon.createFromDate(
        2014,
        3,
        30,
        'Europe/London',
      );
      expect(value.dateTime, DateTime.utc(2014, 3, 30));
    });

    test('DST gaps throw for missing local times', () {
      withClock(Clock.fixed(DateTime.utc(2014, 3, 30)), () {
        expect(
          () => Carbon.createFromTime(1, 30, 0, 0, 'Europe/London'),
          throwsStateError,
        );
      });
    });

    test('timestamp retains instant but records timezone', () {
      final CarbonInterface value = Carbon.createFromTimestamp(
        0,
        timeZone: 'America/Toronto',
      );
      expect(value.dateTime, DateTime.utc(1970, 1, 1));
      expect(value.timeZoneName, 'America/Toronto');
    });
  });
}

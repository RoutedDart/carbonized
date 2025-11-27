import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  group('createFromTimestamp*', () {
    test('recreates the instant represented by the timestamp', () {
      final timestamp =
          DateTime.utc(1975, 5, 21, 22, 32, 5).millisecondsSinceEpoch ~/ 1000;
      final value = Carbon.createFromTimestamp(timestamp, timeZone: 'UTC');
      expect(value.toIso8601String(), '1975-05-21T22:32:05.000Z');
    });

    test('createFromTimestampMs handles fractional milliseconds', () {
      final base = DateTime.utc(1975, 5, 21, 22, 32, 5).millisecondsSinceEpoch;
      final value = Carbon.createFromTimestampMs(base + 321.8479);
      expect(value.microsecond, 321848);
      expect(value.toIso8601String(), '1975-05-21T22:32:05.321848Z');
    });

    test('createFromTimestampMsUTC anchors to UTC regardless of defaults', () {
      final base = DateTime.utc(1975, 5, 21, 22, 32, 5).millisecondsSinceEpoch;
      final value = Carbon.createFromTimestampMsUTC(base + 321.84);
      expect(value.timeZoneName, 'UTC');
      expect(value.microsecond, 321840);
    });

    test('createFromTimestamp applies timezone offsets when provided', () {
      final value = Carbon.createFromTimestamp(0, timeZone: '-05:00');
      expect(value.timeZoneName, '-05:00');
      expect(
        value.toIso8601String(keepOffset: true),
        '1969-12-31T19:00:00.000-05:00',
      );
    });

    test('createFromTimestamp handles DST transitions with named zones', () {
      final earlier = Carbon.createFromTimestamp(
        1572757200,
        timeZone: 'America/New_York',
      );
      final later = Carbon.createFromTimestamp(
        1572757200 + 3600,
        timeZone: 'America/New_York',
      );
      expect(
        earlier.toIso8601String(keepOffset: true),
        '2019-11-03T01:00:00.000-04:00',
      );
      expect(
        later.toIso8601String(keepOffset: true),
        '2019-11-03T01:00:00.000-05:00',
      );
    });
  });
}

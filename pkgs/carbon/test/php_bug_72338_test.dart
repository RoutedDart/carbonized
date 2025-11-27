import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  tearDownAll(Carbon.resetTimeMachineSupport);

  group('PhpBug72338 parity', () {
    test('modify does not corrupt unix timestamps', () {
      final carbon = Carbon.createFromTimestamp(0).tz('+02:00');
      carbon.modify('+1 day');
      expect(carbon.toEpochMilliseconds(), 86400 * 1000);
    });

    test('formatting keeps timestamp after timezone change', () {
      final carbon = Carbon.createFromTimestamp(0).tz('+02:00');
      expect(carbon.toEpochMilliseconds(), 0);
      carbon.tz('-03:00');
      expect(carbon.toEpochMilliseconds(), 0);
    });

    test('parsing with the same timezone matches timestamp', () {
      final fromTimestamp = Carbon.createFromTimestamp(0).tz('+02:00');
      final fromString = Carbon.parse('1970-01-01T02:00:00+02:00');
      expect(
        fromTimestamp.toEpochMilliseconds(),
        fromString.toEpochMilliseconds(),
      );
    });

    test('second timezone change keeps unix timestamp stable', () {
      final carbon = Carbon.createFromTimestamp(0).tz('+02:00');
      expect(carbon.toEpochMilliseconds(), 0);
      carbon.tz('Europe/Moscow');
      expect(carbon.toEpochMilliseconds(), 0);
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  tearDownAll(Carbon.resetTimeMachineSupport);

  group('modify near DST transitions', () {
    test('forward transition keeps real hour semantics', () {
      final carbon = Carbon.parse(
        '2010-03-14T00:00:00-05:00',
      ).tz('America/New_York');
      carbon.addHours(24);
      expect(
        carbon.toIso8601String(keepOffset: true),
        '2010-03-15T01:00:00.000-04:00',
      );
    });

    test('backward transition keeps real hour semantics', () {
      final carbon = Carbon.parse(
        '2010-11-07T00:00:00-04:00',
      ).tz('America/New_York');
      carbon.addHours(24);
      expect(
        carbon.toIso8601String(keepOffset: true),
        '2010-11-07T23:00:00.000-05:00',
      );
    });
  });
}

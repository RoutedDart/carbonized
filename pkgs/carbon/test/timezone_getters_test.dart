import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await Carbon.configureTimeMachine(testing: true);
  });

  tearDownAll(Carbon.resetTimeMachineSupport);

  group('Carbon timezone snapshots', () {
    test('Europe/London switches between BST and GMT', () {
      final summer = Carbon.parse('2024-08-19T12:00:00Z').tz('Europe/London');
      final winter = Carbon.parse('2024-01-19T12:00:00Z').tz('Europe/London');

      expect(summer.format('zzz'), 'BST');
      expect(winter.format('zzz'), 'GMT');
    });

    test('America/Chicago offset reflects DST transition', () {
      final winter = Carbon.parse('2024-01-19T12:00:00Z').tz('America/Chicago');
      final summer = Carbon.parse('2024-08-19T12:00:00Z').tz('America/Chicago');

      expect(winter.format('zzzz'), 'GMT-06:00');
      expect(summer.format('zzzz'), 'GMT-05:00');
    });

    test('tz("UTC") remains stable without backend lookup', () {
      final utc = Carbon.parse('2024-08-19T12:00:00Z').tz('UTC');
      expect(utc.format('zzz'), 'UTC');
    });
  });
}

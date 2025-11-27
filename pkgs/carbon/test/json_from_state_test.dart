import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('fromState rehydrates serialized map', () {
    final state = {
      'iso': '2024-05-21T12:00:00.000Z',
      'timeZone': 'Europe/Paris',
      'locale': 'fr',
      'settings': {'startOfWeek': DateTime.monday},
      'type': 'carbon',
    };
    final restored = Carbon.fromState(state);
    expect(restored.toUtc().toIso8601String(), '2024-05-21T12:00:00.000Z');
    expect(restored.timeZoneName, 'Europe/Paris');
    expect(restored.localeCode, 'fr');
  });
}

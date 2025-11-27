import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.setLocale('en');
    Carbon.setWeekStartsAt(DateTime.monday);
    Carbon.setTestNow(null);
  });

  test('setTestNow overrides now', () {
    final reference = Carbon.parse('2025-01-01T12:00:00Z');
    Carbon.setTestNow(reference);
    final now = Carbon.now();
    expect(now.dateTime, reference.dateTime);
    Carbon.setTestNow(null);
  });

  test('today uses timezone aware midnight', () {
    withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 15)), () {
      final today = Carbon.today(timeZone: 'UTC');
      expect(today.dateTime, DateTime.utc(2025, 11, 14));
    });
  });

  test('tomorrow respects timezone parameter', () {
    withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 9)), () {
      final tomorrow = Carbon.tomorrow(timeZone: 'UTC');
      expect(tomorrow.dateTime, DateTime.utc(2025, 11, 15));
    });
  });

  test('now inherits locale and timezone when testNow is set', () {
    final reference = Carbon.parse('2020-05-01T10:20:30Z');
    Carbon.setTestNow(reference);
    final now = Carbon.now(timeZone: '+02:00');
    expect(now.timeZoneName, '+02:00');
    expect(now.dateTime, reference.dateTime);
  });

  test('yesterday and tomorrow respect mocked clock', () {
    final mocked = Carbon.parse('2024-02-10T09:00:00Z');
    Carbon.setTestNow(mocked);
    expect(Carbon.yesterday().toIso8601String(), '2024-02-09T00:00:00.000Z');
    expect(Carbon.tomorrow().toIso8601String(), '2024-02-11T00:00:00.000Z');
  });
}

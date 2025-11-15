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
}

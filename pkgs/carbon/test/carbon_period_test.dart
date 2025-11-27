import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('recurrences limits period output', () {
    final start = Carbon.parse('2024-12-01T00:00:00Z');
    final full = start.daysUntil('2024-12-10T00:00:00Z');
    final limited = full.recurrences(3);

    expect(limited.length, 3);
    expect(limited.maxRecurrences, 3);
    expect(limited.first, start);
    expect(limited.last.toIso8601String(), '2024-12-03T00:00:00.000Z');
  });

  test('filter retains recurrence limit and picks weekdays', () {
    final start = Carbon.parse('2024-12-23T00:00:00Z');
    final period = start.daysUntil('2025-01-05T00:00:00Z');
    final weekdays = period.filter((date) => !date.isWeekend()).recurrences(5);

    expect(weekdays.length, 5);
    expect(weekdays.maxRecurrences, 5);
    for (final date in weekdays) {
      expect(date.isWeekend(), isFalse);
    }
  });

  test('toString formats period with locale strings', () {
    final start = Carbon.parse('2024-12-01T00:00:00Z');
    final period = start.daysUntil('2024-12-05T00:00:00Z');

    final result = period.toString();
    expect(result, contains('Every 1 day'));
    expect(result, contains('from 2024-12-01'));
    expect(result, contains('to 2024-12-05'));
  });

  test('toString includes recurrences when limited', () {
    final start = Carbon.parse('2024-12-01T00:00:00Z');
    final period = start.daysUntil('2024-12-10T00:00:00Z').recurrences(3);

    final result = period.toString();
    expect(result, contains('3 times'));
    expect(result, contains('every 1 day')); // lowercase when after recurrences
    expect(result, contains('from 2024-12-01'));
  });
}

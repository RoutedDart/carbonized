import 'package:carbon/carbon.dart';
import 'package:test/test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
    await initializeDateFormatting();
  });

  group('calendar', () {
    test('formats dates relative to reference (en)', () {
      Carbon.setLocale('en');
      final now = Carbon.parse('2024-01-10T14:30:00Z');
      Carbon.setTestNow(now);

      // Same day (Today)
      expect(now.calendar(reference: now), contains('Today at'));

      // Next day (Tomorrow)
      final tomorrow = now.copy().addDays(1);
      expect(tomorrow.calendar(reference: now), contains('Tomorrow at'));

      // Last day (Yesterday)
      final yesterday = now.copy().subDays(1);
      expect(yesterday.calendar(reference: now), contains('Yesterday at'));

      // Next week (Saturday - 3 days ahead
      final nextWeek = now.copy().addDays(3);
      expect(nextWeek.calendar(reference: now), isNot(contains('Today')));

      // Last week (Sunday - 3 days ago)
      final lastWeek = now.copy().subDays(3);
      expect(lastWeek.calendar(reference: now), isNot(contains('Today')));

      // Same Else (More than a week away)
      final future = now.copy().addWeeks(2);
      expect(future.calendar(reference: now), '01/24/2024');
    });

    test('formats dates relative to reference (fr)', () {
      Carbon.setLocale('fr');
      final now = Carbon.parse('2024-01-10T14:30:00Z');
      Carbon.setTestNow(now);

      // Same day (Aujourd'hui)
      // Note: French calendar format often includes literal escaping like [Aujourd’hui à] LT
      // We need to ensure isoFormat      // Same day (Aujourd'hui)
      expect(now.calendar(reference: now), contains('à'));

      // Next day (Demain)
      final tomorrow = now.copy().addDays(1);
      expect(tomorrow.calendar(reference: now), contains('Demain'));

      // Last day (Hier)
      final yesterday = now.copy().subDays(1);
      expect(yesterday.calendar(reference: now), contains('Hier'));

      // Next week
      final nextWeek = now.copy().addDays(3); // Samedi
      expect(nextWeek.calendar(reference: now), contains('samedi'));

      // Last week
      final lastWeek = now.copy().subDays(3); // Dimanche
      expect(lastWeek.calendar(reference: now), contains('dimanche'));
    });

    test('accepts reference date', () {
      Carbon.setLocale('en');
      final ref = Carbon.parse('2024-01-10T12:00:00Z');
      final target = Carbon.parse('2024-01-11T12:00:00Z');

      expect(target.calendar(reference: ref), contains('Tomorrow at'));
    });
  });
}

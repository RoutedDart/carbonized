import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('week()/isoWeek()', () {
    test('default getters mirror locale values', () {
      Carbon.setLocale('en');
      final date = Carbon.parse('2024-06-05T00:00:00Z');

      final weekValue = date.weekNumber();
      final isoValue = date.isoWeekNumber();

      expect(weekValue, date.localeWeek);
      expect(isoValue, date.isoWeek);
    });

    test('setters adjust by week delta', () {
      final base = Carbon.parse('2024-06-05T00:00:00Z');
      final result = base.setWeekNumber(30);
      expect(result.toIso8601String(), '2024-07-24T00:00:00.000Z');

      final iso = base.setIsoWeekNumber(2);
      expect(iso.toIso8601String(), '2024-01-10T00:00:00.000Z');
    });

    test('custom parameters accepted', () {
      final base = Carbon.parse('2024-06-05T00:00:00Z');
      final customWeek = base.weekNumber(DateTime.monday, 6);
      expect(customWeek, greaterThan(0));

      final shifted = base.setWeekNumber(5, DateTime.monday, 6);
      expect(shifted, isA<CarbonInterface>());
    });
  });
}

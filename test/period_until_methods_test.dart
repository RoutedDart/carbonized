import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

int _span(CarbonPeriod period) => period.length - 1;

void main() {
  group('Carbon.periodUntil helpers', () {
    test('monthsUntil counts inclusive months', () {
      final start = Carbon.create(year: 2020, month: 1, day: 1);
      final target = Carbon.create(year: 2020, month: 4, day: 1);
      final period = start.monthsUntil(target);
      expect(_span(period), 3);
      expect(period.start.toIso8601String(), '2020-01-01T00:00:00.000Z');
      expect(period.end.toIso8601String(), '2020-04-01T00:00:00.000Z');
    });

    test('centuriesUntil jumps by 100-year windows', () {
      final start = Carbon.create(year: 1900, month: 1, day: 1);
      final target = Carbon.create(year: 2200, month: 1, day: 1);
      expect(_span(start.centuriesUntil(target)), 3);
    });

    test('decadesUntil supports factors', () {
      final start = Carbon.create(year: 2000, month: 1, day: 1);
      final target = Carbon.create(year: 2050, month: 1, day: 1);
      final everyDecade = start.decadesUntil(target);
      expect(_span(everyDecade), 5);
      final everyOther = start.decadesUntil(target, 2);
      expect(_span(everyOther), 2);
    });

    test('hoursUntil builds hour-by-hour period', () {
      final start = CarbonImmutable.parse('2020-05-01T08:00:00Z');
      final target = start.addHours(5);
      expect(_span(start.hoursUntil(target)), 5);
    });

    test('microsecondsUntil honors the requested factor', () {
      final start = CarbonImmutable.parse('2020-05-01T00:00:00Z');
      final target = start.addMicroseconds(10);
      expect(_span(start.microsecondsUntil(target)), 10);
      expect(_span(start.microsecondsUntil(target, 2)), 5);
    });
  });
}

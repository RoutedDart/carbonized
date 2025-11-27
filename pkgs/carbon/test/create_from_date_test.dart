import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  setUp(() {
    Carbon.setTestNow(null);
  });

  tearDown(() {
    Carbon.setTestNow(null);
  });

  group('createFromDate', () {
    test('matches startOfDay when all parts omitted', () {
      Carbon.setTestNow(Carbon.parse('2011-01-01 12:13:14'));
      final fromDate = Carbon.createFromDate();
      final expected = Carbon.now().startOfDay();
      expect(fromDate.toIso8601String(), expected.toIso8601String());
    });

    test('fills missing components from the active test clock', () {
      Carbon.setTestNow(Carbon.parse('2024-04-05 10:20:30').locale('fr'));
      final onlyYear = Carbon.createFromDate(1975);
      expect(onlyYear.year, 1975);
      expect(onlyYear.month, 4);
      expect(onlyYear.day, 5);
      expect(onlyYear.localeCode, 'fr');
    });

    test('inherits timezone from the mocked clock when none supplied', () {
      Carbon.setTestNow(Carbon.parse('2024-04-05 10:20:30').tz('+02:00'));
      final value = Carbon.createFromDate();
      expect(value.timeZoneName, '+02:00');
    });

    test('allows overriding null fields independently', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 15, 8)), () {
        final yearOnly = Carbon.createFromDate(1988, null, null);
        final monthOnly = Carbon.createFromDate(null, 7);
        final dayOnly = Carbon.createFromDate(null, null, 9);
        expect(yearOnly.year, 1988);
        expect(yearOnly.month, 11);
        expect(yearOnly.day, 15);
        expect(monthOnly.month, 7);
        expect(dayOnly.day, 9);
      });
    });

    test('accepts timezone labels and projects to UTC correctly', () {
      final value = Carbon.createFromDate(2016, 12, 31, 'Europe/London');
      expect(value.timeZoneName, 'Europe/London');
      expect(
        value.toIso8601String(keepOffset: true),
        '2016-12-31T00:00:00.000+00:00',
      );
    });
  });
}

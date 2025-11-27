import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  tearDown(Carbon.setTestNow);

  group('Carbon.carbonize', () {
    test('parses strings using the current timezone', () {
      final base = Carbon.parse(
        '2019-02-01T03:45:27.612584Z',
        timeZone: 'Europe/Paris',
      );
      final result = base.carbonize('2019-03-21');

      expect(result.timeZoneName, 'Europe/Paris');
      expect(
        result.toIso8601String(keepOffset: true),
        '2019-03-21T00:00:00.000+01:00',
      );
    });

    test('returns period starts and keeps them detached', () {
      final base = Carbon.parse('2019-01-01T00:00:00Z');
      final period = base.daysUntil('2019-01-05');

      final extracted = base.carbonize(period);
      expect(extracted.toIso8601String(), '2019-01-01T00:00:00.000Z');
      expect(extracted, isNot(same(period.start)));
    });

    test('adds CarbonInterval and Duration inputs', () {
      final base = Carbon.parse('2019-02-01T03:45:27Z');
      final fromInterval = base.carbonize(CarbonInterval.days(3));
      final fromDuration = base.carbonize(const Duration(hours: 6));

      expect(fromInterval.toIso8601String(), '2019-02-04T03:45:27.000Z');
      expect(fromDuration.toIso8601String(), '2019-02-01T09:45:27.000Z');
    });

    test('null input uses now in the same timezone', () {
      final fakeNow = Carbon.parse('2024-06-01T12:34:56+09:00');
      Carbon.setTestNow(fakeNow);

      final base = Carbon.parse(
        '2019-02-01T03:45:27Z',
        timeZone: 'America/New_York',
      );
      final result = base.carbonize();

      expect(result.timeZoneName, 'America/New_York');
      expect(
        result.toIso8601String(keepOffset: true),
        '2024-05-31T23:34:56.000-04:00',
      );
    });

    test('immutable instances keep their type', () {
      final base = CarbonImmutable.parse('2019-02-01T03:45:27Z');
      final result = base.carbonize('2019-03-01');

      expect(result, isA<CarbonImmutable>());
      expect(result.toIso8601String(), '2019-03-01T00:00:00.000Z');
    });
  });
}

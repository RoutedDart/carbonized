import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Instance conversions', () {
    setUpAll(() async {
      await Carbon.configureTimeMachine(testing: true);
    });

    tearDownAll(Carbon.resetTimeMachineSupport);

    test('Carbon.fromDateTime clones native DateTime including micros', () {
      final native = DateTime.utc(2017, 6, 27, 13, 14, 15, 123, 456);
      final carbon = Carbon.fromDateTime(native);
      expect(carbon.toIso8601String(), '2017-06-27T13:14:15.123456Z');
    });

    test('Carbon.parse accepts DateTime inputs directly', () {
      final native = DateTime.utc(1975, 5, 21, 22, 32, 11);
      final parsed = Carbon.parse(native);
      expect(parsed.year, 1975);
      expect(parsed.month, 5);
      expect(parsed.day, 21);
      expect(parsed.hour, 22);
      expect(parsed.minute, 32);
      expect(parsed.second, 11);
    });

    test('CarbonImmutable.from preserves locale and timezone metadata', () {
      final base = Carbon.parse(
        '2017-06-27T13:14:15.123456Z',
      ).locale('fr_FR').tz('+02:00');
      final frozen = CarbonImmutable.from(base);
      expect(frozen.localeCode, 'fr_FR');
      expect(frozen.timeZoneName, '+02:00');
      expect(frozen.isMutable, isFalse);
      expect(frozen.toIso8601String(), '2017-06-27T13:14:15.123456Z');
    });

    test('Carbon.toImmutable returns distinct immutable copy', () {
      final base = Carbon.parse(
        '2017-06-27T13:14:15.123456Z',
      ).locale('en_CA').tz('Europe/Paris');
      final copy = base.toImmutable();
      expect(identical(copy, base), isFalse);
      expect(copy.localeCode, 'en_CA');
      expect(copy.timeZoneName, 'Europe/Paris');
      expect(copy.isMutable, isFalse);
      expect(copy.toIso8601String(), '2017-06-27T13:14:15.123456Z');
      final shifted = copy.modify('+1 day');
      expect(shifted, isNot(copy));
      expect(copy.day, 27); // original unchanged
    });

    test('CarbonImmutable.toMutable returns mutable clone', () {
      final frozen = Carbon.parse(
        '2017-06-27T13:14:15.123456Z',
      ).tz('Europe/Paris').locale('en_CA').toImmutable();
      final mutable = frozen.toMutable();
      expect(mutable.isMutable, isTrue);
      expect(mutable.localeCode, 'en_CA');
      expect(mutable.timeZoneName, 'Europe/Paris');
      final modified = mutable.modify('+1 day');
      expect(identical(mutable, modified), isTrue);
      expect(mutable.day, 28);
      expect(frozen.day, 27);
    });
  });
}

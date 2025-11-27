import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Copy helpers', () {
    test('copy returns a detached instance', () {
      final original = Carbon.parse('2024-01-01 12:00:00');
      final copy = original.copy();
      expect(copy, isNot(same(original)));

      copy.addDays(1);
      expect(original.day, 1);
      expect(copy.day, 2);
    });

    test('clone mirrors copy semantics', () {
      final original = Carbon.parse('2024-03-15T00:00:00Z');
      final clone = original.clone();
      expect(clone, isNot(same(original)));

      clone.subtract(const Duration(hours: 2));
      expect(original.hour, 0);
      expect(clone.hour, 22);
    });

    test('copy retains timezone metadata', () {
      final source = Carbon.parse('2020-10-10T05:06:07Z')..tz('-07:00');
      final copy = source.copy();
      expect(copy.timeZoneName, '-07:00');
      expect(
        copy.toIso8601String(keepOffset: true),
        source.toIso8601String(keepOffset: true),
      );
    });

    test('copy preserves microseconds', () {
      final source = Carbon.parse('2014-02-01 03:45:27.254687');
      final copy = source.copy();
      expect(copy.microsecond, source.microsecond);
    });

    test('CarbonImmutable copy stays immutable', () {
      var frozen = CarbonImmutable.parse('2022-08-01 00:00:00');
      frozen = frozen.locale('es') as CarbonImmutable;
      final snapshot = frozen.copy();
      expect(snapshot, isA<CarbonImmutable>());
      expect(snapshot.localeCode, 'es');
      expect(snapshot.toIso8601String(), frozen.toIso8601String());
    });
  });
}

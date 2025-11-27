import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('setDateFrom/setTimeFrom', () {
    final source = Carbon.parse('2019-01-02T03:04:05.006007Z');

    test('setDateFrom overrides year/month/day only (mutable)', () {
      final target = Carbon.parse('2025-06-15T10:11:12.123456Z');
      final result = target.setDateFrom(source);
      expect(identical(result, target), isTrue);
      expect(target.toIso8601String(), '2019-01-02T10:11:12.123456Z');
    });

    test('setTimeFrom overrides time components only (mutable)', () {
      final target = Carbon.parse('2025-06-15T10:11:12.123456Z');
      final result = target.setTimeFrom(source);
      expect(identical(result, target), isTrue);
      expect(target.toIso8601String(), '2025-06-15T03:04:05.006007Z');
    });

    test('setDateTimeFrom replaces both date and time (mutable)', () {
      final target = Carbon.parse('2025-06-15T10:11:12.123456Z');
      final result = target.setDateTimeFrom(source);
      expect(identical(result, target), isTrue);
      expect(target.toIso8601String(), '2019-01-02T03:04:05.006007Z');
    });

    test('immutable variants return a new instance', () {
      final base = CarbonImmutable.from(Carbon.parse('2025-06-15T10:11:12Z'));
      final date = base.setDateFrom(source);
      final time = base.setTimeFrom(source);
      final full = base.setDateTimeFrom(source);
      expect(date.toIso8601String(), '2019-01-02T10:11:12.000Z');
      expect(time.toIso8601String(), '2025-06-15T03:04:05.006007Z');
      expect(full.toIso8601String(), '2019-01-02T03:04:05.006007Z');
      expect(identical(date, base), isFalse);
      expect(identical(time, base), isFalse);
      expect(identical(full, base), isFalse);
    });
  });
}

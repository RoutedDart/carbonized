import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('CarbonDateTimeView', () {
    test('mirrors DateTime getters', () {
      final carbon = Carbon.parse('2025-11-16T12:34:56.789123Z');
      final view = carbon.toDateTimeView();

      expect(view.year, 2025);
      expect(view.month, 11);
      expect(view.day, 16);
      expect(view.hour, 12);
      expect(view.minute, 34);
      expect(view.second, 56);
      expect(
        view.microsecondsSinceEpoch,
        carbon.toDateTime().microsecondsSinceEpoch,
      );
      expect(view.isUtc, isTrue);
      expect(view.timeZoneName, 'UTC');
      expect(
        view.millisecondsSinceEpoch,
        carbon.toDateTime().millisecondsSinceEpoch,
      );
    });

    test('equality compares epoch microseconds', () {
      final first = Carbon.parse('2020-01-01T00:00:00Z').toDateTimeView();
      final second = Carbon.parse('2020-01-01T00:00:00Z').toDateTimeView();
      final third = Carbon.parse('2020-01-01T01:00:00Z').toDateTimeView();

      expect(first, equals(second));
      expect(first == third, isFalse);
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  group('diffForHumans multi-unit', () {
    test('produces joined segments limited by parts', () {
      final base = Carbon.parse('2024-01-01T00:00:00Z');
      final future = base.copy()
        ..addYears(1)
        ..addMonths(2)
        ..addDays(3)
        ..addHours(4)
        ..addMinutes(30);
      final diff = future.diffForHumans(reference: base, parts: 3);
      expect(diff, '1 year, 2 months and 3 days from now');
    });

    test('uses short labels and custom joiner', () {
      final base = Carbon.parse('2024-01-01T00:00:00Z');
      final future = base.copy()
        ..addWeeks(1)
        ..addHours(2)
        ..addMinutes(15);
      final diff = future.diffForHumans(
        reference: base,
        parts: 2,
        short: true,
        joiner: ', ',
      );
      expect(diff, '1 wk and 2 h from now'); // Uses 'and' from list separators
    });

    test('falls back to "just now" when equal', () {
      final base = Carbon.parse('2024-06-05T12:00:00Z');
      expect(base.diffForHumans(reference: base, parts: 2), 'just now');
    });
  });
}

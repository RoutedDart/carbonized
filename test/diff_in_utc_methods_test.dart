import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon diffInUTC helpers', () {
    final start = Carbon.parse('2030-05-01T00:00:00Z');
    final later = Carbon.parse('2030-05-03T00:00:00Z');

    test('diffInUTCDays matches UTC distance regardless of local tz', () {
      expect(later.diffInUTCDays(start), 2);
    });

    test('diffInUTCHours reports fractional day distance in hours', () {
      expect(later.diffInUTCHours(start), 48);
    });

    test('diffInUTCMinutes supports fractional precision', () {
      expect(later.diffInUTCMinutes(start), 2880);
  });
  });

  group('Carbon long/short diffForHumans helpers', () {
    test('longAbsoluteDiffForHumans describes durations verbosely', () {
      final start = CarbonImmutable.parse('2025-01-01T00:00:00Z');
      final end = start.addDays(2).addHours(3);
      expect(
        end.longAbsoluteDiffForHumans(start).toLowerCase(),
        contains('2 days'),
      );
    });

    test('shortRelative helpers mirror diffForHumans', () {
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1, 0, 0)), () {
        final anchor = CarbonImmutable.parse('2025-01-01T00:00:00Z');
        final future = anchor.addHours(5);
        expect(
          future.shortRelativeDiffForHumans(anchor),
          future.diffForHumans(reference: anchor),
        );
        expect(
          anchor.shortRelativeToNowDiffForHumans(),
          anchor.diffForHumans(),
        );
        expect(
          future.shortRelativeToOtherDiffForHumans(anchor),
          future.diffForHumans(reference: anchor),
        );
      });
    });
  });
}

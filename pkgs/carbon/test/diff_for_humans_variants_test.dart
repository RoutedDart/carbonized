import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon diffForHumans variants', () {
    test('longAbsoluteDiffForHumans mirrors diffForHumans output', () {
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1, 0, 0)), () {
        final anchor = Carbon.now();
        final earlier = anchor.subYears(1).subMonths(1);
        expect(
          anchor.longAbsoluteDiffForHumans(earlier),
          anchor.diffForHumans(reference: earlier),
        );
      });
    });

    test('longRelativeDiffForHumans matches diffForHumans phrasing', () {
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1, 0, 0)), () {
        final anchor = Carbon.now();
        final future = anchor.addMonths(2);
        expect(
          future.longRelativeDiffForHumans(anchor),
          future.diffForHumans(reference: anchor),
        );
      });
    });

    test('shortRelativeToOtherDiffForHumans mirrors diffForHumans', () {
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1, 0, 0)), () {
        final anchor = Carbon.now();
        final target = anchor.addHours(5);
        expect(
          target.shortRelativeToOtherDiffForHumans(anchor),
          target.diffForHumans(reference: anchor),
        );
      });
    });
  });
}

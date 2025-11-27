import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('forHumans returns localized string', () {
    final interval = CarbonInterval.days(3);
    final text = interval.forHumans();
    expect(text, isNotEmpty);
    expect(text.contains('3'), isTrue);
  });

  test('spec returns iso string', () {
    final interval = CarbonInterval.make(days: 2, hours: 5);
    expect(interval.spec(), startsWith('P2D'));
  });

  test('cascade exposes components', () {
    final interval = CarbonInterval.make(weeks: 1, hours: 4, seconds: 30);
    final parts = interval.cascade();
    expect(parts['days'], 7);
    expect(parts['hours'], 4);
    expect(parts['seconds'], 30);
  });

  test('compareDateIntervals respects months and micros', () {
    final first = CarbonInterval.make(months: 1);
    final second = CarbonInterval.make(months: 1, minutes: 5);
    expect(CarbonInterval.compareDateIntervals(first, second), equals(-1));
  });
}

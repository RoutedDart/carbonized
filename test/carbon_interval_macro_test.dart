import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    CarbonInterval.resetMacros();
  });

  test('interval macros execute', () {
    CarbonInterval.registerMacro('doubleDays', (interval, pos, named) {
      final days =
          interval.monthSpan * 30 +
          interval.microseconds ~/ Duration.microsecondsPerDay;
      return CarbonInterval.days(days * 2);
    });

    dynamic interval = CarbonInterval.days(2);
    final doubled = interval.doubleDays();
    expect(doubled.monthSpan, equals(0));
    expect(doubled.microseconds, equals(Duration.microsecondsPerDay * 4));

    final CarbonInterval typedInterval = CarbonInterval.days(3);
    final CarbonInterval doubledViaHelper =
        typedInterval.carbon('doubleDays') as CarbonInterval;
    expect(
      doubledViaHelper.microseconds,
      equals(Duration.microsecondsPerDay * 6),
    );
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    CarbonPeriod.resetMacros();
  });

  test('period macros available', () {
    CarbonPeriod.registerMacro('first', (period, pos, named) => period.start);
    final start = Carbon.parse('2024-01-01T00:00:00Z');
    final CarbonPeriod period = start.daysUntil('2024-01-05');
    final Carbon first = period.carbon('first') as Carbon;
    expect(first.toIso8601String(), startsWith('2024-01-01'));

    final CarbonPeriod typedPeriod = start.daysUntil('2024-01-03');
    final Carbon result = typedPeriod.carbon('first') as Carbon;
    expect(result.toIso8601String(), startsWith('2024-01-01'));
  });
}

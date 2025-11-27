import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  test('interval comparisons', () {
    final first = CarbonInterval.make(days: 3);
    final second = CarbonInterval.make(days: 3, hours: 1);
    expect(first.lessThan(second), isTrue);
    expect(second.greaterThan(first), isTrue);
    expect(first.equalTo(CarbonInterval.make(days: 3)), isTrue);
  });
}

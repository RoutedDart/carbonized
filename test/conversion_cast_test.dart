import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('Carbon.cast returns mutable copy', () {
    final original = CarbonImmutable.parse('2010-01-01T00:00:00Z');
    final casted = Carbon.cast(original);
    expect(casted, isNot(same(original)));
    expect(casted.runtimeType, Carbon);
  });

  test('CarbonImmutable.cast returns immutable', () {
    final original = Carbon.parse('2010-01-01T00:00:00Z');
    final immutable = CarbonImmutable.cast(original);
    expect(immutable.runtimeType, CarbonImmutable);
    expect(immutable.dateTime, original.dateTime);
  });
}

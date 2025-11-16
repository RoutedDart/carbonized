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
}

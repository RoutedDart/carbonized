import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('utcOffset getter/setter mirrors fixed offsets', () {
    final date = Carbon.parse('2024-01-01T00:00:00Z');
    expect(date.utcOffset, 0);

    date.setUtcOffset(180);
    expect(date.utcOffset, 180);
    expect(date.timeZoneName, '+03:00');

    date.setUtcOffset(-90);
    expect(date.utcOffset, -90);
    expect(date.timeZoneName, '-01:30');
  });
}

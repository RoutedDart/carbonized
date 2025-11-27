import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('rawAdd matches DateTime.add', () {
    final base = Carbon.parse('2024-03-10T12:00:00Z');
    final rawAdded = base.copy()..rawAdd(const Duration(days: 1));
    expect(rawAdded.toIso8601String(), '2024-03-11T12:00:00.000Z');
  });

  test('rawSub matches DateTime.subtract', () {
    final base = Carbon.parse('2024-03-10T12:00:00Z');
    final rawSubbed = base.copy()..rawSub(const Duration(hours: 2));
    expect(rawSubbed.toIso8601String(), '2024-03-10T10:00:00.000Z');
  });
}

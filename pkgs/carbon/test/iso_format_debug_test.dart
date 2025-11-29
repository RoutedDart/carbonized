import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() async {
  await Carbon.configureTimeMachine(testing: true);

  test('Chinese month parsing debug', () {
    print('Testing Chinese month parsing...');
    print('Format: Y M d H,i,s');
    print('Input:  2019 四月 4 12,04,21');
    print('Locale: zh_CN');

    try {
      final value = Carbon.createFromLocaleFormat(
        'Y M d H,i,s',
        'zh_CN',
        '2019 四月 4 12,04,21',
      );
      print('SUCCESS: ${value.toIso8601String()}');
      expect(value.year, equals(2019));
      expect(value.month, equals(4));
    } catch (e, stack) {
      print('FAILED: $e');
      print('Stack: $stack');
      rethrow;
    }
  });

  test('French month parsing debug', () {
    print('\nTesting French month parsing...');
    print('Format: Y F d');
    print('Input:  2019 avril 4');
    print('Locale: fr');

    try {
      final value = Carbon.createFromLocaleFormat(
        'Y F d',
        'fr',
        '2019 avril 4',
      );
      print('SUCCESS: ${value.toIso8601String()}');
      expect(value.year, equals(2019));
      expect(value.month, equals(4));
    } catch (e) {
      print('FAILED: $e');
      rethrow;
    }
  });
}

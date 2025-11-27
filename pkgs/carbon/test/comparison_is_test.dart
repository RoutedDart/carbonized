import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.matches (PHP is())', () {
    test('matches PHP documentation samples', () {
      final date = Carbon.parse('2019-06-02T12:23:45Z');

      expect(date.matches('2019'), isTrue);
      expect(date.matches('2018'), isFalse);
      expect(date.matches('2019-06'), isTrue);
      expect(date.matches('06-02'), isTrue);
      expect(date.matches('2019-06-02'), isTrue);
      expect(date.matches('Sunday'), isTrue);
      expect(date.matches('June'), isTrue);
      expect(date.matches('12:23'), isTrue);
      expect(date.matches('12:23:45'), isTrue);
      expect(date.matches('12:23:00'), isFalse);
      expect(date.matches('12h'), isTrue);
      expect(date.matches('3pm'), isFalse);
      expect(date.matches('3am'), isFalse);
    });

    test('numeric hour meridiem parsing', () {
      final date = Carbon.parse('2024-01-10T03:00:00Z');
      expect(date.matches('3am'), isTrue);
      expect(date.matches('3pm'), isFalse);
      expect(date.matches('15h'), isFalse);
    });

    test('fallback modifier parsing', () {
      final date = Carbon.parse('2024-01-10T12:00:00Z');
      expect(date.matches('next monday'), isFalse);
      expect(date.matches('12:00'), isTrue);
    });
  });
}

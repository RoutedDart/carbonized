import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('hasRelativeKeywords', () {
    final scenarios = <String, bool>{
      '2018-01-02 03:04:05': false,
      '1500-01-02 12:00:00': false,
      '1985-12-10': false,
      'Dec 2017': false,
      '25-Dec-2017': false,
      '25 December 2017': false,
      '25 Dec 2017': false,
      'Dec 25 2017': false,
      'first day of January 2008': false,
      'first day of January 1999': false,
      'last day of January 1999': false,
      'last monday of January 1999': false,
      'first day of January 0001': false,
      'monday december 1750': false,
      'december 1750': false,
      'last sunday of January 2005': false,
      'January 2008': false,
      'first day of next month': true,
      'sunday noon': true,
      'sunday midnight': true,
      'monday december': true,
      'next saturday': true,
      'april': true,
    };

    test('matches expectations', () {
      scenarios.forEach((input, expected) {
        expect(
          Carbon.hasRelativeKeywords(input),
          expected,
          reason: 'mismatch for "$input"',
        );
      });
    });
  });

  group('relative parsing for keyword scenarios', () {
    setUp(() {
      Carbon.setTestNow('2017-01-01T12:00:00Z');
    });

    tearDown(() {
      Carbon.setTestNow(null);
    });

    final expectations = <String, String>{
      'first day of next month': '2017-02-01',
      'sunday noon': '2017-01-01',
      'sunday midnight': '2017-01-01',
      'monday december': '2017-12-04',
      'next saturday': '2017-01-07',
      'april': '2017-04-01',
      'first day of January 2008': '2008-01-01',
      'last day of January 1999': '1999-01-31',
      'last sunday of January 2005': '2005-01-30',
      'Dec 2017': '2017-12-01',
      '25 December 2017': '2017-12-25',
    };

    test('parses relative strings to expected dates', () {
      expectations.forEach((input, expectedDate) {
        final parsed = Carbon.parse(input);
        expect(
          parsed.toIso8601String().substring(0, 10),
          expectedDate,
          reason: 'relative parsing mismatch for "$input"',
        );
      });
    });
  });
}

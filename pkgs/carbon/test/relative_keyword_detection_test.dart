import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

const _relativeScenarios = <String, Map<String, Object>>{
  '2018-01-02 03:04:05': {'date': '2018-01-02', 'isRelative': false},
  '1500-01-02 12:00:00': {'date': '1500-01-02', 'isRelative': false},
  '1985-12-10': {'date': '1985-12-10', 'isRelative': false},
  'Dec 2017': {'date': '2017-12-01', 'isRelative': false},
  '25-Dec-2017': {'date': '2017-12-25', 'isRelative': false},
  '25 December 2017': {'date': '2017-12-25', 'isRelative': false},
  '25 Dec 2017': {'date': '2017-12-25', 'isRelative': false},
  'Dec 25 2017': {'date': '2017-12-25', 'isRelative': false},
  'first day of January 2008': {'date': '2008-01-01', 'isRelative': false},
  'first day of January 1999': {'date': '1999-01-01', 'isRelative': false},
  'last day of January 1999': {'date': '1999-01-31', 'isRelative': false},
  'last monday of January 1999': {'date': '1999-01-25', 'isRelative': false},
  'first day of January 0001': {'date': '0001-01-01', 'isRelative': false},
  'monday december 1750': {'date': '1750-12-07', 'isRelative': false},
  'december 1750': {'date': '1750-12-01', 'isRelative': false},
  'last sunday of January 2005': {'date': '2005-01-30', 'isRelative': false},
  'January 2008': {'date': '2008-01-01', 'isRelative': false},
  'first day of next month': {'date': '2017-02-01', 'isRelative': true},
  'sunday noon': {'date': '2017-01-01', 'isRelative': true},
  'sunday midnight': {'date': '2017-01-01', 'isRelative': true},
  'monday december': {'date': '2017-12-04', 'isRelative': true},
  'next saturday': {'date': '2017-01-07', 'isRelative': true},
  'april': {'date': '2017-04-01', 'isRelative': true},
};

void main() {
  group('hasRelativeKeywords', () {
    test('matches PHP RelativeDateStringTest expectations', () {
      _relativeScenarios.forEach((input, metadata) {
        final isRelative = metadata['isRelative'] as bool;
        expect(
          Carbon.hasRelativeKeywords(input),
          isRelative,
          reason: 'hasRelativeKeywords mismatch for "$input"',
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

    test('parses relative strings to expected dates', () {
      _relativeScenarios.forEach((input, metadata) {
        final parsed = Carbon.parse(input);
        final expectedDate = metadata['date'] as String;
        expect(
          parsed.toIso8601String().substring(0, 10),
          expectedDate,
          reason: 'relative parsing mismatch for "$input"',
        );
      });
    });
  });
}

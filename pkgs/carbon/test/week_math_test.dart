import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('ISO week calculations', () {
    final samples = <String, Map<String, int>>{
      '1990-12-31T00:00:00Z': {'isoWeek': 1, 'isoYear': 1991},
      '1991-01-01T00:00:00Z': {'isoWeek': 1, 'isoYear': 1991},
      '1991-01-06T00:00:00Z': {'isoWeek': 1, 'isoYear': 1991},
      '1991-01-07T00:00:00Z': {'isoWeek': 2, 'isoYear': 1991},
      '1991-12-29T00:00:00Z': {'isoWeek': 52, 'isoYear': 1991},
      '1991-12-30T00:00:00Z': {'isoWeek': 1, 'isoYear': 1992},
    };

    samples.forEach((timestamp, expectations) {
      test('iso week snapshot for $timestamp', () {
        final value = Carbon.parse(timestamp);
        expect(value.isoWeek, expectations['isoWeek']);
        expect(value.isoWeekYear, expectations['isoYear']);
      });
    });

    test('isoWeeksInYear returns 53 when appropriate', () {
      expect(Carbon.parse('2020-06-01').isoWeeksInYear, 53);
      expect(Carbon.parse('2021-06-01').isoWeeksInYear, 52);
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('String wrapper formats', () {
    test('iso8601/json helpers', () {
      final offset = Carbon.parse('1975-12-25T14:15:16Z').tz('-05:00');
      final extended = Carbon.parse('21975-12-25T14:15:16Z');
      expect(offset.toIso8601String(), '1975-12-25T14:15:16.000Z');
      expect(
        offset.toIso8601String(keepOffset: true),
        '1975-12-25T09:15:16.000-05:00',
      );
      expect(offset.toIso8601ZuluString(), '1975-12-25T14:15:16.000Z');
      expect(offset.toJsonString(), '1975-12-25T14:15:16.000Z');
      expect(offset.toJSON(), '1975-12-25T14:15:16.000Z');
      expect(extended.toIso8601String(), '+021975-12-25T14:15:16.000Z');
    });

    test('Atom and cookie strings honor offsets', () {
      final utc = Carbon.parse('1975-12-25T14:15:16Z');
      final offset = Carbon.parse('1975-12-25T14:15:16Z').tz('-05:00');
      expect(utc.toAtomString(), '1975-12-25T14:15:16+00:00');
      expect(offset.toAtomString(), '1975-12-25T09:15:16-05:00');
      expect(utc.toCookieString(), 'Thursday, 25-Dec-1975 14:15:16 GMT+00:00');
      expect(
        offset.toCookieString(),
        'Thursday, 25-Dec-1975 09:15:16 GMT-05:00',
      );
    });

    test('RFC family wrappers', () {
      final offset = Carbon.parse('1975-12-25T14:15:16Z').tz('-05:00');
      expect(offset.toRfc822String(), 'Thu, 25 Dec 75 09:15:16 -0500');
      expect(offset.toRfc1036String(), 'Thu, 25 Dec 75 09:15:16 -0500');
      expect(offset.toRfc1123String(), 'Thu, 25 Dec 1975 09:15:16 -0500');
      expect(offset.toRfc2822String(), 'Thu, 25 Dec 1975 09:15:16 -0500');
      expect(offset.toRfc850String(), 'Thursday, 25-Dec-75 09:15:16 GMT-0500');
      expect(offset.toRssString(), 'Thu, 25 Dec 1975 09:15:16 -0500');
      expect(offset.toW3cString(), '1975-12-25T09:15:16-05:00');
      expect(offset.toRfc3339String(), '1975-12-25T09:15:16-05:00');
      expect(
        offset.toRfc3339String(extended: true),
        '1975-12-25T09:15:16.000-05:00',
      );
      final utc = Carbon.parse('1975-12-25T14:15:16Z');
      expect(utc.toRfc7231String(), 'Thu, 25 Dec 1975 14:15:16 GMT');
      expect(offset.toRfc7231String(), 'Thu, 25 Dec 1975 14:15:16 GMT');
    });
  });
}

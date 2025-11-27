import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  setUp(() => Carbon.setTestNow(null));

  tearDown(() => Carbon.setTestNow(null));

  group('createFromFormat translator', () {
    test('parses microseconds with explicit timezone parameter', () {
      final date = Carbon.createFromFormat(
        'Y-m-d H:i:s.u',
        '1975-05-21 22:32:11.123456',
        timeZone: 'UTC',
      );
      expect(date.toIso8601String(), '1975-05-21T22:32:11.123456Z');
    });

    test('extracts timezone from format token', () {
      Carbon.setTestNow(Carbon.parse('2020-03-15T06:07:08Z'));
      final date = Carbon.createFromFormat('H:i e', '10:20 Europe/Paris');
      expect(date.timeZoneName, 'Europe/Paris');
      expect(date.toIso8601String(), '2020-03-15T09:20:08.000Z');
    });

    test('handles textual weekdays and ISO8601 preset', () {
      final date = Carbon.createFromFormat(
        'l c',
        'Sunday 2020-02-02T23:45:12+09:00',
      );
      expect(date.toIso8601String(), '2020-02-02T14:45:12.000Z');
      expect(date.timeZoneName, '+09:00');
    });

    test('treats escaped characters as literals', () {
      final date = Carbon.createFromFormat(
        'Y-m-d\\cH:i:s',
        '2020-02-02c23:45:12',
      );
      expect(date.toIso8601String(), '2020-02-02T23:45:12.000Z');
    });

    test('bang reset mirrors PHP behavior', () {
      Carbon.setTestNow(Carbon.parse('2022-08-01 12:34:56'));
      final date = Carbon.createFromFormat('!Y-m-d', '2018-05-06');
      expect(date.toIso8601String(), '2018-05-06T00:00:00.000Z');
    });

    test('pipe reset zeros unspecified time parts', () {
      Carbon.setTestNow(Carbon.parse('2022-08-01 12:34:56'));
      final date = Carbon.createFromFormat('Y-m-d| H:i', '2018-05-06 10:20');
      expect(date.second, 0);
      expect(date.minute, 20);
      expect(date.hour, 10);
    });

    test('parses millisecond token v', () {
      final date = Carbon.createFromFormat(
        'Y-m-d H:i:s.v',
        '2020-02-02 03:04:05.789',
      );
      expect(date.millisecond, 789);
      expect(date.microsecond, 789000);
    });

    test('falls back to mocked timezone when format omits zone', () {
      Carbon.setTestNow(Carbon.parse('2011-01-01 12:13:14').tz('-05:00'));
      final date = Carbon.createFromFormat(
        'Y-m-d H:i:s',
        '2018-05-06 10:20:30',
      );
      expect(date.timeZoneName, '-05:00');
      expect(
        date.toIso8601String(keepOffset: true),
        '2018-05-06T10:20:30.000-05:00',
      );
    });
  });
}

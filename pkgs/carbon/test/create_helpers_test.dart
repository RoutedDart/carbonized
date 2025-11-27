import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
    await initializeDateFormatting('fr');
  });

  group('Carbon create* helpers', () {
    test('createFromDate falls back to now for missing fields', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 8, 0)), () {
        final CarbonInterface carbon = Carbon.createFromDate(1975, null, 21);
        expect(carbon.year, 1975);
        expect(carbon.month, 11);
        expect(carbon.day, 21);
      });
    });

    test('createFromDate accepts timezone label and nullable parts', () {
      withClock(Clock.fixed(DateTime.utc(2024, 2, 10)), () {
        final result = Carbon.createFromDate(null, 2, null, 'Europe/Paris');
        expect(result.dateTime, DateTime.utc(2024, 2, 9, 23));
        expect(result.timeZoneName, 'Europe/Paris');
      });
    });

    test('CarbonImmutable.createFromDate mirrors Carbon', () {
      final immutable = CarbonImmutable.createFromDate(2001, 1, 15);
      expect(immutable.year, 2001);
      expect(immutable.month, 1);
      expect(immutable.day, 15);
      expect(immutable.runtimeType, CarbonImmutable);
    });

    test('createFromTime uses today and resets lower units', () {
      withClock(Clock.fixed(DateTime.utc(2030, 1, 5, 6, 30)), () {
        final result = Carbon.createFromTime(23, 15, 45, 123456);
        expect(result.year, 2030);
        expect(result.month, 1);
        expect(result.day, 5);
        expect(result.hour, 23);
        expect(result.minute, 15);
        expect(result.second, 45);
        expect(result.microsecond, 123456);
      });
    });

    test('createFromTime validates ranges', () {
      expect(() => Carbon.createFromTime(25), throwsRangeError);
      expect(() => Carbon.createFromTime(0, 60), throwsRangeError);
      expect(() => Carbon.createFromTime(0, 0, 60), throwsRangeError);
    });

    test('createFromFormat parses numeric input with PHP tokens', () {
      final result = Carbon.createFromFormat(
        'Y-m-d H:i',
        '2026-03-15 12:45',
        timeZone: 'UTC',
      );
      expect(result.year, 2026);
      expect(result.month, 3);
      expect(result.day, 15);
      expect(result.hour, 12);
      expect(result.minute, 45);
      expect(result.timeZoneName, 'UTC');
    });

    test('createFromFormat parses locale month names within named zones', () {
      final result = Carbon.createFromFormat(
        'j F Y H:i:s',
        '5 mars 2025 21:10:00',
        locale: 'fr',
        timeZone: 'Europe/Paris',
      );
      expect(result.localeCode, 'fr');
      expect(result.timeZoneName, 'Europe/Paris');
      expect(result.dateTime, DateTime.utc(2025, 3, 5, 20, 10));
    });

    test('createFromTimestamp handles fractional seconds', () {
      final result = Carbon.createFromTimestamp(1.5);
      expect(result.second, 1);
      expect(result.microsecond, 500000);
    });

    test('createFromTimestamp honors timezone label', () {
      final result = Carbon.createFromTimestamp(0, timeZone: 'UTC');
      expect(result.timeZoneName, 'UTC');
    });

    test('createFromTimestampMs preserves micro precision', () {
      final result = Carbon.createFromTimestampMs(1234.567);
      expect(result.second, 1);
      expect(result.millisecond, 234);
      expect(result.microsecond, 234567);
    });

    test('createFromTimestampUTC marks timezone', () {
      final result = Carbon.createFromTimestampUTC(0);
      expect(result.year, 1970);
      expect(result.timeZoneName, 'UTC');
    });

    test('createFromTimestampMsUTC marks timezone and precision', () {
      final result = Carbon.createFromTimestampMsUTC(1.25);
      expect(result.timeZoneName, 'UTC');
      expect(result.microsecond, 1250);
    });
  });
}

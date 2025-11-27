import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr');
    await initializeDateFormatting('de');
    await initializeDateFormatting('cs');
    await initializeDateFormatting('ru');
    await initializeDateFormatting('zh_CN');
    await initializeDateFormatting('es');
    await initializeDateFormatting('it');
    await Carbon.configureTimeMachine(testing: true);
  });

  tearDownAll(() {
    Carbon.resetTimeMachineSupport();
    Carbon.setLocale('en');
    Carbon.setTestNow();
  });

  group('Carbon.parseFromLocale', () {
    test('à l\'instant resolves to now', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 12)), () {
        final value = Carbon.parseFromLocale("à l'instant", 'fr');
        expect(value.toIso8601String(), '2025-11-16T12:00:00.000Z');
      });
    });

    test('Aujourd\'hui maps to today', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 12)), () {
        final value = Carbon.parseFromLocale("Aujourd'hui", 'fr');
        expect(value.toIso8601String(), '2025-11-16T00:00:00.000Z');
      });
    });

    test('Aujourd\'hui à HH:mm sets time on today', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 5)), () {
        final value = Carbon.parseFromLocale("Aujourd'hui à 19:34", 'fr');
        expect(value.toIso8601String(), '2025-11-16T19:34:00.000Z');
      });
    });

    test('Heute maps to today', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 9)), () {
        final value = Carbon.parseFromLocale('Heute', 'de');
        expect(value.toIso8601String(), '2025-11-16T00:00:00.000Z');
      });
    });

    test('Heute um HH:mm applies time component', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 6)), () {
        final value = Carbon.parseFromLocale('Heute um 19:34', 'de');
        expect(value.toIso8601String(), '2025-11-16T19:34:00.000Z');
      });
    });

    test('23 Okt 2019 parses calendar dates', () {
      final value = Carbon.parseFromLocale('23 Okt 2019', 'de');
      expect(value.toIso8601String(), '2019-10-23T00:00:00.000Z');
    });

    test('23 Okt 2019 honors timezone argument', () {
      final berlin = Carbon.parseFromLocale(
        '23 Okt 2019',
        'de',
        'Europe/Berlin',
      );
      expect(berlin.timeZoneName, 'Europe/Berlin');
      expect(
        berlin.toIso8601String(keepOffset: true),
        '2019-10-23T00:00:00.000+02:00',
      );
    });

    test('Czech month names translate correctly', () {
      final july = Carbon.parseFromLocale('23 červenec 2019', 'cs');
      expect(july.toIso8601String(), '2019-07-23T00:00:00.000Z');

      final june = Carbon.parseFromLocale('23 červen 2019', 'cs');
      expect(june.toIso8601String(), '2019-06-23T00:00:00.000Z');
    });

    test('Russian relative keywords respect test now', () {
      Carbon.setTestNow('2021-01-26T15:45:13Z');
      final value = Carbon.parseFromLocale('завтра', 'ru');
      expect(value.toIso8601String(), '2021-01-27T00:00:00.000Z');
      Carbon.setTestNow();
    });

    test('Spanish relative keywords map to English equivalents', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 8)), () {
        expect(
          Carbon.parseFromLocale('hoy', 'es').toIso8601String(),
          '2025-11-16T00:00:00.000Z',
        );
        expect(
          Carbon.parseFromLocale('pasado mañana', 'es').toIso8601String(),
          '2025-11-18T00:00:00.000Z',
        );
        expect(Carbon.parseFromLocale('ahora', 'es').hour, 8);
        final timed = Carbon.parseFromLocale('hoy a las 19:34', 'es');
        expect(timed.toIso8601String(), '2025-11-16T19:34:00.000Z');
      });
    });

    test('Italian relative keywords map to English equivalents', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 16, 6)), () {
        expect(
          Carbon.parseFromLocale('oggi', 'it').toIso8601String(),
          '2025-11-16T00:00:00.000Z',
        );
        expect(
          Carbon.parseFromLocale('dopodomani', 'it').toIso8601String(),
          '2025-11-18T00:00:00.000Z',
        );
        expect(
          Carbon.parseFromLocale("l'altro ieri", 'it').toIso8601String(),
          '2025-11-14T00:00:00.000Z',
        );
        final timed = Carbon.parseFromLocale('oggi alle 08:15', 'it');
        expect(timed.toIso8601String(), '2025-11-16T08:15:00.000Z');
      });
    });

    test('defaults to global locale when none provided', () {
      Carbon.setLocale('fr');
      final value = Carbon.parseFromLocale('Dimanche');
      expect(_localizedDayName(value, 'fr'), 'dimanche');
      Carbon.setLocale('en');
    });

    test('weekday names retain locale formatting', () {
      Carbon.setLocale('fr');
      final value = Carbon.parseFromLocale('Lundi');
      expect(_localizedDayName(value, 'fr'), 'lundi');
      Carbon.setLocale('en');
    });
  });

  group('createFromLocaleFormat', () {
    test('parses zh locale strings without timezone', () {
      final value = Carbon.createFromLocaleFormat(
        'Y M d H,i,s',
        'zh_CN',
        '2019 四月 4 12,04,21',
      );
      expect(value.toIso8601String(), '2019-04-04T12:04:21.000Z');
    });

    test('parses zh locale strings with timezone', () {
      final value = Carbon.createFromLocaleFormat(
        'Y M d H,i,s',
        'zh_CN',
        '2019 四月 4 12,04,21',
        timeZone: 'Asia/Shanghai',
      ).locale('zh');
      expect(value.timeZoneName, 'Asia/Shanghai');
      expect(
        value.toIso8601String(keepOffset: true),
        '2019-04-04T12:04:21.000+08:00',
      );
      expect(value.localeCode, 'zh');
    });

    test('parses Spanish connectors without escaping', () {
      final value = Carbon.createFromLocaleFormat(
        'd \\d\\e F \\d\\e Y',
        'es',
        '05 de diciembre de 2022',
        timeZone: 'America/Mexico_City',
      );
      expect(
        value.toIso8601String(keepOffset: true),
        '2022-12-05T00:00:00.000-06:00',
      );
    });

    test('parses escaped Spanish connectors', () {
      final value = Carbon.createFromLocaleFormat(
        'd \\n\\o\\t F \\n\\o\\t Y',
        'es',
        '05 not diciembre not 2022',
        timeZone: 'America/Mexico_City',
      );
      expect(
        value.toIso8601String(keepOffset: true),
        '2022-12-05T00:00:00.000-06:00',
      );
    });
  });
}

String _localizedDayName(CarbonInterface value, String locale) =>
    DateFormat('EEEE', locale).format(value.toDateTime());

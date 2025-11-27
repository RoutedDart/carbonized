import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  setUp(() {
    Carbon.resetTimeMachineSupport();
  });

  group('Creation & parsing', () {
    test('now uses injected clock', () {
      withClock(Clock.fixed(DateTime.utc(2025, 6, 1, 12, 30)), () {
        final carbon = Carbon.now();
        expect(carbon.dateTime, DateTime.utc(2025, 6, 1, 12, 30));
      });
    });

    test('today truncates time to midnight', () {
      withClock(Clock.fixed(DateTime.utc(2025, 6, 1, 15, 45)), () {
        final carbon = Carbon.today();
        expect(carbon.toIso8601String(), '2025-06-01T00:00:00.000Z');
      });
    });

    test('parse supports custom formats and stores locale preference', () {
      final parsed = Carbon.parse(
        '2025-11-14 08:30',
        format: 'yyyy-MM-dd HH:mm',
        locale: 'en_US',
      );
      expect(parsed.localeCode, equals('en_US'));
      expect(parsed.toIso8601String(), '2025-11-14T08:30:00.000Z');
    });

    test('parse handles unix timestamps expressed in seconds', () {
      const unixSeconds = 1731547200; // 2024-11-14T01:20:00Z
      final parsed = Carbon.parse(unixSeconds);
      expect(parsed.toEpochMilliseconds(), unixSeconds * 1000);
      final expectedIso = DateTime.fromMillisecondsSinceEpoch(
        unixSeconds * 1000,
        isUtc: true,
      ).toIso8601String();
      expect(parsed.toIso8601String(), expectedIso);
    });
  });

  group('Arithmetic & comparison', () {
    test('addMonths overflows by default', () {
      final jan31 = Carbon.create(year: 2025, month: 1, day: 31);
      final shifted = jan31.addMonths(1);
      expect(shifted.format('yyyy-MM-dd HH:mm'), '2025-03-03 00:00');
    });

    test('addMonths can clamp to last day when overflow disabled', () {
      final carbon = Carbon.fromDateTime(
        DateTime.utc(2025, 1, 31),
        settings: const CarbonSettings(monthOverflow: false),
      );
      final shifted = carbon.addMonths(1);
      expect(shifted.format('yyyy-MM-dd HH:mm'), '2025-02-28 00:00');
    });

    test('startOfWeek respects configured first weekday', () {
      final midWeek = Carbon.fromDateTime(
        DateTime.utc(2025, 1, 8, 15, 30),
        settings: const CarbonSettings(startOfWeek: DateTime.sunday),
      );
      final start = midWeek.startOfWeek();
      expect(start.format('yyyy-MM-dd'), '2025-01-05');
    });

    test('diff helpers and comparison APIs agree', () {
      final start = Carbon.parse('2025-01-01T00:00:00Z').toImmutable();
      final end = start.addDays(10);
      expect(end.diffInDays(start), 10);
      expect(end.isAfter(start), isTrue);
      expect(start.isBefore(end), isTrue);
      expect(start.isBetween(start, end), isTrue);
      expect(end.isBetween(start, end), isTrue);
      expect(start.compareTo(end), lessThan(0));
    });

    test('diffForHumans matches expected phrasing', () {
      withClock(Clock.fixed(DateTime.utc(2025, 11, 14, 12)), () {
        final past = Carbon.now().subtract(const Duration(hours: 5));
        expect(past.diffForHumans(), '5 hours ago');
      });
    });
  });

  group('Time zones', () {
    test('throws when timezone backend not configured', () {
      final date = Carbon.parse('2025-03-09T06:30:00Z');
      expect(
        () => date.tz('America/New_York'),
        throwsA(isA<CarbonInvalidTimeZoneException>()),
      );
    });

    test('time machine backend converts zones with DST awareness', () async {
      await Carbon.configureTimeMachine(testing: true);

      final utc = Carbon.parse('2025-03-09T06:30:00Z');
      final eastern = utc.tz('America/New_York');
      expect(
        eastern.format('yyyy-MM-dd HH:mm zzzz'),
        '2025-03-09 01:30 GMT-05:00',
      );

      final afterJump = eastern.add(const Duration(hours: 2));
      expect(
        afterJump.format('yyyy-MM-dd HH:mm zzzz'),
        '2025-03-09 04:30 GMT-04:00',
      );

      // ensure formatting can include abbreviations via 'zzz'.
      final abbr = afterJump.format('yyyy-MM-dd HH:mm zzz');
      expect(abbr.contains('04:30'), isTrue);

      Carbon.resetTimeMachineSupport();
    });
  });

  group('Serialization & mutability', () {
    test('toJson and fromJson round-trip ISO values', () {
      final carbon = Carbon.parse('2025-05-01T00:00:00Z');
      final json = carbon.toJson();
      expect(json['iso'], '2025-05-01T00:00:00.000Z');
      final roundTrip = Carbon.fromJson(jsonEncode(json));
      expect(roundTrip.toIso8601String(), carbon.toIso8601String());
    });

    test('mutable Carbon mutates in place while immutable clones', () {
      final mutable = Carbon.parse('2025-05-01T00:00:00Z');
      mutable.addDays(2);
      expect(mutable.dateTime, DateTime.utc(2025, 5, 3));

      final immutable = mutable.toImmutable();
      final advanced = immutable.addDays(1);
      expect(immutable.dateTime, DateTime.utc(2025, 5, 3));
      expect(advanced.dateTime, DateTime.utc(2025, 5, 4));
      expect(advanced, isA<CarbonImmutable>());
    });
  });

  group('Macros & extensibility', () {
    test('macros can be registered and removed', () {
      Carbon.registerMacro('daysUntilWeekend', (carbon, positional, named) {
        const saturday = DateTime.saturday;
        final weekday = carbon.dateTime.weekday;
        final remaining = saturday - weekday;
        return remaining < 0 ? 0 : remaining;
      });

      final CarbonInterface midWeek = Carbon.fromDateTime(
        DateTime.utc(2025, 6, 4),
      );
      final dynamic dynamicCarbon = midWeek;
      expect(dynamicCarbon.daysUntilWeekend(), 3);

      Carbon.unregisterMacro('daysUntilWeekend');
      expect(
        () => dynamicCarbon.daysUntilWeekend(),
        throwsA(isA<CarbonUnknownMethodException>()),
      );
    });
  });
}

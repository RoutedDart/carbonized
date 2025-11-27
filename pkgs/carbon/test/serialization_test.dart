import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Serialization helpers', () {
    test('toJson exposes iso, epoch, locale, and timezone', () {
      final value = Carbon.parse(
        '2020-02-02T03:04:05Z',
      ).locale('fr').tz('-05:00');
      final json = value.toJson();
      expect(json['iso'], '2020-02-02T03:04:05.000Z');
      expect(json['epochMs'], isA<int>());
      expect(json['locale'], 'fr');
      expect(json['timeZone'], '-05:00');
    });

    test('fromJson parses simple ISO strings', () {
      final payload = jsonEncode('2024-01-01T00:00:00Z');
      final value = Carbon.fromJson(payload);
      expect(value.toIso8601String(), '2024-01-01T00:00:00.000Z');
    });

    test('fromJson parses ISO map payloads', () {
      final payload = jsonEncode({'iso': '1999-12-31T23:59:59Z'});
      final value = Carbon.fromJson(payload);
      expect(value.toIso8601String(), '1999-12-31T23:59:59.000Z');
    });

    test('fromJson parses epoch millis maps', () {
      final payload = jsonEncode({'epochMs': 0});
      final value = Carbon.fromJson(payload);
      expect(value.toIso8601String(), '1970-01-01T00:00:00.000Z');
    });

    test('fromJson rejects unsupported payloads', () {
      expect(
        () => Carbon.fromJson(jsonEncode({'foo': 'bar'})),
        throwsArgumentError,
      );
    });

    test('serialize + fromSerialized round trips locale/timezone/settings', () {
      final source = Carbon.parse('2016-02-01T13:20:25Z')
        ..tz('-05:00')
        ..locale('fr')
        ..copyWith(
          settings: const CarbonSettings(
            monthOverflow: false,
            startOfWeek: DateTime.sunday,
          ),
        );
      final restored = Carbon.fromSerialized(source.serialize());
      expect(
        restored.toIso8601String(keepOffset: true),
        source.toIso8601String(keepOffset: true),
      );
      expect(restored.localeCode, 'fr');
      expect(restored.timeZoneName, '-05:00');
      expect(restored.settings.monthOverflow, isFalse);
      expect(restored.settings.startOfWeek, DateTime.sunday);
    });

    test('serialize preserves immutable subtype metadata', () {
      final frozen = CarbonImmutable.parse(
        '2020-12-01 08:30:45.654321',
      ).locale('ru');
      final restored = CarbonImmutable.fromSerialized(frozen.serialize());
      expect(restored, isA<CarbonImmutable>());
      expect(restored.toIso8601String(), frozen.toIso8601String());
      expect(restored.localeCode, 'ru');
    });

    test('fromSerialized rejects unsupported payload structures', () {
      expect(
        () => Carbon.fromSerialized('"2024-01-01T00:00:00Z"'),
        throwsArgumentError,
      );
      expect(() => Carbon.fromSerialized({'iso': 42}), throwsArgumentError);
    });
  });
}

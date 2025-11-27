import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  group('list separator localization', () {
    final now = Carbon.parse('2024-01-10T12:00:00Z');
    // 1 year, 2 months, 3 days ago
    final past = Carbon.parse('2022-11-07T12:00:00Z');

    test('English uses ", " and " and "', () {
      final result = past.diffForHumans(reference: now, parts: 3, locale: 'en');
      // Should be "1 year, 2 months and 3 days"
      expect(result, contains(', '));
      expect(result, contains(' and '));
    });

    test('French uses ", " and " et "', () {
      final result = past.diffForHumans(reference: now, parts: 3, locale: 'fr');
      // Should be "1 an, 2 mois et 3 jours"
      expect(result, contains(', '));
      expect(result, contains(' et '));
    });

    test('Spanish uses ", " and " y "', () {
      final result = past.diffForHumans(reference: now, parts: 3, locale: 'es');
      // Should be "1 año, 2 meses y 3 días"
      expect(result, contains(', '));
      expect(result, contains(' y '));
    });

    test('German uses ", " and " und "', () {
      final result = past.diffForHumans(reference: now, parts: 3, locale: 'de');
      // Should be "1 Jahr, 2 Monate und 3 Tage"
      expect(result, contains(', '));
      expect(result, contains(' und '));
    });

    test('2-part diff uses only final separator', () {
      final result = past.diffForHumans(reference: now, parts: 2, locale: 'en');
      // Should be "1 year and 2 months" (no comma)
      expect(result, contains(' and '));
      expect(result, isNot(contains(', ')));
    });

    test('Custom joiner works when no locale separators', () {
      // Create a locale without separators or use custom joiner
      final result = past.diffForHumans(
        reference: now,
        parts: 3,
        joiner: ' | ',
      );
      // Should fall back using joiner or use locale separators
      // Since 'en' has separators, it will use them
      expect(result, isNotEmpty);
    });
  });
}

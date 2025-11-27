import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Regional Russian Locales', () {
    setUp(() async {
      await Carbon.configureTimeMachine();
    });

    final regionalVariants = [
      'ru',
      'ru_BY',
      'ru_KG',
      'ru_KZ',
      'ru_MD',
      'ru_RU',
      'ru_UA',
    ];

    test('all regional variants use base Russian translations', () {
      final date = Carbon.parse('2019-05-15T12:00:00Z');

      for (final locale in regionalVariants) {
        final localized = date.locale(locale);

        // All should produce identical Russian output
        expect(
          localized.translatedFormat('jS'),
          '15-го',
          reason: '$locale should use Russian ordinal',
        );

        expect(
          localized.translatedFormat('t F'),
          '31 мая',
          reason: '$locale should use Russian genitive month',
        );
      }
    });

    test('all regional variants use Russian diffForHumans', () {
      final now = Carbon.now();
      final yearAgo = now.copy().subYears(1);

      for (final locale in regionalVariants) {
        final localized = yearAgo.locale(locale);
        final humanDiff = localized.diffForHumans();

        // Should contain Russian text
        expect(
          humanDiff,
          contains('назад'),
          reason: '$locale should use Russian "назад" (ago)',
        );
      }
    });

    test('all regional variants are accessible via setLocale', () {
      for (final locale in regionalVariants) {
        expect(
          () => Carbon.setLocale(locale),
          returnsNormally,
          reason: '$locale should be a valid locale',
        );

        final date = Carbon.parse('2019-05-15T12:00:00Z');
        expect(
          date.translatedFormat('F'),
          'мая',
          reason: '$locale should format using Russian',
        );
      }
    });

    test('regional variants fallback to ru correctly', () {
      // Even variants not explicitly in allLocales should fall back to 'ru'
      final variants = ['ru_Test', 'ru_XX', 'ru_Custom'];

      for (final locale in variants) {
        final date = Carbon.parse('2019-05-15T12:00:00Z').locale(locale);

        expect(
          date.translatedFormat('jS'),
          '15-го',
          reason: '$locale should fall back to ru',
        );
      }
    });
  });
}

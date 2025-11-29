import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

/// Tests that Carbon can work without users manually calling initializeDateFormatting
void main() {
  group('Intl Auto-Initialization', () {
    test('format works without explicit initializeDateFormatting', () {
      // No initializeDateFormatting call here - Carbon should handle it
      final date = Carbon.parse('2025-01-15T10:30:00Z');

      // This should work without throwing an error
      final formatted = date.format('yyyy-MM-dd HH:mm:ss');
      expect(formatted, equals('2025-01-15 10:30:00'));
    });

    test('format with locale works without explicit initialization', () {
      final date = Carbon.parse('2025-01-15T10:30:00Z');

      // Should work with different locales without manual initialization
      final enFormatted = date.format('MMMM d, yyyy', locale: 'en');
      expect(enFormatted, isNotEmpty);

      final frFormatted = date.format('d MMMM yyyy', locale: 'fr');
      expect(frFormatted, isNotEmpty);
    });

    test('localized month names work without initialization', () {
      final date = Carbon.create(year: 2025, month: 3, day: 15);

      // Should return month names without throwing
      final monthName = date.format('MMMM');
      expect(monthName, isNotEmpty);
    });

    test('parse with format works without initialization', () {
      // Should be able to parse formatted dates without manual init
      final date = Carbon.parse(
        '2025-03-15 14:30:00',
        format: 'yyyy-MM-dd HH:mm:ss',
      );

      expect(date.year, equals(2025));
      expect(date.month, equals(3));
      expect(date.day, equals(15));
    });

    test('ensureLocaleInitialized can be called manually', () async {
      // Users can still manually initialize if they want
      await Carbon.ensureLocaleInitialized('es');

      final date = Carbon.create(year: 2025, month: 1, day: 1);
      final formatted = date.format('MMMM', locale: 'es');
      expect(formatted, isNotEmpty);
    });
  });
}

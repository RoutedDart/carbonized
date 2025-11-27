import 'package:carbon/carbon.dart';
import 'package:test/test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
    await initializeDateFormatting();
  });

  group('meridiem localization', () {
    final testTimes = [
      '2024-01-10T00:00:00Z', // Midnight
      '2024-01-10T06:30:00Z', // Morning
      '2024-01-10T12:00:00Z', // Noon
      '2024-01-10T14:30:00Z', // Afternoon
      '2024-01-10T18:45:00Z', // Evening
      '2024-01-10T23:59:00Z', // Late night
    ];

    test('English uses AM/PM', () {
      for (final timeStr in testTimes) {
        final carbon = Carbon.parse(timeStr, locale: 'en');
        final formatted = carbon.toDayDateTimeString();

        final hour = carbon.hour;
        if (hour < 12) {
          expect(formatted, contains('AM'));
        } else {
          expect(formatted, contains('PM'));
        }
      }
    });

    test('Chinese uses time-of-day based meridiem', () {
      final carbon = Carbon.parse('2024-01-10T06:30:00Z', locale: 'zh');
      final formatted = carbon.toDayDateTimeString();
      // Should contain '早上' (morning) for 6:30 AM
      expect(formatted, contains('早上'));
    });

    test('Arabic uses localized meridiem', () {
      final carbon = Carbon.parse('2024-01-10T14:30:00Z', locale: 'ar');
      final formatted = carbon.toDayDateTimeString();
      // Should contain 'م' (Arabic PM)
      expect(formatted, contains('م'));
    });

    test('Japanese uses localized meridiem', () {
      final carbonAM = Carbon.parse('2024-01-10T06:30:00Z', locale: 'ja');
      expect(carbonAM.toDayDateTimeString(), contains('午前'));

      final carbonPM = Carbon.parse('2024-01-10T14:30:00Z', locale: 'ja');
      expect(carbonPM.toDayDateTimeString(), contains('午後'));
    });

    test('Spanish uses a. m. / p. m.', () {
      final carbonAM = Carbon.parse('2024-01-10T06:30:00Z', locale: 'es');
      expect(carbonAM.toDayDateTimeString(), contains('a. m.'));

      final carbonPM = Carbon.parse('2024-01-10T14:30:00Z', locale: 'es');
      expect(carbonPM.toDayDateTimeString(), contains('p. m.'));
    });
  });
}

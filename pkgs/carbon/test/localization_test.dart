import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('fr');
    await initializeDateFormatting('es');
  });

  test('setLocale updates default locale for new instances', () {
    Carbon.setLocale('fr');
    final now = Carbon.now();
    expect(now.localeCode, 'fr');
    Carbon.setLocale('en');
  });

  test('locale() chains per-instance localization', () {
    final date = Carbon.parse('2020-06-01T12:00:00Z');
    final french = date.locale('fr_FR');
    expect(french.localeCode, 'fr_FR');
    expect(french.toFormattedDateString(), contains('juin'));
    final english = french.locale('en');
    expect(english.localeCode, 'en');
  });

  group('Locale-aware properties', () {
    test('localized day names work with different locales', () {
      // Monday in English
      final monday = Carbon.create(
        year: 2024,
        month: 1,
        day: 1,
      ); // January 1, 2024 is a Monday
      expect(monday.localeDayOfWeek, 'Monday');
      expect(monday.shortLocaleDayOfWeek, 'Mon');
      expect(monday.minDayName, 'Mo');

      // Same date in French
      final mondayFr = monday.locale('fr');
      expect(mondayFr.localeDayOfWeek, 'lundi');
      expect(mondayFr.shortLocaleDayOfWeek, 'lun.');
      expect(mondayFr.minDayName, 'lu');
    });

    test('localized month names work with different locales', () {
      final june = Carbon.create(year: 2024, month: 6, day: 15);
      expect(june.localeMonth, 'June');
      expect(june.shortLocaleMonth, 'Jun');

      final juneEs = june.locale('es');
      expect(juneEs.localeMonth, 'junio');
      expect(juneEs.shortLocaleMonth, 'jun.');
    });

    test('English properties return English names regardless of locale', () {
      final monday = Carbon.create(year: 2024, month: 6, day: 17); // Monday
      final mondayFr = monday.locale('fr');

      // Even with French locale, English properties return English
      expect(mondayFr.englishDayOfWeek, 'Monday');
      expect(mondayFr.shortEnglishDayOfWeek, 'Mon');
      expect(mondayFr.englishMonth, 'June');
      expect(mondayFr.shortEnglishMonth, 'Jun');
    });

    test('generic day/month name properties use current locale', () {
      final monday = Carbon.create(year: 2024, month: 6, day: 17); // Monday
      expect(monday.dayName, monday.localeDayOfWeek);
      expect(monday.shortDayName, monday.shortLocaleDayOfWeek);
      expect(monday.monthName, monday.localeMonth);
      expect(monday.shortMonthName, monday.shortLocaleMonth);

      final mondayFr = monday.locale('fr');
      expect(mondayFr.dayName, mondayFr.localeDayOfWeek);
      expect(mondayFr.monthName, mondayFr.localeMonth);
    });
  });
}

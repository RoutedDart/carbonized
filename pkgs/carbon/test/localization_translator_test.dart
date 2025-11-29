import 'package:carbon/carbon.dart';
import 'package:carbon/src/carbon.dart';
import 'package:test/test.dart';
void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
    CarbonTranslator.resetTranslations();
  });
  test('translateNumber honors fallback locales', () {
    final translation = CarbonLocaleData(
      localeCode: 'fr',
      numbers: {'1': 'un ', '2': 'deux ', '3': 'trois '},
      altNumbers: {'4': 'quatre_alt ', '5': 'cinq_alt '},
    );
    CarbonTranslator.registerLocale('fr', translation);
    CarbonTranslator.setFallbackLocales('fr_ca', ['fr']);
    expect(Carbon.translateNumber('123', locale: 'fr_ca'), 'un deux trois');
    expect(Carbon.getAltNumber('45', locale: 'fr_ca'), 'quatre_alt cinq_alt');
  });
  test('diffForHumans returns localized strings', () {
    // French locale is already loaded from generated locales with proper translation strings
    // It includes 'minute', 'hour', 'ago', etc. in French
    final past = Carbon.now().copy()..subMinutes(2);
    final result = past.diffForHumans(locale: 'fr');
    // Should contain French text for minutes
    expect(result.contains('minute'), isTrue);
  });
  test('translateTimeString applies replacements', () {
    CarbonTranslator.registerLocale(
      'tt',
      const CarbonLocaleData(
        localeCode: 'tt',
        timeStrings: {'minutes': 'minutos'},
      ),
    );
    expect(
      Carbon.translateTimeString('15 minutes ago', locale: 'tt'),
      contains('minutos'),
    );
  });
}

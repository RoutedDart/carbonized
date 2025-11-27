import 'package:carbon/carbon.dart';
import 'package:carbon/src/carbon.dart';
import 'package:timeago/timeago.dart' as timeago;
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
      timeagoMessages: timeago.FrMessages(),
    );
    CarbonTranslator.registerLocale('fr', translation);
    CarbonTranslator.setFallbackLocales('fr_ca', ['fr']);

    expect(Carbon.translateNumber('123', locale: 'fr_ca'), 'un deux trois');
    expect(Carbon.getAltNumber('45', locale: 'fr_ca'), 'quatre_alt cinq_alt');
  });

  test('diffForHumans returns localized strings', () {
    CarbonTranslator.registerLocale(
      'fr',
      CarbonLocaleData(
        localeCode: 'fr',
        timeStrings: {'ago': 'il y a', 'from now': "d'ici", 'in ': 'dans '},
        timeagoMessages: timeago.FrMessages(),
      ),
    );

    final past = Carbon.now().copy()..subMinutes(2);
    final result = past.diffForHumans(locale: 'fr');
    expect(result, startsWith('il y a'));
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

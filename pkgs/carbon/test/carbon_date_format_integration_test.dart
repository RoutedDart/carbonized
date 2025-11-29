import 'package:carbon/carbon.dart';
import 'package:carbon/src/carbon.dart' as internal;
import 'package:carbon/src/third_party/intl_date_format.dart';
import 'package:test/test.dart';

const _testMonths = [
  'Solaria',
  'Lunaria',
  'Terranis',
  'Aerion',
  'Aquatia',
  'Ignisia',
  'Zephyra',
  'Gaiana',
  'Luminis',
  'Umbrus',
  'Stellaris',
  'Nocturn',
];

const _testMonthsShort = [
  'Sol',
  'Lun',
  'Ter',
  'Aer',
  'Aqu',
  'Ign',
  'Zep',
  'Gai',
  'Lum',
  'Umb',
  'Ste',
  'Noc',
];

const _testWeekdays = [
  'Sunth',
  'Moons',
  'Terns',
  'Wevra',
  'Threx',
  'Frial',
  'Satyr',
];

const _testWeekdaysShort = ['Su', 'Mo', 'Te', 'We', 'Th', 'Fr', 'Sa'];

const _testWeekdaysMin = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

const _testFormats = {
  'L': 'MM/DD/YYYY',
  'LL': 'MMMM D, YYYY',
  'LLL': 'MMMM D, YYYY h:mm A',
  'LLLL': 'dddd, MMMM D, YYYY h:mm A',
  'LT': 'h:mm A',
  'LTS': 'h:mm:ss A',
};

void main() {
  setUpAll(internal.ensureCarbonDateFormatConfigured);
  setUp(CarbonTranslator.resetTranslations);
  tearDown(CarbonTranslator.resetTranslations);

  test('CarbonDateFormat uses CarbonTranslator locale data for formatting', () {
    const locale = 'zz_fmt_locale';
    _registerLocale(locale);

    final formatted = CarbonDateFormat.yMMMMd(
      locale,
    ).format(DateTime.utc(2024, 2, 10));

    expect(formatted, contains('Lunaria'));
  });

  test(
    'CarbonDateFormat localizes digits when locale provides a native zero',
    () {
      const locale = 'zz_digit_locale';
      _registerLocale(locale, numbers: {'0': '٠'});
      CarbonDateFormat.useNativeDigitsByDefaultFor(locale, true);

      final formatted = CarbonDateFormat.yMd(
        locale,
      ).format(DateTime.utc(2024, 10, 3));

      expect(formatted.contains('٠'), isTrue);
      expect(formatted.contains('٢'), isTrue);
    },
  );
}

void _registerLocale(String code, {Map<String, String> numbers = const {}}) {
  CarbonTranslator.registerLocale(
    code,
    CarbonLocaleData(
      localeCode: code,
      months: _testMonths,
      monthsShort: _testMonthsShort,
      monthsStandalone: _testMonths,
      weekdays: _testWeekdays,
      weekdaysShort: _testWeekdaysShort,
      weekdaysMin: _testWeekdaysMin,
      weekdaysStandalone: _testWeekdays,
      formats: _testFormats,
      numbers: numbers,
      meridiem: (hour, minute, isLower) => isLower ? 'am' : 'pm',
    ),
  );
}

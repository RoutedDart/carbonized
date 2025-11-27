import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.hasFormat (PHP IsTest parity)', () {
    test('matches canonical true cases', () {
      expect(Carbon.hasFormat('1975-05-01', 'Y-m-d'), isTrue);
      expect(Carbon.hasFormat('12/30/2019', 'm/d/Y'), isTrue);
      expect(Carbon.hasFormat('30/12/2019', 'd/m/Y'), isTrue);
      expect(Carbon.hasFormat('Sun 21st', 'D jS'), isTrue);
      expect(
        Carbon.hasFormat('2000-07-01T00:00:00+00:00', r'Y-m-d\TH:i:sP'),
        isTrue,
      );
      expect(Carbon.hasFormat('Y-01-30\\', '\\Y-m-d\\\\'), isTrue);
      expect(
        Carbon.hasFormat('2020-09-01 12:00:00Europe/Moscow', 'Y-m-d H:i:se'),
        isTrue,
      );
      expect(
        Carbon.hasFormat('2012-12-04 22:59.32130', 'Y-m-d H:s.vi'),
        isTrue,
      );
      expect(
        Carbon.hasFormat('2024-03-02T00:00:00+13:00', r'Y-m-d\TH:i:sP'),
        isTrue,
      );
      expect(Carbon.hasFormat('2020.09.09', 'Y.m.d'), isTrue);
    });

    test('rejects malformed inputs', () {
      expect(Carbon.hasFormat('', 'd m Y'), isFalse);
      expect(Carbon.hasFormat('1975-05-01', 'd m Y'), isFalse);
      expect(Carbon.hasFormat('Foo 21st', 'D jS'), isFalse);
      expect(Carbon.hasFormat('Sun 51st', 'D jS'), isFalse);
      expect(Carbon.hasFormat('Sun 21xx', 'D jS'), isFalse);
      expect(Carbon.hasFormat('1975-5-1', 'Y-m-d'), isFalse);
      expect(Carbon.hasFormat('19-05-01', 'Y-m-d'), isFalse);
      expect(Carbon.hasFormat('30/12/2019', 'm/d/Y'), isFalse);
      expect(Carbon.hasFormat('12/30/2019', 'd/m/Y'), isFalse);
      expect(Carbon.hasFormat('1975-05-01', 'Y-m-d!'), isFalse);
      expect(Carbon.hasFormat('1975-05-01', 'Y-m-d|'), isFalse);
      expect(Carbon.hasFormat('1975-05-01', 'Y-*-d'), isFalse);
      expect(Carbon.hasFormat('2020009009', 'Y.m.d'), isFalse);
      expect(Carbon.hasFormat('2020-09-09', 'Y.m.d'), isFalse);
      expect(Carbon.hasFormat('2020*09*09', 'Y.m.d'), isFalse);
      expect(Carbon.hasFormat('2020k09d09', 'Y.m.d'), isFalse);
    });
  });

  group('Carbon.hasFormatWithModifiers', () {
    test('accepts modifier-based samples', () {
      expect(
        Carbon.hasFormatWithModifiers(
          '2021-05-03T00:00:00+02:00',
          r'Y-m-d\TH:i:sp',
        ),
        isTrue,
      );
      expect(
        Carbon.hasFormatWithModifiers(
          '2021-05-03T00:00:00+02:00',
          r'Y-m-d\TH:i:sP',
        ),
        isTrue,
      );
      expect(
        Carbon.hasFormatWithModifiers('2021-05-03T00:00:00Z', r'Y-m-d\TH:i:sp'),
        isTrue,
      );
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y-m-d!'), isTrue);
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y-m-d|'), isTrue);
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y-*-d'), isTrue);
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y-??-d!'), isTrue);
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y#m#d'), isTrue);
      expect(Carbon.hasFormatWithModifiers('1975/05/31', 'Y#m#d'), isTrue);
      expect(Carbon.hasFormatWithModifiers('5', 'N'), isTrue);
    });

    test(' rejects invalid modifier combinations', () {
      expect(
        Carbon.hasFormatWithModifiers('2021-05-03T00:00:00Z', r'Y-m-d\TH:i:sP'),
        isFalse,
      );
      expect(Carbon.hasFormatWithModifiers('1975/31/05', 'Y#m#d'), isFalse);
      expect(Carbon.hasFormatWithModifiers('1975-05-01', 'Y-?-d|'), isFalse);
      expect(Carbon.hasFormatWithModifiers('1975--01', 'Y-*-d'), isFalse);
      expect(Carbon.hasFormatWithModifiers('1975705-01', 'Y#m#d'), isFalse);
    });
  });

  group('Carbon.canBeCreatedFromFormat', () {
    test('returns true when DateTime can be parsed', () {
      expect(Carbon.canBeCreatedFromFormat('1975-05-21 22', 'Y-m-d H'), isTrue);
      expect(
        Carbon.canBeCreatedFromFormat(
          '2019-02-01 03:45:27.612584',
          'Y-m-d H:i:s.u',
        ),
        isTrue,
      );
    });

    test('returns false when input cannot build a date', () {
      expect(Carbon.canBeCreatedFromFormat('5', 'N'), isFalse);
      expect(Carbon.canBeCreatedFromFormat('2021-13-01', 'Y-m-d'), isFalse);
      expect(Carbon.canBeCreatedFromFormat(null, 'Y-m-d'), isFalse);
      expect(
        Carbon.canBeCreatedFromFormat('2021-05-03T00:00:00Z', 'Y-m-d|'),
        isFalse,
      );
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon.add - quarters', () {
    test('addQuarters with positive value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarters(1);
      expect(date.month, 8);
    });

    test('addQuarters with zero', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarters(0);
      expect(date.month, 5);
    });

    test('addQuarters with negative value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarters(-1);
      expect(date.month, 2);
    });

    test('addQuarter adds one quarter', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarter();
      expect(date.month, 8);
    });

    test('addQuarter with explicit count', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarter(2);
      expect(date.month, 11);
    });

    test('addQuarter with negative count', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).addQuarter(-1);
      expect(date.month, 2);
    });
  });

  group('Carbon.sub - quarters', () {
    test('subQuarters with positive value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).subQuarters(1);
      expect(date.month, 2);
    });

    test('subQuarters with zero', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).subQuarters(0);
      expect(date.month, 5);
    });

    test('subQuarters with negative value', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).subQuarters(-1);
      expect(date.month, 8);
    });

    test('subQuarter subtracts one quarter', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).subQuarter();
      expect(date.month, 2);
    });

    test('subQuarters across year boundary', () {
      final date = Carbon.create(year: 1975, month: 5, day: 6).subQuarters(2);
      expect(date.year, 1974);
      expect(date.month, 11);
    });
  });

  group('Carbon.add - decades', () {
    test('addDecades with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addDecades(1);
      expect(date.year, 1985);
    });

    test('addDecades with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addDecades(0);
      expect(date.year, 1975);
    });

    test('addDecades with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addDecades(-1);
      expect(date.year, 1965);
    });

    test('addDecade adds one decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addDecade();
      expect(date.year, 1985);
    });

    test('addDecade with explicit count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addDecade(2);
      expect(date.year, 1995);
    });

    group('decade overflow handling', () {
      test('addDecadeNoOverflow preserves day on leap year boundary', () {
        final date = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        ).addDecadeNoOverflow();
        expect(date.year, 2026);
        expect(date.month, 2);
        expect(date.day, 28);
      });

      test('addDecadeWithOverflow overflows day on leap year boundary', () {
        final date = Carbon.create(
          year: 2016,
          month: 2,
          day: 29,
        ).addDecadeWithOverflow();
        expect(date.year, 2026);
        expect(date.month, 3);
        expect(date.day, 1);
      });

      test('addDecadesNoOverflow with multiple decades', () {
        final date = Carbon.create(
          year: 2000,
          month: 2,
          day: 29,
        ).addDecadesNoOverflow(3);
        expect(date.year, 2030);
        expect(date.month, 2);
        expect(date.day, 28);
      });

      test('addDecadesWithOverflow with multiple decades', () {
        final date = Carbon.create(
          year: 2000,
          month: 2,
          day: 29,
        ).addDecadesWithOverflow(3);
        expect(date.year, 2030);
        expect(date.month, 3);
        expect(date.day, 1);
      });
    });
  });

  group('Carbon.sub - decades', () {
    test('subDecades with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subDecades(1);
      expect(date.year, 1965);
    });

    test('subDecade subtracts one decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subDecade();
      expect(date.year, 1965);
    });
  });

  group('Carbon.add - centuries', () {
    test('addCenturies with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCenturies(1);
      expect(date.year, 2075);
    });

    test('addCenturies with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCenturies(0);
      expect(date.year, 1975);
    });

    test('addCenturies with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCenturies(-1);
      expect(date.year, 1875);
    });

    test('addCentury adds one century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCentury();
      expect(date.year, 2075);
    });

    test('addCentury with explicit count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCentury(2);
      expect(date.year, 2175);
    });

    test('addCentury with negative count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addCentury(-1);
      expect(date.year, 1875);
    });

    group('century overflow handling', () {
      test(
        'addCenturyNoOverflow preserves day when target century drops leap day',
        () {
          final date = Carbon.create(
            year: 2000,
            month: 2,
            day: 29,
          ).addCenturyNoOverflow();
          expect(date.year, 2100);
          expect(date.month, 2);
          expect(date.day, 28);
        },
      );

      test(
        'addCenturyWithOverflow spills into next month when target century drops leap day',
        () {
          final date = Carbon.create(
            year: 2000,
            month: 2,
            day: 29,
          ).addCenturyWithOverflow();
          expect(date.year, 2100);
          expect(date.month, 3);
          expect(date.day, 1);
        },
      );
    });
  });

  group('Carbon.sub - centuries', () {
    test('subCenturies with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subCenturies(1);
      expect(date.year, 1875);
    });

    test('subCenturies with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subCenturies(-1);
      expect(date.year, 2075);
    });

    test('subCentury subtracts one century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subCentury();
      expect(date.year, 1875);
    });

    test('subCentury with explicit count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subCentury(2);
      expect(date.year, 1775);
    });

    test('subCentury with negative count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subCentury(-1);
      expect(date.year, 2075);
    });
  });

  group('Carbon.add - millennia', () {
    test('addMillennia with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addMillennia(1);
      expect(date.year, 2975);
    });

    test('addMillennia with zero', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addMillennia(0);
      expect(date.year, 1975);
    });

    test('addMillennia with negative value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addMillennia(-1);
      expect(date.year, 975);
    });

    test('addMillennium adds one millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addMillennium();
      expect(date.year, 2975);
    });

    test('addMillennium with explicit count', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).addMillennium(2);
      expect(date.year, 3975);
    });

    group('millennium overflow handling', () {
      test(
        'addMillenniumNoOverflow preserves day when target millennium drops leap day',
        () {
          final date = Carbon.create(
            year: 2000,
            month: 2,
            day: 29,
          ).addMillenniumNoOverflow();
          expect(date.year, 3000);
          expect(date.month, 2);
          expect(date.day, 28);
        },
      );

      test(
        'addMillenniumWithOverflow overflows day when target millennium drops leap day',
        () {
          final date = Carbon.create(
            year: 2000,
            month: 2,
            day: 29,
          ).addMillenniumWithOverflow();
          expect(date.year, 3000);
          expect(date.month, 3);
          expect(date.day, 1);
        },
      );
    });
  });

  group('Carbon.sub - millennia', () {
    test('subMillennia with positive value', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subMillennia(1);
      expect(date.year, 975);
    });

    test('subMillennium subtracts one millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1).subMillennium();
      expect(date.year, 975);
    });
  });
}

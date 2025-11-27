import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon accessors - year/month/day', () {
    final date = Carbon.create(
      year: 2020,
      month: 3,
      day: 15,
      hour: 14,
      minute: 35,
      second: 42,
      millisecond: 500,
      microsecond: 0,
    );

    test('year getter returns year', () {
      expect(date.year, 2020);
    });

    test('month getter returns month', () {
      expect(date.month, 3);
    });

    test('day getter returns day', () {
      expect(date.day, 15);
    });

    test('hour getter returns hour', () {
      expect(date.hour, 14);
    });

    test('minute getter returns minute', () {
      expect(date.minute, 35);
    });

    test('second getter returns second', () {
      expect(date.second, 42);
    });

    test('millisecond getter returns millisecond', () {
      expect(date.millisecond, 500);
    });

    test('microsecond getter returns microsecond', () {
      // 500ms = 500,000 microseconds
      expect(date.microsecond, 500000);
    });
  });

  group('Carbon accessors - date components', () {
    test('dayOfWeek returns day of week', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1); // Wednesday
      expect(date.dayOfWeek, 3);
    });

    test('dayOfYear returns day of year', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.dayOfYear > 0, true);
    });

    test('weekOfYear returns week number', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.weekOfYear, isA<int>());
    });

    test('quarter returns quarter', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.quarter, 1);
    });

    test('quarter Q2', () {
      final date = Carbon.create(year: 2020, month: 5, day: 15);
      expect(date.quarter, 2);
    });

    test('quarter Q3', () {
      final date = Carbon.create(year: 2020, month: 8, day: 15);
      expect(date.quarter, 3);
    });

    test('quarter Q4', () {
      final date = Carbon.create(year: 2020, month: 11, day: 15);
      expect(date.quarter, 4);
    });
  });

  group('Carbon accessors - millennium/century/decade', () {
    test('millennium getter for 1234', () {
      final date = Carbon.create(year: 1234, month: 5, day: 6);
      expect(date.millennium, 2);
    });

    test('millennium getter for 2000', () {
      final date = Carbon.create(year: 2000, month: 5, day: 6);
      expect(date.millennium, 2);
    });

    test('millennium getter for 2001', () {
      final date = Carbon.create(year: 2001, month: 5, day: 6);
      expect(date.millennium, 3);
    });

    test('century getter for 1234', () {
      final date = Carbon.create(year: 1234, month: 5, day: 6);
      expect(date.century, 13);
    });

    test('century getter for 2000', () {
      final date = Carbon.create(year: 2000, month: 5, day: 6);
      expect(date.century, 20);
    });

    test('century getter for 2001', () {
      final date = Carbon.create(year: 2001, month: 5, day: 6);
      expect(date.century, 21);
    });

    test('decade getter for 1234', () {
      final date = Carbon.create(year: 1234, month: 5, day: 6);
      expect(date.decade, 123);
    });

    test('decade getter for 2020', () {
      final date = Carbon.create(year: 2020, month: 5, day: 6);
      expect(date.decade, 202);
    });
  });

  group('Carbon accessors - week information', () {
    test('weekOfMonth returns week in month', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.weekOfMonth, isA<int>());
    });

    test('weekOfQuarter returns week in quarter', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.weekOfQuarter, isA<int>());
    });

    test('weekOfDecade returns week in decade', () {
      final date = Carbon.create(year: 1975, month: 5, day: 15);
      expect(date.weekOfDecade, isA<int>());
    });

    test('weekOfCentury returns week in century', () {
      final date = Carbon.create(year: 1975, month: 5, day: 15);
      expect(date.weekOfCentury, isA<int>());
    });

    test('weekOfMillennium returns week in millennium', () {
      final date = Carbon.create(year: 1975, month: 5, day: 15);
      expect(date.weekOfMillennium, isA<int>());
    });
  });

  group('Carbon accessors - ordinal positions', () {
    test('dayOfCentury returns day in century', () {
      final date = Carbon.create(year: 1975, month: 3, day: 15);
      expect(date.dayOfCentury, isA<int>());
    });

    test('dayOfDecade returns day in decade', () {
      final date = Carbon.create(year: 1975, month: 3, day: 15);
      expect(date.dayOfDecade, isA<int>());
    });

    test('dayOfQuarter returns day in quarter', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.dayOfQuarter, isA<int>());
    });

    test('dayOfMonth returns day in month', () {
      final date = Carbon.create(year: 2020, month: 3, day: 15);
      expect(date.dayOfMonth, 15);
    });

    test('yearOfCentury returns year position in century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearOfCentury, isA<int>());
    });

    test('yearOfDecade returns year position in decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearOfDecade, 5);
    });

    test('yearOfMillennium returns year position in millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearOfMillennium, isA<int>());
    });
  });

  group('Carbon accessors - days count', () {
    test('daysInMonth returns days in month', () {
      final dateJan = Carbon.create(year: 2020, month: 1, day: 1);
      expect(dateJan.daysInMonth, 31);

      final dateFeb = Carbon.create(year: 2020, month: 2, day: 1);
      expect(dateFeb.daysInMonth, 29); // Leap year

      final dateApr = Carbon.create(year: 2020, month: 4, day: 1);
      expect(dateApr.daysInMonth, 30);
    });

    test('daysInYear returns days in year', () {
      final leap = Carbon.create(year: 2020, month: 1, day: 1);
      expect(leap.daysInYear, 366);

      final normal = Carbon.create(year: 2019, month: 1, day: 1);
      expect(normal.daysInYear, 365);
    });

    test('daysInQuarter returns days in quarter', () {
      final q1 = Carbon.create(year: 2020, month: 1, day: 1);
      expect(q1.daysInQuarter, isA<int>());
    });

    test('daysInDecade returns days in decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.daysInDecade, isA<int>());
    });

    test('daysInCentury returns days in century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.daysInCentury, isA<int>());
    });
  });

  group('Carbon accessors - weeks count', () {
    test('weeksInMonth returns weeks in month', () {
      final date = Carbon.create(year: 2020, month: 3, day: 1);
      expect(date.weeksInMonth, isA<int>());
    });

    test('weeksInQuarter returns weeks in quarter', () {
      final date = Carbon.create(year: 2020, month: 3, day: 1);
      expect(date.weeksInQuarter, isA<int>());
    });

    test('weeksInYear returns weeks in year', () {
      final date = Carbon.create(year: 2020, month: 1, day: 1);
      expect(date.weeksInYear, isA<int>());
    });

    test('weeksInDecade returns weeks in decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.weeksInDecade, isA<int>());
    });

    test('weeksInCentury returns weeks in century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.weeksInCentury, isA<int>());
    });

    test('weeksInMillennium returns weeks in millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.weeksInMillennium, isA<int>());
    });
  });

  group('Carbon accessors - years count', () {
    test('yearsInDecade returns years in decade', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearsInDecade, 10);
    });

    test('yearsInCentury returns years in century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearsInCentury, 100);
    });

    test('yearsInMillennium returns years in millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.yearsInMillennium, 1000);
    });
  });

  group('Carbon accessors - centuries/decades', () {
    test('centuriesInMillennium returns centuries in millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.centuriesInMillennium, 10);
    });

    test('decadesInCentury returns decades in century', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.decadesInCentury, 10);
    });

    test('decadesInMillennium returns decades in millennium', () {
      final date = Carbon.create(year: 1975, month: 1, day: 1);
      expect(date.decadesInMillennium, 100);
    });
  });

  group('Carbon core properties - age/yearIso/weekNumberInMonth', () {
    test('age returns years since date', () {
      final birthDate = Carbon.create(year: 1990, month: 1, day: 1);
      final now = Carbon.create(year: 2024, month: 1, day: 1);

      // Mock current time for consistent test
      Carbon.setTestNow(now);

      try {
        expect(birthDate.age, 34);
      } finally {
        Carbon.setTestNow(null);
      }
    });

    test('yearIso returns ISO year', () {
      final date = Carbon.create(year: 2024, month: 1, day: 1);
      expect(date.yearIso, 2024);
    });

    test('weekNumberInMonth returns week number within month', () {
      // January 1, 2024 is a Monday, so it's in week 1
      final date = Carbon.create(year: 2024, month: 1, day: 1);
      expect(date.weekNumberInMonth, 1);

      // January 15, 2024 should be in week 3
      final midMonth = Carbon.create(year: 2024, month: 1, day: 15);
      expect(midMonth.weekNumberInMonth, 3);
    });
  });
}

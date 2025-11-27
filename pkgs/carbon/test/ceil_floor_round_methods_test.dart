import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon rounding - ceil', () {
    group('ceil by time units', () {
      test('ceilSecond rounds up to next second', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
          millisecond: 500,
          microsecond: 0,
        );
        final result = date.ceilSecond();
        expect(result.second, 46);
      });

      test('ceilMinute rounds up to next minute', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
        );
        final result = date.ceilMinute();
        expect(result.minute, 31);
        expect(result.second, 0);
      });

      test('ceilHour rounds up to next hour', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
        );
        final result = date.ceilHour();
        expect(result.hour, 13);
        expect(result.minute, 0);
      });

      test('ceilDay rounds up to next day', () {
        final date = Carbon.create(year: 2020, month: 1, day: 1, hour: 12);
        final result = date.ceilDay();
        expect(result.day, 2);
        expect(result.hour, 0);
      });
    });

    group('ceil by calendar units', () {
      test('ceilMonth rounds up to next month', () {
        final date = Carbon.create(year: 2020, month: 1, day: 15);
        final result = date.ceilMonth();
        expect(result.month, 2);
        expect(result.day, 1);
      });

      test('ceilQuarter rounds up to next quarter', () {
        final date = Carbon.create(year: 2020, month: 2, day: 15);
        final result = date.ceilQuarter();
        expect(result.month, 4);
        expect(result.day, 1);
      });

      test('ceilYear rounds up to next year', () {
        final date = Carbon.create(year: 2020, month: 6, day: 15);
        final result = date.ceilYear();
        expect(result.year, 2021);
        expect(result.month, 1);
      });
    });

    group('ceil by decades/centuries/millennia', () {
      test('ceilDecade rounds up to next decade', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.ceilDecade();
        expect(result.year, 1980);
      });

      test('ceilCentury rounds up to next century', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.ceilCentury();
        expect(result.year, 2001);
      });

      test('ceilMillennium rounds up to next millennium', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.ceilMillennium();
        expect(result.year, 2001);
      });
    });

    group('ceil milliseconds/microseconds', () {
      test('ceilMillisecond rounds up', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 500,
          microsecond: 0,
        );
        final result = date.ceilMillisecond();
        expect(result.millisecond, 501);
      });

      test('ceilMicrosecond rounds up', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 500,
        );
        final result = date.ceilMicrosecond();
        expect(result.microsecond, 501);
      });
    });
  });

  group('Carbon rounding - floor', () {
    group('floor by time units', () {
      test('floorSecond rounds down to second', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
          millisecond: 500,
          microsecond: 0,
        );
        final result = date.floorSecond();
        expect(result.second, 45);
        expect(result.millisecond, 0);
      });

      test('floorMinute rounds down to minute', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
        );
        final result = date.floorMinute();
        expect(result.minute, 30);
        expect(result.second, 0);
      });

      test('floorHour rounds down to hour', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
        );
        final result = date.floorHour();
        expect(result.hour, 12);
        expect(result.minute, 0);
      });

      test('floorDay rounds down to day', () {
        final date = Carbon.create(year: 2020, month: 1, day: 1, hour: 12);
        final result = date.floorDay();
        expect(result.day, 1);
        expect(result.hour, 0);
      });
    });

    group('floor by calendar units', () {
      test('floorMonth rounds down to month', () {
        final date = Carbon.create(year: 2020, month: 1, day: 15);
        final result = date.floorMonth();
        expect(result.month, 1);
        expect(result.day, 1);
      });

      test('floorQuarter rounds down to quarter', () {
        final date = Carbon.create(year: 2020, month: 2, day: 15);
        final result = date.floorQuarter();
        expect(result.month, 1);
        expect(result.day, 1);
      });

      test('floorYear rounds down to year', () {
        final date = Carbon.create(year: 2020, month: 6, day: 15);
        final result = date.floorYear();
        expect(result.year, 2020);
        expect(result.month, 1);
        expect(result.day, 1);
      });
    });

    group('floor by decades/centuries/millennia', () {
      test('floorDecade rounds down to decade', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.floorDecade();
        expect(result.year, 1970);
      });

      test('floorCentury rounds down to century', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.floorCentury();
        expect(result.year, 1901);
      });

      test('floorMillennium rounds down to millennium', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.floorMillennium();
        expect(result.year, 1001);
      });
    });

    group('floor milliseconds/microseconds', () {
      test('floorMillisecond rounds down', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 500,
          microsecond: 0,
        );
        final result = date.floorMillisecond();
        expect(result.millisecond, 500);
      });

      test('floorMicrosecond rounds down', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 500,
        );
        final result = date.floorMicrosecond();
        expect(result.microsecond, 500);
      });
    });
  });

  group('Carbon rounding - round', () {
    group('round by time units', () {
      test('roundSecond rounds to nearest second', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
          millisecond: 500,
          microsecond: 0,
        );
        final result = date.roundSecond();
        expect(result.second, 46);
      });

      test('roundMinute rounds to nearest minute', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
          second: 45,
        );
        final result = date.roundMinute();
        expect(result.minute, 31);
      });

      test('roundHour rounds to nearest hour', () {
        final date = Carbon.create(
          year: 2020,
          month: 1,
          day: 1,
          hour: 12,
          minute: 30,
        );
        final result = date.roundHour();
        expect(result.hour, 13);
      });

      test('roundDay rounds to nearest day', () {
        final date = Carbon.create(year: 2020, month: 1, day: 1, hour: 12);
        final result = date.roundDay();
        expect(result.day, 2);
      });
    });

    group('round by calendar units', () {
      test('roundMonth rounds to nearest month', () {
        final date = Carbon.create(year: 2020, month: 1, day: 15);
        final result = date.roundMonth();
        expect(result.month, 2);
      });

      test('roundQuarter rounds to nearest quarter', () {
        final date = Carbon.create(year: 2020, month: 2, day: 15);
        final result = date.roundQuarter();
        expect(result.month, 4);
      });

      test('roundYear rounds to nearest year', () {
        final date = Carbon.create(year: 2020, month: 6, day: 15);
        final result = date.roundYear();
        expect(result.year, 2021);
      });
    });

    group('round by decades/centuries/millennia', () {
      test('roundDecade rounds to nearest decade', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.roundDecade();
        expect(result.year, 1980);
      });

      test('roundCentury rounds to nearest century', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.roundCentury();
        expect(result.year, 2001);
      });

      test('roundMillennium rounds to nearest millennium', () {
        final date = Carbon.create(year: 1975, month: 6, day: 15);
        final result = date.roundMillennium();
        expect(result.year, 2001);
      });
    });
  });
}

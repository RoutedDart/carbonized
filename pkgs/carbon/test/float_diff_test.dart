import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  group('floatDiffIn*', () {
    const epsilon = 1e-9;

    test('sub-second + clock units match PHP outputs', () {
      final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
      final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
      expect(
        secondsStart.floatDiffInSeconds(secondsEnd),
        closeTo(71.068463, epsilon),
      );
      expect(
        secondsStart.floatDiffInMilliseconds(secondsEnd),
        closeTo(71068.463, 1e-6),
      );
      expect(
        secondsStart.floatDiffInMicroseconds(secondsEnd),
        closeTo(71068463, 1e-3),
      );

      final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
      final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
      expect(
        minutesStart.floatDiffInMinutes(minutesEnd),
        closeTo(1.183333333333, epsilon),
      );
      expect(
        minutesStart.floatDiffInHours(minutesEnd),
        closeTo(0.019722222222, epsilon),
      );

      final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
      final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
      expect(
        signedStart.floatDiffInHours(signedEnd, absolute: false),
        closeTo(-5.980277777778, epsilon),
      );
    });

    test('day/week spans include fractional portions', () {
      final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
      final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
      expect(dayStart.floatDiffInDays(dayEnd), closeTo(40.75, epsilon));

      final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
      final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
      expect(
        weekStart.floatDiffInWeeks(weekEnd),
        closeTo(5.857142857143, epsilon),
      );
    });

    test('month-derived units use calendar-aware positioning', () {
      final monthsAStart = Carbon.parse('2000-01-15T00:00:00Z');
      final monthsAEnd = Carbon.parse('2000-02-24T00:00:00Z');
      expect(
        monthsAStart.floatDiffInMonths(monthsAEnd),
        closeTo(1.310344827586, epsilon),
      );

      final monthsBStart = Carbon.parse('2000-02-15T12:00:00Z');
      final monthsBEnd = Carbon.parse('2000-03-24T06:00:00Z');
      expect(
        monthsBStart.floatDiffInMonths(monthsBEnd),
        closeTo(1.282258064516, epsilon),
      );

      final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
      final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');
      expect(
        yearsStart.floatDiffInYears(yearsEnd),
        closeTo(10.100684931507, epsilon),
      );
      expect(
        yearsStart.floatDiffInDecades(yearsEnd),
        closeTo(1.0100684931507, epsilon),
      );
      expect(
        yearsStart.floatDiffInCenturies(yearsEnd),
        closeTo(0.10100684931507, epsilon),
      );
    });
  });
}

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine();
  });

  setUp(() {
    Carbon.setLocale('en');
    Carbon.resetWeekendDays();
  });

  group('day-of-week helpers', () {
    test('default weekend days can be read and overridden', () {
      expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);

      Carbon.setWeekendDays([DateTime.thursday, DateTime.friday]);
      expect(Carbon.getWeekendDays(), [DateTime.thursday, DateTime.friday]);
      expect(Carbon.parse('2018-02-16').isWeekend(), isTrue);

      Carbon.resetWeekendDays();
      expect(Carbon.parse('2018-02-16').isWeekend(), isFalse);
      expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
    });

    test('next with no argument defaults to current weekday', () {
      final result = Carbon.parse('1975-05-21').next();
      expect(result.toIso8601String().substring(0, 10), '1975-05-28');
    });

    test('next accepts weekday string', () {
      final result = Carbon.parse('1975-05-21').next('monday');
      expect(result.toIso8601String().substring(0, 10), '1975-05-26');
    });

    test('previous with no argument defaults to current weekday', () {
      final result = Carbon.parse('1975-11-28').previous();
      expect(result.toIso8601String().substring(0, 10), '1975-11-21');
    });

    test('next accepts weekday integers', () {
      final result = Carbon.parse('1975-05-21').next(DateTime.saturday);
      expect(result.toIso8601String().substring(0, 10), '1975-05-24');
    });

    test('previous accepts weekday integers', () {
      final result = Carbon.parse('1975-05-21').previous(DateTime.saturday);
      expect(result.toIso8601String().substring(0, 10), '1975-05-17');
    });

    test('firstOfMonth without weekday returns start of month', () {
      final result = Carbon.parse('1975-11-21').firstOfMonth();
      expect(result.toIso8601String().substring(0, 10), '1975-11-01');
    });

    test('firstOfMonth with weekday finds match', () {
      final result = Carbon.parse('1975-11-21').firstOfMonth('wednesday');
      expect(result.toIso8601String().substring(0, 10), '1975-11-05');
    });

    test('lastOfMonth with weekday finds match', () {
      final result = Carbon.parse('1975-12-05').lastOfMonth('friday');
      expect(result.toIso8601String().substring(0, 10), '1975-12-26');
    });

    test('nthOfMonth returns null when outside range', () {
      final result = Carbon.parse('1975-12-05').nthOfMonth(6, 'monday');
      expect(result, isNull);
    });

    test('nthOfQuarter finds occurrence', () {
      final result = Carbon.parse('1975-12-05').nthOfQuarter(2, 'monday');
      expect(result?.toIso8601String().substring(0, 10), '1975-10-13');
    });

    test('firstOfQuarter handles months without matching day', () {
      final result = Carbon.parse('2014-05-31').firstOfQuarter();
      expect(result.toIso8601String().substring(0, 10), '2014-04-01');
    });

    test('lastOfQuarter handles months without matching day', () {
      final result = Carbon.parse('2014-05-31').lastOfQuarter();
      expect(result.toIso8601String().substring(0, 10), '2014-06-30');
    });

    test('nthOfQuarter returns null when nth is outside range', () {
      final result = Carbon.parse('1975-01-05').nthOfQuarter(20, 'monday');
      expect(result, isNull);
    });

    test('nthOfQuarter handles late month gaps', () {
      final value = Carbon.parse('2014-05-31').nthOfQuarter(2, 'monday');
      expect(value?.toIso8601String().substring(0, 10), '2014-04-14');
    });

    test('nthOfQuarter counts weekday occurrences correctly', () {
      final value = Carbon.parse('1975-08-05').nthOfQuarter(3, 'wednesday');
      expect(value?.toIso8601String().substring(0, 10), '1975-07-16');
    });

    test('firstOfYear with weekday', () {
      final result = Carbon.parse('1975-11-21').firstOfYear('wednesday');
      expect(result.toIso8601String().substring(0, 10), '1975-01-01');
    });

    test('startOfWeek handles same-week and cross-year boundaries', () {
      final sameWeek = Carbon.parse('1980-08-07T12:11:09');
      final start = sameWeek.startOfWeek();
      expect(start.toIso8601String().substring(0, 10), '1980-08-04');

      final crossYear = Carbon.parse('2013-12-31T00:00:00Z');
      final crossStart = crossYear.startOfWeek();
      expect(crossStart.toIso8601String().substring(0, 10), '2013-12-30');
    });

    test('endOfWeek handles same-week and cross-year boundaries', () {
      final sameWeek = Carbon.parse('1980-08-07T11:12:13');
      final end = sameWeek.endOfWeek();
      expect(end.toIso8601String().substring(0, 10), '1980-08-10');

      final crossYear = Carbon.parse('2013-12-31T00:00:00Z');
      final crossEnd = crossYear.endOfWeek();
      expect(crossEnd.toIso8601String().substring(0, 10), '2014-01-05');
    });

    test('lastOfYear with weekday', () {
      final result = Carbon.parse('1975-11-21').lastOfYear('monday');
      expect(result.toIso8601String().substring(0, 10), '1975-12-29');
    });

    test('nthOfYear returns null when exceeding occurrences', () {
      final result = Carbon.parse('1975-08-05').nthOfYear(55, 'monday');
      expect(result, isNull);
    });

    test('nthOfYear finds weekday occurrence', () {
      final result = Carbon.parse('1975-08-05').nthOfYear(2, 'monday');
      expect(result?.toIso8601String().substring(0, 10), '1975-01-13');
    });

    test('nextWeekday skips configured weekends', () {
      final carbon = Carbon.parse('2016-07-15');
      expect(
        carbon.nextWeekday().toIso8601String().substring(0, 10),
        '2016-07-18',
      );
      expect(
        Carbon.parse(
          '2016-07-16',
        ).nextWeekday().toIso8601String().substring(0, 10),
        '2016-07-18',
      );
      expect(
        Carbon.parse(
          '2016-07-17',
        ).nextWeekday().toIso8601String().substring(0, 10),
        '2016-07-18',
      );
    });

    test('previousWeekday skips configured weekends', () {
      expect(
        Carbon.parse(
          '2016-07-19',
        ).previousWeekday().toIso8601String().substring(0, 10),
        '2016-07-18',
      );
      expect(
        Carbon.parse(
          '2016-07-18',
        ).previousWeekday().toIso8601String().substring(0, 10),
        '2016-07-15',
      );
      expect(
        Carbon.parse(
          '2016-07-17',
        ).previousWeekday().toIso8601String().substring(0, 10),
        '2016-07-15',
      );
      expect(
        Carbon.parse(
          '2016-07-16',
        ).previousWeekday().toIso8601String().substring(0, 10),
        '2016-07-15',
      );
    });
    test('startOfWeek respects timezone offsets', () {
      final carbon = Carbon.parse('2016-07-27T17:13:07Z').tz('-04:00');
      final start = carbon.startOfWeek();
      final local = start.dateTime.add(const Duration(hours: -4));
      expect(local.toIso8601String().substring(0, 10), '2016-07-25');
    });

    test('endOfWeek respects timezone offsets', () {
      final carbon = Carbon.parse('2016-07-27T17:13:07Z').tz('-04:00');
      final end = carbon.endOfWeek();
      final local = end.dateTime.add(const Duration(hours: -4));
      expect(local.toIso8601String().substring(0, 10), '2016-07-31');
    });
  });

  group('locale-aware week boundaries', () {
    test('startOfWeek follows locale first day mapping', () {
      Carbon.setLocale('en_US');
      final usWeekStart = Carbon.parse('2019-06-05').startOfWeek();
      expect(usWeekStart.dateTime.weekday, DateTime.sunday);

      Carbon.setLocale('ar');
      final arWeekStart = Carbon.parse('2019-06-05').startOfWeek();
      expect(arWeekStart.dateTime.weekday, DateTime.saturday);

      Carbon.setLocale('es_US');
      final esWeekStart = Carbon.parse('2019-06-05').startOfWeek();
      expect(esWeekStart.dateTime.weekday, DateTime.sunday);

      Carbon.setLocale('en_GB');
      final gbWeekStart = Carbon.parse('2019-06-05').startOfWeek();
      expect(gbWeekStart.dateTime.weekday, DateTime.monday);

      Carbon.setLocale('en');
      final defaultWeek = Carbon.parse('2019-06-05').startOfWeek();
      expect(defaultWeek.dateTime.weekday, DateTime.monday);
    });

    test('endOfWeek mirrors locale settings', () {
      Carbon.setLocale('en_US');
      final usEnd = Carbon.parse('2019-06-05').endOfWeek();
      expect(usEnd.dateTime.weekday, DateTime.saturday);

      Carbon.setLocale('es_US');
      final esEnd = Carbon.parse('2019-06-05').endOfWeek();
      expect(esEnd.dateTime.weekday, DateTime.saturday);

      Carbon.setLocale('en_GB');
      final gbEnd = Carbon.parse('2019-06-05').endOfWeek();
      expect(gbEnd.dateTime.weekday, DateTime.sunday);

      Carbon.setLocale('en');
      final defaultEnd = Carbon.parse('2019-06-05').endOfWeek();
      expect(defaultEnd.dateTime.weekday, DateTime.sunday);
    });
  });

  group('weekend navigation', () {
    test('nextWeekendDay jumps to the next configured weekend', () {
      final start = Carbon.parse('2016-07-14');
      final weekend = start.nextWeekendDay();
      expect(weekend.toIso8601String().substring(0, 10), '2016-07-16');

      Carbon.setWeekendDays([DateTime.thursday]);
      final custom = Carbon.parse('2016-07-13').nextWeekendDay();
      expect(custom.toIso8601String().substring(0, 10), '2016-07-14');
    });

    test('previousWeekendDay rewinds to the latest weekend day', () {
      final start = Carbon.parse('2016-07-14');
      final previous = start.previousWeekendDay();
      expect(previous.toIso8601String().substring(0, 10), '2016-07-10');

      Carbon.setWeekendDays([DateTime.thursday, DateTime.friday]);
      final custom = Carbon.parse('2016-07-17').previousWeekendDay();
      expect(custom.toIso8601String().substring(0, 10), '2016-07-15');
    });
  });
}

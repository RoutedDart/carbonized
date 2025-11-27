import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.setWeekStartsAt(DateTime.monday);
    Carbon.setWeekendDays([DateTime.saturday, DateTime.sunday]);
    Carbon.setLocale('en');
  });

  tearDown(() {
    Carbon.setWeekStartsAt(DateTime.monday);
    Carbon.setWeekendDays([DateTime.saturday, DateTime.sunday]);
  });

  test('setWeekStartsAt influences startOfWeek helper', () {
    Carbon.setWeekStartsAt(DateTime.wednesday);
    final value = Carbon.parse('2023-01-06T12:00:00Z');
    final start = value.startOfWeek();
    expect(start.dayOfWeek, DateTime.wednesday);
    expect(start.day, 4);
  });

  test('setWeekendDays updates weekend detection', () {
    Carbon.setWeekendDays([DateTime.friday]);
    expect(Carbon.getWeekendDays(), [DateTime.friday]);
    final friday = Carbon.parse('2023-01-06T12:00:00Z');
    expect(friday.isWeekend(), isTrue);
    final saturday = Carbon.parse('2023-01-07T12:00:00Z');
    expect(saturday.isWeekend(), isFalse);
    Carbon.resetWeekendDays();
    expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
  });

  test('locale() applies locale-specific start-of-week', () {
    final us = Carbon.parse('2023-01-03T00:00:00Z').locale('en_US');
    expect(us.startOfWeek().dayOfWeek, 0);
    final fr = Carbon.parse('2023-01-03T00:00:00Z').locale('fr_FR');
    expect(fr.startOfWeek().dayOfWeek, DateTime.monday);
  });
}

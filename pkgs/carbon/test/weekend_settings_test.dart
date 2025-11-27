import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.setLocale('en');
    Carbon.resetWeekendDays();
  });

  test('default weekend days are Saturday/Sunday', () {
    expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
    expect(Carbon.parse('2024-05-18').isWeekend(), isTrue);
    expect(Carbon.parse('2024-05-20').isWeekend(), isFalse);
  });

  test('custom weekend days influence isWeekend()', () {
    Carbon.setWeekendDays([DateTime.thursday, DateTime.friday]);
    expect(Carbon.getWeekendDays(), [DateTime.thursday, DateTime.friday]);
    expect(Carbon.parse('2018-02-16').isWeekend(), isTrue); // Friday
    expect(Carbon.parse('2018-02-17').isWeekend(), isFalse); // Saturday
    Carbon.setWeekendDays([DateTime.saturday, DateTime.sunday]);
  });

  test('locale adjustments apply default weekends when not overridden', () {
    Carbon.setLocale('ar');
    expect(Carbon.getWeekendDays(), [DateTime.friday, DateTime.saturday]);
    Carbon.setWeekendDays([DateTime.saturday, DateTime.sunday]);
    Carbon.setLocale('en');
    expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
  });

  test('locale weekend defaults cover multiple regions', () {
    Carbon.setLocale('fa_AF');
    expect(Carbon.getWeekendDays(), [DateTime.thursday, DateTime.friday]);
    Carbon.setLocale('ps');
    expect(Carbon.getWeekendDays(), [DateTime.thursday, DateTime.friday]);
    Carbon.setLocale('en');
    expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
  });

  test('manual weekend override survives locale changes until reset', () {
    Carbon.setWeekendDays([DateTime.monday]);
    Carbon.setLocale('ar');
    expect(Carbon.getWeekendDays(), [DateTime.monday]);
    Carbon.resetWeekendDays();
    expect(Carbon.getWeekendDays(), [DateTime.friday, DateTime.saturday]);
  });

  test('locale changes update week start defaults', () {
    Carbon.setLocale('en_US');
    expect(Carbon.getWeekStartsAt(), DateTime.sunday);
    Carbon.setLocale('en');
    expect(Carbon.getWeekStartsAt(), DateTime.monday);
  });

  test('locale canonicalization strips encoding/modifier suffixes', () {
    Carbon.setLocale('en_SD.UTF-8');
    expect(Carbon.getWeekendDays(), [DateTime.friday, DateTime.saturday]);

    Carbon.setLocale('es_US.UTF-8@calendar=gregorian');
    expect(Carbon.getWeekStartsAt(), DateTime.sunday);

    Carbon.setLocale('en');
    expect(Carbon.getWeekendDays(), [DateTime.saturday, DateTime.sunday]);
    expect(Carbon.getWeekStartsAt(), DateTime.monday);
  });
}

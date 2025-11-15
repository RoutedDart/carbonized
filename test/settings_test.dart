import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.setLocale('en');
    Carbon.setWeekStartsAt(DateTime.monday);
    Carbon.setTestNow(null);
  });

  test('setWeekStartsAt influences startOfWeek', () {
    Carbon.setWeekStartsAt(DateTime.sunday);
    final result = Carbon.parse('2025-01-01').startOfWeek();
    expect(result.day, 29);
  });

  test('setLocale updates default locale for new instances', () {
    Carbon.setLocale('fr');
    final carbon = Carbon.now();
    expect(carbon.localeCode, 'fr');
  });
}

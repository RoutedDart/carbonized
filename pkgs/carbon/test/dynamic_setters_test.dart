import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await Carbon.configureTimeMachine(testing: true);
  });

  test('set/get helpers mirror PHP dynamic properties', () {
    final date = Carbon.parse('2024-01-01T12:00:00Z');
    date
      ..set('year', '2003')
      ..set('dayOfYear', 35);

    expect(date.get('year'), 2003);
    expect(date.day, 4);
    expect(date.month, 2);
    expect(date.dayOfYear, 35);
  });

  test('timestamp setters update the underlying instant', () {
    final date = Carbon.parse('2024-01-01T12:00:00Z');
    date.setTimestamp(169957925);

    expect(date.get('timestamp'), 169957925);
    expect(date.toIso8601String(keepOffset: true), '1975-05-22T02:32:05.000Z');
  });
}

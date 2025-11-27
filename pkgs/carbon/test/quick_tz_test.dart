import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() async {
  test('someti', () async {
    await initializeDateFormatting('en');
    await Carbon.configureTimeMachine();

    final now = Carbon.now();
    print('UTC: ${now.format("yyyy-MM-dd HH:mm:ss")}');
    print('iso1680: ${now.toIso8601String()}');

    final cities = [
      {'name': 'New York', 'tz': 'America/New_York'},
      {'name': 'Tokyo', 'tz': 'Asia/Tokyo'},
      {'name': 'Sydney', 'tz': 'Australia/Sydney'},
    ];

    for (final city in cities) {
      final cityTime = now.tz(city['tz']!);
      print('\n${city['name']}:');
      print('  format("MMM dd, yyyy"): ${cityTime.format("MMM dd, yyyy")}');
      print('  format("M d, Y"): ${cityTime.format("M d, Y")}');
      print(
        '  format("yyyy-MM-dd HH:mm:ss"): ${cityTime.format("yyyy-MM-dd HH:mm:ss")}',
      );
      print(
        '  year/month/day properties: ${cityTime.year}-${cityTime.month}-${cityTime.day}',
      );
    }
  });
}

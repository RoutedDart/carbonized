import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // Initialize timezone database
  await Carbon.configureTimeMachine();
  await initializeDateFormatting('en_US', null);

  // Get current time in UTC
  final now = Carbon.now();

  print('=== Dart Carbon Timezone Test ===');
  print('Current UTC time: ${now.format('yyyy-MM-dd HH:mm:ss')}\n');

  final cities = [
    {'name': 'New York', 'tz': 'America/New_York'},
    {'name': 'London', 'tz': 'Europe/London'},
    {'name': 'Tokyo', 'tz': 'Asia/Tokyo'},
    {'name': 'Sydney', 'tz': 'Australia/Sydney'},
    {'name': 'Dubai', 'tz': 'Asia/Dubai'},
    {'name': 'Los Angeles', 'tz': 'America/Los_Angeles'},
  ];

  for (final city in cities) {
    final cityTime = now.tz(city['tz']!);
    final offsetMinutes = cityTime.utcOffset;
    final offsetSeconds = offsetMinutes * 60;
    final offsetHours = offsetMinutes / 60;

    print('${city['name']}:');
    print('  Time: ${cityTime.format('HH:mm:ss')}');
    print('  Date: ${cityTime.format('MMM dd, yyyy')}');
    print('  Timezone: ${city['tz']}');
    print('  Offset (minutes): $offsetMinutes');
    print('  Offset (seconds): $offsetSeconds');
    print('  Offset (hours): $offsetHours');
    print('');
  }

  // Test start of day calculations
  print('=== Start of Day Test ===');
  final startOfDay = now.startOfDay();
  print('Now: ${now.format('yyyy-MM-dd HH:mm:ss')}');
  print('Start of day: ${startOfDay.format('yyyy-MM-dd HH:mm:ss')}');
  print('Diff in hours: ${startOfDay.diffInHours(now)}');
  print('Diff in minutes: ${startOfDay.diffInMinutes(now)}');
  print('diffForHumans: ${startOfDay.diffForHumans()}');
  print('');

  // Test start of week
  print('=== Start of Week Test ===');
  final startOfWeek = now.startOfWeek();
  print('Start of week: ${startOfWeek.format('yyyy-MM-dd HH:mm:ss')}');
  print('Diff in days: ${startOfWeek.diffInDays(now)}');
  print('diffForHumans: ${startOfWeek.diffForHumans()}');
  print('');

  // Test end of day
  print('=== End of Day Test ===');
  final endOfDay = now.endOfDay();
  print('End of day: ${endOfDay.format('yyyy-MM-dd HH:mm:ss')}');
  print('diffForHumans: ${endOfDay.diffForHumans()}');
  print('');
}

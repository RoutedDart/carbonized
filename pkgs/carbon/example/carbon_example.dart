import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

/// IMPORTANT: Call `Carbon.configureTimeMachine()` before using IANA timezone
/// names like 'America/Vancouver', 'Europe/Paris', etc.
/// This loads the timezone database asynchronously.
Future<void> main() async {
  // Initialize date formatting for your locale
  await initializeDateFormatting('en');

  // Configure timezone database (required for named timezones)
  await Carbon.configureTimeMachine();

  // Now you can safely use Carbon with or without timezones
  CarbonInterface awesome = Carbon.now();
  print('awesome: ${awesome.toIso8601String()}');
  awesome = awesome.add(Duration(days: 5));
  print('awesome plus 5 days: ${awesome.toIso8601String()}');

  // Example with timezone (requires configureTimeMachine)
  final vancouver = Carbon.parse(
    '2025-01-10T00:00:00Z',
    timeZone: 'America/Vancouver',
  );
  print('Vancouver time: ${vancouver.toIso8601String(keepOffset: true)}');
}

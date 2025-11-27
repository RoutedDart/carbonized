import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  final toronto = Carbon.parse('2022-01-24 10:45', timeZone: 'America/Toronto');
  print('tzName=${toronto.timeZoneName}');
  print('offset=${toronto.toDateTimeView().timeZoneOffset.inMinutes}');
  print('iso=${toronto.toUtc().toIso8601String()}');
}

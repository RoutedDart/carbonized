/// Runnable snippets for the "CarbonTimeZone" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _timezoneSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final paris = Carbon.parse('2024-06-01T12:00:00', timeZone: 'Europe/Paris');
  final toronto = paris.copy().tz('America/Toronto');
  final debug = paris.toDebugMap()['timezone'] as Map<String, Object?>;

  print('paris zone -> ${debug['name']}');
  print('paris offset -> ${debug['offset']}');
  print('toronto iso -> ${toronto.toIso8601String(keepOffset: true)}');
}
''';

/// Shows inspecting timezone metadata and switching zones.
Future<ExampleRun> runTimezoneExample() async {
  await _bootstrap();
  final paris = Carbon.parse('2024-06-01T12:00:00', timeZone: 'Europe/Paris');
  final toronto = paris.copy().tz('America/Toronto');
  final debug = paris.toDebugMap()['timezone'] as Map<String, Object?>;
  final buffer = StringBuffer()
    ..writeln('paris zone -> ${debug['name']}')
    ..writeln('paris offset -> ${debug['offset']}')
    ..writeln('toronto iso -> ${toronto.toIso8601String(keepOffset: true)}');
  return ExampleRun(
    code: _timezoneSource,
    output: buffer.toString().trimRight(),
  );
}

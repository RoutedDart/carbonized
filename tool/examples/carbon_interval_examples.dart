/// Runnable snippets for the "CarbonInterval" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _intervalBasicsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final interval = CarbonInterval.fromComponents(days: 3, hours: 5, minutes: 15);
  final fromDuration = CarbonInterval.fromDuration(const Duration(hours: 12));

  print('month span -> ${interval.monthSpan}');
  print('microseconds -> ${interval.microseconds}');
  print('fromDuration microseconds -> ${fromDuration.microseconds}');
}
''';

/// Shows the limited CarbonInterval API available in Dart.
Future<ExampleRun> runIntervalBasicsExample() async {
  await _bootstrap();
  final interval = CarbonInterval.fromComponents(
    days: 3,
    hours: 5,
    minutes: 15,
  );
  final fromDuration = CarbonInterval.fromDuration(const Duration(hours: 12));
  final buffer = StringBuffer()
    ..writeln('month span -> ${interval.monthSpan}')
    ..writeln('microseconds -> ${interval.microseconds}')
    ..writeln('fromDuration microseconds -> ${fromDuration.microseconds}');
  return ExampleRun(
    code: _intervalBasicsSource,
    output: buffer.toString().trimRight(),
  );
}

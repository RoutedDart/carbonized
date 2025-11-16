/// Runnable snippets for the "CarbonPeriod" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _periodBasicsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final start = Carbon.parse('2024-06-01T00:00:00Z');
  final period = start.daysUntil('2024-06-07', 2);
  for (final date in period) {
    print(date.toIso8601String());
  }
}
''';

/// Demonstrates constructing and iterating a `CarbonPeriod` via `daysUntil`.
Future<ExampleRun> runPeriodBasicsExample() async {
  await _bootstrap();
  final start = Carbon.parse('2024-06-01T00:00:00Z');
  final period = start.daysUntil('2024-06-07', 2);
  final buffer = StringBuffer();
  for (final date in period) {
    buffer.writeln(date.toIso8601String());
  }
  return ExampleRun(
    code: _periodBasicsSource,
    output: buffer.toString().trimRight(),
  );
}

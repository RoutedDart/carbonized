/// Runnable snippets for the "CarbonPeriod" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

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

const _periodAdvancedSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final start = Carbon.parse('2024-12-23T00:00:00Z');
  final period = start.daysUntil('2025-01-05T00:00:00Z');
  final weekdays = period
      .filter((date) => !date.isWeekend())
      .recurrences(5);

  for (final date in weekdays) {
    print(date.toIso8601String());
  }
}
''';

Future<ExampleRun> runPeriodAdvancedExample() async {
  final start = Carbon.parse('2024-12-23T00:00:00Z');
  final period = start.daysUntil('2025-01-05T00:00:00Z');
  final weekdays = period.filter((date) => !date.isWeekend()).recurrences(5);
  final buffer = StringBuffer();
  for (final date in weekdays) {
    buffer.writeln(date.toIso8601String());
  }
  return ExampleRun(
    code: _periodAdvancedSource,
    output: buffer.toString().trimRight(),
  );
}

const _periodStringsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setLocale('en');
  CarbonPeriod.setLocale('en');

  final start = Carbon.parse('2024-12-01T00:00:00Z');
  final basic = start.daysUntil('2024-12-05T00:00:00Z');
  print(basic);

  final limited = start.daysUntil('2024-12-10T00:00:00Z').recurrences(3);
  print(limited);

  Carbon.setLocale('so');
  CarbonPeriod.setLocale('so');

  final somali =
      Carbon.parse('2024-12-01T00:00:00Z').daysUntil('2024-12-05T00:00:00Z');
  print(somali);
}
''';

Future<ExampleRun> runPeriodFormattingExample() async {
  Carbon.setLocale('en');
  CarbonPeriod.setLocale('en');

  final start = Carbon.parse('2024-12-01T00:00:00Z');
  final basic = start.daysUntil('2024-12-05T00:00:00Z');
  final limited = start.daysUntil('2024-12-10T00:00:00Z').recurrences(3);

  Carbon.setLocale('so');
  CarbonPeriod.setLocale('so');
  final somali = Carbon.parse(
    '2024-12-01T00:00:00Z',
  ).daysUntil('2024-12-05T00:00:00Z');

  final buffer = StringBuffer()
    ..writeln(basic)
    ..writeln(limited)
    ..writeln(somali);

  // Reset the locale so other examples continue to run in English.
  Carbon.setLocale('en');
  CarbonPeriod.setLocale('en');

  return ExampleRun(
    code: _periodStringsSource,
    output: buffer.toString().trimRight(),
  );
}

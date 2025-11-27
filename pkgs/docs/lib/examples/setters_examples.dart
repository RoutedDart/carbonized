/// Runnable snippets for the "Setters" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _basicSettersSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2024-01-15T12:34:56Z');
  dt
    ..setYear(1975)
    ..setMonth(13) // rolls into next year
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5);

  dt.tz('Europe/London');

  print('final iso: ${dt.toIso8601String()}');
  print('timezone: ${dt.timeZoneName}');
}
''';

/// Mirrors the base setter example from the PHP docs, including tz changes.
Future<ExampleRun> runBasicSettersExample() async {
  final dt = Carbon.parse('2024-01-15T12:34:56Z');
  dt
    ..setYear(1975)
    ..setMonth(13)
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5);
  dt.tz('Europe/London');

  final buffer = StringBuffer()
    ..writeln('final iso: ${dt.toIso8601String()}')
    ..writeln('timezone: ${dt.timeZoneName}');
  return ExampleRun(
    code: _basicSettersSource,
    output: buffer.toString().trimRight(),
  );
}

const _methodAliasesSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2024-01-15T12:00:00Z');
  dt.setYear(2001);
  print('setYear -> ${dt.year}');

  dt.years(2002); // fluent alias
  print('years() alias -> ${dt.year}');

  dt.setDayOfWeek(DateTime.friday);
  print('day of week -> ${dt.dayOfWeek}');
}
''';

/// Highlights alias helpers like `years()` and `setDayOfWeek`.
Future<ExampleRun> runMethodAliasesExample() async {
  final dt = Carbon.parse('2024-01-15T12:00:00Z');
  dt.setYear(2001);
  dt.years(2002);
  dt.setDayOfWeek(DateTime.friday);

  final buffer = StringBuffer()
    ..writeln('setYear -> ${dt.year}')
    ..writeln('years() alias -> ${dt.year}')
    ..writeln('day of week -> ${dt.dayOfWeek}');
  return ExampleRun(
    code: _methodAliasesSource,
    output: buffer.toString().trimRight(),
  );
}

const _dynamicSettersSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2024-01-01T12:00:00Z');
  dt
    ..set('year', 2003)
    ..set('dayOfYear', 35)
    ..set('timestamp', 169957925);

  print('year -> ${dt.get('year')}');
  print('day of year -> ${dt.dayOfYear}');
  print('timestamp -> ${dt.get('timestamp')}');
  print('iso -> ${dt.toIso8601String(keepOffset: true)}');
}
''';

/// Demonstrates the PHP-style `set()`/`get()` helpers plus `dayOfYear`.
Future<ExampleRun> runDynamicSettersExample() async {
  final dt = Carbon.parse('2024-01-01T12:00:00Z');
  dt
    ..set('year', 2003)
    ..set('dayOfYear', 35)
    ..set('timestamp', 169957925);

  final buffer = StringBuffer()
    ..writeln('year -> ${dt.get('year')}')
    ..writeln('day of year -> ${dt.dayOfYear}')
    ..writeln('timestamp -> ${dt.get('timestamp')}')
    ..writeln('iso -> ${dt.toIso8601String(keepOffset: true)}');
  return ExampleRun(
    code: _dynamicSettersSource,
    output: buffer.toString().trimRight(),
  );
}

const _overflowSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2024-01-31T00:00:00Z');
  dt.setMonth(2); // respects monthOverflow (default true)
  print('month overflow -> ${dt.toIso8601String()}');
}
''';

/// Shows how setter overflow matches PHP Carbon's behavior.
Future<ExampleRun> runOverflowExample() async {
  final dt = Carbon.parse('2024-01-31T00:00:00Z');
  dt.setMonth(2);

  final buffer = StringBuffer()
    ..writeln('month overflow -> ${dt.toIso8601String()}');
  return ExampleRun(
    code: _overflowSource,
    output: buffer.toString().trimRight(),
  );
}

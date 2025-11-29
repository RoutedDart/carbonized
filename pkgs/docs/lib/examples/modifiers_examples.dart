/// Runnable snippets for the "Modifiers" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _startEndSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  print('startOfMinute -> ${dt.copy().startOfMinute()}');
  print('endOfHour -> ${dt.copy().endOfHour()}');
  print('startOfDay -> ${dt.copy().startOfDay()}');
  print('endOfMonth -> ${dt.copy().endOfMonth()}');
  print('startOfQuarter -> ${dt.copy().startOfQuarter()}');
}
''';

/// Shows the start/end helpers for various units.
Future<ExampleRun> runStartEndExample() async {
  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  final buffer = StringBuffer()
    ..writeln('startOfMinute -> ${dt.copy().startOfMinute()}')
    ..writeln('endOfHour -> ${dt.copy().endOfHour()}')
    ..writeln('startOfDay -> ${dt.copy().startOfDay()}')
    ..writeln('endOfMonth -> ${dt.copy().endOfMonth()}')
    ..writeln('startOfQuarter -> ${dt.copy().startOfQuarter()}');
  return ExampleRun(
    code: _startEndSource,
    output: buffer.toString().trimRight(),
  );
}

const _navigationSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2014-05-30T00:00:00Z');
  print('next Wednesday -> ${dt.copy().next(DateTime.wednesday)}');
  print('previous -> ${dt.copy().previous()}');
  final start = Carbon.parse('2014-01-01T00:00:00Z');
  final end = Carbon.parse('2014-01-30T00:00:00Z');
  print('average -> ${start.average(end)}');
}
''';

/// Demonstrates `next()`, `previous()`, and `average()` helpers.
Future<ExampleRun> runNavigationExample() async {
  final dt = Carbon.parse('2014-05-30T00:00:00Z');
  final start = Carbon.parse('2014-01-01T00:00:00Z');
  final end = Carbon.parse('2014-01-30T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('next Wednesday -> ${dt.copy().next(DateTime.wednesday)}')
    ..writeln('previous -> ${dt.copy().previous()}')
    ..writeln('average -> ${start.average(end)}');
  return ExampleRun(
    code: _navigationSource,
    output: buffer.toString().trimRight(),
  );
}

const _roundingSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  print('roundSecond -> ${dt.copy().roundSecond()}');
  print('ceilMinute -> ${dt.copy().ceilMinute()}');
  print('floorHour -> ${dt.copy().floorHour()}');
}
''';

/// Highlights `round*` helpers.
Future<ExampleRun> runRoundingExample() async {
  final dt = Carbon.parse('2012-01-31T15:32:45.654321Z');
  final buffer = StringBuffer()
    ..writeln('roundSecond -> ${dt.copy().roundSecond()}')
    ..writeln('ceilMinute -> ${dt.copy().ceilMinute()}')
    ..writeln('floorHour -> ${dt.copy().floorHour()}');
  return ExampleRun(
    code: _roundingSource,
    output: buffer.toString().trimRight(),
  );
}

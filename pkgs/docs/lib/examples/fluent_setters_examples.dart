/// Runnable snippets for the "Fluent Setters" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _typedSettersSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final value = Carbon.parse('2001-01-01T01:01:01.200000Z');
  value
    ..setYear(1975)
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5)
    ..setMicroseconds(123456);

  print(value.toIso8601String());
}
''';

/// Chains the typed setter helpers to mirror PHP's fluent setters.
Future<ExampleRun> runTypedSettersExample() async {
  final value = Carbon.parse('2001-01-01T01:01:01.200000Z');
  value
    ..setYear(1975)
    ..setMonth(5)
    ..setDay(21)
    ..setHour(22)
    ..setMinute(32)
    ..setSecond(5)
    ..setMicroseconds(123456);

  return ExampleRun(code: _typedSettersSource, output: value.toIso8601String());
}

const _groupedSettersSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final base = Carbon.parse('2001-01-01T01:01:01.200000Z');
  final setDateTime = base.copy()
    ..setDate(1975, 5, 21)
    ..setTime(22, 32, 5, 123456);
  final preciseSource = Carbon.parse('1975-05-21T22:32:05.123456Z');
  final viaCopy = base.copy()
    ..setDate(1975, 5, 21)
    ..setTimeFrom(preciseSource);

  print('setDate/setTime -> ${setDateTime.toIso8601String()}');
  print('setTimeFrom -> ${viaCopy.toIso8601String()}');
}
''';

/// Demonstrates grouped setters such as `setDate`/`setTime` and time strings.
Future<ExampleRun> runGroupedSettersExample() async {
  final base = Carbon.parse('2001-01-01T01:01:01.200000Z');
  final setDateTime = base.copy()
    ..setDate(1975, 5, 21)
    ..setTime(22, 32, 5, 123456);
  final preciseSource = Carbon.parse('1975-05-21T22:32:05.123456Z');
  final viaCopy = base.copy()
    ..setDate(1975, 5, 21)
    ..setTimeFrom(preciseSource);

  final buffer = StringBuffer()
    ..writeln('setDate/setTime -> ${setDateTime.toIso8601String()}')
    ..writeln('setTimeFrom -> ${viaCopy.toIso8601String()}');
  return ExampleRun(
    code: _groupedSettersSource,
    output: buffer.toString().trimRight(),
  );
}

const _copyFromSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final source = Carbon.parse('2010-05-16T22:40:10.100000Z');
  final target = Carbon.parse('2001-01-01T01:01:01.200000Z');

  final fromTime = target.copy()..setTimeFrom(source);
  final fromDate = target.copy()
    ..setDateFrom(Carbon.fromDateTime(DateTime.utc(2013, 9, 1, 9, 22, 56)));
  final fromBoth = target.copy()..setDateTimeFrom(source);

  print('setTimeFrom -> ${fromTime.toIso8601String()}');
  print('setDateFrom -> ${fromDate.toIso8601String()}');
  print('setDateTimeFrom -> ${fromBoth.toIso8601String()}');
}
''';

/// Copies date/time components from other `CarbonInterface` or `DateTime` values.
Future<ExampleRun> runCopyFromExample() async {
  final source = Carbon.parse('2010-05-16T22:40:10.100000Z');
  final target = Carbon.parse('2001-01-01T01:01:01.200000Z');
  final fromTime = target.copy()..setTimeFrom(source);
  final fromDate = target.copy()
    ..setDateFrom(Carbon.fromDateTime(DateTime.utc(2013, 9, 1, 9, 22, 56)));
  final fromBoth = target.copy()..setDateTimeFrom(source);

  final buffer = StringBuffer()
    ..writeln('setTimeFrom -> ${fromTime.toIso8601String()}')
    ..writeln('setDateFrom -> ${fromDate.toIso8601String()}')
    ..writeln('setDateTimeFrom -> ${fromBoth.toIso8601String()}');
  return ExampleRun(
    code: _copyFromSource,
    output: buffer.toString().trimRight(),
  );
}

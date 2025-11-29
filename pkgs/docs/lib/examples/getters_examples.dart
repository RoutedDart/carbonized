/// Runnable snippets for the "Getters" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _componentGetterSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final dt = Carbon.parse('2012-10-05T23:26:11.123789Z');

  print('year: ${dt.year}');
  print('month: ${dt.month}');
  print('day: ${dt.day}');
  print('hour: ${dt.hour}');
  print('minute: ${dt.minute}');
  print('second: ${dt.second}');
  print('microsecond: ${dt.microsecond}');
  print('dayOfWeek: ${dt.dayOfWeek}');
  print('isoWeek: ${dt.isoWeek}');
  print('dayOfYear: ${dt.dayOfYear}');
  print('weekOfMonth: ${dt.weekOfMonth}');
  print('weekOfYear: ${dt.weekOfYear}');
  print('daysInMonth: ${dt.daysInMonth}');
  print('timestamp: ${dt.dateTime.millisecondsSinceEpoch ~/ 1000}');
}
''';

/// Outputs the most common component getters from the PHP docs snippet.
Future<ExampleRun> runComponentGetterExample() async {
  final dt = Carbon.parse('2012-10-05T23:26:11.123789Z');
  final buffer = StringBuffer()
    ..writeln('year: ${dt.year}')
    ..writeln('month: ${dt.month}')
    ..writeln('day: ${dt.day}')
    ..writeln('hour: ${dt.hour}')
    ..writeln('minute: ${dt.minute}')
    ..writeln('second: ${dt.second}')
    ..writeln('microsecond: ${dt.microsecond}')
    ..writeln('dayOfWeek: ${dt.dayOfWeek}')
    ..writeln('isoWeek: ${dt.isoWeek}')
    ..writeln('dayOfYear: ${dt.dayOfYear}')
    ..writeln('weekOfMonth: ${dt.weekOfMonth}')
    ..writeln('weekOfYear: ${dt.weekOfYear}')
    ..writeln('daysInMonth: ${dt.daysInMonth}')
    ..writeln('timestamp: ${dt.dateTime.millisecondsSinceEpoch ~/ 1000}');
  return ExampleRun(
    code: _componentGetterSource,
    output: buffer.toString().trimRight(),
  );
}

const _localizedNamesSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final dt = Carbon.parse('2012-10-05T23:26:11Z');
  print('English weekday: ${dt.locale('en').isoFormat('dddd')}');
  print('German weekday: ${dt.locale('de').isoFormat('dddd')}');
  print('German month: ${dt.locale('de').isoFormat('MMMM')}');
}
''';

/// Shows how locale-aware getters rely on `isoFormat` plus `locale()`.
Future<ExampleRun> runLocalizedNamesExample() async {
  final dt = Carbon.parse('2012-10-05T23:26:11Z');
  final buffer = StringBuffer()
    ..writeln('English weekday: ${dt.locale('en').isoFormat('dddd')}')
    ..writeln('German weekday: ${dt.locale('de').isoFormat('dddd')}')
    ..writeln('German month: ${dt.locale('de').isoFormat('MMMM')}');
  return ExampleRun(
    code: _localizedNamesSource,
    output: buffer.toString().trimRight(),
  );
}

const _timezoneGetterSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final toronto = Carbon.parse(
    '2022-01-24 10:45',
    timeZone: 'America/Toronto',
  );
  final zoneInfo = toronto.toDebugMap()['timezone'] as Map<String, Object?>;

  print('tz name: ${zoneInfo['name']}');
  print('offset: ${zoneInfo['offset']}');
  print('offsetSeconds: ${zoneInfo['offsetSeconds']}');
  print('UTC iso: ${toronto.toUtc().toIso8601String()}');
}
''';

/// Captures the timezone metadata exposed via `toDebugMap()`.
Future<ExampleRun> runTimezoneGetterExample() async {
  await Carbon.configureTimeMachine(testing: true);
  final toronto = Carbon.parse('2022-01-24 10:45', timeZone: 'America/Toronto');
  final zoneInfo = toronto.toDebugMap()['timezone'] as Map<String, Object?>;
  final buffer = StringBuffer()
    ..writeln('tz name: ${zoneInfo['name']}')
    ..writeln('offset: ${zoneInfo['offset']}')
    ..writeln('offsetSeconds: ${zoneInfo['offsetSeconds']}')
    ..writeln('UTC iso: ${toronto.toUtc().toIso8601String()}');
  return ExampleRun(
    code: _timezoneGetterSource,
    output: buffer.toString().trimRight(),
  );
}

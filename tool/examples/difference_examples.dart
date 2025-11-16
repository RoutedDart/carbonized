/// Runnable snippets for the "Difference" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _diffUnitsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final ottawa = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Toronto');
  final vancouver = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Vancouver');
  final january = Carbon.parse('2012-01-31T00:00:00Z');

  print('diffInHours -> ${ottawa.diffInHours(vancouver)}');
  print('diffInHours (signed) -> ${vancouver.diffInHours(ottawa, absolute: false)}');
  print('diffInDays addMonth -> ${january.diffInDays(january.copy()..addMonth())}');
  print('diffInDays subMonth signed -> ${january.diffInDays(january.copy()..subMonth(), absolute: false)}');
  print('diffInMinutes +59s -> ${january.diffInMinutes(january.copy()..addSeconds(59))}');
  print('diffInMinutes +120s -> ${january.diffInMinutes(january.copy()..addSeconds(120))}');
  print('secondsSinceMidnight -> ${(january.copy()..addSeconds(120)).secondsSinceMidnight()}');
}
''';

/// Shows `diffIn*` helpers with absolute vs signed outputs.
Future<ExampleRun> runDiffUnitsExample() async {
  await _bootstrap();
  final ottawa = Carbon.parse(
    '2000-01-01T00:00:00',
    timeZone: 'America/Toronto',
  );
  final vancouver = Carbon.parse(
    '2000-01-01T00:00:00',
    timeZone: 'America/Vancouver',
  );
  final january = Carbon.parse('2012-01-31T00:00:00Z');

  final buffer = StringBuffer()
    ..writeln('diffInHours -> ${ottawa.diffInHours(vancouver)}')
    ..writeln(
      'diffInHours (signed) -> ${vancouver.diffInHours(ottawa, absolute: false)}',
    )
    ..writeln(
      'diffInDays addMonth -> ${january.diffInDays(january.copy()..addMonth())}',
    )
    ..writeln(
      'diffInDays subMonth signed -> ${january.diffInDays(january.copy()..subMonth(), absolute: false)}',
    )
    ..writeln(
      'diffInMinutes +59s -> ${january.diffInMinutes(january.copy()..addSeconds(59))}',
    )
    ..writeln(
      'diffInMinutes +120s -> ${january.diffInMinutes(january.copy()..addSeconds(120))}',
    )
    ..writeln(
      'secondsSinceMidnight -> ${(january.copy()..addSeconds(120)).secondsSinceMidnight()}',
    );

  return ExampleRun(
    code: _diffUnitsSource,
    output: buffer.toString().trimRight(),
  );
}

const _floatDiffSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
  final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
  final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
  final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
  final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
  final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
  final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
  final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
  final monthStart = Carbon.parse('2000-01-15T00:00:00Z');
  final monthEnd = Carbon.parse('2000-02-24T00:00:00Z');
  final monthChunkStart = Carbon.parse('2000-02-15T12:00:00Z');
  final monthChunkEnd = Carbon.parse('2000-03-24T06:00:00Z');
  final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
  final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');

  print('floatDiffInSeconds -> '
      '${secondsStart.floatDiffInSeconds(secondsEnd)}');
  print('floatDiffInMinutes -> '
      '${minutesStart.floatDiffInMinutes(minutesEnd)}');
  print('floatDiffInHours (absolute) -> '
      '${minutesStart.floatDiffInHours(minutesEnd)}');
  print('floatDiffInHours (signed) -> '
      '${signedStart.floatDiffInHours(signedEnd, absolute: false)}');
  print('floatDiffInDays -> ${dayStart.floatDiffInDays(dayEnd)}');
  print('floatDiffInWeeks -> ${weekStart.floatDiffInWeeks(weekEnd)}');
  print('floatDiffInMonths -> ${monthStart.floatDiffInMonths(monthEnd)}');
  print('floatDiffInMonths (chunked) -> '
      '${monthChunkStart.floatDiffInMonths(monthChunkEnd)}');
  print('floatDiffInYears -> ${yearsStart.floatDiffInYears(yearsEnd)}');
}
''';

/// Demonstrates `floatDiffIn*` helpers for fractional deltas.
Future<ExampleRun> runFloatDiffExample() async {
  await _bootstrap();
  final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
  final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
  final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
  final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
  final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
  final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
  final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
  final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
  final monthStart = Carbon.parse('2000-01-15T00:00:00Z');
  final monthEnd = Carbon.parse('2000-02-24T00:00:00Z');
  final monthChunkStart = Carbon.parse('2000-02-15T12:00:00Z');
  final monthChunkEnd = Carbon.parse('2000-03-24T06:00:00Z');
  final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
  final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');

  final buffer = StringBuffer()
    ..writeln(
      'floatDiffInSeconds -> '
      '${secondsStart.floatDiffInSeconds(secondsEnd)}',
    )
    ..writeln(
      'floatDiffInMinutes -> '
      '${minutesStart.floatDiffInMinutes(minutesEnd)}',
    )
    ..writeln(
      'floatDiffInHours (absolute) -> '
      '${minutesStart.floatDiffInHours(minutesEnd)}',
    )
    ..writeln(
      'floatDiffInHours (signed) -> '
      '${signedStart.floatDiffInHours(signedEnd, absolute: false)}',
    )
    ..writeln('floatDiffInDays -> ${dayStart.floatDiffInDays(dayEnd)}')
    ..writeln('floatDiffInWeeks -> ${weekStart.floatDiffInWeeks(weekEnd)}')
    ..writeln('floatDiffInMonths -> ${monthStart.floatDiffInMonths(monthEnd)}')
    ..writeln(
      'floatDiffInMonths (chunked) -> '
      '${monthChunkStart.floatDiffInMonths(monthChunkEnd)}',
    )
    ..writeln('floatDiffInYears -> ${yearsStart.floatDiffInYears(yearsEnd)}');

  return ExampleRun(
    code: _floatDiffSource,
    output: buffer.toString().trimRight(),
  );
}

const _durationDiffSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final base = Carbon.parse('2012-01-01T00:00:00Z');
  final future = base.copy()..addYears(3)..addDays(10)..addHours(12);
  final delta = future.diff(base);

  print('diff() Duration days -> ${delta.inDays}');
  print('diff() Duration hours -> ${delta.inHours}');
}
''';

/// Highlights `diff()` returning a `Duration` in Dart.
Future<ExampleRun> runDurationDiffExample() async {
  await initializeDateFormatting('en');
  final base = Carbon.parse('2012-01-01T00:00:00Z');
  final future = base.copy()
    ..addYears(3)
    ..addDays(10)
    ..addHours(12);
  final delta = future.diff(base);
  final buffer = StringBuffer()
    ..writeln('diff() Duration days -> ${delta.inDays}')
    ..writeln('diff() Duration hours -> ${delta.inHours}');
  return ExampleRun(
    code: _durationDiffSource,
    output: buffer.toString().trimRight(),
  );
}

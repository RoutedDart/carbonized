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

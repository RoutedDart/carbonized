/// Runnable snippets for the "Difference for Humans" section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _humanReadableSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final fiveHoursAgo = now.copy()..subHours(5);
  final nextWeek = now.copy()..addWeek();

  print('five hours ago -> ${fiveHoursAgo.diffForHumans(reference: now)}');
  print('relative to future -> ${now.diffForHumans(reference: nextWeek)}');
  print('to future instant -> ${nextWeek.diffForHumans(reference: now)}');
}
''';

/// Demonstrates the basic `diffForHumans` usage backed by `timeago`.
Future<ExampleRun> runHumanReadableExample() async {
  await _bootstrap();
  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final fiveHoursAgo = now.copy()..subHours(5);
  final nextWeek = now.copy()..addWeek();
  final buffer = StringBuffer()
    ..writeln('five hours ago -> ${fiveHoursAgo.diffForHumans(reference: now)}')
    ..writeln('relative to future -> ${now.diffForHumans(reference: nextWeek)}')
    ..writeln('to future instant -> ${nextWeek.diffForHumans(reference: now)}');
  return ExampleRun(
    code: _humanReadableSource,
    output: buffer.toString().trimRight(),
  );
}

const _humanReadableDetailSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final now = Carbon.parse('2024-01-01T00:00:00Z');
  final horizon = now.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(3)
    ..addHours(4);

  print('multi unit -> ${horizon.diffForHumans(reference: now, parts: 3)}');
  print('short join -> ${horizon.diffForHumans(reference: now, parts: 2, short: true, joiner: ', ')}');
  print('just now -> ${now.diffForHumans(reference: now, parts: 2)}');
}
''';

Future<ExampleRun> runHumanReadableDetailExample() async {
  await _bootstrap();
  final now = Carbon.parse('2024-01-01T00:00:00Z');
  final horizon = now.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(3)
    ..addHours(4);
  final buffer = StringBuffer()
    ..writeln(
      'multi unit -> ${horizon.diffForHumans(reference: now, parts: 3)}',
    )
    ..writeln(
      'short join -> ${horizon.diffForHumans(reference: now, parts: 2, short: true, joiner: ', ')}',
    )
    ..writeln('just now -> ${now.diffForHumans(reference: now)}');
  return ExampleRun(
    code: _humanReadableDetailSource,
    output: buffer.toString().trimRight(),
  );
}

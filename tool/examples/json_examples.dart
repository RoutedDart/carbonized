/// Runnable snippets for the "JSON" documentation section.
library;

import 'dart:async';
import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _jsonSource = r'''
import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  print('json -> ${jsonEncode(dt)}');

  final payload = {
    'iso': '2012-12-25T20:30:00.000000+04:00',
    'timeZone': 'Europe/Moscow',
  };
  final fromJson = Carbon.fromJson(jsonEncode(payload));
  print('fromJson zone -> ${fromJson.timeZoneName}');
}
''';

/// Shows built-in JSON encoding and the `Carbon.fromJson` helper.
Future<ExampleRun> runJsonExample() async {
  await _bootstrap();
  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  final payload = {
    'iso': '2012-12-25T20:30:00.000000+04:00',
    'timeZone': 'Europe/Moscow',
  };
  final fromJson = Carbon.fromJson(jsonEncode(payload));
  final buffer = StringBuffer()
    ..writeln('json -> ${jsonEncode(dt)}')
    ..writeln('fromJson zone -> ${fromJson.timeZoneName}');
  return ExampleRun(code: _jsonSource, output: buffer.toString().trimRight());
}

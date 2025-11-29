/// Runnable snippets for the "Serialization" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _serializeSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  final serialized = dt.serialize();
  final roundTrip = Carbon.fromSerialized(serialized);

  print('serialized length -> ${serialized.length}');
  print('roundTrip iso -> ${roundTrip.toIso8601String(keepOffset: true)}');
  print('roundTrip zone -> ${roundTrip.timeZoneName}');
}
''';

/// Demonstrates `serialize()` / `Carbon.fromSerialized()` round-trip.
Future<ExampleRun> runSerializationExample() async {
  final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
  final serialized = dt.serialize();
  final roundTrip = Carbon.fromSerialized(serialized);
  final buffer = StringBuffer()
    ..writeln('serialized length -> ${serialized.length}')
    ..writeln('roundTrip iso -> ${roundTrip.toIso8601String(keepOffset: true)}')
    ..writeln('roundTrip zone -> ${roundTrip.timeZoneName}');
  return ExampleRun(
    code: _serializeSource,
    output: buffer.toString().trimRight(),
  );
}

const _customSerializeSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  Carbon.serializeUsing((date) => 'CUSTOM:' + date.toIso8601String());

  final dt = Carbon.parse('2024-01-01T00:00:00Z');
  print('custom serialization -> ${dt.serialize()}');
  Carbon.resetSerializationFormat();
}
''';

Future<ExampleRun> runCustomSerializationExample() async {
  Carbon.serializeUsing((date) => 'CUSTOM:${date.toIso8601String()}');
  final dt = Carbon.parse('2024-01-01T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('custom serialization -> ${dt.serialize()}');
  Carbon.resetSerializationFormat();
  return ExampleRun(
    code: _customSerializeSource,
    output: buffer.toString().trimRight(),
  );
}

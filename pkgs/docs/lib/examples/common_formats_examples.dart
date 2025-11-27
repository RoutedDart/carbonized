/// Runnable snippets for the "Common Formats" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _commonFormatsSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');

  print('toAtomString -> ${dt.toAtomString()}');
  print('toIso8601String -> ${dt.toIso8601String()}');
  print('toIso8601ZuluString -> ${dt.toIso8601ZuluString()}');
  print('toISOString -> ${dt.toISOString()}');
  print('toJSON -> ${dt.toJSON()}');
  print('toDateTimeLocalString -> ${dt.toDateTimeLocalString()}');
  print('toRfc1123String -> ${dt.toRfc1123String()}');
  print('toRfc3339String -> ${dt.toRfc3339String()}');
  print('toRfc7231String -> ${dt.toRfc7231String()}');
  print('toW3cString -> ${dt.toW3cString()}');
}
''';

/// Demonstrates Carbon's `toXXXString` helpers for standard RFC/ISO outputs.
Future<ExampleRun> runCommonFormatsExample() async {
  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');
  final buffer = StringBuffer()
    ..writeln('toAtomString -> ${dt.toAtomString()}')
    ..writeln('toIso8601String -> ${dt.toIso8601String()}')
    ..writeln('toIso8601ZuluString -> ${dt.toIso8601ZuluString()}')
    ..writeln('toISOString -> ${dt.toISOString()}')
    ..writeln('toJSON -> ${dt.toJSON()}')
    ..writeln('toDateTimeLocalString -> ${dt.toDateTimeLocalString()}')
    ..writeln('toRfc1123String -> ${dt.toRfc1123String()}')
    ..writeln('toRfc3339String -> ${dt.toRfc3339String()}')
    ..writeln('toRfc7231String -> ${dt.toRfc7231String()}')
    ..writeln('toW3cString -> ${dt.toW3cString()}');
  return ExampleRun(
    code: _commonFormatsSource,
    output: buffer.toString().trimRight(),
  );
}

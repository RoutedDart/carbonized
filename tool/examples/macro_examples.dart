/// Runnable snippets for the "Macro" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.resetMacros();
}

const _macroSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  Carbon.resetMacros();
Carbon.registerMacro('businessEndOfWeek', (carbon, positionalArguments, namedArguments) {
  final date = carbon.copy()..nextWeekday();
  return date.endOfWeek();
});

  final dynamic carbon = Carbon.parse('2024-06-05T12:00:00Z');
  final result = carbon.businessEndOfWeek();
  print('macro result -> ${result.toIso8601String()}');
}
''';

/// Demonstrates registering and invoking a macro.
Future<ExampleRun> runMacroExample() async {
  await _bootstrap();
  Carbon.registerMacro('businessEndOfWeek', (carbon, positionalArguments, namedArguments) {
    final date = carbon.copy()..nextWeekday();
    return date.endOfWeek();
  });
  final dynamic carbon = Carbon.parse('2024-06-05T12:00:00Z');
  final result = carbon.businessEndOfWeek();
  final buffer = StringBuffer()
    ..writeln('macro result -> ${result.toIso8601String()}');
  return ExampleRun(code: _macroSource, output: buffer.toString().trimRight());
}

/// Runnable snippets for the "Addition and Subtraction" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _incrementSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2012-01-31T00:00:00Z');
  print('addYears -> ${(base.copy()..addYears(1)).toIso8601String()}');
  print('addMonths -> ${(base.copy()..addMonths(1)).toIso8601String()}');
  print('addWeekdays -> ${(base.copy()..addWeekdays(4)).toIso8601String()}');
  print('addWeeks -> ${(base.copy()..addWeeks(3)).toIso8601String()}');
  print('addHours -> ${(base.copy()..addHours(24)).toIso8601String()}');
  print('addRealHours -> ${(base.copy()..addRealHours(36)).toIso8601String()}');
}
''';

/// Mirrors the PHP docs' additive helpers (years, months, weekdays, etc.).
Future<ExampleRun> runIncrementExample() async {
  await _bootstrap();
  final base = Carbon.parse('2012-01-31T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('addYears -> ${(base.copy()..addYears(1)).toIso8601String()}')
    ..writeln('addMonths -> ${(base.copy()..addMonths(1)).toIso8601String()}')
    ..writeln(
      'addWeekdays -> ${(base.copy()..addWeekdays(4)).toIso8601String()}',
    )
    ..writeln('addWeeks -> ${(base.copy()..addWeeks(3)).toIso8601String()}')
    ..writeln('addHours -> ${(base.copy()..addHours(24)).toIso8601String()}')
    ..writeln(
      'addRealHours -> ${(base.copy()..addRealHours(36)).toIso8601String()}',
    );
  return ExampleRun(
    code: _incrementSource,
    output: buffer.toString().trimRight(),
  );
}

const _genericAddSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2012-02-03T00:00:00Z');
  print("add(Duration(days: 1)) -> ${(dt.copy()..add(const Duration(days: 1))).toIso8601String()}");
  print("sub(Duration(hours: 3)) -> ${(dt.copy()..sub(const Duration(hours: 3))).toIso8601String()}");
  print("change('next friday') -> ${(dt.copy()..change('next friday')).toIso8601String()}");
}
''';

/// Shows `add(Duration)`, `sub(Duration)`, and the `change()` shorthand.
Future<ExampleRun> runGenericAddExample() async {
  await _bootstrap();
  final dt = Carbon.parse('2012-02-03T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln(
      "add(Duration(days: 1)) -> ${(dt.copy()..add(const Duration(days: 1))).toIso8601String()}",
    )
    ..writeln(
      "sub(Duration(hours: 3)) -> ${(dt.copy()..sub(const Duration(hours: 3))).toIso8601String()}",
    )
    ..writeln(
      "change('next friday') -> ${(dt.copy()..change('next friday')).toIso8601String()}",
    );
  return ExampleRun(
    code: _genericAddSource,
    output: buffer.toString().trimRight(),
  );
}

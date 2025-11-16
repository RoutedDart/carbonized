/// Runnable snippets for the "Conversion" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _snapshotSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');
  final array = dt.toArray();
  final components = dt.toObject();

  print('array year -> ${array['year']}');
  print('array timezone -> ${array['timezone']}');
  print('components formatted -> ${components.formatted}');
  print('components timestamp -> ${components.timestamp}');
}
''';

/// Demonstrates `toArray()`/`toObject()` parity with PHP Carbon.
Future<ExampleRun> runConversionSnapshotExample() async {
  await _bootstrap();
  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');
  final array = dt.toArray();
  final components = dt.toObject();
  final buffer = StringBuffer()
    ..writeln('array year -> ${array['year']}')
    ..writeln('array timezone -> ${array['timezone']}')
    ..writeln('components formatted -> ${components.formatted}')
    ..writeln('components timestamp -> ${components.timestamp}');
  return ExampleRun(
    code: _snapshotSource,
    output: buffer.toString().trimRight(),
  );
}

const _dateTimeConversionSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final dt = Carbon.parse('2019-02-01T03:45:27Z', timeZone: 'Europe/Paris');
  final asDateTime = dt.toDateTime();
  final asImmutable = dt.toDateTimeImmutable();
  final view = dt.toDateTimeView();
  final immutable = dt.toImmutable();
  final backToMutable = immutable.toMutable();

  print('toDateTime zone -> ${asDateTime.timeZoneName}');
  print('toDateTimeImmutable type -> ${asImmutable.runtimeType}');
  print('DateTime view weekday -> ${view.weekday}');
  print('immutable runtimeType -> ${immutable.runtimeType}');
  print('toMutable runtimeType -> ${backToMutable.runtimeType}');
}
''';

/// Converts to `DateTime`, `DateTimeImmutable`, and between mutable/immutable Carbon.
Future<ExampleRun> runDateTimeConversionExample() async {
  await _bootstrap();
  final dt = Carbon.parse('2019-02-01T03:45:27Z', timeZone: 'Europe/Paris');
  final asDateTime = dt.toDateTime();
  final asImmutable = dt.toDateTimeImmutable();
  final view = dt.toDateTimeView();
  final immutable = dt.toImmutable();
  final backToMutable = immutable.toMutable();
  final buffer = StringBuffer()
    ..writeln('toDateTime zone -> ${asDateTime.timeZoneName}')
    ..writeln('toDateTimeImmutable type -> ${asImmutable.runtimeType}')
    ..writeln('DateTime view weekday -> ${view.weekday}')
    ..writeln('immutable runtimeType -> ${immutable.runtimeType}')
    ..writeln('toMutable runtimeType -> ${backToMutable.runtimeType}');
  return ExampleRun(
    code: _dateTimeConversionSource,
    output: buffer.toString().trimRight(),
  );
}

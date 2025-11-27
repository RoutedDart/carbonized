/// Runnable snippets for the "Conversion" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

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

const _carbonizeSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse(
    '2019-02-01T03:45:27.612584',
    timeZone: 'Europe/Paris',
  );
  final fromString = base.carbonize('2019-03-21');
  final period = base.carbonize(base.daysUntil('2019-12-10'));
  final interval = base.carbonize(CarbonInterval.days(3));
  final duration = base.carbonize(const Duration(hours: 12));

  print('carbonize string -> ${fromString.toIso8601String(keepOffset: true)}');
  print('carbonize period -> ${period.toIso8601String(keepOffset: true)}');
  print('carbonize interval -> ${interval.toIso8601String(keepOffset: true)}');
  print('carbonize duration -> ${duration.toIso8601String(keepOffset: true)}');
}
''';

/// Demonstrates PHP-style `carbonize()` inputs.
Future<ExampleRun> runCarbonizeExample() async {
  final base = Carbon.parse(
    '2019-02-01T03:45:27.612584',
    timeZone: 'Europe/Paris',
  );
  final fromString = base.carbonize('2019-03-21');
  final period = base.carbonize(base.daysUntil('2019-12-10'));
  final interval = base.carbonize(CarbonInterval.days(3));
  final duration = base.carbonize(const Duration(hours: 12));
  final buffer = StringBuffer()
    ..writeln(
      'carbonize string -> ${fromString.toIso8601String(keepOffset: true)}',
    )
    ..writeln('carbonize period -> ${period.toIso8601String(keepOffset: true)}')
    ..writeln(
      'carbonize interval -> ${interval.toIso8601String(keepOffset: true)}',
    )
    ..writeln(
      'carbonize duration -> ${duration.toIso8601String(keepOffset: true)}',
    );
  return ExampleRun(
    code: _carbonizeSource,
    output: buffer.toString().trimRight(),
  );
}

const _castSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final source = Carbon.parse('2015-01-01T00:00:00Z');
  final casted = Carbon.cast(source);
  final immutable = CarbonImmutable.cast(source);

  print('cast type -> ${casted.runtimeType}');
  print('cast iso -> ${casted.toIso8601String()}');
  print('immutable -> ${immutable.runtimeType}');
}
''';

Future<ExampleRun> runCastExample() async {
  final source = Carbon.parse('2015-01-01T00:00:00Z');
  final casted = Carbon.cast(source);
  final immutable = CarbonImmutable.cast(source);
  final buffer = StringBuffer()
    ..writeln('cast type -> ${casted.runtimeType}')
    ..writeln('cast iso -> ${casted.toIso8601String()}')
    ..writeln('immutable -> ${immutable.runtimeType}');
  return ExampleRun(code: _castSource, output: buffer.toString().trimRight());
}

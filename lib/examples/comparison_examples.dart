/// Runnable snippets for the "Comparison" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _orderingSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final first = Carbon.parse('2012-09-05T23:26:11Z');
  final second = Carbon.parse(
    '2012-09-05T20:26:11',
    timeZone: 'America/Vancouver',
  );

  print('equalTo -> ${first.equalTo(second)}');
  print('notEqualTo -> ${first.notEqualTo(second)}');
  print('greaterThan -> ${first.greaterThan(second)}');
  print('lessThanOrEqual -> ${first.lessThanOrEqual(second)}');
  print('isAfter -> ${first.isAfter(second)}');
  print('isBefore -> ${first.isBefore(second)}');
}
''';

/// Shows timezone-aware equality/ordering helpers.
Future<ExampleRun> runOrderingExample() async {
  final first = Carbon.parse('2012-09-05T23:26:11Z');
  final second = Carbon.parse(
    '2012-09-05T20:26:11',
    timeZone: 'America/Vancouver',
  );
  final buffer = StringBuffer()
    ..writeln('equalTo -> ${first.equalTo(second)}')
    ..writeln('notEqualTo -> ${first.notEqualTo(second)}')
    ..writeln('greaterThan -> ${first.greaterThan(second)}')
    ..writeln('lessThanOrEqual -> ${first.lessThanOrEqual(second)}')
    ..writeln('isAfter -> ${first.isAfter(second)}')
    ..writeln('isBefore -> ${first.isBefore(second)}');
  return ExampleRun(
    code: _orderingSource,
    output: buffer.toString().trimRight(),
  );
}

const _rangesSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final start = Carbon.parse('2012-09-05T01:00:00Z');
  final end = Carbon.parse('2012-09-05T05:00:00Z');
  print('3am between -> ${Carbon.parse('2012-09-05T03:00:00Z').between(start, end)}');
  print('5am between (inclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').betweenIncluded(start, end)}');
  print('5am between (exclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').between(start, end, inclusive: false)}');

  final dt1 = Carbon.parse('2010-04-01T00:00:00Z');
  final dt2 = Carbon.parse('2010-03-28T00:00:00Z');
  final dt3 = Carbon.parse('2010-04-16T00:00:00Z');
  print('min -> ${dt1.min(dt2).toIso8601String()}');
  print('max -> ${dt1.max(dt3).toIso8601String()}');
  print('closest -> ${dt1.closest(dt2, dt3).toIso8601String()}');
  print('farthest -> ${dt1.farthest(dt2, dt3).toIso8601String()}');
}
''';

/// Demonstrates `between`, `min`/`max`, and closest/farthest helpers.
Future<ExampleRun> runRangeExample() async {
  final start = Carbon.parse('2012-09-05T01:00:00Z');
  final end = Carbon.parse('2012-09-05T05:00:00Z');
  final dt1 = Carbon.parse('2010-04-01T00:00:00Z');
  final dt2 = Carbon.parse('2010-03-28T00:00:00Z');
  final dt3 = Carbon.parse('2010-04-16T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln(
      '3am between -> ${Carbon.parse('2012-09-05T03:00:00Z').between(start, end)}',
    )
    ..writeln(
      '5am between (inclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').betweenIncluded(start, end)}',
    )
    ..writeln(
      '5am between (exclusive) -> ${Carbon.parse('2012-09-05T05:00:00Z').between(start, end, inclusive: false)}',
    )
    ..writeln('min -> ${dt1.min(dt2).toIso8601String()}')
    ..writeln('max -> ${dt1.max(dt3).toIso8601String()}')
    ..writeln('closest -> ${dt1.closest(dt2, dt3).toIso8601String()}')
    ..writeln('farthest -> ${dt1.farthest(dt2, dt3).toIso8601String()}');
  return ExampleRun(code: _rangesSource, output: buffer.toString().trimRight());
}

const _predicatesSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final reference = Carbon.parse('2024-06-05T12:00:00Z');
  final birthday = Carbon.parse('1987-04-23T00:00:00Z');

  print('isFuture -> ${reference.isFuture()}');
  print('isPast -> ${birthday.isPast()}');
  print('isSameMonth -> ${reference.isSameMonth(reference.copy().addDays(10))}');
  print('isCurrentYear -> ${reference.isCurrentYear()}');
  print('isWeekend -> ${reference.isWeekend()}');
}
''';

/// Highlights boolean predicates such as `isFuture`, `isSameMonth`, and `isWeekend`.
Future<ExampleRun> runPredicateExample() async {
  final reference = Carbon.parse('2024-06-05T12:00:00Z');
  final birthday = Carbon.parse('1987-04-23T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('isFuture -> ${reference.isFuture()}')
    ..writeln('isPast -> ${birthday.isPast()}')
    ..writeln(
      'isSameMonth -> ${reference.isSameMonth(reference.copy().addDays(10))}',
    )
    ..writeln('isCurrentYear -> ${reference.isCurrentYear()}')
    ..writeln('isWeekend -> ${reference.isWeekend()}');
  return ExampleRun(
    code: _predicatesSource,
    output: buffer.toString().trimRight(),
  );
}

const _stringMatcherSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  final dt = Carbon.parse('2019-06-02T12:23:45Z');

  print("matches('2019') -> ${dt.matches('2019')}");
  print("matches('Sunday') -> ${dt.matches('Sunday')}");
  print("matches('2019-06') -> ${dt.matches('2019-06')}");
  print("matches('12:23') -> ${dt.matches('12:23')}");
  print("matches('3pm') -> ${dt.matches('3pm')}");
}
''';

/// Demonstrates the Dart replacement for PHP's `is()` helper.
Future<ExampleRun> runStringMatcherExample() async {
  final dt = Carbon.parse('2019-06-02T12:23:45Z');
  final buffer = StringBuffer()
    ..writeln("matches('2019') -> ${dt.matches('2019')}")
    ..writeln("matches('Sunday') -> ${dt.matches('Sunday')}")
    ..writeln("matches('2019-06') -> ${dt.matches('2019-06')}")
    ..writeln("matches('12:23') -> ${dt.matches('12:23')}")
    ..writeln("matches('3pm') -> ${dt.matches('3pm')}");
  return ExampleRun(
    code: _stringMatcherSource,
    output: buffer.toString().trimRight(),
  );
}

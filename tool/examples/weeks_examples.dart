/// Runnable snippets for the "Weeks" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('ar');
  await Carbon.configureTimeMachine(testing: true);
}

const _localeWeekSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('ar');

  Carbon.setLocale('en_US');
  final en = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('ar');
  final ar = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('en');

  print('en startOfWeek -> ${en.startOfWeek().isoFormat('YYYY-MM-DD')}');
  print('en endOfWeek -> ${en.endOfWeek().isoFormat('YYYY-MM-DD')}');
  print('ar startOfWeek -> ${ar.startOfWeek().isoFormat('YYYY-MM-DD')}');
  print('ar endOfWeek -> ${ar.endOfWeek().isoFormat('YYYY-MM-DD')}');
}
''';

/// Shows how locale metadata drives start/end of week calculations.
Future<ExampleRun> runLocaleWeekExample() async {
  await _bootstrap();
  Carbon.setLocale('en_US');
  final en = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('ar');
  final ar = Carbon.parse('2025-11-12T00:00:00Z');
  Carbon.setLocale('en');

  final buffer = StringBuffer()
    ..writeln('en startOfWeek -> ${en.startOfWeek().isoFormat('YYYY-MM-DD')}')
    ..writeln('en endOfWeek -> ${en.endOfWeek().isoFormat('YYYY-MM-DD')}')
    ..writeln('ar startOfWeek -> ${ar.startOfWeek().isoFormat('YYYY-MM-DD')}')
    ..writeln('ar endOfWeek -> ${ar.endOfWeek().isoFormat('YYYY-MM-DD')}');

  return ExampleRun(
    code: _localeWeekSource,
    output: buffer.toString().trimRight(),
  );
}

const _weekNumbersSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2017-02-05T00:00:00Z');
  print('localeWeek -> ${date.localeWeek}');
  print('isoWeek -> ${date.isoWeek}');
  print('localeWeekYear -> ${date.localeWeekYear}');
  print('isoWeekYear -> ${date.isoWeekYear}');
  print('weeksInYear -> ${date.weeksInYear}');
  print('isoWeeksInYear -> ${date.isoWeeksInYear}');
}
''';

/// Outputs the locale-aware week and ISO week numbers for a sample date.
Future<ExampleRun> runWeekNumbersExample() async {
  await _bootstrap();
  final date = Carbon.parse('2017-02-05T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('localeWeek -> ${date.localeWeek}')
    ..writeln('isoWeek -> ${date.isoWeek}')
    ..writeln('localeWeekYear -> ${date.localeWeekYear}')
    ..writeln('isoWeekYear -> ${date.isoWeekYear}')
    ..writeln('weeksInYear -> ${date.weeksInYear}')
    ..writeln('isoWeeksInYear -> ${date.isoWeeksInYear}');
  return ExampleRun(
    code: _weekNumbersSource,
    output: buffer.toString().trimRight(),
  );
}

const _weekdayAdjustSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2017-02-05T00:00:00Z');
  final weekday = date.copy()..setDayOfWeek(DateTime.wednesday);

  print('weekday -> ${weekday.toIso8601String()}');
}
''';

/// Reprojects an instant onto a different weekday without touching other parts.
Future<ExampleRun> runWeekdayAdjustExample() async {
  await _bootstrap();
  final date = Carbon.parse('2017-02-05T00:00:00Z');
  final weekday = date.copy()..setDayOfWeek(DateTime.wednesday);
  final buffer = StringBuffer()
    ..writeln('weekday -> ${weekday.toIso8601String()}');
  return ExampleRun(
    code: _weekdayAdjustSource,
    output: buffer.toString().trimRight(),
  );
}

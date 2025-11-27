/// Runnable snippets for the "Weeks" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

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

const _weekSetterSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-06-05T00:00:00Z');
  final week = date.weekNumber();
  final moved = date.copy().setWeekNumber(week + 2);
  final isoMoved = date.copy().setIsoWeekNumber(2);

  print('weekNumber -> $week');
  print('setWeekNumber(week+2) -> ${moved.isoFormat('YYYY-MM-DD')}');
  print('setIsoWeekNumber(2) -> ${isoMoved.isoFormat('YYYY-MM-DD')}');
}
''';

Future<ExampleRun> runWeekSetterExample() async {
  final date = Carbon.parse('2024-06-05T00:00:00Z');
  final week = date.weekNumber();
  final moved = date.copy().setWeekNumber(week + 2);
  final isoMoved = date.copy().setIsoWeekNumber(2);
  final buffer = StringBuffer()
    ..writeln('weekNumber -> $week')
    ..writeln('setWeekNumber(week+2) -> ${moved.isoFormat('YYYY-MM-DD')}')
    ..writeln('setIsoWeekNumber(2) -> ${isoMoved.isoFormat('YYYY-MM-DD')}');
  return ExampleRun(
    code: _weekSetterSource,
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
  final date = Carbon.parse('2017-02-05T00:00:00Z');
  final weekday = date.copy()..setDayOfWeek(DateTime.wednesday);
  final buffer = StringBuffer()
    ..writeln('weekday -> ${weekday.toIso8601String()}');
  return ExampleRun(
    code: _weekdayAdjustSource,
    output: buffer.toString().trimRight(),
  );
}

const _daysFromStartSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-06-05T00:00:00Z');
  print('default days -> ${date.getDaysFromStartOfWeek()}');
  print("sunday start -> ${date.getDaysFromStartOfWeek('sunday')}");

  final monday = date.copy()..setDaysFromStartOfWeek(0);
  final tuesdayFromSunday = date.copy()..setDaysFromStartOfWeek(2, 'sunday');

  print('setDaysFromStartOfWeek(0) -> ${monday.toIso8601String()}');
  print("setDaysFromStartOfWeek(2, 'sunday') -> ${tuesdayFromSunday.toIso8601String()}");
}
''';

/// Demonstrates `getDaysFromStartOfWeek()` / `setDaysFromStartOfWeek()` parity.
Future<ExampleRun> runDaysFromStartExample() async {
  final date = Carbon.parse('2024-06-05T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('default days -> ${date.getDaysFromStartOfWeek()}')
    ..writeln("sunday start -> ${date.getDaysFromStartOfWeek('sunday')}");
  final monday = date.copy()..setDaysFromStartOfWeek(0);
  final tuesday = date.copy()..setDaysFromStartOfWeek(2, 'sunday');
  buffer
    ..writeln('setDaysFromStartOfWeek(0) -> ${monday.toIso8601String()}')
    ..writeln(
      "setDaysFromStartOfWeek(2, 'sunday') -> ${tuesday.toIso8601String()}",
    );
  return ExampleRun(
    code: _daysFromStartSource,
    output: buffer.toString().trimRight(),
  );
}

/// Runnable snippets for the "String Formatting" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
}

const _basicFormattingSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('1975-12-25T14:15:16-05:00');

  print('toDateString -> ${dt.toDateString()}');
  print('toFormattedDateString -> ${dt.toFormattedDateString()}');
  print('toFormattedDayDateString -> ${dt.toFormattedDayDateString()}');
  print('toTimeString -> ${dt.toTimeString()}');
  print('toDateTimeString -> ${dt.toDateTimeString()}');
  print('toDayDateTimeString -> ${dt.toDayDateTimeString()}');
  print("format('EEEE d of MMMM y h:mm:ss a') -> "
      "${dt.format("EEEE d 'of' MMMM y h:mm:ss a")}");
}
''';

/// Mirrors the PHP docs' toXXXString helpers and `format()` usage.
Future<ExampleRun> runBasicFormattingExample() async {
  await _bootstrap();
  final dt = Carbon.parse('1975-12-25T14:15:16-05:00');
  final buffer = StringBuffer()
    ..writeln('toDateString -> ${dt.toDateString()}')
    ..writeln('toFormattedDateString -> ${dt.toFormattedDateString()}')
    ..writeln('toFormattedDayDateString -> ${dt.toFormattedDayDateString()}')
    ..writeln('toTimeString -> ${dt.toTimeString()}')
    ..writeln('toDateTimeString -> ${dt.toDateTimeString()}')
    ..writeln('toDayDateTimeString -> ${dt.toDayDateTimeString()}')
    ..writeln(
      "format('EEEE d of MMMM y h:mm:ss a') -> "
      "${dt.format("EEEE d 'of' MMMM y h:mm:ss a")}",
    );
  return ExampleRun(
    code: _basicFormattingSource,
    output: buffer.toString().trimRight(),
  );
}

const _customToStringSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final dt = Carbon.parse('1975-12-25T14:15:16Z');
  print('default toString -> $dt');

  Carbon.setToStringFormat('EEEE, MMMM d, y h:mm:ss a');
  print('global override -> $dt');
  Carbon.resetToStringFormat();

  final custom = dt.copy().withToStringFormat((value) => value.isoFormat('LLLL'));
  print('instance override -> $custom');
  print('startOfWeek setting -> ${dt.settings.startOfWeek}');
}
''';

/// Shows `setToStringFormat`, `withToStringFormat`, and settings exposure.
Future<ExampleRun> runCustomToStringExample() async {
  await _bootstrap();
  final dt = Carbon.parse('1975-12-25T14:15:16Z');
  final buffer = StringBuffer()..writeln('default toString -> $dt');
  Carbon.setToStringFormat('EEEE, MMMM d, y h:mm:ss a');
  buffer.writeln('global override -> $dt');
  Carbon.resetToStringFormat();
  final custom = dt.copy().withToStringFormat(
    (value) => value.isoFormat('LLLL'),
  );
  buffer
    ..writeln('instance override -> $custom')
    ..writeln('startOfWeek setting -> ${dt.settings.startOfWeek}');
  return ExampleRun(
    code: _customToStringSource,
    output: buffer.toString().trimRight(),
  );
}

const _isoFormatSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');

  final base = Carbon.parse('2024-02-29T18:45:12Z');
  print('English LLLL: ${base.locale('en').isoFormat('LLLL')}');
  print('French LLLL: ${base.locale('fr').isoFormat('LLLL')}');
  print('Custom ISO tokens: ${base.isoFormat('dddd [week] WW, HH:mm')}');
}
''';

/// Highlights `isoFormat` presets/tokens for locale-aware strings.
Future<ExampleRun> runIsoFormatExample() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');
  final base = Carbon.parse('2024-02-29T18:45:12Z');
  final buffer = StringBuffer()
    ..writeln('English LLLL: ${base.locale('en').isoFormat('LLLL')}')
    ..writeln('French LLLL: ${base.locale('fr').isoFormat('LLLL')}')
    ..writeln('Custom ISO tokens: ${base.isoFormat('dddd [week] WW, HH:mm')}');
  return ExampleRun(
    code: _isoFormatSource,
    output: buffer.toString().trimRight(),
  );
}

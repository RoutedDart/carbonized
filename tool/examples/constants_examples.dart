/// Runnable snippets for the "Constants" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

Future<void> _bootstrap() async {
  await Carbon.configureTimeMachine(testing: true);
}

const _constantsSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  print('DateTime.saturday -> ${DateTime.saturday}');
  print('DateTime.sunday -> ${DateTime.sunday}');
  print('CarbonUnit.month index -> ${CarbonUnit.month.index}');
  print('CarbonUnit.year index -> ${CarbonUnit.year.index}');
}
''';

/// Shows how to reuse Dart's built-in weekday constants and `CarbonUnit` enum.
Future<ExampleRun> runConstantsExample() async {
  await _bootstrap();
  final buffer = StringBuffer()
    ..writeln('DateTime.saturday -> ${DateTime.saturday}')
    ..writeln('DateTime.sunday -> ${DateTime.sunday}')
    ..writeln('CarbonUnit.month index -> ${CarbonUnit.month.index}')
    ..writeln('CarbonUnit.year index -> ${CarbonUnit.year.index}');
  return ExampleRun(
    code: _constantsSource,
    output: buffer.toString().trimRight(),
  );
}

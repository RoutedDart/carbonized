/// Runnable snippets backing the Introduction documentation page.
library;

import 'dart:async';
import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const introductionExampleSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final mutable = Carbon.parse('2025-01-10T00:00:00Z');
  final immutable = CarbonImmutable.parse('2025-01-10T00:00:00Z');

  final modifiedMutable = mutable.addDays(1);
  final modifiedImmutable =
      CarbonImmutable.parse('2025-01-10T00:00:00Z').addDays(1);

  print('mutable === modifiedMutable: '\
      '${identical(mutable, modifiedMutable)}');
  print('mutable isoFormat: ${mutable.isoFormat('dddd D')}');
  print('modifiedMutable isoFormat: ${modifiedMutable.isoFormat('dddd D')}');

  print('immutable === modifiedImmutable: '
      '${identical(immutable, modifiedImmutable)}');
  print('immutable isoFormat: ${immutable.isoFormat('dddd D')}');
  print('modifiedImmutable isoFormat: ${modifiedImmutable.isoFormat('dddd D')}');

  final mutableFromImmutable = CarbonImmutable.now().toMutable();
  print('mutableFromImmutable isMutable: ${mutableFromImmutable.isMutable}');
  print('mutableFromImmutable isImmutable: '
      '${!mutableFromImmutable.isMutable}');

  final immutableFromMutable = Carbon.now().toImmutable();
  print('immutableFromMutable isMutable: ${immutableFromMutable.isMutable}');
  print('immutableFromMutable isImmutable: '
      '${!immutableFromMutable.isMutable}');

  final view = mutable.toDateTimeView();
  print('DateTime view weekday: ${view.weekday}');
}
''';

/// Recreates the PHP docs' mutability example with Carbon/CarbonImmutable.
Future<ExampleRun> runIntroductionExample() async {
  final buffer = StringBuffer();

  final mutable = Carbon.parse('2025-01-10T00:00:00Z');
  final immutable = CarbonImmutable.parse('2025-01-10T00:00:00Z');

  final modifiedMutable = mutable.addDays(1);
  final modifiedImmutable = CarbonImmutable.parse(
    '2025-01-10T00:00:00Z',
  ).addDays(1);

  buffer.writeln(
    'mutable === modifiedMutable: ${identical(mutable, modifiedMutable)}',
  );
  buffer.writeln('mutable isoFormat: ${mutable.isoFormat('dddd D')}');
  buffer.writeln(
    'modifiedMutable isoFormat: ${modifiedMutable.isoFormat('dddd D')}',
  );

  buffer.writeln(
    'immutable === modifiedImmutable: '
    '${identical(immutable, modifiedImmutable)}',
  );
  buffer.writeln('immutable isoFormat: ${immutable.isoFormat('dddd D')}');
  buffer.writeln(
    'modifiedImmutable isoFormat: ${modifiedImmutable.isoFormat('dddd D')}',
  );

  final mutableFromImmutable = CarbonImmutable.now().toMutable();
  buffer.writeln(
    'mutableFromImmutable isMutable: ${mutableFromImmutable.isMutable}',
  );
  buffer.writeln(
    'mutableFromImmutable isImmutable: ${!mutableFromImmutable.isMutable}',
  );

  final immutableFromMutable = Carbon.now().toImmutable();
  buffer.writeln(
    'immutableFromMutable isMutable: ${immutableFromMutable.isMutable}',
  );
  buffer.writeln(
    'immutableFromMutable isImmutable: ${!immutableFromMutable.isMutable}',
  );

  final view = mutable.toDateTimeView();
  buffer.writeln('DateTime view weekday: ${view.weekday}');

  return ExampleRun(
    code: introductionExampleSource,
    output: buffer.toString().trimRight(),
  );
}

/// Temporary entry point for verifying the snippet manually.
Future<void> main() async {
  final result = await runIntroductionExample();
  print(result.output);
}

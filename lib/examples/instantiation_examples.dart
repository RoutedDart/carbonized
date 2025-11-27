/// Runnable snippets for the "Instantiation" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'example_runner.dart';

const _constructorsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-01-15T10:00:00Z');

  final implicitNow = Carbon();
  final viaString = Carbon('first day of January 2008', 'America/Vancouver');
  final fromDateTime = Carbon(DateTime.utc(2008, 1, 1), 'America/Vancouver');
  final londonNow = Carbon.now(timeZone: 'Europe/London');
  final fixedOffset = Carbon.now(timeZone: '+13:30');

  print('implicitNow: ${implicitNow.toIso8601String()}');
  print(
    'viaString: ${viaString.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${viaString.timeZoneName})',
  );
  print('fromDateTime zone: ${fromDateTime.timeZoneName}');
  print('london offset: ${londonNow.isoFormat('ZZ')}');
  print('fixed offset name: ${fixedOffset.timeZoneName}');

  Carbon.setTestNow();
}
''';

/// Demonstrates constructors plus timezone arguments from the PHP docs.
Future<ExampleRun> runConstructorsExample() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-01-15T10:00:00Z');

  final implicitNow = Carbon();
  final viaString = Carbon('first day of January 2008', 'America/Vancouver');
  final fromDateTime = Carbon(DateTime.utc(2008, 1, 1), 'America/Vancouver');
  final londonNow = Carbon.now(timeZone: 'Europe/London');
  final fixedOffset = Carbon.now(timeZone: '+13:30');

  final buffer = StringBuffer()
    ..writeln('implicitNow: ${implicitNow.toIso8601String()}')
    ..writeln(
      'viaString: ${viaString.isoFormat('YYYY-MM-DD HH:mm')} '
      '(${viaString.timeZoneName})',
    )
    ..writeln('fromDateTime zone: ${fromDateTime.timeZoneName}')
    ..writeln('london offset: ${londonNow.isoFormat('ZZ')}')
    ..writeln('fixed offset name: ${fixedOffset.timeZoneName}');

  Carbon.setTestNow();

  return ExampleRun(
    code: _constructorsSource,
    output: buffer.toString().trimRight(),
  );
}

const _componentFactoriesSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-06-15T09:30:00-05:00');

  final christmas = Carbon.createFromDate(null, 12, 25);
  final y2k = Carbon.createFromDateTime(2000, 1, 1, 0, 0, 0)!;
  final alsoY2k = Carbon.createFromDateTime(1999, 12, 31, 24)!;
  final noonLondon = Carbon.createFromTime(12, 0, 0, 0, 'Europe/London');
  final teaTime = Carbon.createFromTimeString('17:00:00', timeZone: 'Europe/London');
  final fromFormat = Carbon.createFromFormat('Y-m-d H', '1975-05-21 22');
  final viaMake = Carbon.make('2023-03-01');
  final invalidMake = Carbon.make('not a date');

  print('christmas defaults year: ${christmas.toIso8601String()}');
  print('y2k: ${y2k.toIso8601String()}');
  print('also y2k: ${alsoY2k.toIso8601String()}');
  print(
    'noon London: ${noonLondon.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${noonLondon.timeZoneName})',
  );
  print(
    'tea time: ${teaTime.isoFormat('YYYY-MM-DD HH:mm')} '
    '(${teaTime.timeZoneName})',
  );
  print('from format: ${fromFormat.toIso8601String()}');
  print('via make: ${viaMake?.toIso8601String()}');
  print('invalid make: $invalidMake');

  Carbon.setTestNow();
}
''';

/// Shows `create*` helpers, PHP-style factories, and the null-returning `make`.
Future<ExampleRun> runComponentFactoriesExample() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);
  Carbon.setTestNow('2024-06-15T09:30:00-05:00');

  final christmas = Carbon.createFromDate(null, 12, 25);
  final y2k = Carbon.createFromDateTime(2000, 1, 1, 0, 0, 0)!;
  final alsoY2K = Carbon.createFromDateTime(1999, 12, 31, 24)!;
  final noonLondon = Carbon.createFromTime(12, 0, 0, 0, 'Europe/London');
  final teaTime = Carbon.createFromTimeString(
    '17:00:00',
    timeZone: 'Europe/London',
  );
  final fromFormat = Carbon.createFromFormat('Y-m-d H', '1975-05-21 22');
  final viaMake = Carbon.make('2023-03-01');
  final invalidMake = Carbon.make('not a date');

  final buffer = StringBuffer()
    ..writeln('christmas defaults year: ${christmas.toIso8601String()}')
    ..writeln('y2k: ${y2k.toIso8601String()}')
    ..writeln('also y2k: ${alsoY2K.toIso8601String()}')
    ..writeln(
      'noon London: ${noonLondon.isoFormat('YYYY-MM-DD HH:mm')} '
      '(${noonLondon.timeZoneName})',
    )
    ..writeln(
      'tea time: ${teaTime.isoFormat('YYYY-MM-DD HH:mm')} '
      '(${teaTime.timeZoneName})',
    )
    ..writeln('from format: ${fromFormat.toIso8601String()}')
    ..writeln('via make: ${viaMake?.toIso8601String()}')
    ..writeln('invalid make: $invalidMake');

  Carbon.setTestNow();

  return ExampleRun(
    code: _componentFactoriesSource,
    output: buffer.toString().trimRight(),
  );
}

const _safeCreationSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final previousStrict = Carbon.isStrictModeEnabled();
  Carbon.useStrictMode(false);

  final overflow = Carbon.create(year: 2000, month: 1, day: 35, hour: 13);
  print('create overflow: ${overflow.toIso8601String()}');

  final safe = Carbon.createSafe(2000, 1, 35, 13, 0, 0);
  print('createSafe result: $safe');

  final skippedHour =
      Carbon.createSafe(2014, 3, 30, 1, 30, 0, 0, 'Europe/London');
  print('DST gap result: $skippedHour');

  Carbon.useStrictMode(previousStrict);

  try {
    Carbon.createStrict(2000, 1, 35, 13, 0, 0);
  } on CarbonInvalidDateException catch (error) {
    print('createStrict throws: ${error.message}');
  }
}
''';

/// Compares `create`, `createSafe`, and `createStrict`, including DST gaps.
Future<ExampleRun> runSafeCreationExample() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final previousStrict = Carbon.isStrictModeEnabled();
  Carbon.useStrictMode(false);

  final overflow = Carbon.create(year: 2000, month: 1, day: 35, hour: 13);
  final safe = Carbon.createSafe(2000, 1, 35, 13, 0, 0);
  final skippedHour = Carbon.createSafe(
    2014,
    3,
    30,
    1,
    30,
    0,
    0,
    'Europe/London',
  );

  Carbon.useStrictMode(previousStrict);

  String strictMessage;
  try {
    Carbon.createStrict(2000, 1, 35, 13, 0, 0);
    strictMessage = 'no error';
  } on CarbonInvalidDateException catch (error) {
    strictMessage = error.message;
  }

  final buffer = StringBuffer()
    ..writeln('create overflow: ${overflow.toIso8601String()}')
    ..writeln('createSafe result: $safe')
    ..writeln('DST gap result: $skippedHour')
    ..writeln('createStrict throws: $strictMessage');

  return ExampleRun(
    code: _safeCreationSource,
    output: buffer.toString().trimRight(),
  );
}

const _utcOffsetSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');

  final date = Carbon.parse('2024-01-01T00:00:00Z');
  print('initial offset -> ${date.utcOffset}');
  date.setUtcOffset(180);
  print('after set -> ${date.utcOffset}');
  print('timezone name -> ${date.timeZoneName}');
}
''';

Future<ExampleRun> runUtcOffsetExample() async {
  await initializeDateFormatting('en');
  final date = Carbon.parse('2024-01-01T00:00:00Z');
  final buffer = StringBuffer()
    ..writeln('initial offset -> ${date.utcOffset}')
    ..writeln('after set -> ${date.setUtcOffset(180).utcOffset}')
    ..writeln('timezone name -> ${date.timeZoneName}');
  return ExampleRun(
    code: _utcOffsetSource,
    output: buffer.toString().trimRight(),
  );
}

const _timestampSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final seconds = Carbon.createFromTimestamp(-1);
  final fractional = Carbon.createFromTimestamp(-1.5, timeZone: 'Europe/London');
  final utc = Carbon.createFromTimestampUTC(-1);
  final millis = Carbon.createFromTimestampMs(1685724000123, timeZone: 'Asia/Tokyo');

  print('seconds: ${seconds.toIso8601String()}');
  print('fractional: ${fractional.isoFormat('YYYY-MM-DD HH:mm:ss.SSS zz')}');
  print('utc: ${utc.toIso8601String()}');
  print('millis: ${millis.isoFormat('YYYY-MM-DD HH:mm:ss z')}');
}
''';

/// Highlights the timestamp factory family (seconds, millis, UTC, fractional).
Future<ExampleRun> runTimestampExample() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final seconds = Carbon.createFromTimestamp(-1);
  final fractional = Carbon.createFromTimestamp(
    -1.5,
    timeZone: 'Europe/London',
  );
  final utc = Carbon.createFromTimestampUTC(-1);
  final millis = Carbon.createFromTimestampMs(
    1685724000123,
    timeZone: 'Asia/Tokyo',
  );

  final buffer = StringBuffer()
    ..writeln('seconds: ${seconds.toIso8601String()}')
    ..writeln(
      'fractional: ${fractional.isoFormat('YYYY-MM-DD HH:mm:ss.SSS zz')}',
    )
    ..writeln('utc: ${utc.toIso8601String()}')
    ..writeln('millis: ${millis.isoFormat('YYYY-MM-DD HH:mm:ss z')}');

  return ExampleRun(
    code: _timestampSource,
    output: buffer.toString().trimRight(),
  );
}

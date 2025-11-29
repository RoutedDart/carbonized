/// Runnable snippets for the "Difference" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _diffUnitsSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final ottawa = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Toronto');
  final vancouver = Carbon.parse('2000-01-01T00:00:00', timeZone: 'America/Vancouver');
  final january = Carbon.parse('2012-01-31T00:00:00Z');

  print('diffInHours -> ${ottawa.diffInHours(vancouver)}');
  print('diffInHours (signed) -> ${vancouver.diffInHours(ottawa, absolute: false)}');
  print('diffInDays addMonth -> ${january.diffInDays(january.copy()..addMonth())}');
  print('diffInDays subMonth signed -> ${january.diffInDays(january.copy()..subMonth(), absolute: false)}');
  print('diffInMinutes +59s -> ${january.diffInMinutes(january.copy()..addSeconds(59))}');
  print('diffInMinutes +120s -> ${january.diffInMinutes(january.copy()..addSeconds(120))}');
  print('secondsSinceMidnight -> ${(january.copy()..addSeconds(120)).secondsSinceMidnight()}');
}
''';

/// Shows `diffIn*` helpers with absolute vs signed outputs.
Future<ExampleRun> runDiffUnitsExample() async {
  final ottawa = Carbon.parse(
    '2000-01-01T00:00:00',
    timeZone: 'America/Toronto',
  );
  final vancouver = Carbon.parse(
    '2000-01-01T00:00:00',
    timeZone: 'America/Vancouver',
  );
  final january = Carbon.parse('2012-01-31T00:00:00Z');

  final buffer = StringBuffer()
    ..writeln('diffInHours -> ${ottawa.diffInHours(vancouver)}')
    ..writeln(
      'diffInHours (signed) -> ${vancouver.diffInHours(ottawa, absolute: false)}',
    )
    ..writeln(
      'diffInDays addMonth -> ${january.diffInDays(january.copy()..addMonth())}',
    )
    ..writeln(
      'diffInDays subMonth signed -> ${january.diffInDays(january.copy()..subMonth(), absolute: false)}',
    )
    ..writeln(
      'diffInMinutes +59s -> ${january.diffInMinutes(january.copy()..addSeconds(59))}',
    )
    ..writeln(
      'diffInMinutes +120s -> ${january.diffInMinutes(january.copy()..addSeconds(120))}',
    )
    ..writeln(
      'secondsSinceMidnight -> ${(january.copy()..addSeconds(120)).secondsSinceMidnight()}',
    );

  return ExampleRun(
    code: _diffUnitsSource,
    output: buffer.toString().trimRight(),
  );
}

const _diffIntervalSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2012-01-15T12:00:00Z');
  final earlier = base.copy()
    ..subYears(2)
    ..subMonths(1)
    ..subDays(3)
    ..subHours(6);

  final signed = base.diffAsCarbonInterval(earlier, absolute: false);
  final absolute = base.diffAsCarbonInterval(earlier);

  Carbon applyInterval(CarbonInterface source, CarbonInterval interval) {
    final copy = source.copy();
    if (interval.monthSpan != 0) {
      copy.addMonths(interval.monthSpan);
    }
    if (interval.microseconds != 0) {
      copy.add(Duration(microseconds: interval.microseconds));
    }
    return copy as Carbon;
  }

  final roundTrip = applyInterval(base, signed).toIso8601String();
  final absoluteRoundTrip = applyInterval(earlier, absolute).toIso8601String();

  print('signed months -> ${signed.monthSpan}');
  print('signed micros -> ${signed.microseconds}');
  print('round-trip -> $roundTrip');
  print('absolute months -> ${absolute.monthSpan}');
  print('absolute micros -> ${absolute.microseconds}');
  print('absolute rebuild -> $absoluteRoundTrip');
}
''';

/// Demonstrates converting a difference into a [CarbonInterval].
Future<ExampleRun> runDiffIntervalExample() async {
  final base = Carbon.parse('2012-01-15T12:00:00Z');
  final earlier = base.copy()
    ..subYears(2)
    ..subMonths(1)
    ..subDays(3)
    ..subHours(6);
  final signed = base.diffAsCarbonInterval(earlier, absolute: false);
  final absolute = base.diffAsCarbonInterval(earlier);
  CarbonInterface applyInterval(
    CarbonInterface source,
    CarbonInterval interval,
  ) {
    final copy = source.copy();
    if (interval.monthSpan != 0) {
      copy.addMonths(interval.monthSpan);
    }
    if (interval.microseconds != 0) {
      copy.add(Duration(microseconds: interval.microseconds));
    }
    return copy;
  }

  final buffer = StringBuffer()
    ..writeln('signed months -> ${signed.monthSpan}')
    ..writeln('signed micros -> ${signed.microseconds}')
    ..writeln('round-trip -> ${applyInterval(base, signed).toIso8601String()}')
    ..writeln('absolute months -> ${absolute.monthSpan}')
    ..writeln('absolute micros -> ${absolute.microseconds}')
    ..writeln(
      'absolute rebuild -> '
      '${applyInterval(earlier, absolute).toIso8601String()}',
    );
  return ExampleRun(
    code: _diffIntervalSource,
    output: buffer.toString().trimRight(),
  );
}

const _floatDiffSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
  final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
  final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
  final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
  final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
  final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
  final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
  final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
  final monthStart = Carbon.parse('2000-01-15T00:00:00Z');
  final monthEnd = Carbon.parse('2000-02-24T00:00:00Z');
  final monthChunkStart = Carbon.parse('2000-02-15T12:00:00Z');
  final monthChunkEnd = Carbon.parse('2000-03-24T06:00:00Z');
  final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
  final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');

  print('floatDiffInSeconds -> '
      '${secondsStart.floatDiffInSeconds(secondsEnd)}');
  print('floatDiffInMinutes -> '
      '${minutesStart.floatDiffInMinutes(minutesEnd)}');
  print('floatDiffInHours (absolute) -> '
      '${minutesStart.floatDiffInHours(minutesEnd)}');
  print('floatDiffInHours (signed) -> '
      '${signedStart.floatDiffInHours(signedEnd, absolute: false)}');
  print('floatDiffInDays -> ${dayStart.floatDiffInDays(dayEnd)}');
  print('floatDiffInWeeks -> ${weekStart.floatDiffInWeeks(weekEnd)}');
  print('floatDiffInMonths -> ${monthStart.floatDiffInMonths(monthEnd)}');
  print('floatDiffInMonths (chunked) -> '
      '${monthChunkStart.floatDiffInMonths(monthChunkEnd)}');
  print('floatDiffInYears -> ${yearsStart.floatDiffInYears(yearsEnd)}');
}
''';

/// Demonstrates `floatDiffIn*` helpers for fractional deltas.
Future<ExampleRun> runFloatDiffExample() async {
  final secondsStart = Carbon.parse('2000-01-01T06:01:23.252987Z');
  final secondsEnd = Carbon.parse('2000-01-01T06:02:34.321450Z');
  final minutesStart = Carbon.parse('2000-01-01T06:01:23Z');
  final minutesEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final signedStart = Carbon.parse('2000-01-01T12:01:23Z');
  final signedEnd = Carbon.parse('2000-01-01T06:02:34Z');
  final dayStart = Carbon.parse('2000-01-01T12:00:00Z');
  final dayEnd = Carbon.parse('2000-02-11T06:00:00Z');
  final weekStart = Carbon.parse('2000-01-01T00:00:00Z');
  final weekEnd = Carbon.parse('2000-02-11T00:00:00Z');
  final monthStart = Carbon.parse('2000-01-15T00:00:00Z');
  final monthEnd = Carbon.parse('2000-02-24T00:00:00Z');
  final monthChunkStart = Carbon.parse('2000-02-15T12:00:00Z');
  final monthChunkEnd = Carbon.parse('2000-03-24T06:00:00Z');
  final yearsStart = Carbon.parse('2000-02-15T12:00:00Z');
  final yearsEnd = Carbon.parse('2010-03-24T06:00:00Z');

  final buffer = StringBuffer()
    ..writeln(
      'floatDiffInSeconds -> '
      '${secondsStart.floatDiffInSeconds(secondsEnd)}',
    )
    ..writeln(
      'floatDiffInMinutes -> '
      '${minutesStart.floatDiffInMinutes(minutesEnd)}',
    )
    ..writeln(
      'floatDiffInHours (absolute) -> '
      '${minutesStart.floatDiffInHours(minutesEnd)}',
    )
    ..writeln(
      'floatDiffInHours (signed) -> '
      '${signedStart.floatDiffInHours(signedEnd, absolute: false)}',
    )
    ..writeln('floatDiffInDays -> ${dayStart.floatDiffInDays(dayEnd)}')
    ..writeln('floatDiffInWeeks -> ${weekStart.floatDiffInWeeks(weekEnd)}')
    ..writeln('floatDiffInMonths -> ${monthStart.floatDiffInMonths(monthEnd)}')
    ..writeln(
      'floatDiffInMonths (chunked) -> '
      '${monthChunkStart.floatDiffInMonths(monthChunkEnd)}',
    )
    ..writeln('floatDiffInYears -> ${yearsStart.floatDiffInYears(yearsEnd)}');

  return ExampleRun(
    code: _floatDiffSource,
    output: buffer.toString().trimRight(),
  );
}

const _durationDiffSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {

  final base = Carbon.parse('2012-01-01T00:00:00Z');
  final future = base.copy()..addYears(3)..addDays(10)..addHours(12);
  final delta = future.diff(base);

  print('diff() Duration days -> ${delta.inDays}');
  print('diff() Duration hours -> ${delta.inHours}');
}
''';

/// Highlights `diff()` returning a `Duration` in Dart.
Future<ExampleRun> runDurationDiffExample() async {
  final base = Carbon.parse('2012-01-01T00:00:00Z');
  final future = base.copy()
    ..addYears(3)
    ..addDays(10)
    ..addHours(12);
  final delta = future.diff(base);
  final buffer = StringBuffer()
    ..writeln('diff() Duration days -> ${delta.inDays}')
    ..writeln('diff() Duration hours -> ${delta.inHours}');
  return ExampleRun(
    code: _durationDiffSource,
    output: buffer.toString().trimRight(),
  );
}

const _diffInUnitSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final base = Carbon.parse('2000-01-15T00:00:00Z');
  final target = base.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(5)
    ..addHours(12);

  print('years -> ${base.diffInUnit(CarbonUnit.year, target)}');
  print('months -> ${base.diffInUnit('months', target)}');
  print('hours (signed) -> '
      '${target.diffInUnit('hours', base, absolute: false)}');
}
''';

/// Shows the flexible `diffInUnit()` helper for mixed units.
Future<ExampleRun> runDiffInUnitExample() async {
  final base = Carbon.parse('2000-01-15T00:00:00Z');
  final target = base.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(5)
    ..addHours(12);
  final buffer = StringBuffer()
    ..writeln('years -> ${base.diffInUnit(CarbonUnit.year, target)}')
    ..writeln('months -> ${base.diffInUnit('months', target)}')
    ..writeln(
      'hours (signed) -> '
      '${target.diffInUnit('hours', base, absolute: false)}',
    );
  return ExampleRun(
    code: _diffInUnitSource,
    output: buffer.toString().trimRight(),
  );
}

/// Runnable snippets for the "Testing Aids" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _basicTestNowSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setTestNow(Carbon.parse('2001-05-21T12:00:00Z'));

  print('has test now: ${Carbon.hasTestNow()}');
  print('now: ${Carbon.now().toIso8601String()}');
  print('Carbon(): ${Carbon().toIso8601String()}');
  print("'tomorrow': ${Carbon.parse('tomorrow').toIso8601String()}");
  print("'next wednesday': ${Carbon.parse('next wednesday').toIso8601String()}");

  Carbon.setTestNow();
  print('cleared: ${Carbon.hasTestNow()}');
}
''';

/// Recreates the PHP docs example for freezing `now()` via `setTestNow`.
Future<ExampleRun> runBasicTestNowExample() async {
  Carbon.setTestNow(Carbon.parse('2001-05-21T12:00:00Z'));
  final buffer = StringBuffer()
    ..writeln('has test now: ${Carbon.hasTestNow()}')
    ..writeln('now: ${Carbon.now().toIso8601String()}')
    ..writeln('Carbon(): ${Carbon().toIso8601String()}')
    ..writeln("'tomorrow': ${Carbon.parse('tomorrow').toIso8601String()}")
    ..writeln(
      "'next wednesday': ${Carbon.parse('next wednesday').toIso8601String()}",
    );
  Carbon.setTestNow();
  buffer.writeln('cleared: ${Carbon.hasTestNow()}');

  return ExampleRun(
    code: _basicTestNowSource,
    output: buffer.toString().trimRight(),
  );
}

const _withTestNowSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  Carbon.withTestNow('2010-09-15T00:00:00Z', () {
    print('inside callback: ${Carbon.now().toIso8601String()}');
  });

  print('outside callback: ${Carbon.now().year}');
}
''';

/// Shows scoped overrides using `Carbon.withTestNow()`.
Future<ExampleRun> runWithTestNowExample() async {
  final buffer = StringBuffer();
  Carbon.withTestNow('2010-09-15T00:00:00Z', () {
    buffer.writeln('inside callback: ${Carbon.now().toIso8601String()}');
  });
  buffer.writeln('outside callback: ${Carbon.now().year}');
  return ExampleRun(
    code: _withTestNowSource,
    output: buffer.toString().trimRight(),
  );
}

const _timezoneTestNowSource = r'''
import 'package:carbon/carbon.dart';

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  Carbon.setTestNowAndTimezone('2022-01-24 10:45', timeZone: 'America/Toronto');
  print('now: ${Carbon.now().isoFormat('YYYY-MM-DD HH:mm zz')}');

  Carbon.setTestNow();
}
''';

/// Freezes both the instant and timezone using `setTestNowAndTimezone`.
Future<ExampleRun> runTimezoneTestNowExample() async {
  Carbon.setTestNowAndTimezone('2022-01-24 10:45', timeZone: 'America/Toronto');
  final buffer = StringBuffer()
    ..writeln("now: ${Carbon.now().isoFormat('YYYY-MM-DD HH:mm zz')}");
  Carbon.setTestNow();
  return ExampleRun(
    code: _timezoneTestNowSource,
    output: buffer.toString().trimRight(),
  );
}

const _seasonalProductSource = r'''
import 'package:carbon/carbon.dart';

class SeasonalProduct {
  SeasonalProduct(this.price);

  final int price;

  int get priceWithSeasonalMultiplier {
    final multiplier = Carbon.now().month == 12 ? 2 : 1;
    return price * multiplier;
  }
}

Future<void> main() async {
  await Carbon.configureTimeMachine(testing: true);

  final product = SeasonalProduct(100);

  Carbon.setTestNow('2000-03-01');
  print('March price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow('2000-12-01');
  print('December price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow('2000-05-01');
  print('May price: ${product.priceWithSeasonalMultiplier}');

  Carbon.setTestNow();
}
''';

/// Mirrors the SeasonalProduct test helper from the PHP docs.
Future<ExampleRun> runSeasonalProductExample() async {
  final product = _SeasonalProduct(100);
  Carbon.setTestNow('2000-03-01');
  final march = product.priceWithSeasonalMultiplier;
  Carbon.setTestNow('2000-12-01');
  final december = product.priceWithSeasonalMultiplier;
  Carbon.setTestNow('2000-05-01');
  final may = product.priceWithSeasonalMultiplier;
  Carbon.setTestNow();

  final buffer = StringBuffer()
    ..writeln('March price: $march')
    ..writeln('December price: $december')
    ..writeln('May price: $may');

  return ExampleRun(
    code: _seasonalProductSource,
    output: buffer.toString().trimRight(),
  );
}

class _SeasonalProduct {
  _SeasonalProduct(this.price);

  final int price;

  int get priceWithSeasonalMultiplier {
    final multiplier = Carbon.now().month == 12 ? 2 : 1;
    return price * multiplier;
  }
}

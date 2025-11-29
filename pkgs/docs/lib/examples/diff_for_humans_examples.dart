/// Runnable snippets for the "Difference for Humans" section.
library;

import 'package:carbon/carbon.dart';

import 'example_runner.dart';

const _humanReadableSource = r'''
import 'package:carbon/carbon.dart';

void main() {
  
  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final fiveHoursAgo = now.copy()..subHours(5);
  final nextWeek = now.copy()..addWeek();

  print('five hours ago -> ${fiveHoursAgo.diffForHumans(reference: now)}');
  print('relative to future -> ${now.diffForHumans(reference: nextWeek)}');
  print('to future instant -> ${nextWeek.diffForHumans(reference: now)}');
}
''';

/// Demonstrates the basic `diffForHumans` usage powered by Carbon's built-in
/// relative formatter.
Future<ExampleRun> runHumanReadableExample() async {
  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final fiveHoursAgo = now.copy()..subHours(5);
  final nextWeek = now.copy()..addWeek();
  final buffer = StringBuffer()
    ..writeln('five hours ago -> ${fiveHoursAgo.diffForHumans(reference: now)}')
    ..writeln('relative to future -> ${now.diffForHumans(reference: nextWeek)}')
    ..writeln('to future instant -> ${nextWeek.diffForHumans(reference: now)}');
  return ExampleRun(
    code: _humanReadableSource,
    output: buffer.toString().trimRight(),
  );
}

const _humanReadableDetailSource = r'''
import 'package:carbon/carbon.dart';

void main() {
  
  final now = Carbon.parse('2024-01-01T00:00:00Z');
  final horizon = now.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(3)
    ..addHours(4);

  print('multi unit -> ${horizon.diffForHumans(reference: now, parts: 3)}');
  print('short join -> ${horizon.diffForHumans(reference: now, parts: 2, short: true, joiner: ', ')}');
  print('just now -> ${now.diffForHumans(reference: now, parts: 2)}');
}
''';

Future<ExampleRun> runHumanReadableDetailExample() async {
  final now = Carbon.parse('2024-01-01T00:00:00Z');
  final horizon = now.copy()
    ..addYears(1)
    ..addMonths(2)
    ..addDays(3)
    ..addHours(4);
  final buffer = StringBuffer()
    ..writeln(
      'multi unit -> ${horizon.diffForHumans(reference: now, parts: 3)}',
    )
    ..writeln(
      'short join -> ${horizon.diffForHumans(reference: now, parts: 2, short: true, joiner: ', ')}',
    )
    ..writeln('just now -> ${now.diffForHumans(reference: now)}');
  return ExampleRun(
    code: _humanReadableDetailSource,
    output: buffer.toString().trimRight(),
  );
}

const _localizedHumanReadableSource = r'''
import 'package:carbon/carbon.dart';

void main() {
  CarbonTranslator.registerLocale(
    'fr',
    CarbonLocaleData(
      localeCode: 'fr',
      timeStrings: {
        'ago': 'il y a',
        'from now': "d'ici",
        'in ': 'dans ',
      },
    ),
  );

  final past = Carbon.parse('2024-06-05T12:00:00Z')..subMinutes(2);
  final future = Carbon.parse('2024-06-05T12:00:00Z')..addDays(3);

  print('French past -> ${past.diffForHumans(locale: 'fr')}');
  print('French future -> ${future.diffForHumans(locale: 'fr')}');
}
''';

Future<ExampleRun> runLocalizedHumanReadableExample() async {
  CarbonTranslator.registerLocale(
    'fr',
    CarbonLocaleData(
      localeCode: 'fr',
      timeStrings: {'ago': 'il y a', 'from now': "d'ici", 'in ': 'dans '},
    ),
  );

  final past = Carbon.parse('2024-06-05T12:00:00Z')..subMinutes(2);
  final future = Carbon.parse('2024-06-05T12:00:00Z')..addDays(3);
  final buffer = StringBuffer()
    ..writeln('French past -> ${past.diffForHumans(locale: 'fr')}')
    ..writeln('French future -> ${future.diffForHumans(locale: 'fr')}');

  return ExampleRun(
    code: _localizedHumanReadableSource,
    output: buffer.toString().trimRight(),
  );
}

const _localeHintSource = r'''
import 'package:carbon/carbon.dart';

void main() {
  // fr_CA inherits the base fr translations
  final canadian = Carbon.parse('2024-06-05T12:00:00Z').locale('fr_CA');
  final european = Carbon.parse('2024-06-05T12:00:00Z').locale('fr');

  print('fr_CA fallbacks -> ${canadian.diffForHumans()}');
  print('fr base -> ${european.diffForHumans()}');
}
''';

Future<ExampleRun> runLocaleHintExample() async {
  final canadian = Carbon.parse('2024-06-05T12:00:00Z').locale('fr_CA');
  final european = Carbon.parse('2024-06-05T12:00:00Z').locale('fr');

  final buffer = StringBuffer()
    ..writeln('fr_CA fallbacks -> ${canadian.diffForHumans()}')
    ..writeln('fr base -> ${european.diffForHumans()}');

  return ExampleRun(
    code: _localeHintSource,
    output: buffer.toString().trimRight(),
  );
}

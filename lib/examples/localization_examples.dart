/// Runnable snippets for the "Localization" documentation section.
library;

import 'dart:async';

import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'example_runner.dart';

Future<void> _ensureLocales(Iterable<String> locales) async {
  for (final locale in locales) {
    await initializeDateFormatting(locale);
  }
}

const _localeFormattingSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');

  Intl.defaultLocale = 'fr';
  Carbon.setLocale('fr');
  final defaultLocale = Carbon.now().localeCode;

  final base = Carbon.parse('2024-06-01T12:00:00Z');
  final french = base.copy().locale('fr');
  final english = base.copy().locale('en');

  print('default locale: $defaultLocale');
  print('French LLLL: ${french.isoFormat('LLLL')}');
  print('French day name: ${french.isoFormat('dddd D MMMM')}');
  print('English day name: ${english.isoFormat('dddd D MMMM')}');

  Carbon.setLocale('en');
  Intl.defaultLocale = 'en';
}
''';

/// Mirrors the PHP docs' locale formatting showcase using isoFormat presets.
Future<ExampleRun> runLocaleFormattingExample() async {
  await _ensureLocales(const ['en', 'fr']);

  Intl.defaultLocale = 'fr';
  Carbon.setLocale('fr');
  final defaultLocale = Carbon.now().localeCode;

  final base = Carbon.parse('2024-06-01T12:00:00Z');
  final french = base.copy().locale('fr');
  final english = base.copy().locale('en');

  final buffer = StringBuffer()
    ..writeln('default locale: $defaultLocale')
    ..writeln('French LLLL: ${french.isoFormat('LLLL')}')
    ..writeln('French day name: ${french.isoFormat('dddd D MMMM')}')
    ..writeln('English day name: ${english.isoFormat('dddd D MMMM')}');

  Carbon.setLocale('en');
  Intl.defaultLocale = 'en';

  return ExampleRun(
    code: _localeFormattingSource,
    output: buffer.toString().trimRight(),
  );
}

const _localeWeekSettingsSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

String describeWeekend(List<int> days) {
  const labels = <int, String>{
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };
  return days.map((day) => labels[day] ?? '$day').join(', ');
}

Future<void> main() async {
  await initializeDateFormatting('en');
  await initializeDateFormatting('en_GB');

  final sample = Carbon.parse('2024-06-05T12:00:00Z');

  Carbon.setLocale('en_US');
  final usWeek = sample.locale('en_US').startOfWeek();
  final usWeekend = describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en_GB');
  final gbWeek = sample.locale('en_GB').startOfWeek();
  final gbWeekend = describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en');

  print('US start of week: ${usWeek.isoFormat('dddd D MMMM')}');
  print('US weekend days: $usWeekend');
  print('UK start of week: ${gbWeek.isoFormat('dddd D MMMM')}');
  print('UK weekend days: $gbWeekend');
}
''';

/// Demonstrates how locale metadata changes week starts and weekend days.
Future<ExampleRun> runLocaleWeekSettingsExample() async {
  await _ensureLocales(const ['en', 'en_GB']);

  final sample = Carbon.parse('2024-06-05T12:00:00Z');

  Carbon.setLocale('en_US');
  final usWeek = sample.locale('en_US').startOfWeek();
  final usWeekend = _describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en_GB');
  final gbWeek = sample.locale('en_GB').startOfWeek();
  final gbWeekend = _describeWeekend(Carbon.getWeekendDays());

  Carbon.setLocale('en');

  final buffer = StringBuffer()
    ..writeln('US start of week: ${usWeek.isoFormat('dddd D MMMM')}')
    ..writeln('US weekend days: $usWeekend')
    ..writeln('UK start of week: ${gbWeek.isoFormat('dddd D MMMM')}')
    ..writeln('UK weekend days: $gbWeekend');

  return ExampleRun(
    code: _localeWeekSettingsSource,
    output: buffer.toString().trimRight(),
  );
}

String _describeWeekend(List<int> days) {
  const labels = <int, String>{
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };
  return days.map((day) => labels[day] ?? day.toString()).join(', ');
}

const _translatorSource = r'''
import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  await initializeDateFormatting('fr');

  CarbonTranslator.registerLocale(
    'fr',
    CarbonLocaleData(
      localeCode: 'fr',
      numbers: {
        '1': 'un ',
        '2': 'deux ',
        '3': 'trois ',
        '4': 'quatre ',
      },
      timeStrings: {
        'ago': 'il y a',
        'from now': "d'ici",
        'minutes': 'minutes',
        'hours': 'heures',
        'days': 'jours',
        'just now': "à l'instant",
        'now': "à l'instant",
        'in ': 'dans ',
      },
      timeagoMessages: timeago.FrMessages(),
    ),
  );

  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final delta = now.copy()..subMinutes(2);

  print('French diff -> ${delta.diffForHumans(locale: 'fr')}');
  print('French digits -> ${Carbon.translateNumber('123', locale: 'fr')}');
  print('French snippet -> ${Carbon.translateTimeString('minutes ago', locale: 'fr')}');
}
''';

Future<ExampleRun> runTranslatorExample() async {
  await _ensureLocales(const ['fr']);

  CarbonTranslator.registerLocale(
    'fr',
    CarbonLocaleData(
      localeCode: 'fr',
      numbers: {'1': 'un ', '2': 'deux ', '3': 'trois ', '4': 'quatre '},
      timeStrings: {
        'ago': 'il y a',
        'from now': "d'ici",
        'minutes': 'minutes',
        'hours': 'heures',
        'days': 'jours',
        'just now': "à l'instant",
        'now': "à l'instant",
        'in ': 'dans ',
      },
      timeagoMessages: timeago.FrMessages(),
    ),
  );

  final now = Carbon.parse('2024-06-05T12:00:00Z');
  final delta = now.copy()..subMinutes(2);

  final buffer = StringBuffer()
    ..writeln('French diff -> ${delta.diffForHumans(locale: 'fr')}')
    ..writeln('French digits -> ${Carbon.translateNumber('123', locale: 'fr')}')
    ..writeln(
      'French snippet -> ${Carbon.translateTimeString('minutes ago', locale: 'fr')}',
    );

  return ExampleRun(
    code: _translatorSource,
    output: buffer.toString().trimRight(),
  );
}

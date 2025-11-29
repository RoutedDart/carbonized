import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

/// Comprehensive test suite for Carbon's locale token parser
///
/// Tests that all locale-specific DateFormat tokens are properly intercepted
/// and replaced with Carbon's CarbonTranslator data, without requiring
/// initializeDateFormatting().
void main() {
  group('Locale Token Parser - Month Names', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z'); // March

    test('MMMM (long month name) - multiple locales', () {
      expect(date.format('MMMM', locale: 'en'), contains('March'));
      expect(date.format('MMMM', locale: 'fr'), equals('mars'));
      expect(date.format('MMMM', locale: 'es'), equals('marzo'));
      expect(date.format('MMMM', locale: 'de'), contains('M'));
      expect(date.format('MMMM', locale: 'ja'), equals('3月'));
      expect(date.format('MMMM', locale: 'zh'), equals('三月'));
      expect(date.format('MMMM', locale: 'ar'), contains('مارس'));
    });

    test('MMM (short month name) - multiple locales', () {
      expect(date.format('MMM', locale: 'en'), contains('Mar'));
      expect(date.format('MMM', locale: 'fr'), equals('mars'));
      expect(date.format('MMM', locale: 'es'), contains('mar'));
      expect(date.format('MMM', locale: 'de'), contains('M'));
      expect(date.format('MMM', locale: 'ja'), equals('3月'));
    });

    test('LLLL (stand-alone long month) - multiple locales', () {
      expect(date.format('LLLL', locale: 'en'), contains('March'));
      expect(date.format('LLLL', locale: 'fr'), equals('mars'));
      expect(date.format('LLLL', locale: 'es'), equals('marzo'));
      expect(date.format('LLLL', locale: 'ru'), contains('март'));
    });

    test('LLL (stand-alone short month) - multiple locales', () {
      expect(date.format('LLL', locale: 'en'), contains('Mar'));
      expect(date.format('LLL', locale: 'fr'), equals('mars'));
      expect(date.format('LLL', locale: 'es'), contains('mar'));
    });

    test('Month names work in complex patterns', () {
      final pattern = 'd MMMM yyyy';
      expect(date.format(pattern, locale: 'fr'), equals('15 mars 2025'));
      expect(date.format(pattern, locale: 'es'), equals('15 marzo 2025'));
      expect(date.format(pattern, locale: 'de'), contains('15'));
      expect(date.format(pattern, locale: 'de'), contains('2025'));
    });
  });

  group('Locale Token Parser - Weekday Names', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z'); // Saturday

    test('EEEE (long weekday name) - multiple locales', () {
      expect(date.format('EEEE', locale: 'en'), contains('Saturday'));
      expect(date.format('EEEE', locale: 'fr'), equals('samedi'));
      expect(date.format('EEEE', locale: 'es'), contains('bado'));
      expect(date.format('EEEE', locale: 'de'), equals('Samstag'));
      expect(date.format('EEEE', locale: 'ja'), equals('土曜日'));
      expect(date.format('EEEE', locale: 'zh'), contains('星期六'));
    });

    test('EEE (short weekday name) - multiple locales', () {
      expect(date.format('EEE', locale: 'en'), contains('Sat'));
      expect(date.format('EEE', locale: 'fr'), contains('sam'));
      expect(date.format('EEE', locale: 'es'), contains('b'));
      expect(date.format('EEE', locale: 'de'), contains('Sa'));
      expect(date.format('EEE', locale: 'ja'), equals('土'));
    });

    test('cccc (stand-alone long weekday) - multiple locales', () {
      expect(date.format('cccc', locale: 'en'), contains('Saturday'));
      expect(date.format('cccc', locale: 'fr'), equals('samedi'));
      expect(date.format('cccc', locale: 'es'), contains('bado'));
    });

    test('ccc (stand-alone short weekday) - multiple locales', () {
      expect(date.format('ccc', locale: 'en'), contains('Sat'));
      expect(date.format('ccc', locale: 'fr'), contains('sam'));
      expect(date.format('ccc', locale: 'ja'), equals('土'));
    });

    test('E (minimal weekday name) - multiple locales', () {
      expect(date.format('E', locale: 'en'), contains('Sat'));
      expect(date.format('E', locale: 'fr'), contains('sam'));
      expect(date.format('E', locale: 'de'), contains('Sa'));
    });

    test('Weekday names work in complex patterns', () {
      final pattern = 'EEEE, d MMMM';
      final result = date.format(pattern, locale: 'fr');
      expect(result, contains('samedi'));
      expect(result, contains('mars'));
    });
  });

  group('Locale Token Parser - Meridiem', () {
    final morning = Carbon.parse('2025-03-15T09:30:00Z'); // 9:30 AM
    final afternoon = Carbon.parse('2025-03-15T14:30:00Z'); // 2:30 PM

    test('a (AM marker) - multiple locales', () {
      expect(morning.format('a', locale: 'en'), contains('AM'));
      expect(morning.format('a', locale: 'fr'), isNotEmpty);
      expect(morning.format('a', locale: 'es'), isNotEmpty);
      expect(morning.format('a', locale: 'ja'), equals('午前'));
      expect(morning.format('a', locale: 'zh'), contains('上午'));
    });

    test('a (PM marker) - multiple locales', () {
      expect(afternoon.format('a', locale: 'en'), contains('PM'));
      expect(afternoon.format('a', locale: 'fr'), isNotEmpty);
      expect(afternoon.format('a', locale: 'es'), contains('m'));
      expect(afternoon.format('a', locale: 'ja'), equals('午後'));
      expect(afternoon.format('a', locale: 'zh'), contains('下午'));
    });

    test('Meridiem works in time patterns', () {
      final pattern = 'h:mm a';
      final morningResult = morning.format(pattern, locale: 'ja');
      expect(morningResult, contains('午前'));

      final afternoonResult = afternoon.format(pattern, locale: 'ja');
      expect(afternoonResult, contains('午後'));
    });
  });

  group('Locale Token Parser - Quarter (uses intl, not Carbon)', () {
    // Note: Quarter tokens are NOT intercepted by Carbon's token parser.
    // They are passed through to intl's DateFormat, which handles them.
    // CarbonTranslator doesn't have quarter data, so we rely on intl for this.

    final q1 = Carbon.parse('2025-01-15T12:00:00Z'); // Q1
    final q2 = Carbon.parse('2025-04-15T12:00:00Z'); // Q2
    final q3 = Carbon.parse('2025-07-15T12:00:00Z'); // Q3
    final q4 = Carbon.parse('2025-10-15T12:00:00Z'); // Q4

    test('Q (numeric quarter) - handled by intl', () {
      // These work because intl can format numeric quarters without initialization
      expect(q1.format('Q', locale: 'en'), isNotEmpty);
      expect(q2.format('Q', locale: 'en'), isNotEmpty);
      expect(q3.format('Q', locale: 'en'), isNotEmpty);
      expect(q4.format('Q', locale: 'en'), isNotEmpty);
    });

    test('QQQ (abbreviated quarter) - handled by intl', () {
      // These may require initializeDateFormatting for proper localization
      expect(q1.format('QQQ', locale: 'en'), isNotEmpty);
      expect(q2.format('QQQ', locale: 'en'), isNotEmpty);
    });

    test('QQQQ (full quarter name) - handled by intl', () {
      // These may require initializeDateFormatting for proper localization
      expect(q1.format('QQQQ', locale: 'en'), isNotEmpty);
      expect(q2.format('QQQQ', locale: 'en'), isNotEmpty);
    });
  });

  group('Locale Token Parser - Quoted Strings', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Single-quoted strings are preserved', () {
      final pattern = "d MMMM 'de' yyyy";
      final result = date.format(pattern, locale: 'fr');
      expect(result, equals('15 mars de 2025'));
    });

    test('Quoted \'at\' does not get replaced by meridiem token', () {
      final pattern = "d MMMM yyyy 'at' h:mm a";
      final result = date.format(pattern, locale: 'en');
      expect(result, contains('at'));
      expect(result, contains('PM'));
    });

    test('Multiple quoted strings in one pattern', () {
      final pattern = "'Day:' d 'of' MMMM";
      final result = date.format(pattern, locale: 'fr');
      expect(result, equals('Day: 15 of mars'));
    });

    test('Quoted string with token characters', () {
      final pattern = "'MMMM' MMMM"; // First MMMM is literal, second is token
      final result = date.format(pattern, locale: 'fr');
      expect(result, equals('MMMM mars'));
    });
  });

  group('Locale Token Parser - Complex Patterns', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Full date and time with all token types', () {
      final pattern = 'EEEE, d MMMM yyyy h:mm a';
      final result = date.format(pattern, locale: 'fr');
      expect(result, contains('samedi'));
      expect(result, contains('mars'));
      expect(result, contains('2025'));
    });

    test('Multiple month tokens in one pattern', () {
      final pattern = 'MMM / MMMM';
      final result = date.format(pattern, locale: 'fr');
      expect(result, contains('mars'));
    });

    test('Multiple weekday tokens in one pattern', () {
      final pattern = 'EEE (EEEE)';
      final result = date.format(pattern, locale: 'fr');
      expect(result, contains('samedi'));
    });

    test('ISO-like pattern with localized names', () {
      final pattern = 'yyyy-MM-dd (EEEE)';
      final result = date.format(pattern, locale: 'ja');
      expect(result, equals('2025-03-15 (土曜日)'));
    });
  });

  group('Locale Token Parser - Edge Cases', () {
    final date = Carbon.parse('2025-01-01T00:00:00Z'); // January 1, midnight

    test('Works with January (month 1)', () {
      expect(date.format('MMMM', locale: 'en'), contains('January'));
      expect(date.format('MMMM', locale: 'fr'), equals('janvier'));
      expect(date.format('MMMM', locale: 'es'), equals('enero'));
    });

    test('Works with Thursday (weekday 4)', () {
      final thursday = Carbon.parse('2025-01-02T12:00:00Z'); // Thursday
      expect(thursday.format('EEEE', locale: 'en'), contains('Thursday'));
      expect(thursday.format('EEEE', locale: 'fr'), equals('jeudi'));
      expect(thursday.format('EEEE', locale: 'es'), equals('jueves'));
    });

    test('Works with midnight (0:00)', () {
      expect(date.format('h:mm a', locale: 'en'), contains('12:00'));
      expect(date.format('a', locale: 'en'), contains('AM'));
    });

    test('Works with December (month 12)', () {
      final december = Carbon.parse('2025-12-31T23:59:59Z');
      expect(december.format('MMMM', locale: 'en'), contains('December'));
      expect(december.format('MMMM', locale: 'fr'), contains('cembre'));
      expect(december.format('MMMM', locale: 'es'), equals('diciembre'));
    });
  });

  group('Locale Token Parser - Multiple Locales', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Works consistently across Romance languages', () {
      final pattern = 'EEEE d MMMM';

      final fr = date.format(pattern, locale: 'fr');
      expect(fr, contains('samedi'));
      expect(fr, contains('mars'));

      final es = date.format(pattern, locale: 'es');
      expect(es, contains('bado'));
      expect(es, contains('marzo'));

      final it = date.format(pattern, locale: 'it');
      expect(it, isNotEmpty);

      final pt = date.format(pattern, locale: 'pt');
      expect(pt, isNotEmpty);
    });

    test('Works consistently across Asian languages', () {
      final pattern = 'MMMM d日';

      final ja = date.format(pattern, locale: 'ja');
      expect(ja, contains('3月'));

      final zh = date.format(pattern, locale: 'zh');
      expect(zh, contains('三月'));

      final ko = date.format(pattern, locale: 'ko');
      expect(ko, isNotEmpty);
    });

    test('Works consistently across Germanic languages', () {
      final pattern = 'EEEE, d. MMMM yyyy';

      final de = date.format(pattern, locale: 'de');
      expect(de, contains('Samstag'));

      final nl = date.format(pattern, locale: 'nl');
      expect(nl, isNotEmpty);

      final sv = date.format(pattern, locale: 'sv');
      expect(sv, isNotEmpty);
    });
  });

  group('Locale Token Parser - Fallback Behavior', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Returns formatted string even with unusual locale', () {
      // Should still work even if locale is not common
      final result = date.format('MMMM d, yyyy', locale: 'tlh'); // Klingon
      expect(result, isNotEmpty);
    });

    test('Returns formatted string with structural tokens only', () {
      final pattern = 'yyyy-MM-dd HH:mm:ss';
      final result = date.format(pattern, locale: 'fr');
      expect(result, equals('2025-03-15 14:30:00'));
    });

    test('Handles empty locale gracefully', () {
      final result = date.format('MMMM', locale: '');
      expect(result, isNotEmpty);
    });
  });

  group('Locale Token Parser - No initializeDateFormatting Required', () {
    test('Works immediately without any initialization', () {
      // This test verifies that we DON'T need to call initializeDateFormatting
      // If this test passes, it proves Carbon's token parser is working

      final date = Carbon.parse('2025-06-21T12:00:00Z'); // June, summer

      // All these should work without any prior initialization
      expect(date.format('MMMM', locale: 'fr'), equals('juin'));
      expect(date.format('MMMM', locale: 'de'), contains('Juni'));
      expect(date.format('MMMM', locale: 'es'), equals('junio'));
      expect(date.format('MMMM', locale: 'it'), equals('giugno'));
      expect(date.format('MMMM', locale: 'pt'), equals('junho'));
      expect(date.format('MMMM', locale: 'ru'), contains('июн'));
      expect(date.format('MMMM', locale: 'ja'), equals('6月'));
      expect(date.format('MMMM', locale: 'zh'), equals('六月'));
      expect(date.format('MMMM', locale: 'ar'), isNotEmpty);
      expect(date.format('MMMM', locale: 'hi'), isNotEmpty);
    });
  });

  group('Locale Token Parser - Performance', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Handles many locale token replacements efficiently', () {
      final pattern = 'EEEE, d MMMM yyyy \'at\' h:mm a (Q)';

      // Should complete quickly even with multiple replacements
      final stopwatch = Stopwatch()..start();
      for (var i = 0; i < 100; i++) {
        date.format(pattern, locale: 'fr');
      }
      stopwatch.stop();

      // Should complete 100 formats in reasonable time (< 1 second)
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });

  group('Locale Token Parser - Compatibility', () {
    final date = Carbon.parse('2025-03-15T14:30:00Z');

    test('Instance locale() method works with token parser', () {
      final localized = date.locale('fr');
      expect(localized.format('MMMM'), equals('mars'));
      expect(localized.format('EEEE'), equals('samedi'));
    });

    test('Works with timezone-aware dates', () async {
      await Carbon.configureTimeMachine(testing: true);

      final tokyo = Carbon.parse(
        '2025-03-15T14:30:00Z',
        timeZone: 'Asia/Tokyo',
      );

      final result = tokyo.format('EEEE, d MMMM yyyy', locale: 'ja');
      expect(result, contains('土曜日'));
      expect(result, contains('3月'));
    });
  });
}

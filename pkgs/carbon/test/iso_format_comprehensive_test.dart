import 'package:test/test.dart';
import 'package:carbon/carbon.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en_US', null);
    Intl.defaultLocale = 'en_US';
  });

  group('format() vs isoFormat() - Critical Difference', () {
    test('format() uses Dart DateFormat where DD = day of year', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // format() delegates to Dart's DateFormat class
      // In Dart's DateFormat: DD = day of year, dd = day of month
      expect(nov26.format('DD'), '331'); // Day 331 of the year
      expect(nov26.format('dd'), '26'); // Day 26 of the month
      expect(nov26.format('MMM DD'), 'Nov 331'); // WRONG for day of month!
      expect(nov26.format('MMM dd'), 'Nov 26'); // CORRECT for day of month
    });

    test('isoFormat() uses Carbon formatter where DD = day of month', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // isoFormat() uses Carbon's custom ISO formatter
      // In Carbon's formatter: DD = day of month, DDD = day of year
      expect(nov26.isoFormat('DD'), '26'); // Day 26 of the month
      expect(nov26.isoFormat('DDD'), '331'); // Day 331 of the year
      expect(nov26.isoFormat('MMM DD'), 'Nov 26'); // CORRECT for day of month
      expect(nov26.isoFormat('MMM DDD'), 'Nov 331'); // Day of year
    });

    test(
      'Summary: Use dd (lowercase) with format(), DD (uppercase) with isoFormat()',
      () {
        final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

        // For day of month display:
        expect(nov26.format('MMM dd'), 'Nov 26'); // format() needs lowercase
        expect(
          nov26.isoFormat('MMM DD'),
          'Nov 26',
        ); // isoFormat() uses uppercase
      },
    );
  });

  group('ISO Format - Day Tokens', () {
    test('D - day of month without padding', () {
      final date1 = Carbon.create(year: 2024, month: 11, day: 5);
      final date2 = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date1.isoFormat('D'), '5');
      expect(date2.isoFormat('D'), '26');
    });

    test('DD - day of month with padding', () {
      final date1 = Carbon.create(year: 2024, month: 11, day: 5);
      final date2 = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date1.isoFormat('DD'), '05');
      expect(date2.isoFormat('DD'), '26');
    });

    test('DDD - day of year without padding', () {
      final jan5 = Carbon.create(year: 2024, month: 1, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(jan5.isoFormat('DDD'), '5');
      expect(nov26.isoFormat('DDD'), '331'); // 2024 is a leap year
      expect(dec31.isoFormat('DDD'), '366');
    });

    test('DDDD - day of year with padding', () {
      final jan5 = Carbon.create(year: 2024, month: 1, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(jan5.isoFormat('DDDD'), '005');
      expect(nov26.isoFormat('DDDD'), '331');
      expect(dec31.isoFormat('DDDD'), '366');
    });

    test('d - single lowercase d token behavior', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // If 'd' is not implemented, it should return literal 'd' or be treated as day
      final result = date.format('d');
      print('Single lowercase d result: $result');

      // This test documents the actual behavior
      expect(result, isNotEmpty);
    });

    test('dd - double lowercase d token behavior', () {
      final date = Carbon.create(year: 2024, month: 11, day: 5);

      // If 'dd' is not implemented, it should return literal 'dd' or be treated as day
      final result = date.format('dd');
      print('Double lowercase dd result: $result');

      // This test documents the actual behavior
      expect(result, isNotEmpty);
    });

    test('ddd - short weekday name', () {
      final monday = Carbon.create(year: 2024, month: 11, day: 25); // Monday
      final tuesday = Carbon.create(year: 2024, month: 11, day: 26); // Tuesday

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(monday.isoFormat('ddd'), 'Mon');
      expect(tuesday.isoFormat('ddd'), 'Tue');
    });

    test('dddd - full weekday name', () {
      final monday = Carbon.create(year: 2024, month: 11, day: 25); // Monday
      final tuesday = Carbon.create(year: 2024, month: 11, day: 26); // Tuesday

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(monday.isoFormat('dddd'), 'Monday');
      expect(tuesday.isoFormat('dddd'), 'Tuesday');
    });

    test('Do - day of month with ordinal', () {
      final first = Carbon.create(year: 2024, month: 11, day: 1);
      final second = Carbon.create(year: 2024, month: 11, day: 2);
      final third = Carbon.create(year: 2024, month: 11, day: 3);
      final twentyFirst = Carbon.create(year: 2024, month: 11, day: 21);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(first.isoFormat('Do'), '1st');
      expect(second.isoFormat('Do'), '2nd');
      expect(third.isoFormat('Do'), '3rd');
      expect(twentyFirst.isoFormat('Do'), '21st');
    });
  });

  group('ISO Format - Month Tokens', () {
    test('M - month without padding', () {
      final jan = Carbon.create(year: 2024, month: 1, day: 15);
      final nov = Carbon.create(year: 2024, month: 11, day: 15);

      expect(jan.format('M'), '1');
      expect(nov.format('M'), '11');
    });

    test('MM - month with padding', () {
      final jan = Carbon.create(year: 2024, month: 1, day: 15);
      final nov = Carbon.create(year: 2024, month: 11, day: 15);

      expect(jan.format('MM'), '01');
      expect(nov.format('MM'), '11');
    });

    test('MMM - short month name', () {
      final jan = Carbon.create(year: 2024, month: 1, day: 15);
      final nov = Carbon.create(year: 2024, month: 11, day: 15);
      final dec = Carbon.create(year: 2024, month: 12, day: 15);

      expect(jan.format('MMM'), 'Jan');
      expect(nov.format('MMM'), 'Nov');
      expect(dec.format('MMM'), 'Dec');
    });

    test('MMMM - full month name', () {
      final jan = Carbon.create(year: 2024, month: 1, day: 15);
      final nov = Carbon.create(year: 2024, month: 11, day: 15);

      expect(jan.format('MMMM'), 'January');
      expect(nov.format('MMMM'), 'November');
    });

    test('Mo - month with ordinal', () {
      final jan = Carbon.create(year: 2024, month: 1, day: 15);
      final dec = Carbon.create(year: 2024, month: 12, day: 15);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(jan.isoFormat('Mo'), '1st');
      expect(dec.isoFormat('Mo'), '12th');
    });
  });

  group('ISO Format - Year Tokens', () {
    test('YY - 2-digit year', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date.isoFormat('YY'), '24');
    });

    test('YYYY - 4-digit year', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date.isoFormat('YYYY'), '2024');
    });

    test('YYYYY - 5-digit year with padding', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date.isoFormat('YYYYY'), '02024');
    });
  });

  group('ISO Format - Combined Patterns (Bug Investigation)', () {
    test('MMM DD with isoFormat - month name and padded day', () {
      final nov5 = Carbon.create(year: 2024, month: 11, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);

      // Using isoFormat() - DD means day of month
      expect(nov5.isoFormat('MMM DD'), 'Nov 05');
      expect(nov26.isoFormat('MMM DD'), 'Nov 26');
      expect(dec31.isoFormat('MMM DD'), 'Dec 31');
    });

    test('MMM DD with format - WRONG! Shows day of year', () {
      final nov5 = Carbon.create(year: 2024, month: 11, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // Using format() - DD means day of YEAR (this is the bug!)
      expect(nov5.format('MMM DD'), 'Nov 310'); // Day 310 of year
      expect(nov26.format('MMM DD'), 'Nov 331'); // Day 331 of year
    });

    test('MMM dd with format - CORRECT for day of month', () {
      final nov5 = Carbon.create(year: 2024, month: 11, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);

      // Using format() with lowercase dd - correct!
      expect(nov5.format('MMM dd'), 'Nov 05');
      expect(nov26.format('MMM dd'), 'Nov 26');
      expect(dec31.format('MMM dd'), 'Dec 31');
    });

    test('MMM D with format - day of year without padding', () {
      final nov5 = Carbon.create(year: 2024, month: 11, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Dart's DateFormat: D = day of year
      expect(nov5.format('MMM D'), 'Nov 310');
      expect(nov26.format('MMM D'), 'Nov 331');
    });

    test('MMM d with format - day of month without padding', () {
      final nov5 = Carbon.create(year: 2024, month: 11, day: 5);
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Dart's DateFormat: d = day of month
      expect(nov5.format('MMM d'), 'Nov 5');
      expect(nov26.format('MMM d'), 'Nov 26');
    });

    test('MMM DDD with isoFormat - month name and day of year', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // 2024 is a leap year, Nov 26 is day 331
      expect(nov26.isoFormat('MMM DDD'), 'Nov 331');
      expect(nov26.dayOfYear, 331);
    });

    test('Relative times - yesterday/tomorrow formatting CORRECTED', () {
      final now = Carbon.create(year: 2024, month: 11, day: 26);
      final yesterday = now.copy().subDay();
      final tomorrow = now.copy().addDay();

      // CORRECT: Use lowercase dd with format() for day of month
      expect(now.format('MMM dd'), 'Nov 26');
      expect(yesterday.format('MMM dd'), 'Nov 25');
      expect(tomorrow.format('MMM dd'), 'Nov 27');

      // OR use isoFormat() with uppercase DD
      expect(now.isoFormat('MMM DD'), 'Nov 26');
      expect(yesterday.isoFormat('MMM DD'), 'Nov 25');
      expect(tomorrow.isoFormat('MMM DD'), 'Nov 27');

      // WRONG: Using format() with uppercase DD shows day of year!
      expect(now.format('MMM DD'), 'Nov 331');
      expect(yesterday.format('MMM DD'), 'Nov 330'); // The bug!
      expect(tomorrow.format('MMM DD'), 'Nov 332'); // The bug!

      // Also test day of year to ensure we're not confusing it
      expect(now.dayOfYear, 331);
      expect(yesterday.dayOfYear, 330);
      expect(tomorrow.dayOfYear, 332);
    });

    test('Hour formatting - HH:mm', () {
      final morning = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 9,
        minute: 32,
      );
      final afternoon = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
      );

      expect(morning.format('HH:mm'), '09:32');
      expect(afternoon.format('HH:mm'), '14:32');
    });

    test('Full datetime format', () {
      final date = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
        second: 15,
      );

      // format() delegates to Dart's DateFormat - use lowercase for day
      expect(date.format('yyyy-MM-dd HH:mm:ss'), '2024-11-26 14:32:15');
      expect(date.format('MMM dd, yyyy'), 'Nov 26, 2024');

      // isoFormat() uses Carbon's formatter
      expect(date.isoFormat('YYYY-MM-DD HH:mm:ss'), '2024-11-26 14:32:15');
      expect(date.isoFormat('MMM DD, YYYY'), 'Nov 26, 2024');
      expect(
        date.isoFormat('dddd, MMMM Do, YYYY'),
        'Tuesday, November 26th, 2024',
      );
    });
  });

  group('ISO Format - Time Tokens', () {
    test('HH - 24-hour with padding', () {
      final morning = Carbon.create(year: 2024, month: 11, day: 26, hour: 9);
      final afternoon = Carbon.create(year: 2024, month: 11, day: 26, hour: 14);

      expect(morning.format('HH'), '09');
      expect(afternoon.format('HH'), '14');
    });

    test('H - 24-hour without padding', () {
      final morning = Carbon.create(year: 2024, month: 11, day: 26, hour: 9);
      final afternoon = Carbon.create(year: 2024, month: 11, day: 26, hour: 14);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(morning.isoFormat('H'), '9');
      expect(afternoon.isoFormat('H'), '14');
    });

    test('hh - 12-hour with padding', () {
      final midnight = Carbon.create(year: 2024, month: 11, day: 26, hour: 0);
      final morning = Carbon.create(year: 2024, month: 11, day: 26, hour: 9);
      final noon = Carbon.create(year: 2024, month: 11, day: 26, hour: 12);
      final afternoon = Carbon.create(year: 2024, month: 11, day: 26, hour: 14);

      expect(midnight.format('hh'), '12');
      expect(morning.format('hh'), '09');
      expect(noon.format('hh'), '12');
      expect(afternoon.format('hh'), '02');
    });

    test('mm - minutes with padding', () {
      final date1 = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 5,
      );
      final date2 = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
      );

      expect(date1.format('mm'), '05');
      expect(date2.format('mm'), '32');
    });

    test('ss - seconds with padding', () {
      final date1 = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
        second: 5,
      );
      final date2 = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
        second: 45,
      );

      expect(date1.format('ss'), '05');
      expect(date2.format('ss'), '45');
    });

    test('A and a - AM/PM indicators', () {
      final morning = Carbon.create(year: 2024, month: 11, day: 26, hour: 9);
      final afternoon = Carbon.create(year: 2024, month: 11, day: 26, hour: 14);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(morning.isoFormat('A'), 'AM');
      expect(afternoon.isoFormat('A'), 'PM');
      expect(morning.isoFormat('a'), 'am');
      expect(afternoon.isoFormat('a'), 'pm');
    });
  });

  group('ISO Format - Edge Cases', () {
    test('End of month transitions', () {
      final jan31 = Carbon.create(year: 2024, month: 1, day: 31);
      final feb1 = jan31.copy().addDay();

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(jan31.isoFormat('MMM DD'), 'Jan 31');
      expect(feb1.isoFormat('MMM DD'), 'Feb 01');
    });

    test('End of year transitions', () {
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);
      final jan1 = dec31.copy().addDay();

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(dec31.isoFormat('MMM DD'), 'Dec 31');
      expect(jan1.isoFormat('MMM DD'), 'Jan 01');
      expect(dec31.dayOfYear, 366); // Leap year
      expect(jan1.dayOfYear, 1);
    });

    test('Leap year day of year', () {
      final leapDay = Carbon.create(year: 2024, month: 2, day: 29);
      final dayAfter = leapDay.copy().addDay();

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(leapDay.isoFormat('MMM DD'), 'Feb 29');
      expect(dayAfter.isoFormat('MMM DD'), 'Mar 01');
      expect(leapDay.dayOfYear, 60);
      expect(dayAfter.dayOfYear, 61);
    });

    test('Non-leap year comparison', () {
      final feb28 = Carbon.create(year: 2023, month: 2, day: 28);
      final mar1 = feb28.copy().addDay();

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(feb28.isoFormat('MMM DD'), 'Feb 28');
      expect(mar1.isoFormat('MMM DD'), 'Mar 01');
      expect(feb28.dayOfYear, 59);
      expect(mar1.dayOfYear, 60);
    });
  });

  group('ISO Format - Literal Characters and Escaping', () {
    test('Brackets preserve literal text', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date.isoFormat('[Today is] MMM DD'), 'Today is Nov 26');
      expect(date.isoFormat('MMM DD [is the date]'), 'Nov 26 is the date');
    });

    test('Backslash escapes single character', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Using isoFormat() for PHP Carbon compatible behavior
      // Escaping a token character should make it literal
      final result = date.isoFormat(r'MMM \D\D');
      print('Escaped DD result: $result');

      // Document the behavior
      expect(result, isNotEmpty);
    });

    test('Mixed tokens and literals', () {
      final date = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
      );

      // Using isoFormat() for PHP Carbon compatible behavior
      expect(date.isoFormat('YYYY-MM-DD [at] HH:mm'), '2024-11-26 at 14:32');
    });
  });

  group('ISO Format - Documentation Example Scenarios', () {
    test('Simulate docs "Today" page relative times display - FIXED', () {
      // This simulates the exact scenario from the docs package
      final now = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
      );

      final hourAgo = now.copy().subHours(1);
      final hourAhead = now.copy().addHours(1);
      final yesterday = now.copy().subDay();
      final tomorrow = now.copy().addDay();

      // FIXED: Use lowercase dd with format() for day of month
      expect(hourAgo.format('HH:mm'), '13:32');
      expect(hourAhead.format('HH:mm'), '15:32');
      expect(yesterday.format('MMM dd'), 'Nov 25'); // Fixed: dd not DD
      expect(tomorrow.format('MMM dd'), 'Nov 27'); // Fixed: dd not DD

      // The BUG was using format('MMM DD') which shows day of year:
      expect(yesterday.format('MMM DD'), 'Nov 330'); // Day 330 of year - WRONG!
      expect(tomorrow.format('MMM DD'), 'Nov 332'); // Day 332 of year - WRONG!

      // Debug: show what day of year shows
      print('\nDebug info for Nov 26, 2024:');
      print(
        'Correct format: ${now.format('MMM dd')} (using dd for day of month)',
      );
      print(
        'BUG format: ${now.format('MMM DD')} (DD shows day of year ${now.dayOfYear})',
      );
      print(
        'Yesterday: ${yesterday.format('MMM dd')} vs ${yesterday.format('MMM DD')} (day ${yesterday.dayOfYear})',
      );
      print(
        'Tomorrow: ${tomorrow.format('MMM dd')} vs ${tomorrow.format('MMM DD')} (day ${tomorrow.dayOfYear})',
      );
    });

    test('Verify DD vs dd difference clearly - format() method', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Dart's DateFormat (used by format()):
      // DD = day of year (1-366)
      // dd = day of month (01-31)
      expect(
        nov26.format('DD'),
        '331',
        reason: 'DD in DateFormat is day of year',
      );
      expect(
        nov26.format('dd'),
        '26',
        reason: 'dd in DateFormat is day of month',
      );

      // Combined with month name
      expect(
        nov26.format('MMM DD'),
        'Nov 331',
        reason: 'DD shows day of year - NOT what we want!',
      );
      expect(
        nov26.format('MMM dd'),
        'Nov 26',
        reason: 'dd shows day of month - correct!',
      );
    });

    test('Verify DD vs DDD difference clearly - isoFormat() method', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Carbon's ISO formatter (used by isoFormat()):
      // DD = day of month (01-31)
      // DDD = day of year (1-366)
      expect(
        nov26.isoFormat('DD'),
        '26',
        reason: 'DD in isoFormat is day of month',
      );
      expect(
        nov26.isoFormat('DDD'),
        '331',
        reason: 'DDD in isoFormat is day of year',
      );

      // Combined with month name
      expect(
        nov26.isoFormat('MMM DD'),
        'Nov 26',
        reason: 'DD shows day of month - correct!',
      );
      expect(
        nov26.isoFormat('MMM DDD'),
        'Nov 331',
        reason: 'DDD shows day of year',
      );
    });
  });

  group('ISO Format - Token Precedence', () {
    test('Longer tokens are matched first - isoFormat()', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // In isoFormat: DDDD should be matched before DDD, DD, or D
      // Per PHP Carbon: DDDD is day of year with padding (3 digits minimum)
      expect(date.isoFormat('DDDD'), '331'); // Day 331 of year (no leading zero needed)
      expect(date.isoFormat('DDD'), '331'); // Day of year
      expect(date.isoFormat('DD'), '26'); // Day of month
      expect(date.isoFormat('D'), '26'); // Day of month
    });

    test('format() uses Dart DateFormat tokens', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // In format (Dart's DateFormat): D/DD = day of year, d/dd = day of month
      expect(date.format('DD'), '331'); // Day of year
      expect(date.format('D'), '331'); // Day of year
      expect(date.format('dd'), '26'); // Day of month
      expect(date.format('d'), '26'); // Day of month
    });

    test('MMMM vs MMM vs MM vs M - works same in both', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // Month tokens work the same in both format() and isoFormat()
      expect(date.format('MMMM'), 'November');
      expect(date.format('MMM'), 'Nov');
      expect(date.format('MM'), '11');
      expect(date.format('M'), '11');

      expect(date.isoFormat('MMMM'), 'November');
      expect(date.isoFormat('MMM'), 'Nov');
      expect(date.isoFormat('MM'), '11');
      expect(date.isoFormat('M'), '11');
    });

    test('dddd vs ddd vs dd vs d - weekday vs day tokens', () {
      final tuesday = Carbon.create(year: 2024, month: 11, day: 26);

      // In isoFormat() (Carbon's formatter) - PHP Carbon compatible:
      // dddd = full weekday name, ddd = short weekday name
      // dd = min weekday name, d = day of week number
      expect(tuesday.isoFormat('dddd'), 'Tuesday');
      expect(tuesday.isoFormat('ddd'), 'Tue');
      // Use DD for day of month in isoFormat
      expect(tuesday.isoFormat('DD'), '26');
      expect(tuesday.isoFormat('D'), '26');

      // In format() (Dart's DateFormat):
      // dd/d = day of month
      expect(tuesday.format('dd'), '26'); // Day of month
      expect(tuesday.format('d'), '26'); // Day of month
    });
  });
}

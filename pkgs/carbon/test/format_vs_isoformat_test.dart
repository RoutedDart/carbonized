import 'package:test/test.dart';
import 'package:carbon/carbon.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Tests documenting the critical difference between Carbon's format() and isoFormat() methods.
///
/// This test file was created to document and prevent a bug found in the Carbon docs package
/// where using format('MMM DD') showed day-of-year (330, 332) instead of day-of-month (25, 27).
///
/// KEY INSIGHT:
/// - format() delegates to Dart's intl DateFormat: DD = day of year, dd = day of month
/// - isoFormat() uses Carbon's formatter: DD = day of month, DDD = day of year
void main() {
  setUpAll(() async {
    await initializeDateFormatting('en_US', null);
    Intl.defaultLocale = 'en_US';
  });

  group('format() vs isoFormat() - Day Token Differences', () {
    test('format() uses Dart DateFormat where DD = day of year', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Dart's DateFormat (used by format()):
      // D/DD = day of year (1-366)
      // d/dd = day of month (1-31)
      expect(nov26.format('DD'), '331'); // Day 331 of the year
      expect(nov26.format('dd'), '26'); // Day 26 of the month
      expect(nov26.format('D'), '331'); // Day of year
      expect(nov26.format('d'), '26'); // Day of month
    });

    test('isoFormat() uses Carbon formatter where DD = day of month', () {
      final nov26 = Carbon.create(year: 2024, month: 11, day: 26);

      // In Carbon's ISO formatter (used by isoFormat()):
      // D/DD = day of month (1-31)
      // DDD/DDDD = day of year (1-366)
      expect(nov26.isoFormat('DD'), '26'); // Day 26 of the month (padded)
      expect(nov26.isoFormat('D'), '26'); // Day 26 of the month
      expect(nov26.isoFormat('DDD'), '331'); // Day 331 of the year
      expect(nov26.isoFormat('DDDD'), '331'); // Padded day of year (3 digits)
    });

    test('Bug reproduction: format("MMM DD") shows day of year', () {
      final now = Carbon.create(year: 2024, month: 11, day: 26);
      final yesterday = now.copy().subDay();
      final tomorrow = now.copy().addDay();

      // THE BUG: Using format() with uppercase DD
      expect(now.format('MMM DD'), 'Nov 331'); // Shows day of year!
      expect(yesterday.format('MMM DD'), 'Nov 330'); // The bug from the docs
      expect(tomorrow.format('MMM DD'), 'Nov 332'); // The bug from the docs

      // Verify these are the correct day-of-year values
      expect(now.dayOfYear, 331);
      expect(yesterday.dayOfYear, 330);
      expect(tomorrow.dayOfYear, 332);
    });

    test('Bug fix: format("MMM dd") shows day of month correctly', () {
      final now = Carbon.create(year: 2024, month: 11, day: 26);
      final yesterday = now.copy().subDay();
      final tomorrow = now.copy().addDay();

      // THE FIX: Using format() with lowercase dd
      expect(now.format('MMM dd'), 'Nov 26'); // Correct!
      expect(yesterday.format('MMM dd'), 'Nov 25'); // Fixed!
      expect(tomorrow.format('MMM dd'), 'Nov 27'); // Fixed!
    });

    test('Alternative fix: isoFormat("MMM DD") works correctly', () {
      final now = Carbon.create(year: 2024, month: 11, day: 26);
      final yesterday = now.copy().subDay();
      final tomorrow = now.copy().addDay();

      // Alternative: Using isoFormat() with uppercase DD
      expect(now.isoFormat('MMM DD'), 'Nov 26'); // Correct!
      expect(yesterday.isoFormat('MMM DD'), 'Nov 25'); // Correct!
      expect(tomorrow.isoFormat('MMM DD'), 'Nov 27'); // Correct!
    });
  });

  group('Real-world examples from docs', () {
    test('Docs "Today" page scenario - reproduces the exact bug', () {
      // This is the exact scenario from carbon/pkgs/docs/web/live_sections.dart
      // On Nov 26, 2024 at 14:32
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

      // Hour formatting works fine with both methods
      expect(hourAgo.format('HH:mm'), '13:32');
      expect(hourAhead.format('HH:mm'), '15:32');

      // THE BUG: Originally used format('MMM DD')
      expect(yesterday.format('MMM DD'), 'Nov 330'); // BUG: Shows day of year
      expect(tomorrow.format('MMM DD'), 'Nov 332'); // BUG: Shows day of year

      // THE FIX: Changed to format('MMM dd')
      expect(yesterday.format('MMM dd'), 'Nov 25'); // FIXED!
      expect(tomorrow.format('MMM dd'), 'Nov 27'); // FIXED!
    });

    test('Common date display patterns - format() method', () {
      final date = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
        second: 15,
      );

      // Common patterns using format() - use lowercase for day of month
      expect(date.format('MMM dd'), 'Nov 26');
      expect(date.format('MMM dd, yyyy'), 'Nov 26, 2024');
      expect(date.format('yyyy-MM-dd'), '2024-11-26');
      expect(date.format('MM/dd/yyyy'), '11/26/2024');
      expect(date.format('EEEE, MMM dd'), 'Tuesday, Nov 26');
    });

    test('Common date display patterns - isoFormat() method', () {
      final date = Carbon.create(
        year: 2024,
        month: 11,
        day: 26,
        hour: 14,
        minute: 32,
        second: 15,
      );

      // Common patterns using isoFormat() - use uppercase for day of month
      expect(date.isoFormat('MMM DD'), 'Nov 26');
      expect(date.isoFormat('MMM DD, YYYY'), 'Nov 26, 2024');
      expect(date.isoFormat('YYYY-MM-DD'), '2024-11-26');
      expect(date.isoFormat('MM/DD/YYYY'), '11/26/2024');
      expect(date.isoFormat('dddd, MMM DD'), 'Tuesday, Nov 26');
    });
  });

  group('Edge cases and boundary conditions', () {
    test('End of month transitions', () {
      final jan31 = Carbon.create(year: 2024, month: 1, day: 31);
      final feb1 = jan31.copy().addDay();

      // format() with lowercase dd
      expect(jan31.format('MMM dd'), 'Jan 31');
      expect(feb1.format('MMM dd'), 'Feb 01');

      // isoFormat() with uppercase DD
      expect(jan31.isoFormat('MMM DD'), 'Jan 31');
      expect(feb1.isoFormat('MMM DD'), 'Feb 01');

      // Day of year values (for reference)
      expect(jan31.dayOfYear, 31);
      expect(feb1.dayOfYear, 32);
    });

    test('End of year transitions', () {
      final dec31 = Carbon.create(year: 2024, month: 12, day: 31);
      final jan1 = dec31.copy().addDay();

      // format() with lowercase dd
      expect(dec31.format('MMM dd'), 'Dec 31');
      expect(jan1.format('MMM dd'), 'Jan 01');

      // isoFormat() with uppercase DD
      expect(dec31.isoFormat('MMM DD'), 'Dec 31');
      expect(jan1.isoFormat('MMM DD'), 'Jan 01');

      // Day of year values (2024 is a leap year)
      expect(dec31.dayOfYear, 366);
      expect(jan1.dayOfYear, 1);
    });

    test('Leap year February 29', () {
      final feb29 = Carbon.create(year: 2024, month: 2, day: 29);
      final mar1 = feb29.copy().addDay();

      // format() with lowercase dd
      expect(feb29.format('MMM dd'), 'Feb 29');
      expect(mar1.format('MMM dd'), 'Mar 01');

      // isoFormat() with uppercase DD
      expect(feb29.isoFormat('MMM DD'), 'Feb 29');
      expect(mar1.isoFormat('MMM DD'), 'Mar 01');

      // Day of year values
      expect(feb29.dayOfYear, 60);
      expect(mar1.dayOfYear, 61);
    });
  });

  group('Documentation and usage guidelines', () {
    test('Quick reference: Day of month patterns', () {
      final date = Carbon.create(year: 2024, month: 11, day: 5);

      // format() method - use lowercase d/dd
      expect(date.format('d'), '5'); // Single digit, no padding
      expect(date.format('dd'), '05'); // Zero-padded

      // isoFormat() method - use uppercase D/DD
      expect(date.isoFormat('D'), '5'); // Single digit, no padding
      expect(date.isoFormat('DD'), '05'); // Zero-padded
    });

    test('Quick reference: Day of year patterns', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // format() method - use uppercase D/DD
      expect(date.format('D'), '331'); // Day of year
      expect(
        date.format('DD'),
        '331',
      ); // Same (no standard padding in DateFormat)

      // isoFormat() method - use DDD/DDDD
      expect(date.isoFormat('DDD'), '331'); // Day of year, no padding
      expect(date.isoFormat('DDDD'), '331'); // Day of year, padded to 3 digits
    });

    test('Summary: Use the right token for the right method', () {
      final date = Carbon.create(year: 2024, month: 11, day: 26);

      // ✓ CORRECT usage
      expect(date.format('MMM dd'), 'Nov 26'); // format() + lowercase dd
      expect(date.isoFormat('MMM DD'), 'Nov 26'); // isoFormat() + uppercase DD

      // ✗ INCORRECT usage (shows day of year instead of day of month)
      expect(
        date.format('MMM DD'),
        'Nov 331',
      ); // format() + uppercase DD = BUG!

      // Rule of thumb:
      // - format() follows Dart's intl conventions: use lowercase d/dd
      // - isoFormat() follows Carbon/Moment.js conventions: use uppercase D/DD
    });
  });
}

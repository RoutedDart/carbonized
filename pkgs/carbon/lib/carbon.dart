/// A fluent date and time library for Dart, inspired by PHP's Carbon.
///
/// Carbon is a comprehensive date/time library that makes working with dates
/// and times in Dart/Flutter intuitive and enjoyable. It provides a fluent,
/// expressive API with full timezone support, localization, and extensive date
/// manipulation capabilities. While Carbon can interoperate with Dart's native
/// DateTime, it is a complete standalone implementation.
///
/// ## Features
///
/// - **Fluent API**: Chain methods for readable date operations
/// - **Timezone Support**: Full IANA timezone database via `time_machine`
/// - **Localization**: Locale-aware formatting in 100+ languages
/// - **Date Math**: Calendar operations with overflow handling
/// - **Mutable & Immutable**: Choose `Carbon` or `CarbonImmutable`
/// - **Intervals & Periods**: Work with date ranges and recurrence
/// - **Testing Helpers**: Freeze time with `setTestNow()`
/// - **DateTime Interop**: Seamlessly convert to/from native DateTime when needed
///
/// ## Quick Start
///
/// ```dart
/// import 'package:carbon/carbon.dart';
///
/// void main() {
///   // Current time
///   final now = Carbon.now();
///   print(now.toIso8601String());
///
///   // Fluent manipulation
///   final nextWeek = Carbon.now().addWeeks(1).startOfDay();
///   print('Next week: ${nextWeek.format('yyyy-MM-dd')}');
///
///   // Human-readable differences
///   final birthday = Carbon.parse('1990-05-15');
///   print(birthday.diffForHumans()); // "34 years ago"
///
///   // Comparisons
///   if (now.isWeekend()) {
///     print('Enjoy your weekend! 🎉');
///   }
/// }
/// ```
///
/// ## Creating Carbon Instances
///
/// ```dart
/// // From current time
/// final now = Carbon.now();
/// final today = Carbon.today();
/// final tomorrow = Carbon.tomorrow();
///
/// // Parsing
/// final parsed = Carbon.parse('2024-12-25');
/// final fromFormat = Carbon.createFromFormat('d/m/Y', '25/12/2024');
/// final fromTimestamp = Carbon.createFromTimestampSeconds(1735084800);
///
/// // Specific date/time
/// final custom = Carbon.create(2024, 12, 25, 10, 30, 0);
/// final fromDateTime = Carbon(DateTime(2024, 12, 25));
/// ```
///
/// ## Date Manipulation
///
/// ```dart
/// final date = Carbon.parse('2024-01-15');
///
/// // Add/subtract time
/// date.addDays(5);          // 2024-01-20
/// date.subWeeks(2);         // 2024-01-01
/// date.addMonths(3);        // 2024-04-15
///
/// // Start/end of periods
/// date.startOfDay();        // 2024-01-15 00:00:00
/// date.endOfWeek();         // 2024-01-21 23:59:59
/// date.startOfMonth();      // 2024-01-01 00:00:00
///
/// // Next/previous
/// date.nextWeekday();
/// date.previousSunday();
/// ```
///
/// ## Comparisons
///
/// ```dart
/// final first = Carbon.parse('2024-01-15');
/// final second = Carbon.parse('2024-02-20');
///
/// first.isBefore(second);        // true
/// first.isAfter(second);         // false
/// first.equalTo(second);         // false
/// first.between(start, end);     // Check if between dates
///
/// // Boolean checks
/// first.isWeekday();            // true
/// first.isWeekend();            // false
/// first.isToday();              // false
/// first.isPast();               // true
/// first.isFuture();             // false
/// first.isLeapYear();           // true
/// ```
///
/// ## Human-Readable Differences
///
/// ```dart
/// final past = Carbon.parse('2023-01-15');
/// final future = Carbon.parse('2025-12-31');
///
/// print(past.diffForHumans());           // "1 year ago"
/// print(future.diffForHumans());         // "1 year from now"
///
/// // Absolute differences
/// final days = past.diffInDays(future);   // 715
/// final hours = past.diffInHours(future); // 17160
/// ```
///
/// ## Localization
///
/// ```dart
/// import 'package:intl/date_symbol_data_local.dart';
///
/// Future<void> main() async {
///   await initializeDateFormatting('fr');
///
///   final date = Carbon.parse('2024-12-25').locale('fr_FR');
///
///   print(date.translatedFormat('l j F Y'));
///   // "mercredi 25 décembre 2024"
///
///   print(date.diffForHumans());
///   // "il y a 1 an"
/// }
/// ```
///
/// ## Timezone Support
///
/// ```dart
/// Future<void> main() async {
///   // Initialize timezone database (required for IANA names)
///   await Carbon.configureTimeMachine(testing: true);
///
///   // Create with timezone
///   final tokyo = Carbon.parse('2024-01-15 12:00',
///     timeZone: 'Asia/Tokyo');
///   final ny = Carbon.parse('2024-01-15 12:00',
///     timeZone: 'America/New_York');
///
///   // Convert between timezones
///   final tokyoTime = ny.tz('Asia/Tokyo');
///
///   // Fixed offset
///   final offset = Carbon.now(timeZone: '+05:30');
///
///   // Get timezone info
///   print(tokyo.timeZoneName);        // "JST"
///   print(tokyo.offsetHours);         // 9
///   print(tokyo.isDST());             // false
/// }
/// ```
///
/// ## Mutable vs Immutable
///
/// ```dart
/// // Mutable (modifies original instance)
/// final mutable = Carbon.parse('2024-01-15');
/// final modified = mutable.addDays(1);
/// print(identical(mutable, modified)); // true
///
/// // Immutable (creates new instance)
/// final immutable = CarbonImmutable.parse('2024-01-15');
/// final newInstance = immutable.addDays(1);
/// print(identical(immutable, newInstance)); // false
///
/// // Convert between types
/// final toImmutable = mutable.toImmutable();
/// final toMutable = immutable.toMutable();
/// ```
///
/// ## Testing Helpers
///
/// ```dart
/// void testSomething() {
///   // Freeze time for testing
///   Carbon.setTestNow('2024-01-15 10:00:00');
///
///   final now = Carbon.now();
///   print(now.toIso8601String());
///   // Always "2024-01-15T10:00:00.000Z"
///
///   // Travel in time
///   Carbon.setTestNow(Carbon.parse('2025-06-01'));
///
///   // Reset to real time
///   Carbon.setTestNow();
/// }
/// ```
///
/// ## Formatting
///
/// ```dart
/// final date = Carbon.parse('2024-12-25 15:30:45');
///
/// // Standard formatting
/// date.format('yyyy-MM-dd');              // "2024-12-25"
/// date.format('EEE, MMM d, yyyy');        // "Wed, Dec 25, 2024"
///
/// // ISO formats
/// date.toIso8601String();                 // "2024-12-25T15:30:45.000"
///
/// // Locale-aware
/// date.isoFormat('LLLL');                 // "December 25, 2024"
/// date.translatedFormat('l j F Y');       // Localized
/// ```
///
/// ## Intervals & Periods
///
/// ```dart
/// // Create intervals
/// final interval = CarbonInterval.days(5).hours(3);
/// print(interval.totalHours); // 123
///
/// // Date periods (ranges)
/// final start = Carbon.parse('2024-01-01');
/// final end = Carbon.parse('2024-01-10');
/// final period = CarbonPeriod(start, end);
///
/// for (final date in period) {
///   print(date.toIso8601String());
/// }
///
/// // Recurring intervals
/// final weekly = CarbonPeriod.create(
///   start,
///   CarbonInterval.weeks(1),
///   end,
/// );
/// ```
///
/// ## Custom Methods (Macros)
///
/// ```dart
/// // Register custom methods
/// Carbon.macro('addWorkDays', (CarbonInterface self, int days) {
///   var result = self as Carbon;
///   for (var i = 0; i < days; i++) {
///     result = result.addDay();
///     if (result.isWeekend()) {
///       result = result.nextWeekday();
///     }
///   }
///   return result;
/// });
///
/// // Use custom method
/// final date = Carbon.parse('2024-01-15');
/// final workDate = date.call('addWorkDays', [5]);
/// ```
///
/// ## Important Notes
///
/// ### Timezone Configuration
///
/// Before using IANA timezone names like `America/Vancouver` or `Europe/Paris`,
/// you must initialize the timezone database:
///
/// ```dart
/// await Carbon.configureTimeMachine(testing: true);
/// ```
///
/// Fixed offset strings like `+05:00` work without configuration.
///
/// ### Localization Setup
///
/// For locale-aware formatting, initialize the desired locales:
///
/// ```dart
/// import 'package:intl/date_symbol_data_local.dart';
/// await initializeDateFormatting('fr');
/// ```
///
/// ### Mutability
///
/// `Carbon` is mutable by default (operations modify the instance).
/// Use `CarbonImmutable` when you need immutable behavior (operations return
/// new instances).
///
/// ## See Also
///
/// - [Carbon for PHP](https://carbon.nesbot.com/) - Original implementation
/// - [time_machine](https://pub.dev/packages/time_machine) - Timezone support
/// - [intl](https://pub.dev/packages/intl) - Internationalization
///
/// {@category DateTime}
library;

export 'src/carbon.dart'
    show
        Carbon,
        CarbonImmutable,
        CarbonInterface,
        CarbonPeriod,
        CarbonMacro,
        CarbonDateTimeView,
        CarbonDateTimeInterop,
        CarbonSettings,
        CarbonLastErrors,
        CarbonComponents,
        CarbonInterval,
        CarbonUnit,
        CarbonAliasShims,
        CarbonInvalidDateException,
        CarbonMessageException,
        CarbonInvalidArgumentException,
        CarbonRuntimeException,
        CarbonBadMethodCallException,
        CarbonUnitException,
        CarbonUnknownGetterException,
        CarbonUnknownSetterException,
        CarbonUnknownMethodException,
        CarbonBadFluentConstructorException,
        CarbonBadFluentSetterException,
        CarbonUnknownUnitException,
        CarbonUnsupportedUnitException,
        CarbonUnitNotConfiguredException,
        CarbonBadComparisonUnitException,
        CarbonInvalidTimeZoneException,
        CarbonImmutableException,
        CarbonEndLessPeriodException,
        CarbonParseErrorException,
        CarbonOutOfRangeException,
        CarbonNotLocaleAwareException,
        CarbonNotACarbonClassException,
        CarbonNotAPeriodException,
        CarbonInvalidFormatException,
        CarbonInvalidIntervalException,
        CarbonInvalidPeriodParameterException,
        CarbonInvalidPeriodDateException,
        CarbonInvalidCastException,
        CarbonInvalidTypeException,
        CarbonUnreachableException,
        CarbonFactory,
        CarbonTranslator,
        CarbonLocaleData,
        CarbonTestSubclass,
        allLocales;

/// Translation data for a specific locale, mirroring PHP Carbon's structure.
part of '../carbon.dart';

typedef OrdinalFunction = String Function(int number, String period);
typedef MeridiemFunction = String Function(int hour, int minute, bool isLower);

class CarbonLocaleData {
  /// The locale code (e.g., "en", "fr_FR").
  final String localeCode;

  /// Mapping of digits/characters that should be replaced before formatting.
  final Map<String, String> numbers;

  /// Alternate digit mapping used by `getAltNumber()`.
  final Map<String, String> altNumbers;

  /// Custom replacements applied to the result of `diffForHumans()` and similar
  /// helpers.
  final Map<String, String> timeStrings;

  /// Optional `timeago` message bundle for humanized relative strings.
  final timeago.LookupMessages? timeagoMessages;

  /// Raw translation strings from PHP Carbon (e.g., 'year', 'a_year').
  final Map<String, String> translationStrings;

  /// PHP Carbon's format definitions (e.g., 'LT', 'LLLL').
  final Map<String, String> formats;

  /// PHP Carbon's calendar definitions.
  final Map<String, String> calendar;

  /// Function to generate ordinal suffixes.
  final OrdinalFunction? ordinal;

  /// Meridiem function (e.g., returns ['AM']/'PM'] based on hour).
  final MeridiemFunction? meridiem;

  /// Full month names.
  final List<String> months;

  /// Short month names.
  final List<String> monthsShort;

  /// Full weekday names.
  final List<String> weekdays;

  /// Short weekday names.
  final List<String> weekdaysShort;

  /// Minimum weekday names.
  final List<String> weekdaysMin;

  /// First day of the week (1 = Monday, 7 = Sunday).
  final int firstDayOfWeek;

  /// Day of the first week of the year.
  final int dayOfFirstWeekOfYear;

  /// List separators (e.g., [', ', ' and ']).
  final List<String> listSeparators;

  /// Words used for ordinal replacements (e.g., 'first' -> 'premier').
  final Map<String, String> ordinalWords;

  /// Standalone month names (nominative case).
  final List<String> monthsStandalone;

  /// Standalone weekday names (nominative case).
  final List<String> weekdaysStandalone;

  /// Period recurrences string.
  final String? periodRecurrences;

  /// Period interval string.
  final String? periodInterval;

  /// Period start date string.
  final String? periodStartDate;

  /// Period end date string.
  final String? periodEndDate;

  const CarbonLocaleData({
    required this.localeCode,
    this.numbers = const {},
    this.altNumbers = const {},
    this.timeStrings = const {},
    this.timeagoMessages,
    this.translationStrings = const {},
    this.formats = const {},
    this.calendar = const {},
    this.ordinal,
    this.meridiem,
    this.months = const [],
    this.monthsShort = const [],
    this.weekdays = const [],
    this.weekdaysShort = const [],
    this.weekdaysMin = const [],
    this.ordinalWords = const {},
    this.monthsStandalone = const [],
    this.weekdaysStandalone = const [],
    this.firstDayOfWeek = 1,
    this.dayOfFirstWeekOfYear = 4,
    this.listSeparators = const [],
    this.periodRecurrences,
    this.periodInterval,
    this.periodStartDate,
    this.periodEndDate,
  });

  /// Merges this locale data with another, prioritizing values from [other].
  CarbonLocaleData merge(CarbonLocaleData other) {
    return CarbonLocaleData(
      localeCode: other.localeCode,
      numbers: {...numbers, ...other.numbers},
      altNumbers: {...altNumbers, ...other.altNumbers},
      timeStrings: {...timeStrings, ...other.timeStrings},
      timeagoMessages: other.timeagoMessages ?? timeagoMessages,
      translationStrings: {...translationStrings, ...other.translationStrings},
      formats: {...formats, ...other.formats},
      calendar: {...calendar, ...other.calendar},
      ordinal: other.ordinal ?? ordinal,
      meridiem: other.meridiem ?? meridiem,
      months: other.months.isNotEmpty ? other.months : months,
      monthsShort: other.monthsShort.isNotEmpty
          ? other.monthsShort
          : monthsShort,
      weekdays: other.weekdays.isNotEmpty ? other.weekdays : weekdays,
      weekdaysShort: other.weekdaysShort.isNotEmpty
          ? other.weekdaysShort
          : weekdaysShort,
      weekdaysMin: other.weekdaysMin.isNotEmpty
          ? other.weekdaysMin
          : weekdaysMin,
      firstDayOfWeek: other.firstDayOfWeek != 1
          ? other.firstDayOfWeek
          : firstDayOfWeek,
      dayOfFirstWeekOfYear: other.dayOfFirstWeekOfYear != 4
          ? other.dayOfFirstWeekOfYear
          : dayOfFirstWeekOfYear,
      listSeparators: other.listSeparators.isNotEmpty
          ? other.listSeparators
          : listSeparators,
      ordinalWords: {...ordinalWords, ...other.ordinalWords},
      monthsStandalone: other.monthsStandalone.isNotEmpty
          ? other.monthsStandalone
          : monthsStandalone,
      weekdaysStandalone: other.weekdaysStandalone.isNotEmpty
          ? other.weekdaysStandalone
          : weekdaysStandalone,
      periodRecurrences: other.periodRecurrences ?? periodRecurrences,
      periodInterval: other.periodInterval ?? periodInterval,
      periodStartDate: other.periodStartDate ?? periodStartDate,
      periodEndDate: other.periodEndDate ?? periodEndDate,
    );
  }

  /// Creates a copy of this locale data with specified fields overridden.
  ///
  /// This is useful for creating regional variants that differ only in
  /// specific fields from a base locale.
  ///
  /// Example:
  /// ```dart
  /// final ruBy = localeRu.copyWith(
  ///   localeCode: 'ru_BY',
  ///   firstDayOfWeek: 0,
  /// );
  /// ```
  CarbonLocaleData copyWith({
    String? localeCode,
    Map<String, String>? numbers,
    Map<String, String>? altNumbers,
    Map<String, String>? timeStrings,
    timeago.LookupMessages? timeagoMessages,
    Map<String, String>? translationStrings,
    Map<String, String>? formats,
    Map<String, String>? calendar,
    OrdinalFunction? ordinal,
    MeridiemFunction? meridiem,
    List<String>? months,
    List<String>? monthsShort,
    List<String>? weekdays,
    List<String>? weekdaysShort,
    List<String>? weekdaysMin,
    Map<String, String>? ordinalWords,
    List<String>? monthsStandalone,
    List<String>? weekdaysStandalone,
    int? firstDayOfWeek,
    int? dayOfFirstWeekOfYear,
    List<String>? listSeparators,
    String? periodRecurrences,
    String? periodInterval,
    String? periodStartDate,
    String? periodEndDate,
  }) {
    return CarbonLocaleData(
      localeCode: localeCode ?? this.localeCode,
      numbers: numbers ?? this.numbers,
      altNumbers: altNumbers ?? this.altNumbers,
      timeStrings: timeStrings ?? this.timeStrings,
      timeagoMessages: timeagoMessages ?? this.timeagoMessages,
      translationStrings: translationStrings ?? this.translationStrings,
      formats: formats ?? this.formats,
      calendar: calendar ?? this.calendar,
      ordinal: ordinal ?? this.ordinal,
      meridiem: meridiem ?? this.meridiem,
      months: months ?? this.months,
      monthsShort: monthsShort ?? this.monthsShort,
      weekdays: weekdays ?? this.weekdays,
      weekdaysShort: weekdaysShort ?? this.weekdaysShort,
      weekdaysMin: weekdaysMin ?? this.weekdaysMin,
      ordinalWords: ordinalWords ?? this.ordinalWords,
      monthsStandalone: monthsStandalone ?? this.monthsStandalone,
      weekdaysStandalone: weekdaysStandalone ?? this.weekdaysStandalone,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      dayOfFirstWeekOfYear: dayOfFirstWeekOfYear ?? this.dayOfFirstWeekOfYear,
      listSeparators: listSeparators ?? this.listSeparators,
      periodRecurrences: periodRecurrences ?? this.periodRecurrences,
      periodInterval: periodInterval ?? this.periodInterval,
      periodStartDate: periodStartDate ?? this.periodStartDate,
      periodEndDate: periodEndDate ?? this.periodEndDate,
    );
  }
}

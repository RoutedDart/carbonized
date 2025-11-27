part of '../carbon.dart';

/// Registry for language overrides inspired by PHP's `Translator` class.
class CarbonTranslator {
  CarbonTranslator._();

  static final Map<String, CarbonLocaleData> _translations =
      <String, CarbonLocaleData>{};
  static final Map<String, List<String>> _fallbackLocales =
      <String, List<String>>{};
  static final Set<String> _registeredTimeagoLocales = <String>{};
  static bool _defaultsReady = false;
  static const String _defaultLocale = 'en';

  /// Registers a locale so translators and `diffForHumans()` can look it up.
  static void registerLocale(
    String locale,
    CarbonLocaleData translation, {
    List<String>? fallbackLocales,
  }) {
    final normalized = _normalizeLocale(locale);
    _translations[normalized] = translation;
    if (fallbackLocales != null) {
      _fallbackLocales[normalized] = fallbackLocales
          .map(_normalizeLocale)
          .toList();
    }
    final messages = translation.timeagoMessages;
    if (messages != null) {
      timeago.setLocaleMessages(normalized, messages);
      _registeredTimeagoLocales.add(normalized);
    }
  }

  /// Overrides the fallback locales for [locale].
  static void setFallbackLocales(String locale, List<String> fallbacks) {
    _fallbackLocales[_normalizeLocale(locale)] = fallbacks
        .map(_normalizeLocale)
        .toList();
  }

  /// Sets a single fallback locale for the default locale.
  static void setFallbackLocale(String locale) {
    setFallbackLocales(_defaultLocale, <String>[locale]);
  }

  /// Gets the first fallback locale for the default locale, or null if none set.
  static String? getFallbackLocale() {
    final fallbacks = _fallbackLocales[_normalizeLocale(_defaultLocale)];
    return fallbacks?.isNotEmpty == true ? fallbacks!.first : null;
  }

  /// Clears all registered locales and fallback settings (primarily for tests).
  static void resetTranslations() {
    _translations.clear();
    _fallbackLocales.clear();
    _registeredTimeagoLocales.clear();
    _defaultsReady = false;
  }

  /// Ensures `timeago` has messages for [locale].
  static String translateTimeString(
    String timeString, {
    String? from,
    String? to,
    String? locale,
    bool translateMonths = true,
    bool translateDays = true,
    bool translateDiff = true,
    bool translateUnits = true,
    bool translateMeridiem = true,
  }) {
    final fromLocale = from ?? _defaultLocale;
    final toLocale = to ?? locale ?? _defaultLocale;

    if (fromLocale == toLocale) {
      return timeString;
    }

    // Standardize apostrophe
    var processedString = timeString.replaceAll('’', "'");

    final fromTranslations = <String>[];
    final toTranslations = <String>[];

    for (final key in ['from', 'to']) {
      final language = key == 'from' ? fromLocale : toLocale;
      final data = matchLocale(language);

      final messages = data.translationStrings;
      final months = data.months;
      final weekdays = data.weekdays;
      // Meridiem handling skipped for now as it requires function execution

      if (data.ordinalWords.isNotEmpty) {
        // Replace ordinal words
        final ordinalMap = key == 'from'
            ? data.ordinalWords.map(
                (k, v) => MapEntry(v, k),
              ) // Reverse for 'from'
            : data.ordinalWords;

        processedString = processedString.replaceAllMapped(
          RegExp(r'(?<![a-z])[a-z]+(?![a-z])', caseSensitive: false),
          (match) {
            final word = match.group(0)!;
            return ordinalMap[word.toLowerCase()] ?? word;
          },
        );
      }

      // Prepare lists for replacement
      final currentTranslations = <String>[];

      if (translateMonths) {
        currentTranslations.addAll(
          _getTranslationArray(months, 12, processedString),
        );
        currentTranslations.addAll(
          _getTranslationArray(data.monthsShort, 12, processedString),
        );
      }

      if (translateDays) {
        currentTranslations.addAll(
          _getTranslationArray(weekdays, 7, processedString),
        );
        currentTranslations.addAll(
          _getTranslationArray(data.weekdaysShort, 7, processedString),
        );
      }

      if (translateDiff) {
        currentTranslations.addAll(
          _translateWordsByKeys(
            [
              'diff_now',
              'diff_today',
              'diff_yesterday',
              'diff_tomorrow',
              'diff_before_yesterday',
              'diff_after_tomorrow',
            ],
            messages,
            key,
          ),
        );
      }

      if (translateUnits) {
        currentTranslations.addAll(
          _translateWordsByKeys(
            ['year', 'month', 'week', 'day', 'hour', 'minute', 'second'],
            messages,
            key,
          ),
        );
      }

      if (translateMeridiem) {
        // Simple meridiem handling for now, assuming AM/PM
        // A full implementation would need to invoke the meridiem function for all hours
        // But for translation purposes, we mainly care about the strings "AM"/"PM"
        // or their localized equivalents.
        // Since meridiem is a function in Dart, we can't easily extract a list of strings
        // unless we run it.
        // Let's skip meridiem translation for now to avoid complexity,
        // or just handle standard AM/PM if possible.
      }

      if (key == 'from') {
        fromTranslations.addAll(currentTranslations);
      } else {
        toTranslations.addAll(currentTranslations);
      }
    }

    // Perform replacement
    if (fromTranslations.isEmpty || toTranslations.isEmpty) {
      return _applyTimeStrings(processedString, toLocale);
    }

    // Construct a map for replacement
    final replacementMap = <String, String>{};
    for (var i = 0; i < fromTranslations.length; i++) {
      if (i < toTranslations.length) {
        final toWord = toTranslations[i];
        if (toWord != '>>DO NOT REPLACE<<') {
          replacementMap[fromTranslations[i]] = toWord;
        }
      }
    }

    if (replacementMap.isNotEmpty) {
      final pattern = fromTranslations.map(RegExp.escape).join('|');

      processedString = processedString.replaceAllMapped(
        RegExp(
          '(?<=[\\d\\s+.\\/,_-])($pattern)(?=[\\d\\s+.\\/,_-])',
          caseSensitive: false,
        ),
        (match) {
          final word = match.group(1)!;
          // Find case-insensitive match in map
          for (final key in replacementMap.keys) {
            if (key.toLowerCase() == word.toLowerCase()) {
              return replacementMap[key]!;
            }
          }
          return word;
        },
      );
    }

    return _applyTimeStrings(processedString, toLocale);
  }

  static String _applyTimeStrings(String input, String locale) {
    final match = matchLocale(locale);
    if (match.timeStrings.isEmpty) {
      return input;
    }
    var result = input;
    match.timeStrings.forEach((token, replacement) {
      result = result.replaceAll(token, replacement);
    });
    return result;
  }

  static List<String> _getTranslationArray(
    List<String> list,
    int length,
    String timeString,
  ) {
    if (list.length < length) return List.filled(length, '>>DO NOT REPLACE<<');
    return list.sublist(0, length);
  }

  static List<String> _translateWordsByKeys(
    List<String> keys,
    Map<String, String> messages,
    String key,
  ) {
    return keys.map((k) {
      final message = messages[k];
      if (message == null) return '>>DO NOT REPLACE<<';
      final parts = message.split('|');
      // For 'to', we want the clean word (singular/plural doesn't matter much for simple translation, usually singular is fine or we take the first)
      // PHP logic:
      // $key === 'to' ? self::cleanWordFromTranslationString(end($parts)) : '(?:'.implode('|', array_map(static::cleanWordFromTranslationString(...), $parts)).')';

      if (key == 'to') {
        return _cleanWord(parts.last);
      } else {
        // For 'from', we return the regex pattern part, but here we are building a list of strings to match.
        // PHP returns a regex group. We are returning a list of strings.
        // So we should probably return all variants.
        // But the structure of this method expects 1-to-1 mapping for the loop above.
        // This is tricky. PHP builds a huge regex.
        // Let's simplify: just take the last part for 'from' as well for now,
        // or better, just the first part which is usually the singular.
        return _cleanWord(parts.last);
      }
    }).toList();
  }

  static String _cleanWord(String word) {
    var w = word.replaceAll(RegExp(r'(:count|%count|:time)'), '');
    w = w.replaceAll(RegExp(r'[\{\[\]].+?[\}\]\]]'), ''); // Remove conditions
    return w.trim();
  }

  static void ensureTimeagoLocale(String locale) {
    _ensureDefaultsRegistered();
    final match = matchLocale(locale);
    if (_registeredTimeagoLocales.contains(match.localeCode)) {
      return;
    }
    final messages = match.timeagoMessages;
    if (messages != null) {
      timeago.setLocaleMessages(match.localeCode, messages);
    }
    _registeredTimeagoLocales.add(match.localeCode);
  }

  /// Translates [input] using the digit map registered for [locale].
  static String translateNumber(
    String input, {
    String? locale,
    bool alt = false,
  }) {
    var match = matchLocale(locale);
    var table = alt ? match.altNumbers : match.numbers;

    if (table.isEmpty) {
      // If the matched locale has no numbers, try explicit fallbacks of the requested locale
      final requested = _normalizeLocale(locale ?? _defaultLocale);
      final fallbacks = _fallbackLocales[requested];
      if (fallbacks != null) {
        for (final fallback in fallbacks) {
          final fallbackMatch = matchLocale(fallback);
          final fallbackTable = alt
              ? fallbackMatch.altNumbers
              : fallbackMatch.numbers;
          if (fallbackTable.isNotEmpty) {
            table = fallbackTable;
            break;
          }
        }
      }
    }

    if (table.isEmpty) {
      return input;
    }
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      final char = String.fromCharCode(rune);
      buffer.write(table[char] ?? char);
    }
    return buffer.toString().trim();
  }

  /// Produces an alternate numeric translation (mirrors `Translator::getAltNumber`).
  static String getAltNumber(String input, {String? locale}) =>
      translateNumber(input, locale: locale, alt: true);

  /// Translates a unit with count using the locale's pluralization rules.
  static String translateUnit(String unit, int count, {String? locale}) {
    final data = matchLocale(locale);
    return CarbonLookupMessages.pluralize(unit, count, data.translationStrings);
  }

  /// Returns the translation metadata that best matches [locale].
  static CarbonLocaleData matchLocale(String? locale, {String? fallback}) {
    _ensureDefaultsRegistered();
    final visited = <String>{};
    for (final candidate in <String?>[locale, fallback, 'en']) {
      final match = _matchLocale(candidate, visited);
      if (match != null) {
        return match;
      }
    }
    if (_translations.isNotEmpty) {
      // If no match found, return the first registered translation as a fallback.
      return _translations.entries.first.value;
    }
    throw StateError('No translations registered for CarbonTranslator');
  }

  static CarbonLocaleData? _loadLocaleFromGenerated(String localeCode) {
    final data = allLocales[localeCode];
    if (data != null) {
      // Register the loaded locale so it's available for future lookups
      _translations[localeCode] = data;

      // If timeagoMessages are not explicitly provided, try to generate them from translationStrings
      if (data.timeagoMessages == null && data.translationStrings.isNotEmpty) {
        timeago.setLocaleMessages(
          localeCode,
          CarbonLookupMessages(data.translationStrings),
        );
      } else if (data.timeagoMessages != null) {
        timeago.setLocaleMessages(localeCode, data.timeagoMessages!);
      }
    }
    return data;
  }

  static CarbonLocaleData? _matchLocale(String? locale, Set<String> visited) {
    if (locale == null || locale.isEmpty) {
      return null;
    }
    final normalized = _normalizeLocale(locale);
    if (!visited.add(normalized)) {
      return null;
    }
    for (final candidate in _localeCandidates(normalized)) {
      CarbonLocaleData? translation = _translations[candidate];
      translation ??= _loadLocaleFromGenerated(candidate);
      if (translation != null) {
        return translation;
      }
    }
    final fallback = _fallbackLocales[normalized];
    if (fallback != null) {
      for (final entry in fallback) {
        final match = _matchLocale(entry, visited);
        if (match != null) {
          return match;
        }
      }
    }
    return null;
  }

  static List<String> _localeCandidates(String locale) {
    final segments = <String>[];
    final normalized = locale.toLowerCase().replaceAll('-', '_');
    final queue = <String>[normalized];
    final seen = <String>{};
    while (queue.isNotEmpty) {
      final value = queue.removeAt(0);
      if (value.isEmpty || !seen.add(value)) {
        continue;
      }
      segments.add(value);
      final dot = value.indexOf('.');
      if (dot != -1) {
        queue.add(value.substring(0, dot));
      }
      final at = value.indexOf('@');
      if (at != -1) {
        queue.add(value.substring(0, at));
      }
      final underscore = value.lastIndexOf('_');
      if (underscore != -1) {
        queue.add(value.substring(0, underscore));
      }
    }
    return segments;
  }

  static String _normalizeLocale(String locale) =>
      locale.toLowerCase().replaceAll('-', '_');

  static void _ensureDefaultsRegistered() {
    if (_defaultsReady) {
      return;
    }
    _registerDefaults();
    _defaultsReady = true;
  }

  static void _registerDefaults() {
    // Locales are now loaded dynamically via matchLocale.
    // Ensure 'en' is available as a fallback.
    _loadLocaleFromGenerated('en');
  }
}

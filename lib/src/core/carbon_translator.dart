part of '../carbon.dart';

/// Translation metadata used by [CarbonTranslator].
///
/// Fields such as [numbers], [altNumbers], and [timeStrings] let callers
/// override the formatter behavior that manipulates digits or text fragments, while
/// [timeagoMessages] registers human-friendly strings for `diffForHumans()`.
class CarbonTranslation {
  /// Mapping of digits/characters that should be replaced before formatting.
  final Map<String, String> numbers;

  /// Alternate digit mapping used by `getAltNumber()`.
  final Map<String, String> altNumbers;

  /// Custom replacements applied to the result of `diffForHumans()` and similar
  /// helpers.
  final Map<String, String> timeStrings;

  /// Optional `timeago` message bundle for humanized relative strings.
  final timeago.LookupMessages? timeagoMessages;

  const CarbonTranslation({
    this.numbers = const {},
    this.altNumbers = const {},
    this.timeStrings = const {},
    this.timeagoMessages,
  });
}

/// A translator match that keeps track of which locale was resolved.
class CarbonTranslationMatch {
  /// Locale key that provided [translation].
  final String locale;

  /// Translation metadata for [locale].
  final CarbonTranslation translation;

  CarbonTranslationMatch(this.locale, this.translation);
}

/// Registry for language overrides inspired by PHP's `Translator` class.
class CarbonTranslator {
  CarbonTranslator._();

  static final Map<String, CarbonTranslation> _translations =
      <String, CarbonTranslation>{};
  static final Map<String, List<String>> _fallbackLocales =
      <String, List<String>>{};
  static final Set<String> _registeredTimeagoLocales = <String>{};
  static final bool _defaultsReady = _registerDefaults();

  /// Registers a locale so translators and `diffForHumans()` can look it up.
  static void registerLocale(
    String locale,
    CarbonTranslation translation, {
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

  /// Ensures `timeago` has messages for [locale].
  static void ensureTimeagoLocale(String locale) {
    if (!_defaultsReady) {
      throw StateError('CarbonTranslator defaults not registered');
    }
    final match = matchLocale(locale);
    if (_registeredTimeagoLocales.contains(match.locale)) {
      return;
    }
    final messages = match.translation.timeagoMessages;
    if (messages != null) {
      timeago.setLocaleMessages(match.locale, messages);
    }
    _registeredTimeagoLocales.add(match.locale);
  }

  /// Translates [input] using the digit map registered for [locale].
  static String translateNumber(
    String input, {
    String? locale,
    bool alt = false,
  }) {
    final match = matchLocale(locale);
    final table = alt
        ? match.translation.altNumbers
        : match.translation.numbers;
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

  /// Replaces tokens inside [input] using the configured time strings.
  static String translateTimeString(String input, {String? locale}) {
    final match = matchLocale(locale);
    if (match.translation.timeStrings.isEmpty) {
      return input;
    }
    var result = input;
    match.translation.timeStrings.forEach((token, replacement) {
      result = result.replaceAll(token, replacement);
    });
    return result;
  }

  /// Returns the translation metadata that best matches [locale].
  static CarbonTranslationMatch matchLocale(
    String? locale, {
    String? fallback,
  }) {
    final visited = <String>{};
    for (final candidate in <String?>[locale, fallback, 'en']) {
      final match = _matchLocale(candidate, visited);
      if (match != null) {
        return match;
      }
    }
    if (_translations.isNotEmpty) {
      final entry = _translations.entries.first;
      return CarbonTranslationMatch(entry.key, entry.value);
    }
    throw StateError('No translations registered for CarbonTranslator');
  }

  static CarbonTranslationMatch? _matchLocale(
    String? locale,
    Set<String> visited,
  ) {
    if (locale == null || locale.isEmpty) {
      return null;
    }
    final normalized = _normalizeLocale(locale);
    if (!visited.add(normalized)) {
      return null;
    }
    for (final candidate in _localeCandidates(normalized)) {
      final translation = _translations[candidate];
      if (translation != null) {
        return CarbonTranslationMatch(candidate, translation);
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

  static bool _registerDefaults() {
    registerLocale(
      'en',
      CarbonTranslation(timeagoMessages: timeago.EnMessages()),
    );
    registerLocale(
      'fr',
      CarbonTranslation(
        timeagoMessages: timeago.FrMessages(),
        timeStrings: {
          'ago': 'il y a',
          'from now': "d'ici",
          'just now': "à l'instant",
          'in ': 'dans ',
          'minutes': 'minutes',
          'hours': 'heures',
          'days': 'jours',
          'months': 'mois',
          'years': 'ans',
        },
      ),
    );
    return true;
  }
}

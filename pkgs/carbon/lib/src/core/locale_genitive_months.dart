part of '../carbon.dart';

/// Genitive month names for locales that require case-specific forms.
///
/// When formatting Russian dates such as "31 мая", PHP Carbon uses locale
/// translators that expose genitive month strings. The Dart Intl data only
/// exposes nominative forms, so we store the genitive variants here.
const Map<String, List<String>> kLocaleGenitiveMonths = {
  'ru': <String>[
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ],
  'ru_ru': <String>[
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ],
};

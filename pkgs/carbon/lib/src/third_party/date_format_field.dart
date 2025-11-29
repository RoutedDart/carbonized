// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'intl_date_format.dart';

/// This is a private class internal to CarbonDateFormat which is used for formatting
/// particular fields in a template. e.g. if the format is hh:mm:ss then the
/// fields would be 'hh', ':', 'mm', ':', and 'ss'. Each type of field knows
/// how to format that portion of a date.
abstract class _CarbonDateFormatField {
  /// The format string that defines us, e.g. 'hh'
  final String pattern;

  /// The CarbonDateFormat that we are part of.
  final CarbonDateFormat parent;

  _CarbonDateFormatField(this.pattern, this.parent);

  String fullPattern() => pattern;

  /// Format date according to our specification and return the result.
  String format(DateTime date) => pattern;
}

/// Represents a literal field - a sequence of characters that doesn't
/// change according to the date's data. As such, the implementation
/// is extremely simple.
class _CarbonDateFormatLiteralField extends _CarbonDateFormatField {
  _CarbonDateFormatLiteralField(super.pattern, super.parent);
}

/// Represents a literal field with quoted characters in it.
class _CarbonDateFormatQuotedField extends _CarbonDateFormatField {
  final String _fullPattern;

  _CarbonDateFormatQuotedField(String pattern, CarbonDateFormat parent)
    : _fullPattern = pattern,
      super(_patchQuotes(pattern), parent);

  @override
  String fullPattern() => _fullPattern;

  static final _twoEscapedQuotes = RegExp(r"''");

  static String _patchQuotes(String pattern) {
    if (pattern == "''") {
      return "'";
    }
    return pattern
        .substring(1, pattern.length - 1)
        .replaceAll(_twoEscapedQuotes, "'");
  }
}

/// Represents a field in the pattern that formats some aspect of the
/// date. Consists primarily of a switch on the particular pattern characters
/// to determine what to do.
class _CarbonDateFormatPatternField extends _CarbonDateFormatField {
  _CarbonDateFormatPatternField(super.pattern, super.parent);

  /// Format date according to our specification and return the result.
  @override
  String format(DateTime date) {
    return switch (pattern[0]) {
      'a' => formatAmPm(date),
      'c' => formatStandaloneDay(date),
      'd' => formatDayOfMonth(date),
      'D' => formatDayOfYear(date),
      'E' => formatDayOfWeek(date),
      'G' => formatEra(date),
      'h' => format1To12Hours(date),
      'H' => format0To23Hours(date),
      'K' => format0To11Hours(date),
      'k' => format24Hours(date),
      'L' => formatStandaloneMonth(date),
      'M' => formatMonth(date),
      'm' => formatMinutes(date),
      'Q' => formatQuarter(date),
      'S' => formatFractionalSeconds(date),
      's' => formatSeconds(date),
      'y' => formatYear(date),
      _ => '',
    };
  }

  /// Return the symbols for our current locale.
  DateSymbols get symbols => parent.dateSymbols;

  String formatEra(DateTime date) {
    var era = date.year > 0 ? 1 : 0;
    return width >= 4 ? symbols.ERANAMES[era] : symbols.ERAS[era];
  }

  String formatYear(DateTime date) {
    // TODO(alanknight): Proper handling of years <= 0
    var year = date.year;
    if (year < 0) {
      year = -year;
    }
    return width == 2 ? padTo(2, year % 100) : padTo(width, year);
  }

  String formatMonth(DateTime date) {
    switch (width) {
      case 5:
        return symbols.NARROWMONTHS[date.month - 1];
      case 4:
        return symbols.MONTHS[date.month - 1];
      case 3:
        return symbols.SHORTMONTHS[date.month - 1];
      default:
        return padTo(width, date.month);
    }
  }

  String format24Hours(DateTime date) {
    var hour = date.hour == 0 ? 24 : date.hour;
    return padTo(width, hour);
  }

  String formatFractionalSeconds(DateTime date) {
    // Always print at least 3 digits. If the width is greater, append 0s
    var basic = padTo(3, date.millisecond);
    if (width - 3 > 0) {
      var extra = padTo(width - 3, 0);
      return basic + extra;
    }
    return basic;
  }

  String formatAmPm(DateTime date) {
    var hours = date.hour;
    var index = (hours >= 12) && (hours < 24) ? 1 : 0;
    var ampm = symbols.AMPMS;
    return ampm[index];
  }

  String format1To12Hours(DateTime date) {
    var hours = date.hour;
    if (date.hour > 12) hours = hours - 12;
    if (hours == 0) hours = 12;
    return padTo(width, hours);
  }

  String format0To11Hours(DateTime date) => padTo(width, date.hour % 12);

  String format0To23Hours(DateTime date) => padTo(width, date.hour);

  String formatStandaloneDay(DateTime date) {
    switch (width) {
      case 5:
        return symbols.STANDALONENARROWWEEKDAYS[date.weekday % 7];
      case 4:
        return symbols.STANDALONEWEEKDAYS[date.weekday % 7];
      case 3:
        return symbols.STANDALONESHORTWEEKDAYS[date.weekday % 7];
      default:
        return padTo(1, date.day);
    }
  }

  String formatStandaloneMonth(DateTime date) {
    switch (width) {
      case 5:
        return symbols.STANDALONENARROWMONTHS[date.month - 1];
      case 4:
        return symbols.STANDALONEMONTHS[date.month - 1];
      case 3:
        return symbols.STANDALONESHORTMONTHS[date.month - 1];
      default:
        return padTo(width, date.month);
    }
  }

  String formatQuarter(DateTime date) {
    var quarter = ((date.month - 1) / 3).truncate();
    switch (width) {
      case 4:
        return symbols.QUARTERS[quarter];
      case 3:
        return symbols.SHORTQUARTERS[quarter];
      default:
        return padTo(width, quarter + 1);
    }
  }

  String formatDayOfMonth(DateTime date) => padTo(width, date.day);

  String formatDayOfYear(DateTime date) => padTo(
    width,
    date_computation.dayOfYear(
      date.month,
      date.day,
      date_computation.isLeapYear(date),
    ),
  );

  /// See also http://www.unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table
  String formatDayOfWeek(DateTime date) {
    // Note that Dart's weekday returns 1 for Monday and 7 for Sunday.
    return switch (width) {
      /// "Abbreviated" - `Tue` for en-US
      <= 3 => symbols.SHORTWEEKDAYS,

      /// "Wide" - `Tuesday` for en-US
      == 4 => symbols.WEEKDAYS,

      /// "Narrow" - `T` for en-US
      == 5 => symbols.NARROWWEEKDAYS,

      ///TODO(mosum): Introduce "Short" - `Tu` for en-US
      >= 6 => throw UnsupportedError(
        '"Short" weekdays are currently not supported.',
      ),
      int() => throw AssertionError('unreachable'),
    }[(date.weekday) % 7];
  }

  String formatMinutes(DateTime date) => padTo(width, date.minute);

  String formatSeconds(DateTime date) => padTo(width, date.second);

  int get width => pattern.length;

  /// Return a string representation of the object padded to the left with
  /// zeros. Primarily useful for numbers.
  String padTo(int width, Object toBePrinted) =>
      parent._localizeDigits('$toBePrinted'.padLeft(width, '0'));
}

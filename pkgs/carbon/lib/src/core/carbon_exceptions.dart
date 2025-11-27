/// Shared exception types used across the Carbon API to mirror PHP Carbon's
/// dedicated exception hierarchy.
part of '../carbon.dart';

/// Base class for Carbon exceptions that carry a human-readable message.
class CarbonMessageException implements Exception {
  const CarbonMessageException(this.message, {this.code = 0, this.cause});

  final String message;
  final int code;
  final Object? cause;

  @override
  String toString() => message;
}

/// Mirrors PHP's InvalidArgumentException interface.
class CarbonInvalidArgumentException extends CarbonMessageException {
  const CarbonInvalidArgumentException(
    super.message, {
    super.code,
    super.cause,
  });
}

/// Mirrors PHP's RuntimeException interface.
class CarbonRuntimeException extends CarbonMessageException {
  const CarbonRuntimeException(super.message, {super.code, super.cause});
}

/// Mirrors PHP's BadMethodCallException interface.
class CarbonBadMethodCallException extends CarbonRuntimeException {
  const CarbonBadMethodCallException(super.message, {super.code, super.cause});
}

/// Base class for all unit-related exceptions.
class CarbonUnitException extends CarbonInvalidArgumentException {
  const CarbonUnitException(super.message, {super.code, super.cause});
}

/// Thrown when a helper receives an out-of-range date component.
class CarbonInvalidDateException extends CarbonInvalidArgumentException {
  CarbonInvalidDateException(this.field, this.value, {int code = 0})
    : super('Invalid value for $field: $value', code: code);

  /// Name of the offending field (for example `month`).
  final String field;

  /// Value that triggered the failure.
  final Object? value;
}

class CarbonUnknownGetterException extends CarbonInvalidArgumentException {
  CarbonUnknownGetterException(this.getter, {int code = 0})
    : super("Unknown getter '$getter'", code: code);

  final String getter;
}

class CarbonUnknownSetterException extends CarbonInvalidArgumentException {
  CarbonUnknownSetterException(this.setter, {int code = 0})
    : super("Unknown setter '$setter'", code: code);

  final String setter;
}

class CarbonUnknownMethodException extends CarbonBadMethodCallException {
  CarbonUnknownMethodException(this.method, {int code = 0})
    : super('Method $method does not exist.', code: code);

  final String method;
}

class CarbonBadFluentConstructorException extends CarbonBadMethodCallException {
  CarbonBadFluentConstructorException(this.method, {int code = 0})
    : super("Unknown fluent constructor '$method'.", code: code);

  final String method;
}

class CarbonBadFluentSetterException extends CarbonBadMethodCallException {
  CarbonBadFluentSetterException(this.setter, {int code = 0})
    : super("Unknown fluent setter '$setter'", code: code);

  final String setter;
}

class CarbonUnknownUnitException extends CarbonUnitException {
  CarbonUnknownUnitException(this.unit, {int code = 0})
    : super("Unknown unit '$unit'", code: code);

  final String unit;
}

class CarbonUnsupportedUnitException extends CarbonUnitException {
  CarbonUnsupportedUnitException(this.unit, {int code = 0})
    : super("Unsupported unit '$unit'", code: code);

  final String unit;
}

class CarbonUnitNotConfiguredException extends CarbonUnitException {
  CarbonUnitNotConfiguredException(this.unit, {int code = 0})
    : super(
        'Unit $unit have no configuration to get total from other units.',
        code: code,
      );

  final String unit;
}

class CarbonBadComparisonUnitException extends CarbonUnitException {
  CarbonBadComparisonUnitException(this.unit, {int code = 0})
    : super("Bad comparison unit: '$unit'", code: code);

  final String unit;
}

class CarbonInvalidTimeZoneException extends CarbonInvalidArgumentException {
  CarbonInvalidTimeZoneException(
    this.timeZone, {
    String? reason,
    int code = 0,
    Object? cause,
  }) : description = reason ?? 'Unknown timezone "$timeZone".',
       super(
         reason ?? 'Unknown timezone "$timeZone".',
         code: code,
         cause: cause,
       );

  final String timeZone;
  final String description;
}

class CarbonImmutableException extends CarbonRuntimeException {
  CarbonImmutableException(this.value, {int code = 0})
    : super('$value is immutable.', code: code);

  final String value;
}

class CarbonEndLessPeriodException extends CarbonRuntimeException {
  CarbonEndLessPeriodException([
    super.message = "Endless period can't be converted to array nor counted.",
  ]);
}

class CarbonParseErrorException extends CarbonInvalidArgumentException {
  CarbonParseErrorException(
    this.expected,
    this.actual, {
    this.help = '',
    int code = 0,
  }) : super(_buildMessage(expected, actual, help), code: code);

  final String expected;
  final String actual;
  final String help;

  static String _buildMessage(String expected, String actual, String help) {
    final actualPhrase = actual.isEmpty ? 'data is missing' : "get '$actual'";
    final buffer = StringBuffer('Format expected $expected but $actualPhrase');
    if (help.trim().isNotEmpty) {
      buffer.write('\n${help.trim()}');
    }
    return buffer.toString();
  }
}

class CarbonOutOfRangeException extends CarbonInvalidArgumentException {
  CarbonOutOfRangeException(
    this.unit,
    this.min,
    this.max,
    this.value, {
    int code = 0,
  }) : super('$unit must be between $min and $max, $value given', code: code);

  final String unit;
  final Object? min;
  final Object? max;
  final Object? value;
}

class CarbonNotLocaleAwareException extends CarbonInvalidArgumentException {
  CarbonNotLocaleAwareException(Object? object, {int code = 0})
    : objectDescription = _describe(object),
      super(
        '${_describe(object)} does neither implements '
        r'Symfony\Contracts\Translation\LocaleAwareInterface nor getLocale() method.',
        code: code,
      );

  final String objectDescription;

  static String _describe(Object? object) {
    if (object == null) {
      return 'null';
    }
    return object.runtimeType.toString();
  }
}

class CarbonNotACarbonClassException extends CarbonInvalidArgumentException {
  CarbonNotACarbonClassException(this.className, {int code = 0})
    : super(
        'Given class does not implement CarbonInterface: $className',
        code: code,
      );

  final String className;
}

class CarbonNotAPeriodException extends CarbonInvalidArgumentException {
  CarbonNotAPeriodException([super.message = 'Not a period.']);
}

class CarbonInvalidFormatException extends CarbonInvalidArgumentException {
  CarbonInvalidFormatException([super.message = 'Invalid format.']);
}

class CarbonInvalidIntervalException extends CarbonInvalidArgumentException {
  CarbonInvalidIntervalException([super.message = 'Invalid interval.']);
}

class CarbonInvalidPeriodParameterException
    extends CarbonInvalidArgumentException {
  CarbonInvalidPeriodParameterException([
    super.message = 'Invalid period parameter.',
  ]);
}

class CarbonInvalidPeriodDateException extends CarbonInvalidArgumentException {
  CarbonInvalidPeriodDateException([super.message = 'Invalid period date.']);
}

class CarbonInvalidCastException extends CarbonInvalidArgumentException {
  CarbonInvalidCastException([super.message = 'Invalid cast.']);
}

class CarbonInvalidTypeException extends CarbonInvalidArgumentException {
  CarbonInvalidTypeException([super.message = 'Invalid type.']);
}

class CarbonUnreachableException extends CarbonRuntimeException {
  CarbonUnreachableException([
    super.message = 'This code path should be unreachable.',
  ]);
}

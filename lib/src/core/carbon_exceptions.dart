/// Houses Carbon-specific exception types raised by validation helpers.
///
/// ```dart
/// throw CarbonInvalidDateException('month', 15);
/// ```
part of '../carbon.dart';

/// Thrown when a helper receives an out-of-range date component.
class CarbonInvalidDateException implements Exception {
  CarbonInvalidDateException(this.field, this.value);

  /// Name of the offending field (for example `month`).
  final String field;

  /// Value that triggered the failure.
  final Object? value;

  @override
  String toString() => 'Invalid value for $field: $value';
}

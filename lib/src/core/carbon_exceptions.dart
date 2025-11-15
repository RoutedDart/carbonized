part of '../carbon.dart';

class CarbonInvalidDateException implements Exception {
  CarbonInvalidDateException(this.field, this.value);

  final String field;
  final Object? value;

  @override
  String toString() => 'Invalid value for $field: $value';
}

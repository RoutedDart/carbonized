/// Defines iterable date ranges returned by helpers like `Carbon.daysUntil`.
///
/// ```dart
/// for (final day in Carbon.now().daysUntil('2024-01-03')) {
///   print(day.toDateString());
/// }
/// ```
part of '../carbon.dart';

/// Iterable range produced by Carbon's `range*` helpers.
///
/// Periods mirror the PHP Carbon period object: [start] and [end] describe the
/// inclusive bounds and iterating returns every intermediate `Carbon`.
class CarbonPeriod extends Iterable<Carbon> {
  CarbonPeriod._(this._instances);

  final List<Carbon> _instances;

  @override
  bool get isEmpty => _instances.isEmpty;
  @override
  int get length => _instances.length;

  /// First `Carbon` in the period (inclusive).
  Carbon get start => _instances.first;

  /// Last `Carbon` in the period (inclusive).
  Carbon get end => _instances.last;

  @override
  Iterator<Carbon> get iterator => _instances.iterator;
}

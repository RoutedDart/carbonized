part of '../carbon.dart';

class CarbonPeriod extends Iterable<Carbon> {
  CarbonPeriod._(this._instances);

  final List<Carbon> _instances;

  @override
  bool get isEmpty => _instances.isEmpty;
  @override
  int get length => _instances.length;
  Carbon get start => _instances.first;
  Carbon get end => _instances.last;

  @override
  Iterator<Carbon> get iterator => _instances.iterator;
}

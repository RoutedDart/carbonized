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
  static final Map<String, CarbonMacro> _macros = <String, CarbonMacro>{};
  static void registerMacro(String name, CarbonMacro macro) =>
      _macros[name] = macro;
  static void unregisterMacro(String name) => _macros.remove(name);
  static bool hasMacro(String name) => _macros.containsKey(name);
  static void resetMacros() => _macros.clear();

  CarbonPeriod._(this._instances, {int? recurrences})
    : _recurrencesLimit = recurrences ?? _instances.length;

  /// Invokes a registered macro by [name] for this period.
  dynamic carbon(
    String name, [
    List<dynamic> positionalArguments = const <dynamic>[],
    Map<Symbol, dynamic> namedArguments = const <Symbol, dynamic>{},
  ]) {
    final macro = _macros[name];
    if (macro == null) {
      if (CarbonBase.strictMode) {
        throw CarbonUnknownMethodException(name);
      }
      return null;
    }
    return macro(this, positionalArguments, namedArguments);
  }

  final List<Carbon> _instances;
  final int _recurrencesLimit;

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

  /// Returns the configured maximum number of occurrences this period should
  /// return. The actual length might be smaller if the source range ended
  /// before the recurrence limit was reached.
  int get maxRecurrences => _recurrencesLimit;

  /// Returns a new period limited to [count] recurrences.
  CarbonPeriod recurrences(int count) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'must be positive');
    }
    final truncated = _instances.take(count).toList();
    return CarbonPeriod._(truncated, recurrences: count);
  }

  /// Alias for [recurrences].
  CarbonPeriod times(int count) => recurrences(count);

  /// Filters the current period using [predicate] and returns a new period.
  CarbonPeriod filter(bool Function(Carbon) predicate) {
    final filtered = _instances.where(predicate).toList();
    final limited = filtered.take(_recurrencesLimit).toList();
    return CarbonPeriod._(limited, recurrences: _recurrencesLimit);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      final name = _symbolToString(invocation.memberName);
      final macro = _macros[name];
      if (macro != null) {
        return macro(
          this,
          invocation.positionalArguments,
          invocation.namedArguments,
        );
      }
    }
    return super.noSuchMethod(invocation);
  }

  static String _symbolToString(Symbol symbol) =>
      symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');
}

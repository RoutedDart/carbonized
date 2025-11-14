part of '../carbon.dart';

const Object _aliasNotHandled = Object();

const _OverflowToken _overflowWithout = _OverflowToken(
  'withoutoverflow',
  false,
);
const _OverflowToken _overflowWithNo = _OverflowToken('withnooverflow', false);
const _OverflowToken _overflowNo = _OverflowToken('nooverflow', false);
const _OverflowToken _overflowWith = _OverflowToken('withoverflow', true);
const _OverflowToken _overflowPlain = _OverflowToken('overflow', true);

const List<_OverflowToken> _overflowTokens = <_OverflowToken>[
  _overflowWithout,
  _overflowWithNo,
  _overflowNo,
  _overflowWith,
  _overflowPlain,
];

const Map<String, _TemporalUnit> _temporalUnits = <String, _TemporalUnit>{
  'micro': _TemporalUnit.microseconds(1),
  'micros': _TemporalUnit.microseconds(1),
  'microsecond': _TemporalUnit.microseconds(1),
  'microseconds': _TemporalUnit.microseconds(1),
  'milli': _TemporalUnit.microseconds(Duration.microsecondsPerMillisecond),
  'millis': _TemporalUnit.microseconds(Duration.microsecondsPerMillisecond),
  'millisecond': _TemporalUnit.microseconds(
    Duration.microsecondsPerMillisecond,
  ),
  'milliseconds': _TemporalUnit.microseconds(
    Duration.microsecondsPerMillisecond,
  ),
  'second': _TemporalUnit.microseconds(Duration.microsecondsPerSecond),
  'seconds': _TemporalUnit.microseconds(Duration.microsecondsPerSecond),
  'minute': _TemporalUnit.microseconds(Duration.microsecondsPerMinute),
  'minutes': _TemporalUnit.microseconds(Duration.microsecondsPerMinute),
  'hour': _TemporalUnit.microseconds(Duration.microsecondsPerHour),
  'hours': _TemporalUnit.microseconds(Duration.microsecondsPerHour),
  'day': _TemporalUnit.microseconds(Duration.microsecondsPerDay),
  'days': _TemporalUnit.microseconds(Duration.microsecondsPerDay),
  'week': _TemporalUnit.microseconds(Duration.microsecondsPerDay * 7),
  'weeks': _TemporalUnit.microseconds(Duration.microsecondsPerDay * 7),
  'weekday': _TemporalUnit.microseconds(Duration.microsecondsPerDay),
  'weekdays': _TemporalUnit.microseconds(Duration.microsecondsPerDay),
  'month': _TemporalUnit.months(1),
  'months': _TemporalUnit.months(1),
  'quarter': _TemporalUnit.months(3),
  'quarters': _TemporalUnit.months(3),
  'year': _TemporalUnit.months(12),
  'years': _TemporalUnit.months(12),
  'decade': _TemporalUnit.months(120),
  'decades': _TemporalUnit.months(120),
  'century': _TemporalUnit.months(1200),
  'centuries': _TemporalUnit.months(1200),
  'millennium': _TemporalUnit.months(12000),
  'millenium': _TemporalUnit.months(12000),
  'millennia': _TemporalUnit.months(12000),
  'millenniums': _TemporalUnit.months(12000),
};

dynamic _invokeAlias(CarbonBase base, String name, Invocation invocation) {
  final result = _handleAddSubAlias(base, name, invocation);
  if (!identical(result, _aliasNotHandled)) {
    return result;
  }
  return _aliasNotHandled;
}

dynamic _handleAddSubAlias(
  CarbonBase base,
  String name,
  Invocation invocation,
) {
  final lower = name.toLowerCase();
  final isAdd = lower.startsWith('add');
  final isSub = lower.startsWith('sub');
  if (!isAdd && !isSub) {
    return _aliasNotHandled;
  }
  final descriptor = _AliasDescriptor.parse(name.substring(3));
  if (descriptor == null) {
    return _aliasNotHandled;
  }

  CarbonInterface executor([dynamic amount]) {
    final value = _asInt(amount);
    if (value == 0) {
      return base;
    }
    final signed = isSub ? -value : value;
    return base._applyTemporalUnit(
      descriptor.unit,
      signed,
      descriptor.overflow,
    );
  }

  if (invocation.isGetter) {
    return ([dynamic amount = 1]) => executor(amount);
  }

  final positional = invocation.positionalArguments;
  final amount = positional.isEmpty ? 1 : positional.first;
  return executor(amount);
}

int _asInt(dynamic value) {
  if (value == null) {
    return 1;
  }
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  throw ArgumentError('Amount must be numeric, got ${value.runtimeType}');
}

class _AliasDescriptor {
  const _AliasDescriptor(this.unit, this.overflow);

  final _TemporalUnit unit;
  final bool? overflow;

  static _AliasDescriptor? parse(String raw) {
    var body = raw;
    var lowered = raw.toLowerCase();
    if (lowered.startsWith('utc')) {
      body = body.substring(3);
      lowered = lowered.substring(3);
    }
    bool? overflow;
    for (final token in _overflowTokens) {
      if (lowered.endsWith(token.token)) {
        overflow = token.allowOverflow;
        body = body.substring(0, body.length - token.token.length);
        lowered = lowered.substring(0, lowered.length - token.token.length);
        break;
      }
    }
    if (body.isEmpty) {
      return null;
    }
    final unit = _temporalUnits[lowered];
    if (unit == null) {
      return null;
    }
    return _AliasDescriptor(unit, overflow);
  }
}

class _OverflowToken {
  const _OverflowToken(this.token, this.allowOverflow);
  final String token;
  final bool allowOverflow;
}

class _TemporalUnit {
  const _TemporalUnit.months(this.months) : microseconds = null;
  const _TemporalUnit.microseconds(this.microseconds) : months = null;

  final int? months;
  final int? microseconds;
}

/// Declares the macro callback signature used by `Carbon.registerMacro`.
///
/// ```dart
/// Carbon.registerMacro('nextRelease', (carbon, _, __) => carbon.addWeeks(2));
/// ```
part of '../carbon.dart';

/// Function signature used by `Carbon.registerMacro`.
///
/// Provides the current [CarbonInterface] along with the positional and named
/// arguments forwarded from the macro invocation.
typedef CarbonMacro =
    dynamic Function(
      dynamic target,
      List<dynamic> positionalArguments,
      Map<Symbol, dynamic> namedArguments,
    );

part of '../carbon.dart';

typedef CarbonMacro =
    dynamic Function(
      CarbonInterface carbon,
      List<dynamic> positionalArguments,
      Map<Symbol, dynamic> namedArguments,
    );

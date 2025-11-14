part of carbon_internal;

typedef CarbonMacro =
    dynamic Function(
      CarbonInterface carbon,
      List<dynamic> positionalArguments,
      Map<Symbol, dynamic> namedArguments,
    );

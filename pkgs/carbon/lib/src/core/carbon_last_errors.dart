part of '../carbon.dart';

/// Captures the results of the most recent parsing or creation attempt.
///
/// Mirrors PHP Carbon's `DateTime::getLastErrors()` payload: warning and
/// error counts alongside keyed message maps. When no parsing work occurred
/// yet the value is `null`.
class CarbonLastErrors {
  /// Internal constructor used for constant instances.
  const CarbonLastErrors._internal({
    this.warningCount = 0,
    this.warnings = const <String, String>{},
    this.errorCount = 0,
    this.errors = const <String, String>{},
  });

  /// Creates an empty, constant report.
  const CarbonLastErrors.empty() : this._internal();

  /// Builds a report with the provided warnings/errors.
  factory CarbonLastErrors({
    int warningCount = 0,
    Map<String, String>? warnings,
    int errorCount = 0,
    Map<String, String>? errors,
  }) => CarbonLastErrors._internal(
    warningCount: warningCount,
    warnings: Map.unmodifiable(warnings ?? const <String, String>{}),
    errorCount: errorCount,
    errors: Map.unmodifiable(errors ?? const <String, String>{}),
  );

  /// Number of warnings captured during the last operation.
  final int warningCount;

  /// Warning messages keyed by the field that triggered them.
  final Map<String, String> warnings;

  /// Number of errors captured during the last operation.
  final int errorCount;

  /// Error messages keyed by the field that triggered them.
  final Map<String, String> errors;

  /// Returns a JSON-style map representation (mirrors PHP's structure).
  Map<String, Object> toJson() => <String, Object>{
    'warning_count': warningCount,
    'warnings': warnings,
    'error_count': errorCount,
    'errors': errors,
  };

  @override
  bool operator ==(Object other) =>
      other is CarbonLastErrors &&
      other.warningCount == warningCount &&
      other.errorCount == errorCount &&
      _mapEquals(other.warnings, warnings) &&
      _mapEquals(other.errors, errors);

  @override
  int get hashCode => Object.hash(
    warningCount,
    errorCount,
    Object.hashAll(warnings.entries),
    Object.hashAll(errors.entries),
  );

  static bool _mapEquals(Map<String, String> a, Map<String, String> b) {
    if (identical(a, b)) {
      return true;
    }
    if (a.length != b.length) {
      return false;
    }
    for (final entry in a.entries) {
      if (b[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }
}

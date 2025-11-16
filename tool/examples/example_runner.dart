/// Container for a runnable doc example plus its captured output.
/// Shared utilities for doc-generator example snippets.
class ExampleRun {
  /// Creates a new example snippet with the source [code] and stdout [output].
  ExampleRun({required this.code, required this.output});

  /// Dart code that appears inside the generated documentation fence.
  final String code;

  /// Exact stdout produced by executing [code].
  final String output;
}

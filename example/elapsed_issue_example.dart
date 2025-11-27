import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Demonstrates how mutating helpers like `startOfDay()` change
/// the instance they are called on, which can break elapsed math
/// when you keep a single `now` variable around.
Future<void> main() async {
  await initializeDateFormatting('en');
  await Carbon.configureTimeMachine(testing: true);

  final capturedNow = Carbon.now();
  final originalNowIso = capturedNow.toIso8601String();

  final mutatedStartOfDay = capturedNow.startOfDay();
  final diffUsingMutatedNow =
      mutatedStartOfDay.diffForHumans(reference: capturedNow, parts: 2);

  print('Original now timestamp before mutation: $originalNowIso');
  print('Now after calling now.startOfDay(): ${capturedNow.toIso8601String()}');
  print('mutatedStartOfDay reference equality: '
      '${identical(capturedNow, mutatedStartOfDay)}');
  print('Elapsed using mutated now reference -> $diffUsingMutatedNow');
  print('');

  final safeNow = Carbon.now();
  final safeStartOfDay = safeNow.copy().startOfDay();
  final diffUsingSafeNow =
      safeStartOfDay.diffForHumans(reference: safeNow, parts: 2);

  print('Safe now (copy + startOfDay) timestamp: ${safeNow.toIso8601String()}');
  print('Safe startOfDay timestamp: ${safeStartOfDay.toIso8601String()}');
  print('Elapsed using safe now reference -> $diffUsingSafeNow');
  print('');

  final diffUsingFreshInstances = Carbon.now()
      .startOfDay()
      .diffForHumans(reference: Carbon.now(), parts: 2);

  print('Elapsed using fresh Carbon.now() calls -> $diffUsingFreshInstances');
}

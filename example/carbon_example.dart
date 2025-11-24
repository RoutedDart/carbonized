import 'package:carbon/carbon.dart';

void main() {
  CarbonInterface awesome = Carbon.now();
  print('awesome: ${awesome.toIso8601String()}');
  awesome = awesome.add(Duration(days: 5));
  print('awesome plus 5 days: ${awesome.toIso8601String()}');
}

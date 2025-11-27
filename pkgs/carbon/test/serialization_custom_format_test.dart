import 'dart:convert';

import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await Carbon.configureTimeMachine(testing: true);
  });

  test('default serialization matches payload and reset works', () {
    final dt = Carbon.parse('2012-12-25T20:30:00Z', timeZone: 'Europe/Moscow');
    final payload = dt.serialize();
    final decoded = jsonDecode(payload) as Map<String, dynamic>;
    expect(decoded['iso'], dt.toIso8601String(keepOffset: true));
    Carbon.serializeUsing((date) => 'custom:${date.toIso8601String()}');
    expect(dt.serialize(), startsWith('custom:')); // custom now
    Carbon.resetSerializationFormat();
    final defaultAgain = dt.serialize();
    final rebuild = jsonDecode(defaultAgain) as Map<String, dynamic>;
    expect(rebuild['timeZone'], 'Europe/Moscow');
  });
}

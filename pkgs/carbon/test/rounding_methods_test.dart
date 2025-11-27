import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  group('Carbon rounding helpers', () {
    test('ceilQuarter advances to next quarter boundary', () {
      final date = Carbon.create(year: 2025, month: 5, day: 15);
      final rounded = (date as dynamic).ceilQuarter();
      expect(rounded.month, 7);
      expect(rounded.day, 1);
    });

    test('floorMonth clamps to start of month', () {
      final date = Carbon.create(year: 2025, month: 5, day: 15);
      final rounded = (date as dynamic).floorMonth();
      expect(rounded.day, 1);
    });

    test('roundYear chooses nearest boundary', () {
      final date = Carbon.create(year: 2025, month: 9, day: 1);
      final rounded = (date as dynamic).roundYear();
      expect(rounded.year, 2026);
    });
  });
}

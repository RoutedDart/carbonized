import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  test('weekday constants match DateTime', () {
    expect(Carbon.sunday, DateTime.sunday);
    expect(Carbon.monday, DateTime.monday);
  });

  test('numeric helpers exist', () {
    expect(Carbon.yearsPerDecade, 10);
    expect(Carbon.monthsPerYear, 12);
  });
}

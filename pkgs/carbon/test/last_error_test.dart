import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(Carbon.resetLastErrors);

  group('Carbon last error reporting', () {
    test('returns null before any parsing work', () {
      expect(Carbon.lastErrorsSnapshot(), isNull);
    });

    test('records warnings for impossible calendar dates', () {
      Carbon('2017-02-30');
      final errors = Carbon.lastErrorsSnapshot();
      expect(errors, isNotNull);
      expect(errors!.warningCount, 1);
      expect(errors.errors, isEmpty);
      expect(errors.warnings.values.single, contains('invalid'));
    });

    test('successful parse clears previous warnings', () {
      Carbon('2017-02-30');
      Carbon('2017-02-15');
      final errors = Carbon.lastErrorsSnapshot();
      expect(errors, isNotNull);
      expect(errors!.warningCount, 0);
      expect(errors.errorCount, 0);
    });

    test('format exceptions populate the error bucket', () {
      expect(() => Carbon('not-a-date'), throwsA(isA<FormatException>()));
      final errors = Carbon.lastErrorsSnapshot();
      expect(errors, isNotNull);
      expect(errors!.errorCount, 1);
      expect(errors.errors.values.single, isNotEmpty);
    });

    test('setLastErrors initializes the default payload', () {
      Carbon.setLastErrors();
      final errors = Carbon.lastErrorsSnapshot();
      expect(errors, isNotNull);
      expect(errors!.warningCount, 0);
      expect(errors.errorCount, 0);
      expect(errors.warnings, isEmpty);
      expect(errors.errors, isEmpty);
    });
  });
}

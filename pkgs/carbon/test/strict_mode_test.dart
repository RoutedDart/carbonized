import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.useStrictMode(true);
    Carbon.setTestNow(null);
  });

  tearDown(() {
    Carbon.useStrictMode(true);
    Carbon.setTestNow(null);
  });

  group('Strict mode dynamic access', () {
    test('unknown getter throws when strict mode enabled', () {
      final dynamic carbon = Carbon.now();
      expect(
        () => carbon.foobar,
        throwsA(
          isA<CarbonUnknownGetterException>().having(
            (error) => error.toString(),
            'message',
            contains("Unknown getter 'foobar'"),
          ),
        ),
      );
    });

    test('unknown setter stores data when strict mode disabled', () {
      Carbon.useStrictMode(false);
      final dynamic carbon = Carbon.now();
      carbon.foobar = 'biz';
      expect(carbon.foobar, 'biz');
    });

    test('unknown setter throws when strict mode enabled', () {
      final dynamic carbon = Carbon.now();
      expect(
        () => carbon.foobar = 'biz',
        throwsA(
          isA<CarbonUnknownSetterException>().having(
            (error) => error.toString(),
            'message',
            contains("Unknown setter 'foobar'"),
          ),
        ),
      );
    });

    test('unknown method throws when strict mode enabled', () {
      final dynamic carbon = Carbon.now();
      expect(
        () => carbon.foobar(),
        throwsA(
          isA<CarbonUnknownMethodException>().having(
            (error) => error.toString(),
            'message',
            contains('Method foobar does not exist.'),
          ),
        ),
      );
    });

    test('unknown method returns null when strict mode disabled', () {
      Carbon.useStrictMode(false);
      final dynamic carbon = Carbon.now();
      expect(carbon.foobar(), isNull);
    });
  });
}

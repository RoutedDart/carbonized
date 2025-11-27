import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.resetMacros();
  });

  group('Macro registration', () {
    test('macros can be registered and invoked on instances', () {
      Carbon.registerMacro('doubleYears', (carbon, args, _) {
        final target = args.isEmpty ? 1 : args.first as int;
        return carbon.addYears(target).year;
      });
      final dynamic value = Carbon.parse('2000-01-01');
      expect(value.doubleYears(2), 2002);
      Carbon.unregisterMacro('doubleYears');
      expect(Carbon.hasMacro('doubleYears'), isFalse);
    });

    test('carbon() helper invokes registered macros', () {
      Carbon.registerMacro('doubleYears', (carbon, args, _) {
        final target = args.isEmpty ? 1 : args.first as int;
        return carbon.addYears(target).year;
      });
      final Carbon carbon = Carbon.parse('2000-01-01');
      expect(carbon.carbon('doubleYears', [2]), 2002);
    });

    test('macros expose getter/setter helpers', () {
      Carbon.registerMacro('getSchoolYear', (
        carbon,
        unusedPositional,
        unusedNamed,
      ) {
        var year = carbon.year;
        if (carbon.month > 7) {
          year++;
        }
        return year;
      });
      Carbon.registerMacro('setSchoolYear', (carbon, args, unusedNamed) {
        var schoolYear = args.first as int;
        if (carbon.month > 7) {
          schoolYear--;
        }
        carbon.setYear(schoolYear);
        return null;
      });

      final dynamic termStart = Carbon.parse('2016-06-01');
      expect(termStart.getSchoolYear(), 2016);
      termStart.addMonths(3);
      expect(termStart.getSchoolYear(), 2017);
      termStart.setSchoolYear(2020);
      expect((termStart as CarbonInterface).year, 2019);
    });
  });
}

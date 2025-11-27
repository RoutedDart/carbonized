import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('zh_TW');
  });

  test('createFromIsoFormat parses extended years with bang prefix', () {
    final date = Carbon.createFromIsoFormat('!YYYYY MMMM D', '2019 April 4');
    expect(date.year, 2019);
    expect(date.month, 4);
    expect(date.day, 4);
    expect(date.hour, 0);
    expect(date.minute, 0);
    expect(date.second, 0);
  });

  test('createFromIsoFormat throws for unsupported tokens', () {
    expect(
      () => Carbon.createFromIsoFormat('YY D wo', '2019 April 4'),
      throwsArgumentError,
    );
  });

  test('createFromLocaleIsoFormat understands localized month names', () {
    final monthName = DateFormat.MMMM('zh_TW').format(DateTime.utc(2019, 4, 1));
    final date = Carbon.createFromLocaleIsoFormat(
      'YYYY MMMM D HH,mm,ss',
      'zh_TW',
      '2019 $monthName 4 12,04,21',
    );
    expect(date.year, 2019);
    expect(date.month, 4);
    expect(date.day, 4);
    expect(date.hour, 12);
    expect(date.minute, 4);
    expect(date.second, 21);
  });

  test('createFromIsoFormat understands preset macros', () {
    final date = Carbon.createFromIsoFormat('LL', 'April 4, 2019');
    expect(date.year, 2019);
    expect(date.month, 4);
    expect(date.day, 4);
  });
}

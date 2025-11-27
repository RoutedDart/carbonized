import 'package:carbon/carbon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('fr');
    await initializeDateFormatting('fr_FR');
    await initializeDateFormatting('ru');
    await initializeDateFormatting('es');
  });

  setUp(() {
    Carbon.setLocale('en');
    Carbon.resetToStringFormat();
  });

  group('String formatting helpers', () {
    test('CarbonFactory applies scoped toString format', () {
      final factory = CarbonFactory(
        toStringFormat: (CarbonInterface value) => value.isoFormat('dddd'),
      );
      final created = factory.create(1976, 12, 25, 14, 15, 16);
      expect(created.toString(), 'Saturday');
      final normal = Carbon.parse('1975-12-25T14:15:16Z');
      expect(normal.toString(), normal.toDateTimeString());
    });

    test('isoFormat token overrides mirror PHP getIsoUnits', () {
      Carbon.registerIsoFormatToken('MMM', (_) => '');
      addTearDown(Carbon.resetIsoFormatTokens);
      expect(Carbon.parse('2017-01-01T00:00:00Z').isoFormat('MMM'), '');
    });

    test('toString defaults to toDateTimeString', () {
      final value = Carbon.parse('1975-12-25T14:15:16Z');
      expect(value.toString(), value.toDateTimeString());
    });

    test('toLegacyString matches PHP DateTime style', () {
      final value = Carbon.parse('1975-12-25T14:15:16Z');
      expect(value.toLegacyString(), 'Thu Dec 25 1975 14:15:16 GMT+0000');
      final offset = value.tz('-05:00');
      expect(offset.toLegacyString(), 'Thu Dec 25 1975 09:15:16 GMT-0500');
    });

    test('toDateString/toTimeString/toDateTimeString', () {
      final value = Carbon.parse('2025-11-14T08:30:45Z');
      expect(value.toDateString(), '2025-11-14');
      expect(value.toTimeString(), '08:30:45');
      expect(value.toDateTimeString(), '2025-11-14 08:30:45');
    });

    test('toDateTimeString pads zeroes', () {
      final value = Carbon.parse('2000-05-02T04:03:04Z');
      expect(value.toDateTimeString(), '2000-05-02 04:03:04');
    });

    test('toDateTimeLocalString precision selection', () {
      final value = Carbon.parse('1975-12-25T19:15:16.615342Z');
      expect(value.toDateTimeLocalString('second'), '1975-12-25T19:15:16');
      expect(value.toDateTimeLocalString('minute'), '1975-12-25T19:15');
      expect(
        value.toDateTimeLocalString('millisecond'),
        '1975-12-25T19:15:16.615',
      );
      expect(
        value.toDateTimeLocalString('microsecond'),
        '1975-12-25T19:15:16.615342',
      );
      expect(() => value.toDateTimeLocalString('hour'), throwsArgumentError);
    });

    test('toDateTimeLocalString retains precision for named zones', () async {
      await Carbon.configureTimeMachine(testing: true);
      addTearDown(Carbon.resetTimeMachineSupport);
      final value = Carbon.parse(
        '1975-12-25T19:15:16.615342Z',
      ).tz('America/New_York');
      expect(
        value.toDateTimeLocalString('millisecond'),
        '1975-12-25T14:15:16.615',
      );
      expect(
        value.toDateTimeLocalString('microsecond'),
        '1975-12-25T14:15:16.615342',
      );
    });

    test('formatted date helpers use locale', () {
      Carbon.setLocale('en');
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      expect(value.toFormattedDateString(), 'Dec 25, 1975');
      expect(value.toDayDateTimeString(), 'Thu, Dec 25, 1975 7:15 PM');
      expect(value.toFormattedDayDateString(), 'Thu, Dec 25, 1975');
      expect(
        value.isoFormat('MMMM Do YYYY, h:mm:ss a'),
        'December 25th 1975, 7:15:16 pm',
      );
    });

    test('formatted date helpers honor non-English locales', () {
      Carbon.setLocale('fr');
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      expect(value.toFormattedDateString(), 'déc. 25, 1975');
      expect(value.toDayDateTimeString(), 'jeu., déc. 25, 1975 7:15 PM');
      expect(value.toFormattedDayDateString(), 'jeu., déc. 25, 1975');
      print("-------");
      print(value.isoFormat('MMMM Do YYYY, h:mm:ss a'));
      print("-------");
      expect(
        value.isoFormat('MMMM Do YYYY, h:mm:ss a'),
        'décembre 25 1975, 7:15:16 pm',
      );
    });

    test('isoFormat advanced tokens', () {
      Carbon.setLocale('en');
      final value = Carbon.parse('2017-01-01T22:25:24.182937Z');
      expect(value.isoFormat('Q Qo'), '1 1st');
      expect(value.isoFormat('k kk'), '22 22');
      expect(value.isoFormat('S SS SSS SSSSSS'), '1 18 182 182937');
      final epochSeconds =
          value.dateTime.millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond;
      expect(
        value.isoFormat('X x'),
        '$epochSeconds ${value.dateTime.millisecondsSinceEpoch}',
      );
      final isoWeekSample = Carbon.parse('2017-01-01T00:00:00Z');
      expect(isoWeekSample.isoFormat('WW GGGG'), '52 2016');
      expect(isoWeekSample.isoFormat('g G'), '2017 2016');
      expect(isoWeekSample.locale('fr').isoFormat('g G'), '2016 2016');
      final previousWeekSample = Carbon.parse('2015-12-31T00:00:00Z');
      expect(previousWeekSample.isoFormat('g G'), '2016 2015');
      expect(previousWeekSample.locale('fr').isoFormat('g G'), '2015 2015');
      final spanish = Carbon.parse('2017-01-01T00:00:00Z').locale('es');
      expect(spanish.isoFormat('LL'), '1 de enero de 2017');
      expect(spanish.isoFormat('ll'), '1 de ene. de 2017');
    });

    test('translatedFormat mirrors PHP semantics', () {
      Carbon.setLocale('en');
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      expect(
        value.translatedFormat('jS \\o\\f F, Y g:i A'),
        '25th of December, 1975 7:15 PM',
      );
      Carbon.setLocale('fr');
      final french = Carbon.parse('1975-12-25T19:15:16Z');
      expect(french.translatedFormat('jS \\d\\e F Y'), '25 de décembre 1975');
      Carbon.setLocale('ru');
      final russian = Carbon.parse('2019-05-15T12:00:00Z');
      expect(russian.translatedFormat('jS'), '15-го');
      expect(russian.translatedFormat('t F'), '31 мая');
      expect(russian.translatedFormat('n F'), '5 мая');
    });

    test('setToStringFormat supports conditional closures', () {
      Carbon.setToStringFormat((CarbonInterface carbon) {
        return carbon.year == 1976
            ? carbon.translatedFormat('jS \\o\\f F g:i:s a')
            : carbon.translatedFormat('jS \\o\\f F, Y g:i:s a');
      });
      final leap = Carbon.parse('1976-12-25T14:15:16');
      final normal = Carbon.parse('1975-12-25T14:15:16');
      expect(leap.toString(), '25th of December 7:15:16 pm');
      expect(normal.toString(), '25th of December, 1975 7:15:16 pm');
      Carbon.resetToStringFormat();
    });

    test('translatedFormat renders weekday/timezone tokens', () {
      final value = Carbon.parse('1975-12-25T00:00:00Z');
      expect(
        value.translatedFormat('l D T e O P'),
        'Thursday Thu UTC UTC +0000 +00:00',
      );
      expect(
        value.locale('fr').translatedFormat('l D T e O P'),
        'jeudi jeu. UTC UTC +0000 +00:00',
      );
    });

    test('isoFormat handles escaped tokens', () {
      final value = Carbon.parse('2017-01-01T00:00:00Z');
      expect(value.isoFormat('\\MMM'), 'M01');
    });

    test('isoFormat covers full fractional precision range', () {
      final value = Carbon.parse('2017-01-01T22:25:24.182937Z');
      expect(
        value.isoFormat(
          'S SS SSS SSSS SSSSS SSSSSS SSSSSSS SSSSSSSS SSSSSSSSS',
        ),
        '1 18 182 1829 18293 182937 1829370 18293700 182937000',
      );
    });

    test('isoFormat exposes timezone names via zz', () {
      final value = Carbon.parse('2024-01-05T15:00:00Z').tz('-05:00');
      expect(value.isoFormat('zz'), '-05:00');
      expect(value.isoFormat('ZZZ'), '-18000');
    });

    test('hasIsoRelativeKeywords detects tokens and presets', () {
      expect(Carbon.hasIsoRelativeKeywords('YYYY-MM-DD'), isTrue);
      expect(Carbon.hasIsoRelativeKeywords('[literal]'), isFalse);
      expect(Carbon.hasIsoRelativeKeywords('LL'), isTrue);
    });

    test('toDebugMap surfaces date/timezone metadata', () {
      Carbon.setLocale('en');
      final value = Carbon.parse('2019-04-09T11:10:10.667Z').tz('-04:00');
      final debug = value.toDebugMap();
      expect(debug['date'], '2019-04-09 07:10:10.667000');
      final timezone = debug['timezone'] as Map<String, Object?>;
      expect(timezone['name'], '-04:00');
      expect(timezone['offset'], '-04:00');
      expect(timezone['offsetSeconds'], -4 * Duration.secondsPerHour);
      expect(timezone['isDst'], isFalse);
      expect(debug['timezoneType'], 3);
    });

    test('toDebugMap includes locale hint when non-default', () {
      Carbon.setLocale('en');
      final value = Carbon.parse('2000-01-01T00:00:00Z').locale('fr');
      final debug = value.toDebugMap();
      expect(debug['locale'], 'fr');
      expect(debug['translator'], {
        'type': 'CarbonTranslator',
        'locale': 'fr',
        'fallbackLocale': 'en',
      });
    });

    test('formatted helpers support region-specific locales', () {
      Carbon.setLocale('fr_FR');
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      expect(value.toFormattedDateString(), 'déc. 25, 1975');
      expect(value.toDayDateTimeString(), 'jeu., déc. 25, 1975 7:15 PM');
      expect(value.toFormattedDayDateString(), 'jeu., déc. 25, 1975');
    });

    test('formatted helpers fall back for unsupported locales', () {
      Carbon.setLocale('xx_YY.UTF-8@calendar=gregorian');
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      expect(value.toFormattedDateString(), 'Dec 25, 1975');
      expect(value.toDayDateTimeString(), 'Thu, Dec 25, 1975 7:15 PM');
      expect(value.toFormattedDayDateString(), 'Thu, Dec 25, 1975');
    });

    test('ISO and Atom strings honor offsets', () {
      final base = Carbon.parse('1975-12-25T14:15:16', timeZone: '-05:00');
      expect(base.toIso8601String(), '1975-12-25T19:15:16.000Z');
      expect(
        base.toIso8601String(keepOffset: true),
        '1975-12-25T14:15:16.000-05:00',
      );
      expect(base.toIso8601ZuluString(), '1975-12-25T19:15:16.000Z');
      expect(base.toAtomString(), '1975-12-25T14:15:16-05:00');
      expect(base.toJsonString(), '1975-12-25T19:15:16.000Z');
      expect(base.toISOString(), '1975-12-25T19:15:16.000Z');
      expect(
        base.toISOString(keepOffset: true),
        '1975-12-25T14:15:16.000-05:00',
      );
    });

    test('toIso8601String supports expanded years', () {
      final future = Carbon.create(
        year: 12021,
        month: 3,
        day: 4,
        hour: 5,
        minute: 6,
        second: 7,
      );
      expect(future.toIso8601String(), '+012021-03-04T05:06:07.000Z');
      final past = Carbon.create(
        year: -120,
        month: 1,
        day: 2,
        hour: 3,
        minute: 4,
        second: 5,
      );
      expect(past.toIso8601String(), '-000120-01-02T03:04:05.000Z');
    });

    test('toCookieString includes GMT offset', () {
      final base = Carbon.parse('1975-12-25T14:15:16', timeZone: '-05:00');
      expect(base.toCookieString(), 'Thursday, 25-Dec-1975 14:15:16 GMT-05:00');
    });

    test('RFC helpers mirror PHP formats', () async {
      await Carbon.configureTimeMachine(testing: true);
      addTearDown(Carbon.resetTimeMachineSupport);
      final base = Carbon.parse('1975-12-25T14:15:16', timeZone: '-05:00');
      expect(base.toRfc822String(), 'Thu, 25 Dec 75 14:15:16 -0500');
      expect(base.toRfc1036String(), 'Thu, 25 Dec 75 14:15:16 -0500');
      expect(base.toRfc1123String(), 'Thu, 25 Dec 1975 14:15:16 -0500');
      expect(base.toRfc2822String(), 'Thu, 25 Dec 1975 14:15:16 -0500');
      expect(base.toRssString(), 'Thu, 25 Dec 1975 14:15:16 -0500');
      expect(base.toRfc3339String(), '1975-12-25T14:15:16-05:00');
      final precise = Carbon.parse('1975-12-25T19:15:16.615342Z');
      expect(precise.toRfc3339String(), '1975-12-25T19:15:16+00:00');
      expect(
        precise.toRfc3339String(extended: true),
        '1975-12-25T19:15:16.615+00:00',
      );
      expect(precise.toW3cString(), '1975-12-25T19:15:16+00:00');
      expect(precise.toRfc7231String(), 'Thu, 25 Dec 1975 19:15:16 GMT');
      final named = Carbon.parse('1975-12-25T19:15:16Z').tz('America/New_York');
      expect(named.toRfc850String(), 'Thursday, 25-Dec-75 14:15:16 EST');
    });

    test('toLegacyString mirrors PHP Carbon format', () {
      final value = Carbon.parse('1975-12-25T14:15:16', timeZone: '-05:00');
      expect(value.toLegacyString(), 'Thu Dec 25 1975 14:15:16 GMT-0500');
    });

    test('setToStringFormat accepts format strings', () {
      final value = Carbon.parse('1975-12-25T14:15:16');
      Carbon.setToStringFormat('yyyy');
      expect(value.toString(), '1975');
      Carbon.resetToStringFormat();
      expect(value.toString(), value.toDateTimeString());
    });

    test('resetToStringFormat restores default behavior', () {
      final value = Carbon.parse('1999-12-31T23:59:59Z');
      Carbon.setToStringFormat('yyyy');
      expect(value.toString(), '1999');
      Carbon.resetToStringFormat();
      expect(value.toString(), '1999-12-31 23:59:59');
    });

    test('Carbon subclasses inherit toString overrides', () {
      final base = Carbon.parse('1975-12-25T14:15:16');
      final subclass = CarbonTestSubclass.from(base);
      expect(subclass.toString(), base.toDateTimeString());
      Carbon.setToStringFormat('yyyy');
      expect(subclass.toString(), '1975');
      Carbon.resetToStringFormat();
    });

    test('setToStringFormat accepts callbacks', () {
      Carbon.setToStringFormat((carbon) => carbon.toDateString());
      final value = Carbon.parse('1975-12-25T14:15:16');
      expect(value.toString(), '1975-12-25');
      Carbon.resetToStringFormat();
    });

    test('setToStringFormat accepts Carbon-specific callbacks', () {
      Carbon.setToStringFormat((Carbon carbon) => carbon.toDateString());
      final mutable = Carbon.parse('1975-12-25T14:15:16');
      final immutable = mutable.toImmutable();
      expect(mutable.toString(), '1975-12-25');
      expect(immutable.toString(), '1975-12-25');
      Carbon.resetToStringFormat();
    });

    test('setToStringFormat accepts no-argument callbacks', () {
      Carbon.setToStringFormat(() => 'static');
      final value = Carbon.parse('1975-12-25T14:15:16');
      expect(value.toString(), 'static');
      Carbon.resetToStringFormat();
    });

    test('toJson surfaces locale and timezone', () {
      final value = Carbon.parse('1975-12-25T14:15:16', timeZone: '-05:00');
      final json = value.toJson();
      expect(json['iso'], value.toIso8601String());
      expect(json['epochMs'], value.toEpochMilliseconds());
      expect(json['locale'], 'en');
      expect(json['timeZone'], '-05:00');
    });

    test('toArray exposes individual components', () {
      final value = Carbon.parse('1975-12-25T19:15:16Z').tz('-05:00');
      final snapshot = value.toArray();
      expect(snapshot['year'], value.year);
      expect(snapshot['month'], value.month);
      expect(snapshot['day'], value.day);
      expect(snapshot['dayOfWeek'], value.dayOfWeek);
      expect(snapshot['dayOfYear'], value.dayOfYear);
      expect(snapshot['hour'], value.hour);
      expect(snapshot['minute'], value.minute);
      expect(snapshot['second'], value.second);
      expect(snapshot['micro'], value.microsecond);
      expect(
        snapshot['timestamp'],
        value.dateTime.microsecondsSinceEpoch ~/ Duration.microsecondsPerSecond,
      );
      expect(snapshot['timezone'], '-05:00');
      expect(snapshot['formatted'], '1975-12-25 14:15:16');
    });

    test('toObject mirrors toArray output', () {
      final value = Carbon.parse('1975-12-25T19:15:16Z');
      final asObject = value.toObject();
      expect(asObject.year, value.year);
      expect(asObject.month, value.month);
      expect(asObject.day, value.day);
      expect(asObject.dayOfWeek, value.dayOfWeek);
      expect(asObject.dayOfYear, value.dayOfYear);
      expect(asObject.hour, value.hour);
      expect(asObject.minute, value.minute);
      expect(asObject.second, value.second);
      expect(asObject.micro, value.microsecond);
      expect(
        asObject.timestamp,
        value.dateTime.microsecondsSinceEpoch ~/ Duration.microsecondsPerSecond,
      );
      expect(asObject.timezone, 'UTC');
      expect(asObject.formatted, '1975-12-25 19:15:16');
      expect(asObject.toMap(), value.toArray());
    });

    test('toDateTime/toDate honor timezone snapshots', () async {
      await Carbon.configureTimeMachine(testing: true);
      addTearDown(Carbon.resetTimeMachineSupport);
      final value = Carbon.parse(
        '2019-11-02T23:10:10.888480Z',
      ).tz('America/Toronto');
      final dt = value.toDateTime();
      expect(dt.year, 2019);
      expect(dt.month, 11);
      expect(dt.day, 2);
      expect(dt.hour, 19); // Toronto is UTC-4 before fallback
      expect(dt.minute, 10);
      expect(dt.second, 10);
      expect(dt.millisecond, value.millisecond);
      expect(dt.millisecond * 1000 + dt.microsecond, value.microsecond);
      final dateOnly = value.toDate();
      expect(dateOnly.hour, 0);
      expect(dateOnly.minute, 0);
      expect(dateOnly.second, 0);
      expect(dateOnly.year, 2019);
      expect(dateOnly.month, 11);
      expect(dateOnly.day, 2);
    });
  });
}

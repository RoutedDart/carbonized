import 'package:carbon/carbon.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Carbon.setLocale('en');
    Carbon.setWeekStartsAt(DateTime.monday);
    Carbon.setTestNow(null);
  });

  tearDown(() {
    Carbon.setTestNow(null);
  });

  test('hasTestNow reflects whether a mock clock is registered', () {
    expect(Carbon.hasTestNow(), isFalse);
    expect(Carbon.getTestNow(), isNull);

    Carbon.setTestNow('2016-11-23 00:00:00');
    expect(Carbon.hasTestNow(), isTrue);
    final snapshot = Carbon.getTestNow();
    expect(snapshot, isNotNull);
    expect(
      snapshot!.toIso8601String(),
      Carbon.parse('2016-11-23 00:00:00').toIso8601String(),
    );
  });

  test('withTestNow scopes the mocked clock and restores it afterwards', () {
    final marker = Carbon.parse('2025-06-01 12:00:00');
    final value = Carbon.withTestNow(marker, () {
      expect(Carbon.hasTestNow(), isTrue);
      return Carbon.now();
    });
    expect(value.dateTime, marker.dateTime);
    expect(Carbon.hasTestNow(), isFalse);
  });

  test('setTestNow accepts closures that adjust timezone-aware results', () {
    final base = Carbon.parse('2019-09-21 12:34:56.123456');
    var delta = 0;

    Carbon.setTestNow((Carbon now) {
      final clone = base.toMutable().copyWith(timeZone: now.timeZoneName);
      if (delta != 0) {
        clone.addMicroseconds(delta);
      }
      return clone;
    });

    final first = Carbon.now(timeZone: 'UTC');
    expect(first.timeZoneName, 'UTC');
    expect(first.dateTime, base.dateTime);

    delta = 11111111;
    final second = Carbon.now(timeZone: '+02:00');
    expect(second.timeZoneName, '+02:00');
    expect(second.dateTime, first.dateTime.add(Duration(microseconds: delta)));
  });

  test('setTestNowAndTimezone aligns timezone on now()', () {
    Carbon.setTestNowAndTimezone('2020-01-01 10:20:30', timeZone: '+02:00');
    final now = Carbon.now();
    expect(now.timeZoneName, '+02:00');
    expect(
      now.toIso8601String(),
      Carbon.parse('2020-01-01 10:20:30').toIso8601String(),
    );
  });

  test('constructor tokens return mocked now when present', () {
    final mocked = Carbon.yesterday();
    Carbon.setTestNow(mocked);

    expect(Carbon().dateTime, mocked.dateTime);
    expect(Carbon(null).dateTime, mocked.dateTime);
    expect(Carbon('').dateTime, mocked.dateTime);
    expect(Carbon('now').dateTime, mocked.dateTime);
  });

  test('constructor tokens respect timezone parameter', () {
    final mocked = Carbon.parse('2020-05-01 10:00:00', timeZone: 'UTC');
    Carbon.setTestNow(mocked);
    final offset = Carbon('', '-04:00');
    expect(offset.timeZoneName, '-04:00');
    expect(offset.dateTime, mocked.dateTime);
  });

  test('parse tokens return mocked now when present', () {
    final mocked = Carbon.parse('2013-09-01T05:15:05Z');
    Carbon.setTestNow(mocked);

    expect(Carbon.parse(null).dateTime, mocked.dateTime);
    expect(Carbon.parse('').dateTime, mocked.dateTime);
    expect(Carbon.parse('now').dateTime, mocked.dateTime);
  });

  test('parse tokens fall back to the active clock when not mocked', () {
    Carbon.setTestNow(null);
    final fixed = DateTime.utc(2030, 7, 4, 12, 30);
    withClock(Clock.fixed(fixed), () {
      final parsed = Carbon.parse('now');
      expect(parsed.dateTime, fixed);
    });
  });

  test('parse tokens honor timezone overrides under mocked clock', () {
    final mocked = Carbon.parse('2013-07-01 12:00:00', timeZone: '-04:00');
    Carbon.setTestNow(mocked);

    final mexico = Carbon.parse('now', timeZone: '-05:00');
    expect(mexico.timeZoneName, '-05:00');
    expect(mexico.dateTime, mocked.dateTime);
  });

  test('setTestNow(false) restores real clock', () {
    Carbon.setTestNow('2020-01-01T00:00:00Z');
    expect(Carbon.hasTestNow(), isTrue);
    Carbon.setTestNow(false);
    expect(Carbon.hasTestNow(), isFalse);
  });

  test('relative phrases mirror PHP behavior when testNow set', () {
    final reference = Carbon.parse('2013-09-01T05:15:05Z');
    Carbon.setTestNow(reference);

    expect(
      Carbon.parse('5 minutes ago').toIso8601String(),
      '2013-09-01T05:10:05.000Z',
    );
    expect(
      Carbon.parse('1 week ago').toIso8601String(),
      '2013-08-25T05:15:05.000Z',
    );
    expect(
      Carbon.parse('+1 day').toIso8601String(),
      '2013-09-02T05:15:05.000Z',
    );
    expect(
      Carbon.parse('-1 day').toIso8601String(),
      '2013-08-31T05:15:05.000Z',
    );
    expect(
      Carbon.parse('tomorrow').toIso8601String(),
      '2013-09-02T00:00:00.000Z',
    );
    expect(Carbon.parse('today').toIso8601String(), '2013-09-01T00:00:00.000Z');
    expect(
      Carbon.parse('yesterday').toIso8601String(),
      '2013-08-31T00:00:00.000Z',
    );
    expect(
      Carbon.parse('next monday').toIso8601String(),
      '2013-09-02T00:00:00.000Z',
    );
    expect(
      Carbon.parse('last monday').toIso8601String(),
      '2013-08-26T00:00:00.000Z',
    );
    expect(
      Carbon.parse('this sunday').toIso8601String(),
      '2013-09-01T00:00:00.000Z',
    );
    expect(
      Carbon.parse('first day of next month').toIso8601String(),
      '2013-10-01T05:15:05.000Z',
    );
    expect(
      Carbon.parse('last day of this month').toIso8601String(),
      '2013-09-30T05:15:05.000Z',
    );
  });

  test('withTestNow restores mock clock after exceptions', () {
    expect(
      () => Carbon.withTestNow('2020-09-16 10:20:00', () {
        expect(Carbon.hasTestNow(), isTrue);
        throw StateError('boom');
      }),
      throwsStateError,
    );
    expect(Carbon.hasTestNow(), isFalse);
  });

  test('setTestNow propagates to immutable variants', () {
    final reference = Carbon.parse('2018-05-06 05:10:15.123456');
    Carbon.setTestNow(reference);
    expect(
      CarbonImmutable.now().toIso8601String(),
      reference.toIso8601String(),
    );
    expect(Carbon.now().toIso8601String(), reference.toIso8601String());
  });
}

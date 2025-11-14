import 'package:carbon/carbon.dart';
import 'package:test/test.dart';

Carbon _time(
  int hour, [
  int minute = 0,
  num second = 0,
  int millisecond = 0,
  int microsecond = 0,
]) {
  final wholeSeconds = second.floor();
  final fractionalMillis = ((second - wholeSeconds) * 1000).round();
  return Carbon.create(
    year: 1970,
    month: 1,
    day: 1,
    hour: hour,
    minute: minute,
    second: wholeSeconds,
    millisecond: millisecond + fractionalMillis,
    microsecond: microsecond,
  );
}

void main() {
  group('Carbon.add - hours', () {
    test('addHours with positive value', () {
      final date = _time(0).addHours(1);
      expect(date.hour, 1);
    });

    test('addHours with zero', () {
      final date = _time(0).addHours(0);
      expect(date.hour, 0);
    });

    test('addHours with negative value', () {
      final date = _time(0).addHours(-1);
      expect(date.hour, 23);
    });

    test('addHour adds one hour', () {
      final date = _time(0).addHour();
      expect(date.hour, 1);
    });

    test('addHour with explicit count', () {
      final date = _time(10).addHour(2);
      expect(date.hour, 12);
    });

    test('addHours across day boundary', () {
      final date = Carbon.create(year: 2020, month: 1, day: 15, hour: 22).addHours(5);
      expect(date.hour, 3);
      expect(date.day, 16);
    });
  });

  group('Carbon.sub - hours', () {
    test('subHours with positive value', () {
      final date = _time(1).subHours(1);
      expect(date.hour, 0);
    });

    test('subHours with zero', () {
      final date = _time(1).subHours(0);
      expect(date.hour, 1);
    });

    test('subHours with negative value', () {
      final date = _time(0).subHours(-1);
      expect(date.hour, 1);
    });

    test('subHour subtracts one hour', () {
      final date = _time(1).subHour();
      expect(date.hour, 0);
    });
  });

  group('Carbon.add - minutes', () {
    test('addMinutes with positive value', () {
      final date = _time(0, 0).addMinutes(1);
      expect(date.minute, 1);
    });

    test('addMinutes with zero', () {
      final date = _time(0, 0).addMinutes(0);
      expect(date.minute, 0);
    });

    test('addMinutes with negative value', () {
      final date = _time(0, 0).addMinutes(-1);
      expect(date.minute, 59);
    });

    test('addMinute adds one minute', () {
      final date = _time(0, 0).addMinute();
      expect(date.minute, 1);
    });

    test('addMinute with explicit count', () {
      final date = _time(0).addMinute(2);
      expect(date.minute, 2);
    });

    test('addMinutes across hour boundary', () {
      final date = _time(0, 55).addMinutes(10);
      expect(date.hour, 1);
      expect(date.minute, 5);
    });
  });

  group('Carbon.sub - minutes', () {
    test('subMinutes with positive value', () {
      final date = _time(0, 1).subMinutes(1);
      expect(date.minute, 0);
    });

    test('subMinutes with zero', () {
      final date = _time(0, 1).subMinutes(0);
      expect(date.minute, 1);
    });

    test('subMinutes with negative value', () {
      final date = _time(0, 0).subMinutes(-1);
      expect(date.minute, 1);
    });

    test('subMinute subtracts one minute', () {
      final date = _time(0, 1).subMinute();
      expect(date.minute, 0);
    });
  });

  group('Carbon.add - seconds', () {
    test('addSeconds with positive value', () {
      final date = _time(0, 0, 0).addSeconds(1);
      expect(date.second, 1);
    });

    test('addSeconds with zero', () {
      final date = _time(0, 0, 0).addSeconds(0);
      expect(date.second, 0);
    });

    test('addSeconds with negative value', () {
      final date = _time(0, 0, 0).addSeconds(-1);
      expect(date.second, 59);
    });

    test('addSecond adds one second', () {
      final date = _time(0, 0, 0).addSecond();
      expect(date.second, 1);
    });

    test('addSecond with explicit count', () {
      final date = _time(0).addSecond(2);
      expect(date.second, 2);
    });

    test('addSeconds across minute boundary', () {
      final date = _time(0, 0, 55).addSeconds(10);
      expect(date.minute, 1);
      expect(date.second, 5);
    });
  });

  group('Carbon.sub - seconds', () {
    test('subSeconds with positive value', () {
      final date = _time(0, 0, 1).subSeconds(1);
      expect(date.second, 0);
    });

    test('subSeconds with zero', () {
      final date = _time(0, 0, 1).subSeconds(0);
      expect(date.second, 1);
    });

    test('subSeconds with negative value', () {
      final date = _time(0, 0, 0).subSeconds(-1);
      expect(date.second, 1);
    });

    test('subSecond subtracts one second', () {
      final date = _time(0, 0, 1).subSecond();
      expect(date.second, 0);
    });
  });

  group('Carbon.add - milliseconds', () {
    test('addMilliseconds with positive value', () {
      final date = _time(0, 0, 0).addMilliseconds(1);
      expect(date.millisecond, 1);
    });

    test('addMilliseconds with zero', () {
      final date = _time(0, 0, 0.1).addMilliseconds(0);
      expect(date.millisecond, 100);
    });

    test('addMilliseconds with negative value', () {
      final date = _time(0, 0, 0).addMilliseconds(-1);
      expect(date.millisecond, 999);
    });

    test('addMillisecond adds one millisecond', () {
      final date = _time(0, 0, 0.1).addMillisecond();
      expect(date.millisecond, 101);
    });
  });

  group('Carbon.sub - milliseconds', () {
    test('subMilliseconds with positive value', () {
      final date = _time(0, 0, 0).addMilliseconds(1).subMilliseconds(1);
      expect(date.millisecond, 0);
    });

    test('subMilliseconds with zero', () {
      final date = _time(0, 0, 0.1).subMilliseconds(0);
      expect(date.millisecond, 100);
    });

    test('subMillisecond subtracts one millisecond', () {
      final date = _time(0, 0, 0.1).subMillisecond();
      expect(date.millisecond, 99);
    });
  });

  group('Carbon.add - microseconds', () {
    test('addMicroseconds with positive value', () {
      final date = _time(0, 0, 0, 0, 0).addMicroseconds(1);
      expect(date.microsecond, 1);
    });

    test('addMicroseconds with zero', () {
      final date = _time(0, 0, 0, 0, 100).addMicroseconds(0);
      expect(date.microsecond, 100);
    });

    test('addMicroseconds with negative value', () {
      final date = _time(0, 0, 0, 0, 0).addMicroseconds(-1);
      expect(date.microsecond, 999999);
    });

    test('addMicrosecond adds one microsecond', () {
      final date = _time(0, 0, 0, 0, 100).addMicrosecond();
      expect(date.microsecond, 101);
    });
  });

  group('Carbon.sub - microseconds', () {
    test('subMicroseconds with positive value', () {
      final date = _time(0, 0, 0, 0, 0).addMicroseconds(1).subMicroseconds(1);
      expect(date.microsecond, 0);
    });

    test('subMicroseconds with zero', () {
      final date = _time(0, 0, 0, 0, 100).subMicroseconds(0);
      expect(date.microsecond, 100);
    });

    test('subMicrosecond subtracts one microsecond', () {
      final date = _time(0, 0, 0, 0, 100).subMicrosecond();
      expect(date.microsecond, 99);
    });
  });
}

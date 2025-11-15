part of '../carbon.dart';

enum CarbonUnit {
  microsecond,
  millisecond,
  second,
  minute,
  hour,
  day,
  week,
  month,
  quarter,
  year,
  decade,
  century,
  millennium,
}

class CarbonSettings {
  const CarbonSettings({
    this.monthOverflow = true,
    this.startOfWeek = DateTime.monday,
  });

  final bool monthOverflow;
  final int startOfWeek;

  CarbonSettings copyWith({bool? monthOverflow, int? startOfWeek}) =>
      CarbonSettings(
        monthOverflow: monthOverflow ?? this.monthOverflow,
        startOfWeek: startOfWeek ?? this.startOfWeek,
      );
}

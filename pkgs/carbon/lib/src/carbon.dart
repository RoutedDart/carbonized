/// Internal Carbon core that stitches together the shared part files.
///
/// This library exposes the implementation imported by `package:carbon/carbon.dart`.
library;

import 'dart:convert';
import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:intl/intl.dart';

// Import generated locales first
import 'core/locales/generated/all_generated.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:time_machine/time_machine.dart' as tm;
// Import internal API needed to load timezone data on web
// ignore: implementation_imports
import 'package:time_machine/src/timezones/tzdb_datetimezone_source.dart'
    // ignore: invalid_use_of_internal_member
    show ITzdbDateTimeZoneSource;

part 'core/carbon_macro.dart';
part 'core/carbon_settings.dart';
part 'core/carbon_interface.dart';
part 'core/carbon_date_time_view.dart';
part 'core/carbon_last_errors.dart';
part 'core/carbon_base.dart';
part 'core/carbon_aliases.dart';
part 'core/carbon_interval.dart';
part 'core/carbon_period.dart';
part 'core/carbon_mutable.dart';
part 'core/carbon_immutable.dart';
part 'core/carbon_components.dart';
part 'core/timezone_snapshot.dart';
part 'core/carbon_alias_shims.dart';
part 'core/carbon_exceptions.dart';
part 'core/locale_defaults.dart';
part 'core/locale_first_week_min_days.dart';
part 'core/locale_genitive_months.dart';
part 'core/carbon_factory.dart';
part 'core/carbon_test_support.dart';
part 'core/iso_format.dart';
part 'core/carbon_translator.dart';
part 'core/carbon_locale_data.dart';
part 'core/carbon_lookup_messages.dart';
part 'core/locales/all_locales.dart';

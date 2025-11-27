// AUTO-GENERATED from PHP Carbon locale: ar
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeAr = CarbonLocaleData(
  localeCode: 'ar',
  translationStrings: {
    'year':
        '{0}:count سنة|{1}سنة|{2}سنتين|]2,11[:count سنوات|]10,Inf[:count سنة',
    'a_year':
        '{0}:count سنة|{1}سنة|{2}سنتين|]2,11[:count سنوات|]10,Inf[:count سنة',
    'month':
        '{0}:count شهر|{1}شهر|{2}شهرين|]2,11[:count أشهر|]10,Inf[:count شهر',
    'a_month':
        '{0}:count شهر|{1}شهر|{2}شهرين|]2,11[:count أشهر|]10,Inf[:count شهر',
    'week':
        '{0}:count أسبوع|{1}أسبوع|{2}أسبوعين|]2,11[:count أسابيع|]10,Inf[:count أسبوع',
    'a_week':
        '{0}:count أسبوع|{1}أسبوع|{2}أسبوعين|]2,11[:count أسابيع|]10,Inf[:count أسبوع',
    'day': '{0}:count يوم|{1}يوم|{2}يومين|]2,11[:count أيام|]10,Inf[:count يوم',
    'a_day':
        '{0}:count يوم|{1}يوم|{2}يومين|]2,11[:count أيام|]10,Inf[:count يوم',
    'hour':
        '{0}:count ساعة|{1}ساعة|{2}ساعتين|]2,11[:count ساعات|]10,Inf[:count ساعة',
    'a_hour':
        '{0}:count ساعة|{1}ساعة|{2}ساعتين|]2,11[:count ساعات|]10,Inf[:count ساعة',
    'minute':
        '{0}:count دقيقة|{1}دقيقة|{2}دقيقتين|]2,11[:count دقائق|]10,Inf[:count دقيقة',
    'a_minute':
        '{0}:count دقيقة|{1}دقيقة|{2}دقيقتين|]2,11[:count دقائق|]10,Inf[:count دقيقة',
    'second':
        '{0}:count ثانية|{1}ثانية|{2}ثانيتين|]2,11[:count ثواني|]10,Inf[:count ثانية',
    'a_second':
        '{0}:count ثانية|{1}ثانية|{2}ثانيتين|]2,11[:count ثواني|]10,Inf[:count ثانية',
    'ago': 'منذ :time',
    'from_now': ':time من الآن',
    'after': 'بعد :time',
    'before': 'قبل :time',
    'diff_now': 'الآن',
    'diff_today': 'اليوم',
    'diff_today_regexp': 'اليوم(?:\\s+عند)?(?:\\s+الساعة)?',
    'diff_yesterday': 'أمس',
    'diff_yesterday_regexp': 'أمس(?:\\s+عند)?(?:\\s+الساعة)?',
    'diff_tomorrow': 'غداً',
    'diff_tomorrow_regexp': 'غدًا(?:\\s+عند)?(?:\\s+الساعة)?',
    'diff_before_yesterday': 'قبل الأمس',
    'diff_after_tomorrow': 'بعد غد',
    'period_recurrences':
        '{0}مرة|{1}مرة|{2}:count مرتين|]2,11[:count مرات|]10,Inf[:count مرة',
    'period_interval': 'كل :interval',
    'period_start_date': 'من :date',
    'period_end_date': 'إلى :date',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'D/M/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'dddd D MMMM YYYY HH:mm',
  },
  months: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  monthsShort: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  weekdays: [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ],
  weekdaysShort: ['أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت'],
  weekdaysMin: ['ح', 'اث', 'ثل', 'أر', 'خم', 'ج', 'س'],
  firstDayOfWeek: 6,
  dayOfFirstWeekOfYear: 1,
  calendar: {
    'sameDay': '[اليوم عند الساعة] LT',
    'nextDay': '[غدًا عند الساعة] LT',
    'nextWeek': 'dddd [عند الساعة] LT',
    'lastDay': '[أمس عند الساعة] LT',
    'lastWeek': 'dddd [عند الساعة] LT',
    'sameElse': 'L',
  },
  listSeparators: ['، ', ' و '],
  periodRecurrences:
      '{0}مرة|{1}مرة|{2}:count مرتين|]2,11[:count مرات|]10,Inf[:count مرة',
  periodInterval: 'كل :interval',
  periodStartDate: 'من :date',
  periodEndDate: 'إلى :date',
  meridiem: _meridiem,
);

// Regional variant: ar_AE
final CarbonLocaleData localeArAe = localeAr.copyWith(
  localeCode: 'ar_ae',
  weekdays: [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت ',
  ],
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_BH
final CarbonLocaleData localeArBh = localeAr.copyWith(
  localeCode: 'ar_bh',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_DJ
final CarbonLocaleData localeArDj = localeAr.copyWith(localeCode: 'ar_dj');

// Regional variant: ar_DZ
final CarbonLocaleData localeArDz = localeAr.copyWith(
  localeCode: 'ar_dz',
  weekdaysMin: ['أح', 'إث', 'ثلا', 'أر', 'خم', 'جم', 'سب'],
  months: [
    'جانفي',
    'فيفري',
    'مارس',
    'أفريل',
    'ماي',
    'جوان',
    'جويلية',
    'أوت',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  monthsShort: [
    'جانفي',
    'فيفري',
    'مارس',
    'أفريل',
    'ماي',
    'جوان',
    'جويلية',
    'أوت',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  calendar: {
    'sameDay': '[اليوم على الساعة] LT',
    'nextDay': '[غدا على الساعة] LT',
    'nextWeek': 'dddd [على الساعة] LT',
    'lastDay': '[أمس على الساعة] LT',
    'lastWeek': 'dddd [على الساعة] LT',
    'sameElse': 'L',
  },
);

// Regional variant: ar_EG
final CarbonLocaleData localeArEg = localeAr.copyWith(
  localeCode: 'ar_eg',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_EH
final CarbonLocaleData localeArEh = localeAr.copyWith(localeCode: 'ar_eh');

// Regional variant: ar_ER
final CarbonLocaleData localeArEr = localeAr.copyWith(localeCode: 'ar_er');

// Regional variant: ar_IL
final CarbonLocaleData localeArIl = localeAr.copyWith(localeCode: 'ar_il');

// Regional variant: ar_IN
final CarbonLocaleData localeArIn = localeAr.copyWith(
  localeCode: 'ar_in',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_IQ
final CarbonLocaleData localeArIq = localeAr.copyWith(
  localeCode: 'ar_iq',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
  monthsShort: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
);

// Regional variant: ar_JO
final CarbonLocaleData localeArJo = localeAr.copyWith(
  localeCode: 'ar_jo',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
  monthsShort: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
);

// Regional variant: ar_KM
final CarbonLocaleData localeArKm = localeAr.copyWith(localeCode: 'ar_km');

// Regional variant: ar_KW
final CarbonLocaleData localeArKw = localeAr.copyWith(
  localeCode: 'ar_kw',
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'ماي',
    'يونيو',
    'يوليوز',
    'غشت',
    'شتنبر',
    'أكتوبر',
    'نونبر',
    'دجنبر',
  ],
  monthsShort: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'ماي',
    'يونيو',
    'يوليوز',
    'غشت',
    'شتنبر',
    'أكتوبر',
    'نونبر',
    'دجنبر',
  ],
  calendar: {
    'sameDay': '[اليوم على الساعة] LT',
    'nextDay': '[غدا على الساعة] LT',
    'nextWeek': 'dddd [على الساعة] LT',
    'lastDay': '[أمس على الساعة] LT',
    'lastWeek': 'dddd [على الساعة] LT',
    'sameElse': 'L',
  },
);

// Regional variant: ar_LB
final CarbonLocaleData localeArLb = localeAr.copyWith(
  localeCode: 'ar_lb',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
  monthsShort: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
);

// Regional variant: ar_LY
final CarbonLocaleData localeArLy = localeAr.copyWith(
  localeCode: 'ar_ly',
  periodRecurrences: 'مرة|مرة|:count مرتين|:count مرات|:count مرة',
);

// Regional variant: ar_MA
final CarbonLocaleData localeArMa = localeAr.copyWith(
  localeCode: 'ar_ma',
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'ماي',
    'يونيو',
    'يوليوز',
    'غشت',
    'شتنبر',
    'أكتوبر',
    'نونبر',
    'دجنبر',
  ],
  monthsShort: [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'ماي',
    'يونيو',
    'يوليوز',
    'غشت',
    'شتنبر',
    'أكتوبر',
    'نونبر',
    'دجنبر',
  ],
  calendar: {
    'sameDay': '[اليوم على الساعة] LT',
    'nextDay': '[غدا على الساعة] LT',
    'nextWeek': 'dddd [على الساعة] LT',
    'lastDay': '[أمس على الساعة] LT',
    'lastWeek': 'dddd [على الساعة] LT',
    'sameElse': 'L',
  },
);

// Regional variant: ar_MR
final CarbonLocaleData localeArMr = localeAr.copyWith(localeCode: 'ar_mr');

// Regional variant: ar_OM
final CarbonLocaleData localeArOm = localeAr.copyWith(
  localeCode: 'ar_om',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_PS
final CarbonLocaleData localeArPs = localeAr.copyWith(localeCode: 'ar_ps');

// Regional variant: ar_QA
final CarbonLocaleData localeArQa = localeAr.copyWith(
  localeCode: 'ar_qa',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_SA
final CarbonLocaleData localeArSa = localeAr.copyWith(
  localeCode: 'ar_sa',
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  calendar: {
    'sameDay': '[اليوم على الساعة] LT',
    'nextDay': '[غدا على الساعة] LT',
    'nextWeek': 'dddd [على الساعة] LT',
    'lastDay': '[أمس على الساعة] LT',
    'lastWeek': 'dddd [على الساعة] LT',
    'sameElse': 'L',
  },
);

// Regional variant: ar_SD
final CarbonLocaleData localeArSd = localeAr.copyWith(
  localeCode: 'ar_sd',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_SO
final CarbonLocaleData localeArSo = localeAr.copyWith(localeCode: 'ar_so');

// Regional variant: ar_SS
final CarbonLocaleData localeArSs = localeAr.copyWith(
  localeCode: 'ar_ss',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Regional variant: ar_SY
final CarbonLocaleData localeArSy = localeAr.copyWith(
  localeCode: 'ar_sy',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
  monthsShort: [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ],
);

// Regional variant: ar_Shakl
final CarbonLocaleData localeArShakl = localeAr.copyWith(
  localeCode: 'ar_shakl',
);

// Regional variant: ar_TD
final CarbonLocaleData localeArTd = localeAr.copyWith(localeCode: 'ar_td');

// Regional variant: ar_TN
final CarbonLocaleData localeArTn = localeAr.copyWith(
  localeCode: 'ar_tn',
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  months: [
    'جانفي',
    'فيفري',
    'مارس',
    'أفريل',
    'ماي',
    'جوان',
    'جويلية',
    'أوت',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  monthsShort: [
    'جانفي',
    'فيفري',
    'مارس',
    'أفريل',
    'ماي',
    'جوان',
    'جويلية',
    'أوت',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ],
  calendar: {
    'sameDay': '[اليوم على الساعة] LT',
    'nextDay': '[غدا على الساعة] LT',
    'nextWeek': 'dddd [على الساعة] LT',
    'lastDay': '[أمس على الساعة] LT',
    'lastWeek': 'dddd [على الساعة] LT',
    'sameElse': 'L',
  },
);

// Regional variant: ar_YE
final CarbonLocaleData localeArYe = localeAr.copyWith(
  localeCode: 'ar_ye',
  weekdaysShort: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  weekdaysMin: ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
  monthsShort: [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ],
);

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ص' : 'م';
}

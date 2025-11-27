// AUTO-GENERATED from PHP Carbon locale: lo
// Do not edit - changes will be overwritten

import 'package:carbon/carbon.dart';

const CarbonLocaleData localeLo = CarbonLocaleData(
  localeCode: 'lo',
  translationStrings: {
    'year': ':count ປີ',
    'y': ':count ປີ',
    'month': ':count ເດືອນ',
    'm': ':count ດ. ',
    'week': ':count ອາທິດ',
    'w': ':count ອທ. ',
    'day': ':count ມື້',
    'd': ':count ມື້',
    'hour': ':count ຊົ່ວໂມງ',
    'h': ':count ຊມ. ',
    'minute': ':count ນາທີ',
    'min': ':count ນທ. ',
    'second': ':count ວິນາທີ',
    'a_second': '{0,1}ບໍ່ເທົ່າໃດວິນາທີ|[-Inf,Inf]:count ວິນາທີ',
    's': ':count ວິ. ',
    'ago': ':timeຜ່ານມາ',
    'from_now': 'ອີກ :time',
    'diff_now': 'ຕອນນີ້',
    'diff_today': 'ມື້ນີ້ເວລາ',
    'diff_yesterday': 'ມື້ວານນີ້ເວລາ',
    'diff_tomorrow': 'ມື້ອື່ນເວລາ',
  },
  formats: {
    'LT': 'HH:mm',
    'LTS': 'HH:mm:ss',
    'L': 'DD/MM/YYYY',
    'LL': 'D MMMM YYYY',
    'LLL': 'D MMMM YYYY HH:mm',
    'LLLL': 'ວັນdddd D MMMM YYYY HH:mm',
  },
  months: [
    'ມັງກອນ',
    'ກຸມພາ',
    'ມີນາ',
    'ເມສາ',
    'ພຶດສະພາ',
    'ມິຖຸນາ',
    'ກໍລະກົດ',
    'ສິງຫາ',
    'ກັນຍາ',
    'ຕຸລາ',
    'ພະຈິກ',
    'ທັນວາ',
  ],
  monthsShort: [
    'ມັງກອນ',
    'ກຸມພາ',
    'ມີນາ',
    'ເມສາ',
    'ພຶດສະພາ',
    'ມິຖຸນາ',
    'ກໍລະກົດ',
    'ສິງຫາ',
    'ກັນຍາ',
    'ຕຸລາ',
    'ພະຈິກ',
    'ທັນວາ',
  ],
  weekdays: ['ອາທິດ', 'ຈັນ', 'ອັງຄານ', 'ພຸດ', 'ພະຫັດ', 'ສຸກ', 'ເສົາ'],
  weekdaysShort: ['ທິດ', 'ຈັນ', 'ອັງຄານ', 'ພຸດ', 'ພະຫັດ', 'ສຸກ', 'ເສົາ'],
  weekdaysMin: ['ທ', 'ຈ', 'ອຄ', 'ພ', 'ພຫ', 'ສກ', 'ສ'],
  calendar: {
    'sameDay': '[ມື້ນີ້ເວລາ] LT',
    'nextDay': '[ມື້ອື່ນເວລາ] LT',
    'nextWeek': '[ວັນ]dddd[ໜ້າເວລາ] LT',
    'lastDay': '[ມື້ວານນີ້ເວລາ] LT',
    'lastWeek': '[ວັນ]dddd[ແລ້ວນີ້ເວລາ] LT',
    'sameElse': 'L',
  },
  listSeparators: [', ', 'ແລະ '],
  meridiem: _meridiem,
);

// Regional variant: lo_LA
final CarbonLocaleData localeLoLa = localeLo.copyWith(localeCode: 'lo_la');

// Auto-generated meridiem function from array
String _meridiem(int hour, dynamic minute, dynamic isLower) {
  return hour < 12 ? 'ຕອນເຊົ້າ' : 'ຕອນແລງ';
}

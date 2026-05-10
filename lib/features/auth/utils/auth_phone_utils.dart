import 'package:intl_phone_field/countries.dart' as ipc;
import 'package:intl_phone_field/phone_number.dart';

/// Kirilgan raqamlardan eng uzun mos xalqaro prefiksni topadi; bo‘lmasa [defaultCountry] ostidagi milliy raqam.
class ParsedNationalPhone {
  const ParsedNationalPhone({required this.country, required this.nationalDigits});

  final ipc.Country country;
  final String nationalDigits;
}

ParsedNationalPhone parseDigitsForCountry(String raw, ipc.Country defaultCountry) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) {
    return ParsedNationalPhone(country: defaultCountry, nationalDigits: '');
  }
  final sorted = List<ipc.Country>.from(ipc.countries)
    ..sort((a, b) => b.fullCountryCode.length.compareTo(a.fullCountryCode.length));
  for (final c in sorted) {
    final prefix = c.fullCountryCode;
    if (prefix.isEmpty) continue;
    if (digits.startsWith(prefix)) {
      return ParsedNationalPhone(
        country: c,
        nationalDigits: digits.substring(prefix.length),
      );
    }
  }
  return ParsedNationalPhone(country: defaultCountry, nationalDigits: digits);
}

PhoneNumber parsedToPhoneNumber(ParsedNationalPhone p) {
  return PhoneNumber(
    countryISOCode: p.country.code,
    countryCode: '+${p.country.fullCountryCode}',
    number: p.nationalDigits,
  );
}

/// intl_phone_field ro‘yxatida yo‘q bo‘lgan geo kodlarida xavfsiz default.
String sanitizeCountryCodeForPicker(String iso2) {
  final u = iso2.trim().toUpperCase();
  if (u.length != 2) return 'UZ';
  return ipc.countries.any((c) => c.code == u) ? u : 'UZ';
}

/// OTP yuborishdan oldin — raqam uzunligi tanlangan mamlakatga mosligi.
String? validatePhoneNumberForOtp(PhoneNumber phone) {
  final digits = phone.number.trim();
  if (digits.isEmpty) {
    return 'Telefon raqamingizni kiriting';
  }
  try {
    phone.isValidNumber();
    return null;
  } on NumberTooShortException {
    return 'Telefon raqami juda qisqa';
  } on NumberTooLongException {
    return 'Telefon raqami juda uzun';
  }
}

/// Supabase OTP uchun telefon raqamini **E.164** ga yaqinlashtirish (O‘zbekiston: +998…).
String normalizeToE164Uz(String raw) {
  var digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return '';

  digits = digits.replaceFirst(RegExp(r'^0+'), '');
  if (digits.isEmpty) return '';

  if (digits.startsWith('998')) {
    return '+$digits';
  }

  if (digits.length == 9) {
    return '+998$digits';
  }

  return '+$digits';
}

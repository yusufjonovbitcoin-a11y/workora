import 'dart:convert';

import 'package:http/http.dart' as http;

/// IP orqali taxminiy joylashuvdan ISO 3166-1 alpha-2 mamlakat kodi (masalan UZ, DE).
class IpCountryService {
  static const _fallbackIso = 'UZ';
  static const _timeout = Duration(seconds: 5);

  Future<String> fetchCountryCodeIso2() async {
    try {
      final uri = Uri.parse('https://ipapi.co/json/');
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode != 200) return _fallbackIso;
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final raw = map['country_code'];
      if (raw is! String || raw.length != 2) return _fallbackIso;
      return raw.toUpperCase();
    } catch (_) {
      return _fallbackIso;
    }
  }
}

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart' as ipc;

import '../../../core/theme/app_colors.dart';
import '../services/ip_country_service.dart';
import '../utils/auth_phone_utils.dart';

/// Chapdagi kod/bayroq faqat ko‘rsatiladi (bosilmaydi); raqam yozilganda prefiks bo‘yicha mamlakat avtomatik.
class AuthPhoneField extends StatefulWidget {
  const AuthPhoneField({
    super.key,
    required this.onPhoneChanged,
    this.hint = 'Telefon raqamingiz',
  });

  final ValueChanged<ParsedNationalPhone> onPhoneChanged;
  final String hint;

  @override
  State<AuthPhoneField> createState() => _AuthPhoneFieldState();
}

class _AuthPhoneFieldState extends State<AuthPhoneField> {
  final _controller = TextEditingController();
  final _ipCountry = IpCountryService();

  late ipc.Country _defaultCountry;

  @override
  void initState() {
    super.initState();
    _defaultCountry = ipc.countries.firstWhere((c) => c.code == 'UZ');
    _controller.addListener(_emitParsed);
    _emitParsed();
    _applyGeoCountry();
  }

  void _emitParsed() {
    final parsed = parseDigitsForCountry(_controller.text, _defaultCountry);
    widget.onPhoneChanged(parsed);
    setState(() {});
  }

  Future<void> _applyGeoCountry() async {
    final iso = await _ipCountry.fetchCountryCodeIso2();
    if (!mounted) return;
    final safe = sanitizeCountryCodeForPicker(iso);
    final country = ipc.countries.firstWhere((c) => c.code == safe, orElse: () => _defaultCountry);
    if (_controller.text.trim().isEmpty) {
      _defaultCountry = country;
      _emitParsed();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_emitParsed);
    _controller.dispose();
    super.dispose();
  }

  ipc.Country get _displayCountry {
    return parseDigitsForCountry(_controller.text, _defaultCountry).country;
  }

  @override
  Widget build(BuildContext context) {
    final country = _displayCountry;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(22),
      ),
      constraints: const BoxConstraints(minHeight: 66),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (kIsWeb)
                  Image.asset(
                    'assets/flags/${country.code.toLowerCase()}.png',
                    package: 'intl_phone_field',
                    width: 28,
                  )
                else
                  Text(country.flag, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  '+${country.displayCC}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF344054),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: AppColors.primary,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF101828),
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                isDense: true,
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintStyle: const TextStyle(
                  color: Color(0xFF98A2B3),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

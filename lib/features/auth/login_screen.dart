import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_colors.dart';
import 'presentation/providers/auth_provider.dart';
import 'widgets/telegram_login_waiting_dialog.dart';
import 'utils/auth_error_utils.dart';
import 'utils/auth_phone_utils.dart';
import 'widgets/auth_divider.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_phone_field.dart';
import 'widgets/auth_main_button.dart';
import 'widgets/auth_social_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  PhoneNumber? _phone;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectIfLoggedIn());
  }

  /// Allaqachon kirilgan bo‘lsa, login sahifasida turmasdan ilovaga kiradi.
  void _redirectIfLoggedIn() {
    if (!mounted) return;
    if (!Supabase.instance.isInitialized) return;
    if (Supabase.instance.client.auth.currentSession != null) {
      context.go('/app');
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
    );
  }

  Future<void> _sendOtp() async {
    final p = _phone;
    if (p == null) {
      _snack('Telefon raqamingizni kiriting');
      return;
    }
    final err = validatePhoneNumberForOtp(p);
    if (err != null) {
      _snack(err);
      return;
    }
    final normalized = p.completeNumber;

    setState(() => _loading = true);
    try {
      await ref.read(authRepositoryProvider).sendOtp(normalized);
      if (!mounted) return;
      context.push('/otp', extra: normalized);
    } on AuthException catch (e) {
      if (mounted) _snack(formatAuthErrorMessage(e));
    } catch (e) {
      if (mounted) {
        _snack(
          e.toString().contains('initialize')
              ? 'Supabase sozlanmagan — .env dagi URL va kalitni tekshiring'
              : e.toString(),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _telegramLogin() async {
    if (!Supabase.instance.isInitialized) {
      _snack('Supabase sozlanmagan — .env dagi URL va kalitni tekshiring');
      return;
    }
    final ok = await showTelegramLoginDialog(context, Supabase.instance.client);
    if (ok == true && mounted) context.go('/app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: BackButton(color: AppColors.primary),
            ),
            const SizedBox(height: 28),
            AuthHeader(
              title: 'Kirish',
              subtitle: 'Hisobingizga kiring',
              description: 'Workora’da davom eting',
              icon: Icons.login_rounded,
              illustrationAsset: 'assets/images/auth_login_hero.webp',
              illustrationWidthFraction: 0.38,
            ),
            const SizedBox(height: 42),
            AuthPhoneField(
              onPhoneChanged: (parsed) => _phone = parsedToPhoneNumber(parsed),
            ),
            const SizedBox(height: 22),
            AuthMainButton(
              text: 'Kirish',
              isLoading: _loading,
              onTap: _sendOtp,
            ),
            const SizedBox(height: 32),
            const AuthDivider(text: 'Yoki orqali kirish'),
            const SizedBox(height: 24),
            AuthSocialButton(
              icon: Icons.telegram_rounded,
              iconColor: const Color(0xFF229ED9),
              text: 'Telegram orqali',
              onTap: _telegramLogin,
            ),
            const SizedBox(height: 14),
            AuthSocialButton(
              leading: SvgPicture.asset(
                'assets/icons/google_logo.svg',
                fit: BoxFit.contain,
              ),
              text: 'Google orqali',
            ),
            const SizedBox(height: 34),
            AuthSwitchLink(
              text: 'Hisobingiz yo‘qmi? ',
              actionText: 'Ro‘yxatdan o‘tish',
              onTap: () => context.go('/register'),
            ),
          ],
        ),
      ),
    );
  }
}

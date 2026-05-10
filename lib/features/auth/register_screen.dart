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
import 'widgets/auth_input.dart';
import 'widgets/auth_phone_field.dart';
import 'widgets/auth_main_button.dart';
import 'widgets/auth_social_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  PhoneNumber? _phone;
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _password.dispose();
    _passwordConfirm.dispose();
    super.dispose();
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

    final p1 = _password.text;
    final p2 = _passwordConfirm.text;
    if (p1.isNotEmpty || p2.isNotEmpty) {
      if (p1 != p2) {
        _snack('Parollar mos emas');
        return;
      }
    }

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
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final keyboardOpen = bottomInset > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: keyboardOpen
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(bottom: keyboardOpen ? 24 : 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Transform.translate(
                    offset: const Offset(0, -130),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 36,
                                  ),
                                  icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/login');
                                    }
                                  },
                                ),
                              ),
                              ClipRect(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  heightFactor: 0.76,
                                  child: Image.asset(
                                    'assets/images/auth_register_hero.png',
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, -54),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Ro‘yxatdan o‘ting!',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: const Color(0xFF0B1220),
                                          height: 1.05,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Yangi hisob yarating',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF344054),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              AuthPhoneField(
                                onPhoneChanged: (parsed) =>
                                    _phone = parsedToPhoneNumber(parsed),
                              ),
                              const SizedBox(height: 6),
                              AuthInput(
                                hint: 'Parol yarating',
                                icon: Icons.lock_rounded,
                                obscure: true,
                                controller: _password,
                              ),
                              const SizedBox(height: 6),
                              AuthInput(
                                hint: 'Parolni tasdiqlang',
                                icon: Icons.lock_rounded,
                                obscure: true,
                                controller: _passwordConfirm,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AuthMainButton(
                                text: 'Ro‘yxatdan o‘tish',
                                isLoading: _loading,
                                onTap: _sendOtp,
                              ),
                              const SizedBox(height: 10),
                              const AuthDivider(text: 'Yoki orqali ro‘yxatdan o‘tish'),
                              const SizedBox(height: 10),
                              AuthSocialButton(
                                icon: Icons.telegram_rounded,
                                iconColor: const Color(0xFF229ED9),
                                text: 'Telegram orqali',
                                onTap: _telegramLogin,
                              ),
                              const SizedBox(height: 8),
                              AuthSocialButton(
                                leading: SvgPicture.asset(
                                  'assets/icons/google_logo.svg',
                                  fit: BoxFit.contain,
                                ),
                                text: 'Google orqali',
                              ),
                              const SizedBox(height: 12),
                              AuthSwitchLink(
                                text: 'Hisobingiz bormi? ',
                                actionText: 'Kirish',
                                onTap: () => context.go('/login'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

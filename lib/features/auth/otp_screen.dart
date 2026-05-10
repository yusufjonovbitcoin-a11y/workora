import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_colors.dart';
import 'presentation/providers/auth_provider.dart';
import 'utils/auth_error_utils.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_input.dart';
import 'widgets/auth_main_button.dart';
import 'widgets/auth_otp_illustration.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final controllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());
  bool _loading = false;

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
    );
  }

  Future<void> verify() async {
    if (widget.phone.isEmpty) {
      _snack('Telefon topilmadi — qaytadan kiriting');
      context.go('/login');
      return;
    }

    final code = controllers.map((c) => c.text).join();
    if (code.length != 6) {
      _snack('6 xonali kodni kiriting');
      return;
    }

    setState(() => _loading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .verifyOtp(phone: widget.phone, token: code);
      if (!mounted) return;
      context.go('/app');
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

  Future<void> resend() async {
    if (widget.phone.isEmpty) return;

    setState(() => _loading = true);
    try {
      await ref.read(authRepositoryProvider).sendOtp(widget.phone);
      if (mounted) _snack('Kod qayta yuborildi');
    } on AuthException catch (e) {
      if (mounted) _snack(formatAuthErrorMessage(e));
    } catch (e) {
      if (mounted) _snack(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
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
            const SizedBox(height: 48),
            const AuthOtpHeader(),
            const SizedBox(height: 54),
            const AuthOtpIllustration(),
            const SizedBox(height: 54),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return AuthOtpInput(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  autofocus: index == 0,
                  onChanged: (value) => onOtpChanged(value, index),
                );
              }),
            ),
            const SizedBox(height: 36),
            const _OtpTimerText(),
            const SizedBox(height: 60),
            AuthMainButton(
              text: 'Tasdiqlash',
              fontSize: 20,
              isLoading: _loading,
              onTap: verify,
            ),
            const SizedBox(height: 30),
            _ResendLink(onTap: _loading ? null : resend),
          ],
        ),
      ),
    );
  }
}

class _OtpTimerText extends StatelessWidget {
  const _OtpTimerText();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(
        TextSpan(
          text: 'Kodni ',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: '00:54',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextSpan(text: ' ichida kiriting'),
          ],
        ),
      ),
    );
  }
}

class _ResendLink extends StatelessWidget {
  const _ResendLink({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Center(
        child: Text.rich(
          TextSpan(
            text: 'Kod kelmadimi? ',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'Qayta yuborish',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

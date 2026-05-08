import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xush kelibsiz! 👋',
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0B1220),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hisobingizga kiring',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF344054),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Workora’da davom eting',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF667085),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8F1),
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: const Icon(
                    Icons.login_rounded,
                    color: AppColors.primary,
                    size: 54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 42),

            const AuthInput(
              hint: 'Telefon raqamingiz',
              icon: Icons.phone_rounded,
            ),

            const SizedBox(height: 22),

            MainButton(text: 'Kirish', onTap: () => context.go('/otp')),

            const SizedBox(height: 32),

            const DividerText(text: 'Yoki orqali kirish'),

            const SizedBox(height: 24),

            const SocialButton(
              icon: Icons.telegram_rounded,
              text: 'Telegram orqali',
              color: Color(0xFF229ED9),
            ),
            const SizedBox(height: 14),
            const SocialButton(
              icon: Icons.g_mobiledata_rounded,
              text: 'Google orqali',
              color: Colors.red,
            ),
            const SizedBox(height: 14),
            const SocialButton(
              icon: Icons.phone_android_rounded,
              text: 'SMS orqali kirish',
              color: Color(0xFF101828),
            ),

            const SizedBox(height: 34),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hisobingiz yo‘qmi? ',
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/register'),
                  child: const Text(
                    'Ro‘yxatdan o‘tish',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 48),

            const InfoBox(
              title: 'Ma’lumotlaringiz xavfsiz!',
              subtitle: 'Biz sizning ma’lumotlaringizni himoya qilamiz',
              icon: Icons.shield_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;

  const AuthInput({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: icon == Icons.phone_rounded
                  ? TextInputType.phone
                  : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Color(0xFF98A2B3),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (obscure)
            const Icon(Icons.visibility_off_outlined, color: Color(0xFF667085)),
        ],
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MainButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF006B4F), Color(0xFF009E72)],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: .22),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class DividerText extends StatelessWidget {
  final String text;

  const DividerText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF475467),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

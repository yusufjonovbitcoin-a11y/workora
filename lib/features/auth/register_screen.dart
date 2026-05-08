import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                        'Ro‘yxatdan o‘ting! 🚀',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0B1220),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Yangi hisob yarating',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF344054),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Workora’da imkoniyatlarni boshlang',
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
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.primary,
                    size: 54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 38),

            const AuthInput(
              hint: 'Telefon raqamingiz',
              icon: Icons.phone_rounded,
            ),
            const SizedBox(height: 14),
            const AuthInput(
              hint: 'Parol yarating',
              icon: Icons.lock_rounded,
              obscure: true,
            ),
            const SizedBox(height: 14),
            const AuthInput(
              hint: 'Parolni tasdiqlang',
              icon: Icons.lock_rounded,
              obscure: true,
            ),

            const SizedBox(height: 22),

            MainButton(
              text: 'Ro‘yxatdan o‘tish',
              onTap: () => context.go('/otp'),
            ),

            const SizedBox(height: 28),

            const DividerText(text: 'Yoki orqali ro‘yxatdan o‘tish'),

            const SizedBox(height: 22),

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
              text: 'SMS orqali ro‘yxatdan o‘tish',
              color: Color(0xFF101828),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hisobingiz bormi? ',
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: const Text(
                    'Kirish',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            const InfoBox(
              title: 'Tez va oson ro‘yxatdan o‘tish!',
              subtitle: 'Bir necha soniyada hisob yarating',
              icon: Icons.check_circle_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

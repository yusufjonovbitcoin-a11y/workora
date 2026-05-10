import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.titleSize = 31,
    this.illustrationAsset,
    this.illustrationWidthFraction = 0.38,
    this.showTrailingGraphic = true,
  });

  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final double titleSize;

  /// O‘ng tomonda ko‘rsatiladigan PNG (masalan kirish illüstratsiyasi).
  final String? illustrationAsset;

  /// Ekran kengligining qismi (taxminan 0.35–0.4 screenshotga yaqin).
  final double illustrationWidthFraction;

  /// `false` bo‘lsa, yon tomonda rasm yoki ikonka konteyneri chiqmaydi (faqat matn).
  final bool showTrailingGraphic;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0B1220),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF344054),
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showTrailingGraphic && illustrationAsset != null) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: w * illustrationWidthFraction,
            child: Image.asset(
              illustrationAsset!,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ] else if (showTrailingGraphic)
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F1),
              borderRadius: BorderRadius.circular(34),
            ),
            child: Icon(icon, color: AppColors.primary, size: 54),
          ),
      ],
    );
  }
}

class AuthOtpHeader extends StatelessWidget {
  const AuthOtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tasdiqlash kodi',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0B1220),
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Telefon raqamingizga yuborilgan 6 xonali kodni kiriting',
          style: TextStyle(
            fontSize: 18,
            height: 1.35,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class AuthSwitchLink extends StatelessWidget {
  const AuthSwitchLink({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

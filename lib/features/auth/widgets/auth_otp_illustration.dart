import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthOtpIllustration extends StatelessWidget {
  const AuthOtpIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 230,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F1),
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          Container(
            width: 105,
            height: 165,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 5),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: .12),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Column(
              children: [
                SizedBox(height: 8),
                SizedBox(
                  width: 34,
                  height: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _CodeCard(),
          _VerifiedBadge(),
          const Positioned(
            left: 82,
            top: 46,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFFFACC15), fontSize: 22),
            ),
          ),
          const Positioned(
            right: 72,
            top: 52,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFF9AD29E), fontSize: 24),
            ),
          ),
          const Positioned(
            left: 112,
            bottom: 34,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFF8FD8BE), fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Text(
        '* * * * *',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          letterSpacing: 6,
        ),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 92,
      bottom: 32,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.verified_user_rounded, color: Colors.white, size: 30),
      ),
    );
  }
}

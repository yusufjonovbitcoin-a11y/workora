import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// IshTopdi — yuqorida qotib turadigan blur header (iOS uslubida).
/// [brand] berilsa matn o‘rniga shu widget (masalan SVG logo) chiqadi.
class HomeStickyHeader extends StatelessWidget {
  const HomeStickyHeader({
    super.key,
    required this.elevated,
    this.onNotificationTap,
    this.brand,
  });

  final bool elevated;
  final VoidCallback? onNotificationTap;

  /// Matn o‘rniga ko‘rsatiladigan logo yoki brend.
  final Widget? brand;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: elevated ? 0.08 : 0.04,
            ),
            blurRadius: elevated ? 22 : 14,
            offset: Offset(0, elevated ? 10 : 5),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 8, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.82),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: brand ??
                          Text(
                            'IshTopdi',
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.6,
                              color: const Color(0xFF0F172A),
                              height: 1.1,
                            ),
                          ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onNotificationTap,
                      borderRadius: BorderRadius.circular(14),
                      child: Ink(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F8),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.04),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 24,
                              color: Colors.grey.shade800,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

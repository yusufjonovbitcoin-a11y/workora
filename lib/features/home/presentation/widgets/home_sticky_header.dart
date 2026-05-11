import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_typography.dart';

/// Qotib turadigan ixcham header — balandlik kontent bo‘yicha (fixed height yo‘q).
class HomeStickyHeader extends StatelessWidget {
  const HomeStickyHeader({
    super.key,
    required this.elevated,
    this.onNotificationTap,
    this.brand,
    this.leading,
  });

  final bool elevated;
  final VoidCallback? onNotificationTap;
  final Widget? brand;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: elevated ? 0.06 : 0.03),
            blurRadius: elevated ? 12 : 8,
            offset: Offset(0, elevated ? 4 : 2),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark
                        ? 0.88
                        : 0.92,
                  ),
              border: Border(
                bottom: BorderSide(
                  color: scheme.outline.withValues(alpha: 0.35),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.s16.w,
                AppSpacing.s12.h,
                AppSpacing.s12.w,
                AppSpacing.s12.h,
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: AppSpacing.s8.w),
                  ],
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: brand ??
                          Text(
                            'IshTopdi',
                            style: AppTypography.appBarTitle(context).copyWith(
                              color: onSurface,
                              fontSize: 22.sp,
                              height: 1.15,
                              letterSpacing: -0.35,
                            ),
                          ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onNotificationTap,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Ink(
                        width: 46.r,
                        height: 46.r,
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: scheme.outline.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 24.r,
                              color: onSurface.withValues(alpha: 0.75),
                            ),
                            Positioned(
                              top: 9.r,
                              right: 9.r,
                              child: Container(
                                width: 7.r,
                                height: 7.r,
                                decoration: BoxDecoration(
                                  color: scheme.primary,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/design_system/app_shadows.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/theme/app_colors.dart';

/// Ixcham floating pastki navigatsiya — katta soyalar va gradient FABsiz.
class PremiumNavBar extends StatelessWidget {
  const PremiumNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBarBg = isDark
        ? AppColors.primary.withValues(alpha: 0.22)
        : AppColors.navBarLight;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          0,
          AppSpacing.s16,
          AppSpacing.s8,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: navBarBg,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: AppShadows.navBar,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: isDark ? 0.28 : 0.14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _NavItem(
                    index: 0,
                    label: 'Bosh sahifa',
                    icon: Icons.home_rounded,
                    currentIndex: currentIndex,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 1,
                    label: 'AI Chat',
                    icon: Icons.smart_toy_rounded,
                    currentIndex: currentIndex,
                    onTap: onTap,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
                  child: _CenterAddButton(
                    isActive: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 3,
                    label: 'Xabarlar',
                    icon: Icons.chat_bubble_outline_rounded,
                    currentIndex: currentIndex,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 4,
                    label: 'Profil',
                    icon: Icons.person_outline_rounded,
                    currentIndex: currentIndex,
                    onTap: onTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.currentIndex,
    required this.onTap,
  });

  final int index;
  final String label;
  final IconData icon;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final active = currentIndex == index;
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(AppSpacing.s4),
                decoration: BoxDecoration(
                  color: active
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? scheme.primary.withValues(alpha: 0.2)
                          : AppColors.accentSoft)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 20.r,
                  color: active
                      ? AppColors.primary
                      : scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTypography.navLabel(context).copyWith(
                  color: active
                      ? AppColors.primary
                      : scheme.onSurface.withValues(alpha: 0.55),
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterAddButton extends StatelessWidget {
  const _CenterAddButton({required this.isActive, required this.onTap});

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: 'Qo‘shish',
      child: Material(
        color: scheme.primary,
        elevation: isActive ? 3 : 1,
        shadowColor: Colors.black26,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 48.r,
            height: 48.r,
            child: Icon(Icons.add_rounded, color: scheme.onPrimary, size: 24.r),
          ),
        ),
      ),
    );
  }
}

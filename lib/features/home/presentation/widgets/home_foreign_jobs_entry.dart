import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/app_typography.dart';

/// Qidiruv ostidagi «Xorijda ish» — chapda logo (ClipOval = rasm aylanasi).
class HomeForeignJobsEntry extends StatelessWidget {
  const HomeForeignJobsEntry({super.key});

  static const String _logoAsset = 'assets/icons/logoaylana.png';

  void _open(BuildContext context) {
    GoRouter.of(context).push('/foreign-jobs');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? scheme.surface.withValues(alpha: 0.9)
        : const Color(0xFFF3F4F6);
    final border = isDark
        ? scheme.outline.withValues(alpha: 0.35)
        : const Color(0xFFE5E7EB);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _open(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
        ),
        child: Row(
          children: [
            ClipOval(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 64,
                height: 64,
                child: Transform.scale(
                  scale: 1.18,
                  alignment: Alignment.center,
                  child: Image.asset(
                    _logoAsset,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (_, __, ___) => ColoredBox(
                      color: scheme.surfaceContainerHigh,
                      child: Center(
                        child: Icon(
                          Icons.language_rounded,
                          size: 32,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xorijda ish',
                    style: AppTypography.cardTitle(context).copyWith(
                      letterSpacing: -0.2,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Chet el vakansiyalari va ariza topshirish',
                    style: AppTypography.caption(context).copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: scheme.onSurface.withValues(alpha: 0.35),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design_system/app_shadows.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/job_seeker_entity.dart';
import 'mini_tag.dart';

class JobSeekerCard extends StatelessWidget {
  const JobSeekerCard({super.key, required this.seeker});

  final JobSeekerEntity seeker;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 48.r,
                  height: 48.r,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? scheme.primary.withValues(alpha: 0.2)
                          : AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        _initials(seeker.profession),
                        style: AppTypography.cardTitle(context).copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seeker.profession,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.cardTitle(context),
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      Text(
                        seeker.experience,
                        style: AppTypography.caption(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              seeker.about,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body(context).copyWith(
                color: scheme.onSurface.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            Wrap(
              spacing: AppSpacing.s8,
              runSpacing: AppSpacing.s8,
              children: [
                MiniTag(icon: Icons.location_on_outlined, text: seeker.location),
                MiniTag(
                  icon: Icons.attach_money_rounded,
                  text: seeker.expectedSalary,
                ),
                if (seeker.contact.isNotEmpty)
                  MiniTag(icon: Icons.phone_outlined, text: seeker.contact),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _initials(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return 'IQ';
  return trimmed
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}

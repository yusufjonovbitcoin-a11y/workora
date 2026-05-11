import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import 'models/profile_model.dart';
import 'widgets/ai_recommendation_card.dart';
import 'widgets/completion_card.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_card.dart';
import 'widgets/stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const profile = ProfileModel.empty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
          children: [
            ProfileHeader(
              profile: profile,
              onEdit: () => context.push('/edit-profile'),
              onNotifications: () => context.push('/notifications'),
            ),
            const SizedBox(height: 18),
            CompletionCard(
              percentage: profile.completion,
              onTap: () => context.push('/edit-profile'),
            ),
            const SizedBox(height: 18),
            StatsCard(
              appliedJobsCount: profile.appliedJobsCount,
              savedJobsCount: profile.savedJobsCount,
              aiMatchPercent: profile.aiMatchPercent,
              onApplied: () => context.push('/applied-jobs'),
              onSaved: () => context.push('/saved-jobs'),
              onAiMatch: () => context.go('/app'),
            ),
            const SizedBox(height: 18),
            AiRecommendationCard(onTap: () => context.go('/app')),
            const SizedBox(height: 24),
            const Text(
              'Mening ma’lumotlarim',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ProfileMenuCard(
              onCv: () => context.push('/edit-profile'),
              onSkills: () => context.push('/edit-profile'),
              onLanguages: () => context.push('/edit-profile'),
              onExperience: () => context.push('/edit-profile'),
              onPortfolio: () =>
                  _showDemoSnack(context, 'Portfolio demo rejimda'),
              onSettings: () => context.push('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDemoSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
  );
}

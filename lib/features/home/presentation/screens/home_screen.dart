import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/home_provider.dart';
import '../widgets/ai_recommendation_banner.dart';
import '../widgets/category_chips.dart';
import '../widgets/home_header.dart';
import '../widgets/home_job_card.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
          children: [
            const HomeHeader(),
            const SizedBox(height: 28),
            const HomeSearchBar(),
            const SizedBox(height: 22),
            CategoryChips(categories: state.categories),
            const SizedBox(height: 28),
            const AiRecommendationBanner(),
            const SizedBox(height: 28),
            const SectionHeader(),
            const SizedBox(height: 16),
            ...state.jobs.map(
              (job) => HomeJobCard(
                job: job,
                onTap: () => context.go('/vacancy-detail'),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

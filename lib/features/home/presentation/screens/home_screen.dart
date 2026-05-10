import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/home_job_filters.dart';
import '../../domain/home_list_filters.dart';
import '../providers/home_provider.dart';
import '../widgets/ai_recommendation_banner.dart';
import '../widgets/category_chips.dart';
import '../widgets/home_job_card.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_sticky_header.dart';
import '../widgets/job_filter_sheet.dart';
import '../widgets/job_seeker_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;
  bool _headerElevated = false;

  static const _scrollElevationThreshold = 14.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final next =
        _scrollController.offset > _scrollElevationThreshold;
    if (next != _headerElevated) {
      setState(() => _headerElevated = next);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final query = ref.watch(homeSearchQueryProvider);
    final filters = ref.watch(homeJobFiltersProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: HomeStickyHeader(
              elevated: _headerElevated,
              onNotificationTap: () => context.push('/notifications'),
            ),
          ),
          Expanded(
            child: homeState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _HomeError(
                message: 'Vakansiyalarni yuklab bo‘lmadi',
                onRetry: () => ref.invalidate(homeProvider),
              ),
              data: (state) {
                final filteredJobs =
                    applyHomeJobFilters(state.jobs, query, filters);
                final filteredSeekers =
                    applyHomeSeekerFilters(state.jobSeekers, query, filters);

                return RefreshIndicator(
                  color: const Color(0xFF22C55E),
                  displacement: 48,
                  onRefresh: () => ref.refresh(homeProvider.future),
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeSearchBar(
                                query: query,
                                onChanged: (value) => ref
                                    .read(homeSearchQueryProvider.notifier)
                                    .state = value,
                                onFilterTap: () =>
                                    showHomeJobFilterSheet(context, ref),
                              ),
                              const SizedBox(height: 20),
                              if (state.categories.isNotEmpty) ...[
                                CategoryChips(categories: state.categories),
                                const SizedBox(height: 22),
                              ],
                              const AiRecommendationBanner(),
                              const SizedBox(height: 26),
                              const SectionHeader(),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ),
                      ),
                      if (filteredJobs.isEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverToBoxAdapter(
                            child: _EmptyJobs(
                              filtersMayHideJobs: state.jobs.isNotEmpty,
                              onRetryFilters: () => ref
                                  .read(homeJobFiltersProvider.notifier)
                                  .state = HomeJobFilters.initial(),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final job = filteredJobs[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        index == filteredJobs.length - 1
                                            ? 12
                                            : 14,
                                  ),
                                  child: HomeJobCard(
                                    job: job,
                                    onTap: () => context.go(
                                      '/vacancy-detail/${job.id}',
                                    ),
                                  ),
                                );
                              },
                              childCount: filteredJobs.length,
                            ),
                          ),
                        ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        sliver: SliverToBoxAdapter(
                          child: _SectionTitle(
                            title: query.trim().isEmpty
                                ? 'Ish qidiruvchilar'
                                : 'Topilgan ish qidiruvchilar',
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                      if (filteredSeekers.isEmpty)
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverToBoxAdapter(child: _EmptySeekers()),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: JobSeekerCard(
                                  seeker: filteredSeekers[index],
                                ),
                              ),
                              childCount: filteredSeekers.length,
                            ),
                          ),
                        ),
                      const SliverToBoxAdapter(child: SizedBox(height: 96)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showHomeJobFilterSheet(BuildContext context, WidgetRef ref) {
  final asyncHome = ref.read(homeProvider);
  final state = asyncHome.asData?.value;
  if (state == null) return;

  final query = ref.read(homeSearchQueryProvider);
  final initial = HomeJobFilters.clone(ref.read(homeJobFiltersProvider));

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (sheetContext) => JobFilterSheet(
      initial: initial,
      computeCount: (draft) => homeFilterMatchCount(
        state.jobs,
        state.jobSeekers,
        query,
        draft,
      ),
      onApply: (draft) {
        ref.read(homeJobFiltersProvider.notifier).state = draft;
        Navigator.of(sheetContext).pop();
      },
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: Color(0xFF101828),
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
              ),
              child: const Text('Qayta urinish'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyJobs extends StatelessWidget {
  const _EmptyJobs({
    required this.filtersMayHideJobs,
    this.onRetryFilters,
  });

  final bool filtersMayHideJobs;
  final VoidCallback? onRetryFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text(
            filtersMayHideJobs
                ? 'Filtrlarga mos vakansiya topilmadi. Filtrlarni o‘zgartiring.'
                : 'Hozircha vakansiyalar yo‘q. Keyinroq qayting.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontWeight: FontWeight.w600,
              height: 1.45,
              fontSize: 15,
            ),
          ),
          if (filtersMayHideJobs && onRetryFilters != null) ...[
            const SizedBox(height: 14),
            TextButton(
              onPressed: onRetryFilters,
              child: const Text(
                'Filtrlarni tiklash',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF16A34A),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptySeekers extends StatelessWidget {
  const _EmptySeekers();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: const Text(
        'Hozircha ish qidiruvchi anketalari yo‘q.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF667085),
          fontWeight: FontWeight.w600,
          height: 1.45,
          fontSize: 15,
        ),
      ),
    );
  }
}

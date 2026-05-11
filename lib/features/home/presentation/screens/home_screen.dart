import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_typography.dart';
import '../../domain/entities/home_job_filters.dart';
import '../../domain/home_list_filters.dart';
import '../../domain/match_percent.dart';
import '../providers/home_provider.dart';
import '../widgets/ai_recommendation_banner.dart';
import '../widgets/home_job_card.dart';
import '../widgets/home_foreign_jobs_entry.dart';
import '../widgets/search_section.dart';
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

  static const _scrollElevationThreshold = 12.0;

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

  static const _scrollPhysics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  /// Qidiruv va «Xorijda ish» — scroll ichida, tepaga surilganda header bilan birga harakatlanadi.
  Widget _sliverSearchAndForeignJobs(String query) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        0,
        AppSpacing.s12,
        0,
        AppSpacing.s4,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchSection(
              query: query,
              onChanged: (value) =>
                  ref.read(homeSearchQueryProvider.notifier).state = value,
              onFilterTap: () => showHomeJobFilterSheet(context, ref),
            ),
            const SizedBox(height: AppSpacing.s16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s20),
              child: HomeForeignJobsEntry(),
            ),
            const SizedBox(height: AppSpacing.s16),
          ],
        ),
      ),
    );
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              loading: () => RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                displacement: AppSpacing.s32,
                onRefresh: () => ref.refresh(homeProvider.future),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: _scrollPhysics,
                  slivers: [
                    _sliverSearchAndForeignJobs(query),
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
              error: (error, _) => RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                displacement: AppSpacing.s32,
                onRefresh: () => ref.refresh(homeProvider.future),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: _scrollPhysics,
                  slivers: [
                    _sliverSearchAndForeignJobs(query),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _HomeError(
                        message: 'Vakansiyalarni yuklab bo‘lmadi',
                        onRetry: () => ref.invalidate(homeProvider),
                      ),
                    ),
                  ],
                ),
              ),
              data: (state) {
                final filteredJobs =
                    applyHomeJobFilters(state.jobs, query, filters);
                final filteredSeekers =
                    applyHomeSeekerFilters(state.jobSeekers, query, filters);
                final profileForMatch =
                    ref.watch(jobMatchProfileProvider).valueOrNull;

                return RefreshIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  displacement: AppSpacing.s32,
                  onRefresh: () async {
                    ref.invalidate(jobMatchProfileProvider);
                    final _ = await ref.refresh(homeProvider.future);
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: _scrollPhysics,
                    slivers: [
                      _sliverSearchAndForeignJobs(query),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.s20,
                          0,
                          AppSpacing.s20,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AiRecommendationBanner(),
                              const SizedBox(height: AppSpacing.s24),
                              const SectionHeader(),
                              const SizedBox(height: AppSpacing.s12),
                            ],
                          ),
                        ),
                      ),
                      if (filteredJobs.isEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s20,
                          ),
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
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.s20,
                            0,
                            AppSpacing.s20,
                            0,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final job = filteredJobs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.s12,
                                  ),
                                  child: HomeJobCard(
                                    job: job,
                                    matchLabel: effectiveMatchLabel(
                                      job,
                                      profileForMatch,
                                    ),
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
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.s20,
                          AppSpacing.s8,
                          AppSpacing.s20,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _SectionTitle(
                            title: query.trim().isEmpty
                                ? 'Ish qidiruvchilar'
                                : 'Topilgan ish qidiruvchilar',
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: AppSpacing.s12),
                      ),
                      if (filteredSeekers.isEmpty)
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s20,
                          ),
                          sliver: SliverToBoxAdapter(child: _EmptySeekers()),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.s20,
                            0,
                            AppSpacing.s20,
                            0,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.s12,
                                ),
                                child: JobSeekerCard(
                                  seeker: filteredSeekers[index],
                                ),
                              ),
                              childCount: filteredSeekers.length,
                            ),
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: AppSpacing.s32 +
                              AppSpacing.s32 +
                              AppSpacing.s32,
                        ),
                      ),
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
      style: AppTypography.sectionTitle(context),
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
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            FilledButton(
              onPressed: onRetry,
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
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          children: [
            Text(
              filtersMayHideJobs
                  ? 'Filtrlarga mos vakansiya topilmadi. Filtrlarni o‘zgartiring.'
                  : 'Hozircha vakansiyalar yo‘q. Keyinroq qayting.',
              textAlign: TextAlign.center,
              style: AppTypography.body(context).copyWith(
                color: scheme.onSurface.withValues(alpha: 0.65),
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
            if (filtersMayHideJobs && onRetryFilters != null) ...[
              const SizedBox(height: AppSpacing.s12),
              TextButton(
                onPressed: onRetryFilters,
                child: Text(
                  'Filtrlarni tiklash',
                  style: AppTypography.caption(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptySeekers extends StatelessWidget {
  const _EmptySeekers();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Text(
          'Hozircha ish qidiruvchi anketalari yo‘q.',
          textAlign: TextAlign.center,
          style: AppTypography.body(context).copyWith(
            color: scheme.onSurface.withValues(alpha: 0.65),
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

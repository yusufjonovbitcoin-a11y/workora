import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../home/presentation/widgets/home_sticky_header.dart';
import '../providers/foreign_jobs_provider.dart';
import '../widgets/country_list.dart';
import '../widgets/foreign_big_banner.dart';
import '../widgets/foreign_program_card.dart';
import '../widgets/foreign_search_bar.dart';
import '../widgets/foreign_section_header.dart';
import '../widgets/region_chips.dart';

class ForeignJobsScreen extends ConsumerStatefulWidget {
  const ForeignJobsScreen({super.key});

  /// Sticky headerdagi logo (PNG). Fayl: `assets/icons/logo.png`
  static const brandLogoAsset = 'assets/icons/logo.png';

  @override
  ConsumerState<ForeignJobsScreen> createState() =>
      _ForeignJobsScreenState();
}

class _ForeignJobsScreenState extends ConsumerState<ForeignJobsScreen> {
  late final ScrollController _scrollController;
  bool _headerElevated = false;

  static const _scrollElevationThreshold = 14.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final next = _scrollController.offset > _scrollElevationThreshold;
    if (next != _headerElevated) setState(() => _headerElevated = next);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(foreignJobsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: HomeStickyHeader(
              elevated: _headerElevated,
              onNotificationTap: () => context.push('/notifications'),
              leading: ModalRoute.of(context)?.canPop ?? false
                  ? IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 44,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Color(0xFF0F172A),
                      ),
                      onPressed: () => context.pop(),
                    )
                  : null,
              brand: Image.asset(
                ForeignJobsScreen.brandLogoAsset,
                height: 28,
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, __, ___) => Text(
                  'IshTopdi',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: const Color(0xFF0F172A),
                      ),
                ),
              ),
            ),
          ),
          Expanded(
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
                        const ForeignSearchBar(),
                        const SizedBox(height: 20),
                        RegionChips(regions: state.regions),
                        const SizedBox(height: 22),
                        const ForeignBigBanner(),
                        const SizedBox(height: 26),
                        const ForeignSectionHeader(title: 'Mashhur davlatlar'),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: CountryList(countries: state.countries),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: ForeignSectionHeader(
                      title: 'Tavsiya etilgan dasturlar',
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 14)),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index == state.programs.length - 1 ? 0 : 14,
                        ),
                        child: ForeignProgramCard(
                          program: state.programs[index],
                        ),
                      ),
                      childCount: state.programs.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 96)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
